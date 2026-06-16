#include <rclcpp/rclcpp.hpp>
#include <geometry_msgs/msg/twist_with_covariance_stamped.hpp>
#include <geometry_msgs/msg/pose_with_covariance_stamped.hpp>
#include <sensor_msgs/msg/range.hpp>
#include <linux/can.h>
#include <linux/can/raw.h>
#include <sys/socket.h>
#include <sys/ioctl.h>
#include <net/if.h>
#include <unistd.h>
#include <fcntl.h>
#include <cstring>
#include <thread>
#include <atomic>
#include <poll.h>

// DroneCAN IDs
#define UAVCAN_EQUIPMENT_OPTICAL_FLOW_ID 20200
#define UAVCAN_EQUIPMENT_RANGE_SENSOR_ID 1050


#pragma GCC diagnostic push
#pragma GCC diagnostic ignored "-Wpedantic"
#include <canard.h>
#pragma GCC diagnostic pop

namespace uavcan_bridge {

class DronecanBridgeComponent;

//PROTOTYPES
bool shouldAcceptTransfer(const CanardInstance* ins, uint64_t* out_data_type_signature, uint16_t data_type_id, CanardTransferType transfer_type, uint8_t source_node_id);
void onTransferReceived(CanardInstance* ins, CanardRxTransfer* transfer);

// CLASS
class DronecanBridgeComponent : public rclcpp::Node {
public:
    float current_distance_z_ = 0.0f;
    DronecanBridgeComponent(const rclcpp::NodeOptions & options)
    : Node("dronecan_bridge", options) {
        
        this->declare_parameter<std::string>("can_interface", "slcan0");
        auto can_iface = this->get_parameter("can_interface").as_string();

        //Initializing the 3 ROS 2 Publishers
        flow_pub_ = this->create_publisher<geometry_msgs::msg::TwistWithCovarianceStamped>("/optical_flow/velocity", rclcpp::SensorDataQoS());
        range_pub_ = this->create_publisher<geometry_msgs::msg::PoseWithCovarianceStamped>("/optical_flow/range", rclcpp::SensorDataQoS());

        canardInit(&canard_, canard_memory_pool_, sizeof(canard_memory_pool_), onTransferReceived, shouldAcceptTransfer, this);
        canardSetLocalNodeID(&canard_, 127); // Le Jetson a l'ID 127

        if (!init_socketcan(can_iface)) {
            RCLCPP_FATAL(this->get_logger(), "Impossible to open the bus CAN: %s", can_iface.c_str());
            throw std::runtime_error("CAN Init Failed");
        }

        is_running_ = true;
        rx_thread_ = std::thread(&DronecanBridgeComponent::can_rx_loop, this);

        RCLCPP_INFO(this->get_logger(), "DroneCAN Bridge active on %s (Threaded). Ready for Flow and Range!", can_iface.c_str());
    }

    ~DronecanBridgeComponent() { 
        // --- MODIFICATION : Arrêt propre du thread ---
        is_running_ = false;
        if (rx_thread_.joinable()) {
            rx_thread_.join();
        }
        if (socket_fd_ >= 0) close(socket_fd_);
    }

    void publish_flow_data(float x, float y, uint64_t hardware_timestamp_usec) {
        auto msg = geometry_msgs::msg::TwistWithCovarianceStamped();
        
        // Convertit le timestamp microsecondes du SocketCAN en rclcpp::Time
        msg.header.stamp = rclcpp::Time(static_cast<int64_t>(hardware_timestamp_usec) * 1000);
        msg.header.frame_id = "optical_flow_link";
        msg.twist.twist.linear.x = x;
        msg.twist.twist.linear.y = y;
        msg.twist.covariance[0]  = 0.005;
        msg.twist.covariance[7]  = 0.005;
        msg.twist.covariance[14] = 10000.0;
        msg.twist.covariance[21] = 10000.0;
        msg.twist.covariance[28] = 10000.0;
        msg.twist.covariance[35] = 10000.0;       
        flow_pub_->publish(msg);
    }
    

    void publish_range_data(float distance, uint64_t hardware_timestamp_usec) {
        current_distance_z_ = distance;
        auto msg = geometry_msgs::msg::PoseWithCovarianceStamped();
        
        // Convertit le timestamp microsecondes du SocketCAN en rclcpp::Time
        msg.header.stamp = rclcpp::Time(static_cast<int64_t>(hardware_timestamp_usec) * 1000);
        msg.header.frame_id = "optical_flow_link";
        msg.pose.pose.position.z = distance;
        msg.pose.covariance[0]  = 10000.0;
        msg.pose.covariance[7]  = 10000.0;
        msg.pose.covariance[14] = 0.005;
        msg.pose.covariance[21] = 10000.0;
        msg.pose.covariance[28] = 10000.0;
        msg.pose.covariance[35] = 10000.0;
        range_pub_->publish(msg);
    }



private:
    int socket_fd_;
    rclcpp::Publisher<geometry_msgs::msg::TwistWithCovarianceStamped>::SharedPtr flow_pub_;
    rclcpp::Publisher<geometry_msgs::msg::PoseWithCovarianceStamped>::SharedPtr range_pub_;
    
    std::thread rx_thread_;
    std::atomic<bool> is_running_;
    CanardInstance canard_;
    alignas(8) uint8_t canard_memory_pool_[16384]; 

    bool init_socketcan(const std::string& iface_name) {
        struct sockaddr_can addr; struct ifreq ifr;
        socket_fd_ = socket(PF_CAN, SOCK_RAW, CAN_RAW);
        if (socket_fd_ < 0) return false;
        std::strncpy(ifr.ifr_name, iface_name.c_str(), IFNAMSIZ - 1);
        ifr.ifr_name[IFNAMSIZ - 1] = '\0';
        if (ioctl(socket_fd_, SIOCGIFINDEX, &ifr) < 0) return false;
        addr.can_family = AF_CAN; addr.can_ifindex = ifr.ifr_ifindex;
        int flags = fcntl(socket_fd_, F_GETFL, 0); fcntl(socket_fd_, F_SETFL, flags | O_NONBLOCK);
        int timestamp_on = 1;
        if (setsockopt(socket_fd_, SOL_SOCKET, SO_TIMESTAMP, &timestamp_on, sizeof(timestamp_on)) < 0) {
            RCLCPP_WARN(this->get_logger(), "Failed to enable SO_TIMESTAMP");
        }

        if (bind(socket_fd_, (struct sockaddr *)&addr, sizeof(addr)) < 0) return false;
        return true;
    }
    
    void can_rx_loop() { // Ou read_can_frames()
        struct pollfd pfd;
        pfd.fd = socket_fd_;
        pfd.events = POLLIN;

        struct can_frame frame;
        struct iovec iov;
        struct msghdr msg;
        char ctrlmsg[CMSG_SPACE(sizeof(struct timeval))];

        iov.iov_base = &frame;
        iov.iov_len = sizeof(frame);

        msg.msg_name = nullptr;
        msg.msg_namelen = 0;
        msg.msg_iov = &iov;
        msg.msg_iovlen = 1;
        msg.msg_control = ctrlmsg;
        msg.msg_controllen = sizeof(ctrlmsg);

        while (is_running_) {
            int ret = poll(&pfd, 1, 100);

            if (ret > 0 && (pfd.revents & POLLIN)) {
                // --- MODIFICATION : recvmsg au lieu de read ---
                while (recvmsg(socket_fd_, &msg, 0) > 0) {
                    
                    uint64_t timestamp_usec = 0;
                    struct cmsghdr *cmsg;

                    // Extraction du timestamp noyau
                    for (cmsg = CMSG_FIRSTHDR(&msg); cmsg != nullptr; cmsg = CMSG_NXTHDR(&msg, cmsg)) {
                        if (cmsg->cmsg_level == SOL_SOCKET && cmsg->cmsg_type == SO_TIMESTAMP) {
                            struct timeval *tv = (struct timeval *)CMSG_DATA(cmsg);
                            timestamp_usec = static_cast<uint64_t>(tv->tv_sec) * 1000000ULL + tv->tv_usec;
                            break;
                        }
                    }

                    // Fallback sécurité si non supporté
                    if (timestamp_usec == 0) {
                        timestamp_usec = std::chrono::duration_cast<std::chrono::microseconds>(
                            std::chrono::system_clock::now().time_since_epoch()).count();
                    }

                    CanardCANFrame canard_frame;
                    canard_frame.id = frame.can_id;
                    canard_frame.data_len = frame.can_dlc;
                    std::memcpy(canard_frame.data, frame.data, frame.can_dlc);

                    canardHandleRxFrame(&canard_, &canard_frame, timestamp_usec);
                }
            }
        }
    }

};

//CALLBACKS LIBCANARD
bool shouldAcceptTransfer(const CanardInstance* ins, uint64_t* out_data_type_signature, uint16_t data_type_id, CanardTransferType transfer_type, uint8_t source_node_id) {
    (void)ins; (void)transfer_type; (void)source_node_id;

    if (data_type_id == UAVCAN_EQUIPMENT_OPTICAL_FLOW_ID) {
        *out_data_type_signature = 0x6a908866bcb49c18ULL; // sgnatur Flow 
        return true;
    }
    if (data_type_id == UAVCAN_EQUIPMENT_RANGE_SENSOR_ID) {
        *out_data_type_signature = 0x68fffe70fc771952ULL; // signature Telemeter
        return true;
    }
    return false;
}

void onTransferReceived(CanardInstance* ins, CanardRxTransfer* transfer) {
    auto* node = static_cast<DronecanBridgeComponent*>(ins->user_reference);

    // OPTICAL FLOW
    if (transfer->data_type_id == UAVCAN_EQUIPMENT_OPTICAL_FLOW_ID && transfer->payload_len >= 21) {
        uint32_t dt_bits = 0, flow_x_bits = 0, flow_y_bits = 0;
        uint8_t quality = 0;

        canardDecodeScalar(transfer, 0, 32, false, &dt_bits); // integration_interval
        canardDecodeScalar(transfer, 96, 32, false, &flow_x_bits);
        canardDecodeScalar(transfer, 128, 32, false, &flow_y_bits);
        canardDecodeScalar(transfer, 160, 8, false, &quality);

        float dt_sec, flow_x_rad, flow_y_rad;
        std::memcpy(&dt_sec, &dt_bits, 4);
        std::memcpy(&flow_x_rad, &flow_x_bits, 4);
        std::memcpy(&flow_y_rad, &flow_y_bits, 4);

        // ATTENTION : Tu dois stocker la dernière distance lue par le laser (Z) dans une variable membre de ta classe (ex: current_distance_z_)
        // Formule : V = (deplacement_angulaire / temps) * distance_au_sol
        if (quality > 0 && dt_sec > 0 && node->current_distance_z_ > 0.05f) { 
            float vel_x = (flow_x_rad / dt_sec) * node->current_distance_z_;
            float vel_y = (flow_y_rad / dt_sec) * node->current_distance_z_;
            node->publish_flow_data(vel_x, vel_y, transfer->timestamp_usec);
        }
    }
    
    // LASER RANGE 
    else if (transfer->data_type_id == UAVCAN_EQUIPMENT_RANGE_SENSOR_ID && transfer->payload_len >= 15) {
        
        uint16_t range_bits = 0;
        
        // The ‘range’ field (float16) begins exactly at the 104th bit of the message
        canardDecodeScalar(transfer, 104, 16, false, &range_bits);
        
        // Converting CAN float16 to native C++ float32
        float distance_m = canardConvertFloat16ToNativeFloat(range_bits);
        
        // The distance is only published if it is valid (the sensor returns 0.0 if it is out of range)
	if (distance_m > 0.05f) {
	    node->publish_range_data(distance_m, transfer->timestamp_usec);
	}
    }
}
} 

#include "rclcpp_components/register_node_macro.hpp"
RCLCPP_COMPONENTS_REGISTER_NODE(uavcan_bridge::DronecanBridgeComponent)

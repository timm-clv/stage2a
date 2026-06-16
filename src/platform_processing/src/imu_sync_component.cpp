#include <rclcpp/rclcpp.hpp>
#include <sensor_msgs/msg/imu.hpp>
#include <sensor_msgs/msg/compressed_image.hpp>
#include <geometry_msgs/msg/pose_stamped.hpp>
#include <geometry_msgs/msg/twist_stamped.hpp>
#include <geometry_msgs/msg/accel_stamped.hpp>
#include <sensor_msgs/msg/camera_info.hpp>

namespace platform_processing
{
class ImuSyncComponent : public rclcpp::Node
{
public:
  explicit ImuSyncComponent(const rclcpp::NodeOptions & options)
  : Node("imu_sync_node", options)
  {
    // --- Déclaration des paramètres ---
    this->declare_parameter("variance_orientation_rp", 0.000076); // 0.5° RMSE -> rad**2 Roll/Pitch
    this->declare_parameter("variance_orientation_y", 0.0012);    // < 2° RMSE -> rad**2 Yaw
    this->declare_parameter("variance_angular_velocity", 0.0001); // Gyroscopes
    this->declare_parameter("variance_linear_acceleration", 0.1); // Accéléromètres
    
    var_ori_rp_ = this->get_parameter("variance_orientation_rp").as_double();
    var_ori_y_ = this->get_parameter("variance_orientation_y").as_double();
    var_ang_vel_ = this->get_parameter("variance_angular_velocity").as_double();
    var_lin_acc_ = this->get_parameter("variance_linear_acceleration").as_double();
    
    // ==============================================================================
    // 0. TOPICS PRINCIPAUX (Callbacks dédiés)
    // ==============================================================================
    pub_imu_fused_ = this->create_publisher<sensor_msgs::msg::Imu>("/imu/fused", rclcpp::SensorDataQoS());
    
    sub_imu_ = this->create_subscription<sensor_msgs::msg::Imu>(
      "/imu/data", rclcpp::SensorDataQoS(), 
      [this](sensor_msgs::msg::Imu::UniquePtr msg) {
          this->imuCallback(std::move(msg));
      });

    pub_cam_synced_ = this->create_publisher<sensor_msgs::msg::CompressedImage>("/olive/camera/image_synced/compressed", rclcpp::SensorDataQoS());
    
    sub_cam_ = this->create_subscription<sensor_msgs::msg::CompressedImage>(
      "/olive/camera/olivecam/image/compressed", rclcpp::SensorDataQoS(), 
      [this](sensor_msgs::msg::CompressedImage::UniquePtr msg) {
          this->camCallback(std::move(msg));
      });

    // ==============================================================================
    // 1. CAMÉRA : POSE & TWIST
    // ==============================================================================
    pub_cam_pose_synced_ = this->create_publisher<geometry_msgs::msg::PoseStamped>("/olive/camera/olivecam/pose_synced", rclcpp::SensorDataQoS());
    sub_cam_pose_ = this->create_subscription<geometry_msgs::msg::PoseStamped>(
      "/olive/camera/olivecam/pose", rclcpp::SensorDataQoS(), 
      [this](geometry_msgs::msg::PoseStamped::UniquePtr msg) { // <-- UniquePtr
        msg->header.stamp = applyCamOffset(msg->header.stamp);
        msg->header.frame_id = "olivecam_link"; 
        pub_cam_pose_synced_->publish(std::move(msg)); // <-- std::move
      });

    pub_cam_twist_synced_ = this->create_publisher<geometry_msgs::msg::TwistStamped>("/olive/camera/olivecam/twist_synced", rclcpp::SensorDataQoS());
    sub_cam_twist_ = this->create_subscription<geometry_msgs::msg::TwistStamped>(
      "/olive/camera/olivecam/twist", rclcpp::SensorDataQoS(), 
      [this](geometry_msgs::msg::TwistStamped::UniquePtr msg) {
        msg->header.stamp = applyCamOffset(msg->header.stamp);
        msg->header.frame_id = "olivecam_link"; 
        pub_cam_twist_synced_->publish(std::move(msg)); 
      });

    // ==============================================================================
    // 2. CAMÉRA : ACCÉLÉRATION & AHRS
    // ==============================================================================
    pub_cam_acc_synced_ = this->create_publisher<geometry_msgs::msg::AccelStamped>("/olive/camera/olivecam/linear_acc_synced", rclcpp::SensorDataQoS());
    sub_cam_acc_ = this->create_subscription<geometry_msgs::msg::AccelStamped>(
      "/olive/camera/olivecam/linear_acc", rclcpp::SensorDataQoS(), 
      [this](geometry_msgs::msg::AccelStamped::UniquePtr msg) {
        msg->header.stamp = applyCamOffset(msg->header.stamp); 
        msg->header.frame_id = "olivecam_link"; 
        pub_cam_acc_synced_->publish(std::move(msg)); 
      });

    pub_cam_ahrs_synced_ = this->create_publisher<sensor_msgs::msg::Imu>("/olive/camera/olivecam/filtered_ahrs_synced", rclcpp::SensorDataQoS());
    sub_cam_ahrs_ = this->create_subscription<sensor_msgs::msg::Imu>(
      "/olive/camera/olivecam/filtered_ahrs", rclcpp::SensorDataQoS(), 
        [this](sensor_msgs::msg::Imu::UniquePtr msg) {
        msg->header.stamp = applyCamOffset(msg->header.stamp); 
        msg->header.frame_id = "olivecam_link"; 
        pub_cam_ahrs_synced_->publish(std::move(msg)); 
      });

    // ==============================================================================
    // 3. CAMÉRA : INFO (REPÈRE OPTIQUE)
    // ==============================================================================
    pub_cam_info_synced_ = this->create_publisher<sensor_msgs::msg::CameraInfo>("/olive/camera/image_synced/camera_info", rclcpp::SensorDataQoS());
    sub_cam_info_ = this->create_subscription<sensor_msgs::msg::CameraInfo>(
      "/olive/camera/olivecam/image/camera_info", rclcpp::SensorDataQoS(), 
        [this](sensor_msgs::msg::CameraInfo::UniquePtr msg) {
        msg->header.stamp = applyCamOffset(msg->header.stamp); 
        msg->header.frame_id = "olivecam_optical_frame"; 
        pub_cam_info_synced_->publish(std::move(msg)); 
      });

    // ==============================================================================
    // 4. IMU : ACCÉLÉRATION & VITESSE
    // ==============================================================================
    pub_imu_acc_synced_ = this->create_publisher<geometry_msgs::msg::AccelStamped>("/olive/olixSense/x1/id001/acceleration_synced", rclcpp::SensorDataQoS());
    sub_imu_acc_ = this->create_subscription<geometry_msgs::msg::AccelStamped>(
      "/olive/olixSense/x1/id001/acceleration", rclcpp::SensorDataQoS(), 
        [this](geometry_msgs::msg::AccelStamped::UniquePtr msg) {
        msg->header.stamp = applyImuOffset(msg->header.stamp); 
        msg->header.frame_id = "imu_link"; 
        pub_imu_acc_synced_->publish(std::move(msg)); 
      });

    pub_imu_vel_synced_ = this->create_publisher<geometry_msgs::msg::TwistStamped>("/olive/olixSense/x1/id001/velocity_synced", rclcpp::SensorDataQoS());
    sub_imu_vel_ = this->create_subscription<geometry_msgs::msg::TwistStamped>(
      "/olive/olixSense/x1/id001/velocity", rclcpp::SensorDataQoS(),
        [this](geometry_msgs::msg::TwistStamped::UniquePtr msg) {
        msg->header.stamp = applyImuOffset(msg->header.stamp); 
        msg->header.frame_id = "imu_link"; 
        pub_imu_vel_synced_->publish(std::move(msg)); 
      });

    RCLCPP_INFO(this->get_logger(), "Nœud de synchronisation actif : Offsets statiques verrouillés au premier message.");
  }

private:
  double var_ori_rp_, var_ori_y_, var_ang_vel_, var_lin_acc_;
  // --- VARIABLES D'OFFSET ---
  bool imu_offset_initialized_ = false;
  rclcpp::Duration imu_time_offset_{0, 0};

  bool cam_offset_initialized_ = false;
  rclcpp::Duration cam_time_offset_{0, 0};

  // --- HELPERS (EWA Filter) ---
  rclcpp::Time applyImuOffset(const builtin_interfaces::msg::Time & stamp)
  {
    rclcpp::Time msg_time(stamp);
    rclcpp::Duration new_offset = this->now() - msg_time;

    if (!imu_offset_initialized_) {
      imu_time_offset_ = new_offset;
      imu_offset_initialized_ = true;
      RCLCPP_INFO(this->get_logger(), "Offset temporel initial IMU verrouillé.");
    } else {
      constexpr double alpha = 0.01; // Facteur de lissage
      imu_time_offset_ = rclcpp::Duration::from_nanoseconds(
        (1.0 - alpha) * imu_time_offset_.nanoseconds() + alpha * new_offset.nanoseconds());
    }
    return msg_time + imu_time_offset_;
  }

  rclcpp::Time applyCamOffset(const builtin_interfaces::msg::Time & stamp)
  {
    rclcpp::Time msg_time(stamp);
    rclcpp::Duration new_offset = this->now() - msg_time;

    if (!cam_offset_initialized_) {
      cam_time_offset_ = new_offset;
      cam_offset_initialized_ = true;
      RCLCPP_INFO(this->get_logger(), "Offset temporel initial Caméra verrouillé.");
    } else {
      constexpr double alpha = 0.01; // Facteur de lissage
      cam_time_offset_ = rclcpp::Duration::from_nanoseconds(
        (1.0 - alpha) * cam_time_offset_.nanoseconds() + alpha * new_offset.nanoseconds());
    }
    return msg_time + cam_time_offset_;
  }

  // --- CALLBACKS PRINCIPAUX ---
  // --- CALLBACKS PRINCIPAUX ---
  void imuCallback(sensor_msgs::msg::Imu::UniquePtr msg)
  {
    msg->header.stamp = applyImuOffset(msg->header.stamp);
    msg->header.frame_id  = "imu_link";
    
    double var_ori_rp = this->get_parameter("variance_orientation_rp").as_double();
    double var_ori_y = this->get_parameter("variance_orientation_y").as_double();
    double var_ang_vel = this->get_parameter("variance_angular_velocity").as_double();
    double var_lin_acc = this->get_parameter("variance_linear_acceleration").as_double();
    
    // Remplacement de fused_msg. par msg->
    msg->orientation_covariance[0] = var_ori_rp;
    msg->orientation_covariance[4] = var_ori_rp;
    msg->orientation_covariance[8] = var_ori_y;
    msg->angular_velocity_covariance[0] = var_ang_vel;
    msg->angular_velocity_covariance[4] = var_ang_vel;
    msg->angular_velocity_covariance[8] = var_ang_vel;
    msg->linear_acceleration_covariance[0] = var_lin_acc;
    msg->linear_acceleration_covariance[4] = var_lin_acc;
    msg->linear_acceleration_covariance[8] = var_lin_acc;
    
    pub_imu_fused_->publish(std::move(msg));
  }

void camCallback(sensor_msgs::msg::CompressedImage::UniquePtr msg) {
    msg->header.stamp = applyCamOffset(msg->header.stamp);
    msg->header.frame_id = "olivecam_optical_frame";
    pub_cam_synced_->publish(std::move(msg));
}

  // --- DÉCLARATIONS DES PUBLISHERS / SUBSCRIBERS ---
  rclcpp::Subscription<sensor_msgs::msg::Imu>::SharedPtr sub_imu_;
  rclcpp::Publisher<sensor_msgs::msg::Imu>::SharedPtr pub_imu_fused_;
  
  rclcpp::Subscription<sensor_msgs::msg::CompressedImage>::SharedPtr sub_cam_;
  rclcpp::Publisher<sensor_msgs::msg::CompressedImage>::SharedPtr pub_cam_synced_;
  
  rclcpp::Subscription<geometry_msgs::msg::PoseStamped>::SharedPtr sub_cam_pose_;
  rclcpp::Publisher<geometry_msgs::msg::PoseStamped>::SharedPtr pub_cam_pose_synced_;
  
  rclcpp::Subscription<geometry_msgs::msg::TwistStamped>::SharedPtr sub_cam_twist_;
  rclcpp::Publisher<geometry_msgs::msg::TwistStamped>::SharedPtr pub_cam_twist_synced_;
  
  rclcpp::Subscription<geometry_msgs::msg::AccelStamped>::SharedPtr sub_cam_acc_;
  rclcpp::Publisher<geometry_msgs::msg::AccelStamped>::SharedPtr pub_cam_acc_synced_;
  
  rclcpp::Subscription<sensor_msgs::msg::Imu>::SharedPtr sub_cam_ahrs_;
  rclcpp::Publisher<sensor_msgs::msg::Imu>::SharedPtr pub_cam_ahrs_synced_;
  
  rclcpp::Subscription<sensor_msgs::msg::CameraInfo>::SharedPtr sub_cam_info_;
  rclcpp::Publisher<sensor_msgs::msg::CameraInfo>::SharedPtr pub_cam_info_synced_;

  rclcpp::Subscription<geometry_msgs::msg::AccelStamped>::SharedPtr sub_imu_acc_;
  rclcpp::Publisher<geometry_msgs::msg::AccelStamped>::SharedPtr pub_imu_acc_synced_;
  
  rclcpp::Subscription<geometry_msgs::msg::TwistStamped>::SharedPtr sub_imu_vel_;
  rclcpp::Publisher<geometry_msgs::msg::TwistStamped>::SharedPtr pub_imu_vel_synced_;
};
} // namespace platform_processing

#include "rclcpp_components/register_node_macro.hpp"
RCLCPP_COMPONENTS_REGISTER_NODE(platform_processing::ImuSyncComponent)

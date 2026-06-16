#!/usr/bin/env python3
import rclpy
from rclpy.node import Node
from rclpy.qos import qos_profile_sensor_data
from sensor_msgs.msg import Imu
from geometry_msgs.msg import TwistStamped, AccelStamped

class ImuRelay(Node):
    def __init__(self):
        super().__init__('imu_namespace_relay')
        
        # Publishers
        self.pub_imu = self.create_publisher(Imu, '/imu/data', qos_profile_sensor_data)
        self.pub_vel = self.create_publisher(TwistStamped, '/olive/olixSense/x1/id001/velocity', qos_profile_sensor_data)
        self.pub_acc = self.create_publisher(AccelStamped, '/olive/olixSense/x1/id001/acceleration', qos_profile_sensor_data)
        
        # Subscribers (Redirection directe via les callbacks des publishers)
        self.create_subscription(Imu, '/olive/olixSense/x1/id001/imu', self.pub_imu.publish, qos_profile_sensor_data)
        self.create_subscription(TwistStamped, '/olive/olixSense/x1/id001/velocity', self.pub_vel.publish, qos_profile_sensor_data)
        self.create_subscription(AccelStamped, '/olive/olixSense/x1/id001/acceleration', self.pub_acc.publish, qos_profile_sensor_data)

def main(args=None):
    rclpy.init(args=args)
    rclpy.spin(ImuRelay())
    rclpy.shutdown()

if __name__ == '__main__':
    main()

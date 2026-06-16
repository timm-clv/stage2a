#!/usr/bin/env python3
import rclpy
from rclpy.node import Node
from sensor_msgs.msg import Imu
import random

class MockImuNode(Node):
    def __init__(self):
        super().__init__('mock_imu_node')
        
        # Default QoS (history of 10) to match your current C++ component
        self.pub_olive = self.create_publisher(Imu, '/olive/imu/data', 10)
        self.pub_xsens1 = self.create_publisher(Imu, '/xsens1/imu/data', 10)
        self.pub_xsens2 = self.create_publisher(Imu, '/xsens2/imu/data', 10)
        
        # Timer at 1000 Hz (0.001 s)
        self.timer = self.create_timer(0.002, self.timer_callback)
        self.get_logger().info("Mock IMU Node démarré (1000 Hz).")

    def timer_callback(self):
        now = self.get_clock().now()
        
        # OliveSense is the master clock (no jitter)
        self.publish_imu(self.pub_olive, now, 0.0)
        
        # Xsens 1 and 2 experience random jitter ranging from -0.5 ms to +0.5 ms
        self.publish_imu(self.pub_xsens1, now, random.uniform(-0.0005, 0.0005))
        self.publish_imu(self.pub_xsens2, now, random.uniform(-0.0005, 0.0005))

    def publish_imu(self, publisher, base_time, jitter_sec):
        msg = Imu()
        
        # Application of the jitter on the timestamp
        jittered_time = base_time.nanoseconds + int(jitter_sec * 1e9)
        msg.header.stamp.sec = int(jittered_time // 1e9)
        msg.header.stamp.nanosec = int(jittered_time % 1e9)
        msg.header.frame_id = "mock_frame"
        
         # Dummy data for averaging
        msg.linear_acceleration.x = 9.81 + random.uniform(-0.1, 0.1)
        
        publisher.publish(msg)

def main(args=None):
    rclpy.init(args=args)
    node = MockImuNode()
    try:
        rclpy.spin(node)
    except KeyboardInterrupt:
        pass
    finally:
        node.destroy_node()
        rclpy.shutdown()

if __name__ == '__main__':
    main()

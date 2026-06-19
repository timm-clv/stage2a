import os
from datetime import datetime
from launch import LaunchDescription
from launch.actions import ExecuteProcess

def generate_launch_description():
    # Génération d'un nom de dossier unique basé sur la date et l'heure
    bag_name = datetime.now().strftime('rosbag_%Y_%m_%d-%H_%M_%S')
    
    # Liste stricte des topics requis pour les phases de benchmark (EKF/VIO)
    topics_to_record = [
        '/olive/camera/image_synced/compressed',
        '/olive/camera/olivecam/image/camera_info',
        '/olive/camera/olivecam/filtered_ahrs',
        '/olive/olixSense/x1/oliveimu/velocity',
        '/olive/olixSense/x1/oliveimu/acceleration',
        '/olive/camera/olivecam/pose',
        '/olive/camera/olivecam/twist',
        '/olive/camera/olivecam/linear_acc',
        '/olive/olixSense/x1/oliveimu/imu',
        '/imu/fused',
        '/optical_flow/velocity',
        '/optical_flow/range',
        '/vrpn_mocap/RigidBody/pose',
        '/odometry/filtered_ekf',
        '/odometry/filtered_inekf',
        '/odometry/filtered_fusion'
    ]
    
    # Construction de la commande de l'exécutable ros2 bag
    record_command = ['ros2', 'bag', 'record',
    '--max-bag-size', '2147483648',   # 2 GB par fichier
    '--compression-mode', 'file',
    '--compression-format', 'zstd',
    '-o', bag_name] + topics_to_record

    return LaunchDescription([
        ExecuteProcess(
            cmd=record_command,
            output='screen'
        )
    ])

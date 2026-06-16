import os
from ament_index_python.packages import get_package_share_directory
from launch import LaunchDescription
from launch.actions import ExecuteProcess
from launch_ros.actions import Node
from ament_index_python.packages import get_package_prefix

def generate_launch_description():
    pkg_networking_lib = os.path.join(get_package_prefix('olive_networking'), 'lib', 'olive_networking')
    script_imu_path = os.path.join(pkg_networking_lib, 'setup_imu_namespace.sh')
    
    # 1. Isolation réseau de l'IMU (Crée le topic /imu/data avec horloge d'origine)
    network_setup = ExecuteProcess(
        cmd=['sudo', script_imu_path],
        output='screen'
    )

    return LaunchDescription([
        network_setup
    ])

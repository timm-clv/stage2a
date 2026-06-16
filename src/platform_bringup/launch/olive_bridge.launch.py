import os
from ament_index_python.packages import get_package_share_directory
from launch import LaunchDescription
from launch.actions import SetEnvironmentVariable
from launch_ros.actions import Node

def generate_launch_description():
    config_file = os.path.join(
        get_package_share_directory('platform_bringup'),
        'config',
        'olive_bridge.yaml'
    )

    # CRITIQUE : Désactiver le profil FastDDS global UNIQUEMENT pour le pont
    # Cela permet au bridge de parler librement sur les Domaines 3 et 0
    #reset_profile = SetEnvironmentVariable('FASTRTPS_DEFAULT_PROFILES_FILE', '')

    domain_bridge_node = Node(
        package='domain_bridge',
        executable='domain_bridge',
        name='olive_camera_bridge',
        arguments=[config_file],
        output='screen'
    )

    return LaunchDescription([
        #reset_profile,
        domain_bridge_node
    ])

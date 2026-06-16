import os
from ament_index_python.packages import get_package_share_directory
from launch import LaunchDescription
from launch.actions import IncludeLaunchDescription
from launch.launch_description_sources import PythonLaunchDescriptionSource
from launch_ros.actions import Node

def generate_launch_description():
    
    # 1. Inclusion de notre nœud pont (Domaine 3 -> Domaine 0)
    bridge_launch = IncludeLaunchDescription(
        PythonLaunchDescriptionSource([os.path.join(
            get_package_share_directory('platform_bringup'), 'launch', 'olive_bridge.launch.py'
        )])
    )

    # 2. Arbre TF2 (Publication de la position de la caméra)
    #static_tf_cam = Node(
    #    package='tf2_ros',
    #    executable='static_transform_publisher',
    #    name='base_link_to_olive_cam',
    #    arguments=['0.15', '0.0', '0.1', '0.0', '0.0', '0.0', 'base_link', 'olivecam_link'],
    #    output='screen'
    #)

    # Retour SANS rviz2_node
    return LaunchDescription([
        bridge_launch,
        #static_tf_cam
    ])

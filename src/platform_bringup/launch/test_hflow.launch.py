import os
from launch import LaunchDescription
from launch.actions import SetEnvironmentVariable
from launch_ros.actions import Node

def generate_launch_description():
    
    # 1. On s'assure d'être sur le domaine principal (0)
    #set_domain_id = SetEnvironmentVariable('ROS_DOMAIN_ID', '0')

    # 2. Arbre TF2 (REP-105)
    # L'optical flow regarde généralement vers le sol. 
    # J'ai mis un décalage en Z (-5cm), à ajuster selon ta CAO.
    # Remplace 'optical_flow_link' par le frame_id réel publié par ton noeud.
    #static_tf_flow = Node(
    #    package='tf2_ros',
    #    executable='static_transform_publisher',
    #    name='base_link_to_flow',
    #    arguments=['0.0', '0.0', '-0.05', '0.0', '0.0', '0.0', 'base_link', 'optical_flow_link'],
    #    output='screen'
    #)

    # 3. Le Driver CAN (Pont UAVCAN -> ROS 2)
    # ATTENTION: Vérifie le nom de l'executable dans le CMakeLists.txt 
    # de ton package 'uavcan_bridge' (je présume 'uavcan_bridge_node').
    uavcan_node = Node(
        package='uavcan_bridge',
        executable='dronecan_bridge_node', # <- Nom mis à jour ici
        name='hflow_can_bridge',
        parameters=[{
            'can_interface': 'slcan0',
            'node_id': 127
        }],
        output='screen'
    )

    return LaunchDescription([
        #set_domain_id,
        #static_tf_flow,
        uavcan_node
    ])

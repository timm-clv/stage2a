import os
from launch import LaunchDescription
from launch.actions import SetEnvironmentVariable, ExecuteProcess
from launch_ros.actions import Node

def generate_launch_description():
    
    # 1. Configuration des variables d'environnement DDS et Domaine
    #set_domain_id = SetEnvironmentVariable('ROS_DOMAIN_ID', '0') 
    #set_fastdds_profile = SetEnvironmentVariable(
    #    'FASTRTPS_DEFAULT_PROFILES_FILE', 
    #    '/home/darts/sensor_platform_ws/src/olive_networking/config/fastdds_profiles.xml'
    #)

    # 2. Automatisation : Exécution du script réseau et du relais ROS 2 en arrière-plan
    script_path = '/home/darts/sensor_platform_ws/src/olive_networking/scripts/setup_imu_namespace.sh'
    network_setup = ExecuteProcess(
        cmd=['sudo', script_path],
        output='screen'
    )

    # 3. Arbre TF2 Statique (Convention REP-105)
    #static_tf_imu = Node(
    #    package='tf2_ros',
    #    executable='static_transform_publisher',
    #    name='base_link_to_olive_imu',
    #    arguments=[
    #        '--x', '0.0', '--y', '0.0', '--z', '0.05', 
    #        '--roll', '0.0', '--pitch', '0.0', '--yaw', '0.0', 
    #        '--frame-id', 'base_link', 
    #        '--child-frame-id', 'id001_base_link'
    #    ],
    #    output='screen'
    #)

    return LaunchDescription([
        #set_domain_id,
        #set_fastdds_profile,
        network_setup,
        #static_tf_imu
    ])

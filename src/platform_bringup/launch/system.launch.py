import os
from ament_index_python.packages import get_package_share_directory
from launch import LaunchDescription
from launch.actions import TimerAction, SetEnvironmentVariable, ExecuteProcess
from launch_ros.actions import Node, ComposableNodeContainer
from launch_ros.descriptions import ComposableNode
import xacro
from ament_index_python.packages import get_package_prefix

def generate_launch_description():

    SetEnvironmentVariable('ROS_DOMAIN_ID', '3')
       
    # Extraction des chemins des packages
    pkg_networking = get_package_share_directory('olive_networking')
    pkg_desc = get_package_share_directory('platform_description')
    pkg_bringup = get_package_share_directory('platform_bringup')
    
    # Fichiers de configuration
    ekf_config = os.path.join(pkg_bringup, 'config', 'ekf.yaml')
    inekf_config = os.path.join(pkg_bringup, 'config', 'inekf.yaml')
    #fusion_config = os.path.join(pkg_bringup, 'config', 'fusioncore.yaml')
    

    # 2. Serveur d'allocation DroneCAN pour le Holybro H-Flow
    # Lancé via python3 directement depuis le dossier partagé pour éviter les conflits de binaires
    allocator_script_path = os.path.join(pkg_bringup, 'launch', 'can_allocator.py')
    hflow_allocator = ExecuteProcess(
        cmd=['python3', allocator_script_path],
        output='screen'
    )

    # --- MODIFICATION : Fusion des nœuds dans un conteneur unique Single-Threaded (Zéro-copie) ---
    sensor_processing_container = ComposableNodeContainer(
        name='sensor_processing_container',
        namespace='',
        package='rclcpp_components',
        executable='component_container_mt', # Utilisation de la version single-threaded plus légère
        composable_node_descriptions=[
            # Composant 1 : Pont matériel DroneCAN
            ComposableNode(
                package='uavcan_bridge',
                plugin='uavcan_bridge::DronecanBridgeComponent',
                name='hflow_can_bridge',
                parameters=[{
                    'can_interface': 'slcan0',
                    'node_id': 127
                }],
                extra_arguments=[{'use_intra_process_comms': True}] # Active le zéro-copie
            ),
            # Composant 2 : Alignement temporel et synchronisation
            ComposableNode(
                package='platform_processing',
                plugin='platform_processing::ImuSyncComponent',
                name='imu_sync_node',
                extra_arguments=[{'use_intra_process_comms': True}] # Active le zéro-copie
            )
        ],
        output='screen'
    )


    # 5. Modèle URDF du Robot (Source de vérité géométrique unique - REP-105)
    xacro_file = os.path.join(pkg_desc, 'urdf', 'sensor_platform.urdf.xacro')
    robot_description_raw = xacro.process_file(xacro_file).toxml()
    rsp_node = Node(
        package='robot_state_publisher',
        executable='robot_state_publisher',
        name='robot_state_publisher',
        output='screen',
        parameters=[{'robot_description': robot_description_raw}]
    )        



    # 7.1 Filtre de Fusion EKF
    ekf_node = Node(
        package='robot_localization',
        executable='ekf_node',
        name='ekf_filter_node',
        output='screen',
        parameters=[ekf_config, {'use_sim_time': False}],
        remappings=[
            ('odometry/filtered', 'odometry/filtered_ekf'),
            ('accel/filtered', 'accel/filtered_ekf')
        ]
    )
    delayed_ekf = TimerAction(period=3.0, actions=[ekf_node])

    # 7.2 Filtre de Fusion InEKF (Désactivé temporairement)
    # À décommenter quand tu auras compilé le bon package InEKF
    # inekf_node = Node(
    #     package='nom_du_package_inekf', # Ce n'est pas robot_localization
    #     executable='nom_executable_inekf',
    #     name='inekf_filter_node',
    #     output='screen',
    #     parameters=[inekf_config, {'use_sim_time': False}],
    #     remappings=[('odometry/filtered', 'odometry/filtered_inekf')]
    # )
    # delayed_inekf = TimerAction(period=3.0, actions=[inekf_node])
    
    # 7.3 Filtre de Fusion FUSIONCORE 
    #fusion_node = Node(
    #    package='robot_localization',
    #    executable='ekf_node',
    #    name='fusion_filter_node',
    #    output='screen',
    #    parameters=[fusion_config, {'use_sim_time': False}],
    #    remappings=[
    #        ('odometry/filtered', 'odometry/filtered_fusion'),
    #        ('accel/filtered', 'accel/filtered_fusion')
    #    ]
    #)
    #delayed_fusion = TimerAction(period=3.0, actions=[fusion_node])
    
    # 8. Client VRPN
    vrpn_node = Node(
        package='vrpn_mocap',
        executable='client_node',
        name='vrpn_client',
        parameters=[{
            'server': '192.168.0.101', 
            'port': 3883,
            'update_freq': 100.0,     
            'frame_id': 'map',        
            'use_sim_time': False,
        }],
        output='screen'
    )

    return LaunchDescription([
        hflow_allocator,
        rsp_node,
        sensor_processing_container,
        #delayed_ekf,
        # delayed_inekf, 
        #delayed_fusion,
        #vrpn_node,
    ])

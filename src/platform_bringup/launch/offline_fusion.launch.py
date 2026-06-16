import os
from ament_index_python.packages import get_package_share_directory
from launch import LaunchDescription
from launch.actions import ExecuteProcess
from launch_ros.actions import Node
import xacro

def generate_launch_description():
    pkg_bringup = get_package_share_directory('platform_bringup')
    pkg_desc = get_package_share_directory('platform_description')
    
    ekf_config = os.path.join(pkg_bringup, 'config', 'ekf.yaml')
    ukf_config = os.path.join(pkg_bringup, 'config', 'ukf.yaml')
    
    # Aligne le zéro OptiTrack (map) avec le zéro EKF (odom)
    tf_align_node = Node(
        package='tf2_ros',
        executable='static_transform_publisher',
        name='map_to_odom_aligner',
        arguments=['0', '0', '0', '0', '0', '0', 'map', 'odom'],
        parameters=[{'use_sim_time': True}]
    )

    # 1. TF Statique (Indispensable pour l'EKF/UKF)
    xacro_file = os.path.join(pkg_desc, 'urdf', 'sensor_platform.urdf.xacro')
    robot_description_raw = xacro.process_file(xacro_file).toxml()
    
    rsp_node = Node(
        package='robot_state_publisher',
        executable='robot_state_publisher',
        parameters=[
            {'robot_description': robot_description_raw},
            {'use_sim_time': True} # CRITIQUE : Se synchronise sur le rosbag
        ]
    )

    # 2. Filtre EKF
    ekf_node = Node(
        package='robot_localization',
        executable='ekf_node',
        name='ekf_filter_node',
        parameters=[ekf_config, {'use_sim_time': True}],
        remappings=[
            ('odometry/filtered', 'odometry/filtered_ekf'),
            ('accel/filtered', 'accel/filtered_ekf')
        ]
    )

    # 3. Filtre UKF
    ukf_node = Node(
        package='robot_localization',
        executable='ukf_node',
        name='ukf_filter_node',
        parameters=[ukf_config, {'use_sim_time': True}],
        remappings=[
            ('odometry/filtered', 'odometry/filtered_ukf'),
            ('accel/filtered', 'accel/filtered_ukf')
        ]
    )

    # 4. PlotJuggler
    plotjuggler_node = Node(
        package='plotjuggler',
        executable='plotjuggler',
        name='plotjuggler',
        parameters=[{'use_sim_time': True}], # Méthode propre pour ROS 2
        output='screen'
    )

    return LaunchDescription([
        rsp_node,
        ekf_node,
        ukf_node,
        plotjuggler_node
    ])

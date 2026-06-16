from launch import LaunchDescription
from launch_ros.actions import Node, ComposableNodeContainer
from launch_ros.descriptions import ComposableNode

def generate_launch_description():
    # C++ component container (high-performance, intra-process-ready)
    sync_container = ComposableNodeContainer(
        name='sensor_processing_container',
        namespace='',
        package='rclcpp_components',
        executable='component_container',
        composable_node_descriptions=[
            ComposableNode(
                package='platform_processing',
                plugin='platform_processing::ImuSyncComponent',
                name='imu_sync_node',
                extra_arguments=[{'use_intra_process_comms': True}] 
            )
        ],
        output='screen',
    )

    # Nœud Mock in Python
    mock_node = Node(
        package='platform_processing',
        executable='mock_imu_node.py',
        name='mock_imu_node',
        output='screen'
    )

    return LaunchDescription([
        sync_container,
        mock_node
    ])

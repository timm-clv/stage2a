cmake_minimum_required(VERSION 3.8)
project(uavcan_bridge)

if(CMAKE_COMPILER_IS_GNUCXX OR CMAKE_CXX_COMPILER_ID MATCHES "Clang")
  add_compile_options(-Wall -Wextra -Wpedantic)
endif()

# --- 1. Recherche des dépendances ---
find_package(ament_cmake REQUIRED)
find_package(rclcpp REQUIRED)
find_package(rclcpp_components REQUIRED)
find_package(geometry_msgs REQUIRED)
find_package(sensor_msgs REQUIRED) # Ajout pour la hauteur (Range)

# --- 2. Inclusion de la librairie C pure (libcanard) ---
include_directories(include/libcanard)

# --- 3. Création de la librairie partagée (Le Composant ROS 2) ---
add_library(dronecan_bridge_component SHARED 
  src/dronecan_bridge_component.cpp
  include/libcanard/canard.c
)

target_compile_features(dronecan_bridge_component PUBLIC c_std_99 cxx_std_17)

# --- 4. Lier le composant à ses dépendances ---
ament_target_dependencies(dronecan_bridge_component 
  rclcpp 
  rclcpp_components 
  geometry_msgs 
  sensor_msgs
)

# --- 5. Enregistrement du composant et création automatique de l'exécutable ---
# C'est cette macro qui crée le fichier binaire final nommé "dronecan_bridge_node"
rclcpp_components_register_node(dronecan_bridge_component 
  PLUGIN "uavcan_bridge::DronecanBridgeComponent" 
  EXECUTABLE dronecan_bridge_node
)

# --- 6. Règles d'installation ---
install(TARGETS
  dronecan_bridge_component
  ARCHIVE DESTINATION lib
  LIBRARY DESTINATION lib
  RUNTIME DESTINATION bin
)

ament_export_dependencies(rclcpp rclcpp_components geometry_msgs sensor_msgs)
ament_package()

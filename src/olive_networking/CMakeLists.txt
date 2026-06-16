cmake_minimum_required(VERSION 3.8)
project(olive_networking)

if(CMAKE_COMPILER_IS_GNUCXX OR CMAKE_CXX_COMPILER_ID MATCHES "Clang")
  add_compile_options(-Wall -Wextra -Wpedantic)
endif()

# find dependencies
find_package(ament_cmake REQUIRED)
# uncomment the following section in order to fill in
# further dependencies manually.
# find_package(<dependency> REQUIRED)

if(BUILD_TESTING)
  find_package(ament_lint_auto REQUIRED)
  # the following line skips the linter which checks for copyrights
  # comment the line when a copyright and license is added to all source files
  set(ament_cmake_copyright_FOUND TRUE)
  # the following line skips cpplint (only works in a git repo)
  # comment the line when this package is in a git repo and when
  # a copyright and license is added to all source files
  set(ament_cmake_cpplint_FOUND TRUE)
  ament_lint_auto_find_test_dependencies()
endif()


# Installer les règles udev dans le dossier de partage du package
install(FILES
  rules/99-olive-networking.rules
  DESTINATION share/${PROJECT_NAME}/udev
)

# Rendre le script exécutable et l'installer dans le répertoire attendu
install(PROGRAMS
  scripts/olive_network_configuration.sh
  scripts/setup_imu_namespace.sh
  scripts/imu_relay.py
  DESTINATION lib/${PROJECT_NAME}/scripts
)

# Installer le dossier config contenant les fichiers YAML
install(DIRECTORY config
  DESTINATION share/${PROJECT_NAME}
)


ament_package()

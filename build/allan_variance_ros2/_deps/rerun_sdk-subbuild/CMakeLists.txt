# Distributed under the OSI-approved BSD 3-Clause License.  See accompanying
# file Copyright.txt or https://cmake.org/licensing for details.

cmake_minimum_required(VERSION 3.22.1)

# We name the project and the target for the ExternalProject_Add() call
# to something that will highlight to the user what we are working on if
# something goes wrong and an error message is produced.

project(rerun_sdk-populate NONE)



include(ExternalProject)
ExternalProject_Add(rerun_sdk-populate
                     "UPDATE_DISCONNECTED" "False" "URL" "https://github.com/rerun-io/rerun/releases/latest/download/rerun_cpp_sdk.zip"
                    SOURCE_DIR          "/home/student/sensor_platform_ws/build/allan_variance_ros2/_deps/rerun_sdk-src"
                    BINARY_DIR          "/home/student/sensor_platform_ws/build/allan_variance_ros2/_deps/rerun_sdk-build"
                    CONFIGURE_COMMAND   ""
                    BUILD_COMMAND       ""
                    INSTALL_COMMAND     ""
                    TEST_COMMAND        ""
                    USES_TERMINAL_DOWNLOAD  YES
                    USES_TERMINAL_UPDATE    YES
)



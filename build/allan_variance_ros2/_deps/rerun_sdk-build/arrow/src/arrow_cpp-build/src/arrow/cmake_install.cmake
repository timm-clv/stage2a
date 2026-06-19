# Install script for directory: /home/student/sensor_platform_ws/build/allan_variance_ros2/_deps/rerun_sdk-build/arrow/src/arrow_cpp/cpp/src/arrow

# Set the install prefix
if(NOT DEFINED CMAKE_INSTALL_PREFIX)
  set(CMAKE_INSTALL_PREFIX "/home/student/sensor_platform_ws/build/allan_variance_ros2/_deps/rerun_sdk-build/arrow")
endif()
string(REGEX REPLACE "/$" "" CMAKE_INSTALL_PREFIX "${CMAKE_INSTALL_PREFIX}")

# Set the install configuration name.
if(NOT DEFINED CMAKE_INSTALL_CONFIG_NAME)
  if(BUILD_TYPE)
    string(REGEX REPLACE "^[^A-Za-z0-9_]+" ""
           CMAKE_INSTALL_CONFIG_NAME "${BUILD_TYPE}")
  else()
    set(CMAKE_INSTALL_CONFIG_NAME "RELEASE")
  endif()
  message(STATUS "Install configuration: \"${CMAKE_INSTALL_CONFIG_NAME}\"")
endif()

# Set the component getting installed.
if(NOT CMAKE_INSTALL_COMPONENT)
  if(COMPONENT)
    message(STATUS "Install component: \"${COMPONENT}\"")
    set(CMAKE_INSTALL_COMPONENT "${COMPONENT}")
  else()
    set(CMAKE_INSTALL_COMPONENT)
  endif()
endif()

# Install shared libraries without execute permission?
if(NOT DEFINED CMAKE_INSTALL_SO_NO_EXE)
  set(CMAKE_INSTALL_SO_NO_EXE "1")
endif()

# Is this installation the result of a crosscompile?
if(NOT DEFINED CMAKE_CROSSCOMPILING)
  set(CMAKE_CROSSCOMPILING "FALSE")
endif()

# Set default install directory permissions.
if(NOT DEFINED CMAKE_OBJDUMP)
  set(CMAKE_OBJDUMP "/usr/bin/objdump")
endif()

if("x${CMAKE_INSTALL_COMPONENT}x" STREQUAL "xUnspecifiedx" OR NOT CMAKE_INSTALL_COMPONENT)
  file(INSTALL DESTINATION "${CMAKE_INSTALL_PREFIX}/include/arrow/util" TYPE FILE FILES "/home/student/sensor_platform_ws/build/allan_variance_ros2/_deps/rerun_sdk-build/arrow/src/arrow_cpp-build/src/arrow/util/config.h")
endif()

if("x${CMAKE_INSTALL_COMPONENT}x" STREQUAL "xUnspecifiedx" OR NOT CMAKE_INSTALL_COMPONENT)
  file(INSTALL DESTINATION "${CMAKE_INSTALL_PREFIX}/lib" TYPE FILE FILES "/home/student/sensor_platform_ws/build/allan_variance_ros2/_deps/rerun_sdk-build/arrow/src/arrow_cpp-build/release/libarrow_bundled_dependencies.a")
endif()

if("x${CMAKE_INSTALL_COMPONENT}x" STREQUAL "xUnspecifiedx" OR NOT CMAKE_INSTALL_COMPONENT)
  file(INSTALL DESTINATION "${CMAKE_INSTALL_PREFIX}/lib" TYPE STATIC_LIBRARY FILES "/home/student/sensor_platform_ws/build/allan_variance_ros2/_deps/rerun_sdk-build/arrow/src/arrow_cpp-build/release/libarrow.a")
endif()

if("x${CMAKE_INSTALL_COMPONENT}x" STREQUAL "xUnspecifiedx" OR NOT CMAKE_INSTALL_COMPONENT)
  file(INSTALL DESTINATION "${CMAKE_INSTALL_PREFIX}/lib/cmake/Arrow" TYPE FILE FILES
    "/home/student/sensor_platform_ws/build/allan_variance_ros2/_deps/rerun_sdk-build/arrow/src/arrow_cpp-build/src/arrow/ArrowConfig.cmake"
    "/home/student/sensor_platform_ws/build/allan_variance_ros2/_deps/rerun_sdk-build/arrow/src/arrow_cpp-build/src/arrow/ArrowConfigVersion.cmake"
    )
endif()

if("x${CMAKE_INSTALL_COMPONENT}x" STREQUAL "xUnspecifiedx" OR NOT CMAKE_INSTALL_COMPONENT)
  if(EXISTS "$ENV{DESTDIR}${CMAKE_INSTALL_PREFIX}/lib/cmake/Arrow/ArrowTargets.cmake")
    file(DIFFERENT EXPORT_FILE_CHANGED FILES
         "$ENV{DESTDIR}${CMAKE_INSTALL_PREFIX}/lib/cmake/Arrow/ArrowTargets.cmake"
         "/home/student/sensor_platform_ws/build/allan_variance_ros2/_deps/rerun_sdk-build/arrow/src/arrow_cpp-build/src/arrow/CMakeFiles/Export/lib/cmake/Arrow/ArrowTargets.cmake")
    if(EXPORT_FILE_CHANGED)
      file(GLOB OLD_CONFIG_FILES "$ENV{DESTDIR}${CMAKE_INSTALL_PREFIX}/lib/cmake/Arrow/ArrowTargets-*.cmake")
      if(OLD_CONFIG_FILES)
        message(STATUS "Old export file \"$ENV{DESTDIR}${CMAKE_INSTALL_PREFIX}/lib/cmake/Arrow/ArrowTargets.cmake\" will be replaced.  Removing files [${OLD_CONFIG_FILES}].")
        file(REMOVE ${OLD_CONFIG_FILES})
      endif()
    endif()
  endif()
  file(INSTALL DESTINATION "${CMAKE_INSTALL_PREFIX}/lib/cmake/Arrow" TYPE FILE FILES "/home/student/sensor_platform_ws/build/allan_variance_ros2/_deps/rerun_sdk-build/arrow/src/arrow_cpp-build/src/arrow/CMakeFiles/Export/lib/cmake/Arrow/ArrowTargets.cmake")
  if("${CMAKE_INSTALL_CONFIG_NAME}" MATCHES "^([Rr][Ee][Ll][Ee][Aa][Ss][Ee])$")
    file(INSTALL DESTINATION "${CMAKE_INSTALL_PREFIX}/lib/cmake/Arrow" TYPE FILE FILES "/home/student/sensor_platform_ws/build/allan_variance_ros2/_deps/rerun_sdk-build/arrow/src/arrow_cpp-build/src/arrow/CMakeFiles/Export/lib/cmake/Arrow/ArrowTargets-release.cmake")
  endif()
endif()

if("x${CMAKE_INSTALL_COMPONENT}x" STREQUAL "xUnspecifiedx" OR NOT CMAKE_INSTALL_COMPONENT)
  file(INSTALL DESTINATION "${CMAKE_INSTALL_PREFIX}/lib/pkgconfig" TYPE FILE FILES "/home/student/sensor_platform_ws/build/allan_variance_ros2/_deps/rerun_sdk-build/arrow/src/arrow_cpp-build/src/arrow/RELEASE/arrow.pc")
endif()

if("x${CMAKE_INSTALL_COMPONENT}x" STREQUAL "xUnspecifiedx" OR NOT CMAKE_INSTALL_COMPONENT)
  file(INSTALL DESTINATION "${CMAKE_INSTALL_PREFIX}/include/arrow" TYPE FILE FILES
    "/home/student/sensor_platform_ws/build/allan_variance_ros2/_deps/rerun_sdk-build/arrow/src/arrow_cpp/cpp/src/arrow/api.h"
    "/home/student/sensor_platform_ws/build/allan_variance_ros2/_deps/rerun_sdk-build/arrow/src/arrow_cpp/cpp/src/arrow/array.h"
    "/home/student/sensor_platform_ws/build/allan_variance_ros2/_deps/rerun_sdk-build/arrow/src/arrow_cpp/cpp/src/arrow/buffer.h"
    "/home/student/sensor_platform_ws/build/allan_variance_ros2/_deps/rerun_sdk-build/arrow/src/arrow_cpp/cpp/src/arrow/buffer_builder.h"
    "/home/student/sensor_platform_ws/build/allan_variance_ros2/_deps/rerun_sdk-build/arrow/src/arrow_cpp/cpp/src/arrow/builder.h"
    "/home/student/sensor_platform_ws/build/allan_variance_ros2/_deps/rerun_sdk-build/arrow/src/arrow_cpp/cpp/src/arrow/chunk_resolver.h"
    "/home/student/sensor_platform_ws/build/allan_variance_ros2/_deps/rerun_sdk-build/arrow/src/arrow_cpp/cpp/src/arrow/chunked_array.h"
    "/home/student/sensor_platform_ws/build/allan_variance_ros2/_deps/rerun_sdk-build/arrow/src/arrow_cpp/cpp/src/arrow/compare.h"
    "/home/student/sensor_platform_ws/build/allan_variance_ros2/_deps/rerun_sdk-build/arrow/src/arrow_cpp/cpp/src/arrow/config.h"
    "/home/student/sensor_platform_ws/build/allan_variance_ros2/_deps/rerun_sdk-build/arrow/src/arrow_cpp/cpp/src/arrow/datum.h"
    "/home/student/sensor_platform_ws/build/allan_variance_ros2/_deps/rerun_sdk-build/arrow/src/arrow_cpp/cpp/src/arrow/device.h"
    "/home/student/sensor_platform_ws/build/allan_variance_ros2/_deps/rerun_sdk-build/arrow/src/arrow_cpp/cpp/src/arrow/device_allocation_type_set.h"
    "/home/student/sensor_platform_ws/build/allan_variance_ros2/_deps/rerun_sdk-build/arrow/src/arrow_cpp/cpp/src/arrow/extension_type.h"
    "/home/student/sensor_platform_ws/build/allan_variance_ros2/_deps/rerun_sdk-build/arrow/src/arrow_cpp/cpp/src/arrow/memory_pool.h"
    "/home/student/sensor_platform_ws/build/allan_variance_ros2/_deps/rerun_sdk-build/arrow/src/arrow_cpp/cpp/src/arrow/memory_pool_test.h"
    "/home/student/sensor_platform_ws/build/allan_variance_ros2/_deps/rerun_sdk-build/arrow/src/arrow_cpp/cpp/src/arrow/pch.h"
    "/home/student/sensor_platform_ws/build/allan_variance_ros2/_deps/rerun_sdk-build/arrow/src/arrow_cpp/cpp/src/arrow/pretty_print.h"
    "/home/student/sensor_platform_ws/build/allan_variance_ros2/_deps/rerun_sdk-build/arrow/src/arrow_cpp/cpp/src/arrow/record_batch.h"
    "/home/student/sensor_platform_ws/build/allan_variance_ros2/_deps/rerun_sdk-build/arrow/src/arrow_cpp/cpp/src/arrow/result.h"
    "/home/student/sensor_platform_ws/build/allan_variance_ros2/_deps/rerun_sdk-build/arrow/src/arrow_cpp/cpp/src/arrow/scalar.h"
    "/home/student/sensor_platform_ws/build/allan_variance_ros2/_deps/rerun_sdk-build/arrow/src/arrow_cpp/cpp/src/arrow/sparse_tensor.h"
    "/home/student/sensor_platform_ws/build/allan_variance_ros2/_deps/rerun_sdk-build/arrow/src/arrow_cpp/cpp/src/arrow/status.h"
    "/home/student/sensor_platform_ws/build/allan_variance_ros2/_deps/rerun_sdk-build/arrow/src/arrow_cpp/cpp/src/arrow/stl.h"
    "/home/student/sensor_platform_ws/build/allan_variance_ros2/_deps/rerun_sdk-build/arrow/src/arrow_cpp/cpp/src/arrow/stl_allocator.h"
    "/home/student/sensor_platform_ws/build/allan_variance_ros2/_deps/rerun_sdk-build/arrow/src/arrow_cpp/cpp/src/arrow/stl_iterator.h"
    "/home/student/sensor_platform_ws/build/allan_variance_ros2/_deps/rerun_sdk-build/arrow/src/arrow_cpp/cpp/src/arrow/table.h"
    "/home/student/sensor_platform_ws/build/allan_variance_ros2/_deps/rerun_sdk-build/arrow/src/arrow_cpp/cpp/src/arrow/table_builder.h"
    "/home/student/sensor_platform_ws/build/allan_variance_ros2/_deps/rerun_sdk-build/arrow/src/arrow_cpp/cpp/src/arrow/tensor.h"
    "/home/student/sensor_platform_ws/build/allan_variance_ros2/_deps/rerun_sdk-build/arrow/src/arrow_cpp/cpp/src/arrow/type.h"
    "/home/student/sensor_platform_ws/build/allan_variance_ros2/_deps/rerun_sdk-build/arrow/src/arrow_cpp/cpp/src/arrow/type_fwd.h"
    "/home/student/sensor_platform_ws/build/allan_variance_ros2/_deps/rerun_sdk-build/arrow/src/arrow_cpp/cpp/src/arrow/type_traits.h"
    "/home/student/sensor_platform_ws/build/allan_variance_ros2/_deps/rerun_sdk-build/arrow/src/arrow_cpp/cpp/src/arrow/visit_array_inline.h"
    "/home/student/sensor_platform_ws/build/allan_variance_ros2/_deps/rerun_sdk-build/arrow/src/arrow_cpp/cpp/src/arrow/visit_data_inline.h"
    "/home/student/sensor_platform_ws/build/allan_variance_ros2/_deps/rerun_sdk-build/arrow/src/arrow_cpp/cpp/src/arrow/visit_scalar_inline.h"
    "/home/student/sensor_platform_ws/build/allan_variance_ros2/_deps/rerun_sdk-build/arrow/src/arrow_cpp/cpp/src/arrow/visit_type_inline.h"
    "/home/student/sensor_platform_ws/build/allan_variance_ros2/_deps/rerun_sdk-build/arrow/src/arrow_cpp/cpp/src/arrow/visitor.h"
    "/home/student/sensor_platform_ws/build/allan_variance_ros2/_deps/rerun_sdk-build/arrow/src/arrow_cpp/cpp/src/arrow/visitor_generate.h"
    )
endif()

if("x${CMAKE_INSTALL_COMPONENT}x" STREQUAL "xUnspecifiedx" OR NOT CMAKE_INSTALL_COMPONENT)
  file(INSTALL DESTINATION "${CMAKE_INSTALL_PREFIX}/lib/cmake/Arrow" TYPE FILE FILES "/home/student/sensor_platform_ws/build/allan_variance_ros2/_deps/rerun_sdk-build/arrow/src/arrow_cpp-build/src/arrow/ArrowOptions.cmake")
endif()

if("x${CMAKE_INSTALL_COMPONENT}x" STREQUAL "xUnspecifiedx" OR NOT CMAKE_INSTALL_COMPONENT)
  file(INSTALL DESTINATION "${CMAKE_INSTALL_PREFIX}/lib/cmake/Arrow" TYPE FILE FILES "/home/student/sensor_platform_ws/build/allan_variance_ros2/_deps/rerun_sdk-build/arrow/src/arrow_cpp/cpp/src/arrow/arrow-config.cmake")
endif()

if(NOT CMAKE_INSTALL_LOCAL_ONLY)
  # Include the install script for the subdirectory.
  include("/home/student/sensor_platform_ws/build/allan_variance_ros2/_deps/rerun_sdk-build/arrow/src/arrow_cpp-build/src/arrow/testing/cmake_install.cmake")
endif()

if(NOT CMAKE_INSTALL_LOCAL_ONLY)
  # Include the install script for the subdirectory.
  include("/home/student/sensor_platform_ws/build/allan_variance_ros2/_deps/rerun_sdk-build/arrow/src/arrow_cpp-build/src/arrow/array/cmake_install.cmake")
endif()

if(NOT CMAKE_INSTALL_LOCAL_ONLY)
  # Include the install script for the subdirectory.
  include("/home/student/sensor_platform_ws/build/allan_variance_ros2/_deps/rerun_sdk-build/arrow/src/arrow_cpp-build/src/arrow/c/cmake_install.cmake")
endif()

if(NOT CMAKE_INSTALL_LOCAL_ONLY)
  # Include the install script for the subdirectory.
  include("/home/student/sensor_platform_ws/build/allan_variance_ros2/_deps/rerun_sdk-build/arrow/src/arrow_cpp-build/src/arrow/compute/cmake_install.cmake")
endif()

if(NOT CMAKE_INSTALL_LOCAL_ONLY)
  # Include the install script for the subdirectory.
  include("/home/student/sensor_platform_ws/build/allan_variance_ros2/_deps/rerun_sdk-build/arrow/src/arrow_cpp-build/src/arrow/extension/cmake_install.cmake")
endif()

if(NOT CMAKE_INSTALL_LOCAL_ONLY)
  # Include the install script for the subdirectory.
  include("/home/student/sensor_platform_ws/build/allan_variance_ros2/_deps/rerun_sdk-build/arrow/src/arrow_cpp-build/src/arrow/io/cmake_install.cmake")
endif()

if(NOT CMAKE_INSTALL_LOCAL_ONLY)
  # Include the install script for the subdirectory.
  include("/home/student/sensor_platform_ws/build/allan_variance_ros2/_deps/rerun_sdk-build/arrow/src/arrow_cpp-build/src/arrow/tensor/cmake_install.cmake")
endif()

if(NOT CMAKE_INSTALL_LOCAL_ONLY)
  # Include the install script for the subdirectory.
  include("/home/student/sensor_platform_ws/build/allan_variance_ros2/_deps/rerun_sdk-build/arrow/src/arrow_cpp-build/src/arrow/util/cmake_install.cmake")
endif()

if(NOT CMAKE_INSTALL_LOCAL_ONLY)
  # Include the install script for the subdirectory.
  include("/home/student/sensor_platform_ws/build/allan_variance_ros2/_deps/rerun_sdk-build/arrow/src/arrow_cpp-build/src/arrow/vendored/cmake_install.cmake")
endif()

if(NOT CMAKE_INSTALL_LOCAL_ONLY)
  # Include the install script for the subdirectory.
  include("/home/student/sensor_platform_ws/build/allan_variance_ros2/_deps/rerun_sdk-build/arrow/src/arrow_cpp-build/src/arrow/ipc/cmake_install.cmake")
endif()


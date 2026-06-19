# Install script for directory: /home/student/sensor_platform_ws/build/allan_variance_ros2/_deps/rerun_sdk-build/arrow/src/arrow_cpp-build/mimalloc_ep-prefix/src/mimalloc_ep

# Set the install prefix
if(NOT DEFINED CMAKE_INSTALL_PREFIX)
  set(CMAKE_INSTALL_PREFIX "/home/student/sensor_platform_ws/build/allan_variance_ros2/_deps/rerun_sdk-build/arrow/src/arrow_cpp-build/mimalloc_ep/src/mimalloc_ep")
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
  file(INSTALL DESTINATION "${CMAKE_INSTALL_PREFIX}/lib/mimalloc-2.0" TYPE STATIC_LIBRARY FILES "/home/student/sensor_platform_ws/build/allan_variance_ros2/_deps/rerun_sdk-build/arrow/src/arrow_cpp-build/mimalloc_ep-prefix/src/mimalloc_ep-build/libmimalloc.a")
endif()

if("x${CMAKE_INSTALL_COMPONENT}x" STREQUAL "xUnspecifiedx" OR NOT CMAKE_INSTALL_COMPONENT)
  if(EXISTS "$ENV{DESTDIR}${CMAKE_INSTALL_PREFIX}/lib/cmake/mimalloc-2.0/mimalloc.cmake")
    file(DIFFERENT EXPORT_FILE_CHANGED FILES
         "$ENV{DESTDIR}${CMAKE_INSTALL_PREFIX}/lib/cmake/mimalloc-2.0/mimalloc.cmake"
         "/home/student/sensor_platform_ws/build/allan_variance_ros2/_deps/rerun_sdk-build/arrow/src/arrow_cpp-build/mimalloc_ep-prefix/src/mimalloc_ep-build/CMakeFiles/Export/lib/cmake/mimalloc-2.0/mimalloc.cmake")
    if(EXPORT_FILE_CHANGED)
      file(GLOB OLD_CONFIG_FILES "$ENV{DESTDIR}${CMAKE_INSTALL_PREFIX}/lib/cmake/mimalloc-2.0/mimalloc-*.cmake")
      if(OLD_CONFIG_FILES)
        message(STATUS "Old export file \"$ENV{DESTDIR}${CMAKE_INSTALL_PREFIX}/lib/cmake/mimalloc-2.0/mimalloc.cmake\" will be replaced.  Removing files [${OLD_CONFIG_FILES}].")
        file(REMOVE ${OLD_CONFIG_FILES})
      endif()
    endif()
  endif()
  file(INSTALL DESTINATION "${CMAKE_INSTALL_PREFIX}/lib/cmake/mimalloc-2.0" TYPE FILE FILES "/home/student/sensor_platform_ws/build/allan_variance_ros2/_deps/rerun_sdk-build/arrow/src/arrow_cpp-build/mimalloc_ep-prefix/src/mimalloc_ep-build/CMakeFiles/Export/lib/cmake/mimalloc-2.0/mimalloc.cmake")
  if("${CMAKE_INSTALL_CONFIG_NAME}" MATCHES "^([Rr][Ee][Ll][Ee][Aa][Ss][Ee])$")
    file(INSTALL DESTINATION "${CMAKE_INSTALL_PREFIX}/lib/cmake/mimalloc-2.0" TYPE FILE FILES "/home/student/sensor_platform_ws/build/allan_variance_ros2/_deps/rerun_sdk-build/arrow/src/arrow_cpp-build/mimalloc_ep-prefix/src/mimalloc_ep-build/CMakeFiles/Export/lib/cmake/mimalloc-2.0/mimalloc-release.cmake")
  endif()
endif()

if("x${CMAKE_INSTALL_COMPONENT}x" STREQUAL "xUnspecifiedx" OR NOT CMAKE_INSTALL_COMPONENT)
  file(INSTALL DESTINATION "${CMAKE_INSTALL_PREFIX}/include/mimalloc-2.0" TYPE FILE FILES "/home/student/sensor_platform_ws/build/allan_variance_ros2/_deps/rerun_sdk-build/arrow/src/arrow_cpp-build/mimalloc_ep-prefix/src/mimalloc_ep/include/mimalloc.h")
endif()

if("x${CMAKE_INSTALL_COMPONENT}x" STREQUAL "xUnspecifiedx" OR NOT CMAKE_INSTALL_COMPONENT)
  file(INSTALL DESTINATION "${CMAKE_INSTALL_PREFIX}/include/mimalloc-2.0" TYPE FILE FILES "/home/student/sensor_platform_ws/build/allan_variance_ros2/_deps/rerun_sdk-build/arrow/src/arrow_cpp-build/mimalloc_ep-prefix/src/mimalloc_ep/include/mimalloc-override.h")
endif()

if("x${CMAKE_INSTALL_COMPONENT}x" STREQUAL "xUnspecifiedx" OR NOT CMAKE_INSTALL_COMPONENT)
  file(INSTALL DESTINATION "${CMAKE_INSTALL_PREFIX}/include/mimalloc-2.0" TYPE FILE FILES "/home/student/sensor_platform_ws/build/allan_variance_ros2/_deps/rerun_sdk-build/arrow/src/arrow_cpp-build/mimalloc_ep-prefix/src/mimalloc_ep/include/mimalloc-new-delete.h")
endif()

if("x${CMAKE_INSTALL_COMPONENT}x" STREQUAL "xUnspecifiedx" OR NOT CMAKE_INSTALL_COMPONENT)
  file(INSTALL DESTINATION "${CMAKE_INSTALL_PREFIX}/lib/cmake/mimalloc-2.0" TYPE FILE FILES "/home/student/sensor_platform_ws/build/allan_variance_ros2/_deps/rerun_sdk-build/arrow/src/arrow_cpp-build/mimalloc_ep-prefix/src/mimalloc_ep/cmake/mimalloc-config.cmake")
endif()

if("x${CMAKE_INSTALL_COMPONENT}x" STREQUAL "xUnspecifiedx" OR NOT CMAKE_INSTALL_COMPONENT)
  file(INSTALL DESTINATION "${CMAKE_INSTALL_PREFIX}/lib/cmake/mimalloc-2.0" TYPE FILE FILES "/home/student/sensor_platform_ws/build/allan_variance_ros2/_deps/rerun_sdk-build/arrow/src/arrow_cpp-build/mimalloc_ep-prefix/src/mimalloc_ep/cmake/mimalloc-config-version.cmake")
endif()

if(CMAKE_INSTALL_COMPONENT)
  set(CMAKE_INSTALL_MANIFEST "install_manifest_${CMAKE_INSTALL_COMPONENT}.txt")
else()
  set(CMAKE_INSTALL_MANIFEST "install_manifest.txt")
endif()

string(REPLACE ";" "\n" CMAKE_INSTALL_MANIFEST_CONTENT
       "${CMAKE_INSTALL_MANIFEST_FILES}")
file(WRITE "/home/student/sensor_platform_ws/build/allan_variance_ros2/_deps/rerun_sdk-build/arrow/src/arrow_cpp-build/mimalloc_ep-prefix/src/mimalloc_ep-build/${CMAKE_INSTALL_MANIFEST}"
     "${CMAKE_INSTALL_MANIFEST_CONTENT}")

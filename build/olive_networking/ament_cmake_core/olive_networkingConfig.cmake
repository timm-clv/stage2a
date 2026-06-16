# generated from ament/cmake/core/templates/nameConfig.cmake.in

# prevent multiple inclusion
if(_olive_networking_CONFIG_INCLUDED)
  # ensure to keep the found flag the same
  if(NOT DEFINED olive_networking_FOUND)
    # explicitly set it to FALSE, otherwise CMake will set it to TRUE
    set(olive_networking_FOUND FALSE)
  elseif(NOT olive_networking_FOUND)
    # use separate condition to avoid uninitialized variable warning
    set(olive_networking_FOUND FALSE)
  endif()
  return()
endif()
set(_olive_networking_CONFIG_INCLUDED TRUE)

# output package information
if(NOT olive_networking_FIND_QUIETLY)
  message(STATUS "Found olive_networking: 0.0.0 (${olive_networking_DIR})")
endif()

# warn when using a deprecated package
if(NOT "" STREQUAL "")
  set(_msg "Package 'olive_networking' is deprecated")
  # append custom deprecation text if available
  if(NOT "" STREQUAL "TRUE")
    set(_msg "${_msg} ()")
  endif()
  # optionally quiet the deprecation message
  if(NOT ${olive_networking_DEPRECATED_QUIET})
    message(DEPRECATION "${_msg}")
  endif()
endif()

# flag package as ament-based to distinguish it after being find_package()-ed
set(olive_networking_FOUND_AMENT_PACKAGE TRUE)

# include all config extra files
set(_extras "")
foreach(_extra ${_extras})
  include("${olive_networking_DIR}/${_extra}")
endforeach()

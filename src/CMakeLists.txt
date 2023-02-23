# The Flutter tooling requires that developers have CMake 3.10 or later
# installed. You should not increase this version, as doing so will cause
# the plugin to fail to compile for some customers of the plugin.
cmake_minimum_required(VERSION 3.10)

project(ros2_flutter_package_library VERSION 0.0.1 LANGUAGES C)

add_library(ros2_flutter_package SHARED
  "ros2_flutter_package.c"
)

set_target_properties(ros2_flutter_package PROPERTIES
  PUBLIC_HEADER ros2_flutter_package.h
  OUTPUT_NAME "ros2_flutter_package"
)

target_compile_definitions(ros2_flutter_package PUBLIC DART_SHARED_LIB)

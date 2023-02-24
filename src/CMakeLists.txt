# The Flutter tooling requires that developers have CMake 3.10 or later
# installed. You should not increase this version, as doing so will cause
# the plugin to fail to compile for some customers of the plugin.
cmake_minimum_required(VERSION 3.10)

project(ros2_flutter_package_library VERSION 0.0.1 LANGUAGES C)

# TODO: want to delete
add_library(ros2_flutter_package SHARED
  "ros2_flutter_package.c"
)

# TODO: want to delete
set_target_properties(ros2_flutter_package PROPERTIES
  PUBLIC_HEADER ros2_flutter_package.h
  OUTPUT_NAME "ros2_flutter_package"
)

# TODO: want to delete
target_compile_definitions(ros2_flutter_package PUBLIC DART_SHARED_LIB)



##--------

if(ANDROID)
  # run colcon build
  add_custom_target(colcon
    COMMAND
            CMAKE_COMMAND=${CMAKE_COMMAND}
            CMAKE_TOOLCHAIN_FILE=${CMAKE_TOOLCHAIN_FILE}
            ANDROID=${ANDROID}
            ANDROID_FUNCTION_LEVEL_LINKING=${ANDROID_FUNCTION_LEVEL_LINKING}
            ANDROID_NATIVE_API_LEVEL=${ANDROID_NATIVE_API_LEVEL}
            ANDROID_TOOLCHAIN_NAME=${ANDROID_TOOLCHAIN_NAME}
            ANDROID_STL=${ANDROID_STL}
            ANDROID_ABI=${ANDROID_ABI}
            ANDROID_NDK=${ANDROID_NDK}
            ANDROID_PLATFORM=${ANDROID_PLATFORM}
            CMAKE_FIND_ROOT_PATH=${CMAKE_FIND_ROOT_PATH}
            CMAKE_BUILD_TOOL=${CMAKE_BUILD_TOOL}
            CMAKE_GENERATOR=${CMAKE_GENERATOR}
            CMAKE_MAKE_PROGRAM=${CMAKE_MAKE_PROGRAM}
            ${PROJECT_SOURCE_DIR}/../ros2_ws/build_colcon_android.sh)

  # copy .so from colcon's workspace
  add_custom_command(TARGET ros2_flutter_package POST_BUILD        
      COMMAND ${CMAKE_COMMAND} -E copy
          "${PROJECT_SOURCE_DIR}/../ros2_ws/install/${ANDROID_ABI}/lib/*.so"
          $<TARGET_FILE_DIR:ros2_flutter_package>)

  add_dependencies(ros2_flutter_package colcon)
endif()
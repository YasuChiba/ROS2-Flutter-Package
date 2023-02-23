this directory is the workspace for the ROS2


vcs import --input ros2-flutter.repos src/


colcon build --merge-install --cmake-args -DBUILD_TESTING=OFF
FROM osrf/ros:humble-desktop-full

RUN mkdir -p /ros2_ws/src

RUN git clone https://github.com/Livox-SDK/livox_ros_driver2.git \
  /ros2_ws/src/livox_ros_driver2

RUN . /opt/ros/$ROS_DISTRO/setup.sh \
 && apt-get update \
 && rosdep install -r -y \
     --from-paths /ros2_ws/src \
     --ignore-src \
 && rm -rf /var/lib/apt/lists/*

RUN . /opt/ros/$ROS_DISTRO/setup.sh \
 && cd /ros2_ws/src/livox_ros_driver2 \
 && ./build.sh humble

RUN git clone https://github.com/TransMisiones-Centauro/FAST_LIO_SLAM_ros2.git \
  /ros2_ws/src/FAST_LIO_SLAM_ros2

RUN . /opt/ros/$ROS_DISTRO/setup.sh \
 && cd /ros2_ws \
 && colcon build --symlink-install


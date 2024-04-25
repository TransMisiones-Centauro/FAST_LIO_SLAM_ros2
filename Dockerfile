FROM osrf/ros:humble-desktop-full

#RUN git clone https://github.com/Livox-SDK/Livox-SDK2.git /Livox-SDK2 \
# && cd /Livox-SDK2 && mkdir build && cd build \
# && cmake .. && make -j install \
# && rm -fr /Livox-SDK2

RUN mkdir -p /livox_ws/src

RUN git clone https://github.com/Duna-System/livox_ros2_driver.git \
  /livox_ws/src/livox_ros2_driver

RUN . /opt/ros/$ROS_DISTRO/setup.sh \
 && cd /livox_ws \
 && colcon build

RUN mkdir -p /ros2_ws/src

RUN git clone --recurse-submodules \
      https://github.com/TransMisiones-Centauro/FAST_LIO_SLAM_ros2.git \
      /ros2_ws/src/FAST_LIO_SLAM_ros2

RUN . /opt/ros/$ROS_DISTRO/setup.sh \
 && . /livox_ws/install/setup.sh \
 && cd /ros2_ws \
 && colcon build --symlink-install


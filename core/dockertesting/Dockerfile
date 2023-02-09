FROM ros:noetic
# This is the base image

# ENV ${ROS_DISTRO}=noetic set in base image
# add Ros repository to apt
RUN echo "deb http://packages.ros.org/ros/ubuntu $(lsb_release -sc) main" > /etc/apt/sources.list.d/ros-latest.list
RUN apt install curl -y
RUN curl -s https://raw.githubusercontent.com/ros/rosdistro/master/ros.asc | sudo apt-key add -

# install dependencies
RUN apt-get update && apt-get install -y \
    ros-${ROS_DISTRO}-camera-info-manager \
    ros-${ROS_DISTRO}-image-view \
    python-catkin-tools \
    git \
    software-properties-common

# sudo apt-get install software-properties-common
RUN apt-get update
RUN add-apt-repository ppa:inivation-ppa/inivation
RUN apt-get update && apt-get install -y dv-runtime


# Install libcaer after dv-runtime is installed.
RUN apt-get install -y libcaer-dev

RUN echo "source /opt/ros/${ROS_DISTRO}/setup.bash" >> ~/.bashrc
RUN source ~/.bashrc

# Create catkin workspace to build the DVS driver
RUN mkdir -p /catkin_ws/src
WORKDIR /catkin_ws
RUN catkin config --init --mkdirs --extend /opt/ros/${ROS_DISTRO} --merge-devel --cmake-args -DCMAKE_BUILD_TYPE=Release

# same as: cd /catkin_ws/src
WORKDIR /catkin_ws/src

# Clone the catkin_simple package
RUN git clone https://github.com/catkin/catkin_simple.git

# Clone the rpg_dvs_ros repository
RUN git clone https://github.com/uzh-rpg/rpg_dvs_ros.git

# Build the packages
RUN catkin build dvxplorer_ros_driver

# Set environment variables, separated by colons, keeping the original path.
ENV ROS_PACKAGE_PATH /catkin_ws:$ROS_PACKAGE_PATH

# CMD specifies the command(s) to execute when the container starts.
CMD ["roslaunch", "dvxplorer_ros_driver", "dvxplorer.launch"]

# To build run
# docker build -t dvxplorer_ros_driver .
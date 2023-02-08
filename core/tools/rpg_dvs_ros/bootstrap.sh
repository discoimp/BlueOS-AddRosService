#!/usr/bin/env bash

# Exit if something goes wrong
set -e

# Dnsmasq provides DHCP and DNS servers for small networks
echo "Installing IniVation DVXplorer dependencies."
export ROS_DISTRO=noetic    
apt-get update && apt-get install -y --no-install-recommends ros-${ROS_DISTRO}-camera-info-manager ros-${ROS_DISTRO}-image-view python-catkin-tools git software-properties-common



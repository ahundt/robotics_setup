#!/bin/bash


# source: https://gist.github.com/phatblat/1713458
# Save script's current directory
DIR=$(pwd)

# /bin/bash
set -e
set -u
set -x

####################
# ROS Karmic Setup #
####################

# source: http://wiki.ros.org/kinetic/Installation/Ubuntu
sudo sh -c 'echo "deb http://packages.ros.org/ros/ubuntu $(lsb_release -sc) main" > /etc/apt/sources.list.d/ros-latest.list'
sudo apt-key adv --keyserver hkp://ha.pool.sks-keyservers.net:80 --recv-key 0xB01FA116
sudo apt update
sudo apt install ros-kinetic-desktop-full
sudo apt install python-rosinstall

sudo apt install python-catkin-tools libgflags-dev

# To find available packages, use:
#
# apt-cache search ros-kinetic


# If using bash:
#
# echo "source /opt/ros/kinetic/setup.bash" >> ~/.bashrc
# source ~/.bashrc
#
#

# Add ros setup to zshrc if it isn't already present
LINE="source /opt/ros/kinetic/setup.zsh"
FILE=~/.zshrc
grep -q "$LINE" "$FILE" || echo "$LINE" >> "$FILE"


cd $DIR


# source: https://gist.github.com/phatblat/1713458
# Save script's current directory
DIR=$(pwd)

set -e
set -u
set -x

echo "###############################################"
echo "# Google Cartographer - ROS"
echo "###############################################"
echo "#"
echo "# https://github.com/googlecartographer/cartographer_ros"
echo "# also see: https://github.com/googlecartographer/cartographer"
echo "#"
echo "# Extra steps: this runs ceres.sh first!"

# Install the required libraries that are available as debs.
sudo apt-get update
sudo apt-get install -y \
    cmake \
    g++ \
    git \
    google-mock \
    libboost-all-dev \
    libcairo2-dev \
    libeigen3-dev \
    libgflags-dev \
    libgoogle-glog-dev \
    liblua5.2-dev \
    libprotobuf-dev \
    libsuitesparse-dev \
    ninja-build \
    protobuf-compiler \
    python-sphinx

# Install ROS
./ros.sh

# Install wstool and rosdep.
sudo apt-get update
sudo apt-get install -y python-wstool python-rosdep ninja-build

# make sure TMPDIR variable is set
if [ -z ${var+x} ]; then export TMPDIR="/tmp"; fi

source /opt/ros/kinetic/setup.bash

cd ~/src

# Create a new workspace in 'catkin_ws'.
mkdir -p cartographer_ws
cd cartographer_ws

if [ ! -f ~/src/cartographer_ws/src/.rosinstall ]
then
	wstool init src
fi


# Merge the cartographer_ros.rosinstall file and fetch code for dependencies.
wstool merge -t src https://raw.githubusercontent.com/googlecartographer/cartographer_ros/master/cartographer_ros.rosinstall
wstool update -t src

# Install deb dependencies.
# The command 'sudo rosdep init' will print an error if you have already
# executed it since installing ROS. This error can be ignored.
if [ ! -f /etc/ros/rosdep/sources.list.d/20-default.list ]
then
	sudo rosdep init
fi

# make sure ROS_DISTRO variable is set
if [ -z ${var+x} ]; then export ROS_DISTRO="kinetic"; fi

rosdep update
rosdep install --from-paths src --ignore-src --rosdistro=${ROS_DISTRO} -y

cd ~/src/cartographer_ws


# Build and install.
catkin_make_isolated --install --use-ninja
source install_isolated/setup.bash

# Build and install.
# catkin build --install --use-ninja


cd $DIR

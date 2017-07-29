#!/bin/bash
# source: https://gist.github.com/phatblat/1713458
# Save script's current directory
DIR=$(pwd)

set -e
set -u
set -x

echo "############################"
echo "# kalibr ROS library"
echo "############################"
echo "# calibration library"
echo ""
echo "# https://github.com/ethz-asl/kalibr"
echo ""
echo "Manual steps: installing libopencv-dev ros-*-vision-opencv "
echo "where * is either indigo or kinetic"

# location="ethz-asl"
location="ahundt"
# location="clearpath"

#branch="master"
branch="robone"


# ROS must be installed first, assuming it is in default /opt/ros location
if [ ! -d /opt/ros ]; then
    ./ros.sh
fi

cd ~/src


. /etc/lsb-release # get ubuntu version number


if [ "$DISTRIB_RELEASE" = "16.04" ]; then
    ROSVERSION="kinetic"
	# TODO(ahundt) How to install fcl? should "soem" be installed?
	# TODO(ahundt) Are there univeral robot ros-industrial kinetic binaries?
	sudo apt-get install -y ros-kinetic-moveit # ros-kinetic-universal-robot ros-kinetic-ur-msgs #  ros-indigo-fcl

	source /opt/ros/kinetic/setup.bash
fi


if [ "$DISTRIB_RELEASE" = "14.04" ]; then
    ROSVERSION="indigo"
	sudo apt-get install -y ros-indigo-moveit-full ros-indigo-fcl ros-indigo-soem

	source /opt/ros/indigo/setup.bash
fi

if [ -e "/opt/ros/${ROSVERSION}/setup.bash"]; then
	source /opt/ros/${ROSVERSION}/setup.bash
fi

sudo apt-get install -y python-setuptools python-rosinstall ipython libeigen3-dev libboost-all-dev doxygen ros-${ROSVERSION}-image-transport-plugins ros-${ROSVERSION}-cmake-modules python-software-properties software-properties-common libpoco-dev python-matplotlib python-scipy python-git python-pip ipython libtbb-dev libblas-dev liblapack-dev python-catkin-tools libv4l-dev
# opencv can be a bit tricky, maybe do that on your own
# sudo apt-get install -y libopencv-dev ros-${ROSVERSION}-vision-opencv

sudo pip install python-igraph --upgrade

cd $HOME/src
mkdir -p kalibr_ws/src
cd kalibr_ws
catkin init
cd src

if [ ! -d ~/src/kalibr_ws/src/kalibr ]; then
	git clone https://github.com/${location}/kalibr.git
fi

cd kalibr
git pull
git checkout $branch
cd ..

catkin build

cd $DIR
# source: https://gist.github.com/phatblat/1713458
# Save script's current directory
DIR=$(pwd)

set -e
set -u
set -x

sudo apt-get update
sudo apt-get install -y libtool pkg-config build-essential autoconf automake cmake cmake-curses-gui pkg-config
sudo apt-get install -y libboost-all-dev libeigen3-dev doxygen

sh python.sh

sudo apt-get install -y libprotobuf-dev protobuf-compiler libboost-all-dev

pip install protobuf
pip install pybindgen

echo "############################"
echo "# Guided Policy Search"
echo "############################"
echo "# repo: https://github.com/cbfinn/gps "
echo "# docs: http://rll.berkeley.edu/gps/"
echo "# this script is based on the docs link"
echo ""
echo "MANUAL STEPS REQUIRED - NEED to run ros.sh and mujoco.sh first for full installation"
echo "                        MANUAL STEPS FOR MUJOCO LICENSE SEE http://rll.berkeley.edu/gps/"
echo "                        with ubuntu 16.04 cmake 3.5: comment out line 64 of  /usr/share/cmake-3.5/Modules/FindPythonLibs.cmake"

cd ~/src

#location="ahundt" # github.com/ahundt/gps # I have some patches here
location="cbfinn" # github.com/cbfinn/gps # ongoing development happens here

branch="master"

# install https://github.com/cbfinn/gps
# note: still putting it in jrl-umi3218 for consistency
if [ ! -d ~/src/gps ]
then
	git clone --recursive https://github.com/${location}/gps.git
fi

cd gps
git pull
git checkout ${branch}

./compile_proto.sh

# Here are the instructions for setting up Pybox2D.
# https://github.com/pybox2d/pybox2d
sudo apt-get install -y build-essential python-dev swig python-pygame subversion python-box2d

# Steps for mujoco setup
sudo apt-get install -y openscenegraph libopenscenegraph-dev

# NOTE: MANUAL STEPS FOR MUJOCO LICENSE SEE http://rll.berkeley.edu/gps/
if [ -d ~/src/mujoco/mjpro131 ]
then
	cp -a  ~/src/mujoco/mjpro131 ~/src/gps/src/3rdparty/mjpro
	cd ~/src/gps/build
	cmake ../src/3rdparty
	make -j
fi


# ROS SETUP WITH CAFFE http://rll.berkeley.edu/gps/
sudo apt-get install -y ros-kinetic-pr2-common ros-kinetic-pr2-dashboard-aggregator ros-kinetic-pr2-description ros-kinetic-pr2-machine ros-kinetic-pr2-msgs ros-kinetic-gazebo-ros-control ros-kinetic-moveit-ros-control-interface ros-kinetic-moveit-sim-controller

if [ -d /opt/ros/kinetic ]
then
	export ROS_PACKAGE_PATH=$ROS_PACKAGE_PATH:$HOME/src/gps:$HOME/src/gps/src/gps_agent_pkg
	cd ~/src/gps/src/gps_agent_pkg/
	cmake . -DUSE_CAFFE=1 -DUSE_CAFFE_GPU=1 -DCAFFE_INCLUDE_PATH=~/src/caffe/distribute/include -DCAFFE_LIBRARY_PATH=~/src/caffe/build/lib
	make -j
fi


cd ~/src



cd $DIR

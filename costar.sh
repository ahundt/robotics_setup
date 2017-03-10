#!/bin/bash
# source: https://gist.github.com/phatblat/1713458
# Save script's current directory
DIR=$(pwd)

set -e
set -u
set -x

echo "############################"
echo "# costar_stack ROS library"
echo "############################"
echo "# Robot User Interface"
echo "# for flexible task creation "
echo ""
echo "# github.com/cpaxton/costar_stack"


# ROS must be installed first, assuming it is in default /opt/ros location
if [ ! -d /opt/ros ]; then
    ./ros.sh
fi

cd ~/src

location="cpaxton" # github.com/ahundt/Tasks # I have some patches here
#location="lcsr" # github.com/jrl-umi3218/Tasks # ongoing development happens here
#location="jorisv" # github.com/jorisv/Tasks # original repository location

# TODO(ahundt) switch back to master once standardized cmake changes are merged, see https://github.com/jrl-umi3218/jrl-cmakemodules/pull/103
branch="master"
#branch="package" # this branch adds standard cmake package configuration


. /etc/lsb-release # get ubuntu version number


if [ "$DISTRIB_RELEASE" = "16.04" ]; then
    ROSVERSION="kinetic"
	# TODO: How to install fcl? should soem be installed? soem
	sudo apt-get install -y ros-kinetic-moveit #  ros-indigo-fcl

	source /opt/ros/kinetic/setup.bash
fi


if [ "$DISTRIB_RELEASE" = "14.04" ]; then
    ROSVERSION="indigo"
	sudo apt-get install -y ros-indigo-moveit-full ros-indigo-fcl ros-indigo-soem

	source /opt/ros/indigo/setup.bash
fi

sudo apt-get install -y python-catkin-tools liburdfdom-headers-dev ros-${ROSVERSION}-control-msgs ros-${ROSVERSION}-gazebo-ros-control ros-${ROSVERSION}-python-orocos-kdl xdot libccd-dev ros-${ROSVERSION}-ros-control ros-${ROSVERSION}-octomap-msgs ros-${ROSVERSION}-gazebo-plugins ros-${ROSVERSION}-pcl-ros ros-${ROSVERSION}-socketcan-interface ros-${ROSVERSION}-rqt-gui ros-${ROSVERSION}-object-recognition-msgs ros-${ROSVERSION}-realtime-tools ros-${ROSVERSION}-position-controllers ros-${ROSVERSION}-robot-state-publisher ros-${ROSVERSION}-joint-state-controller
 
cd $HOME/src
mkdir -p costar_ws/src
cd costar_ws
catkin init
cd src

# TODO: add better recovery and update utilities, and use specific release versions
if [ ! -d ~/src/costar_ws/src/costar_stack ]; then
	git clone https://github.com/${location}/costar_stack.git  
	git clone https://github.com/SalvoVirga/iiwa_stack.git  
	git clone https://github.com/ros-industrial/robotiq.git  
	git clone https://github.com/jbohren/rqt_dot.git  
	git clone https://github.com/sniekum/ar_track_alvar.git  -b ${ROSVERSION}-devel
	git clone https://github.com/sniekum/ar_track_alvar_msgs.git  
	git clone https://github.com/gt-ros-pkg/hrl-kdl.git  
	git clone https://github.com/cpaxton/xdot.git  
	git clone https://github.com/ThomasTimm/ur_modern_driver.git
fi

if [ -e ../devel/setup.bash ]; then
    source ../devel/setup.bash
fi
echo "Ignore COSTAR_PERCEPTION until you have installed its dependencies."
touch costar_stack/costar_perception/CATKIN_IGNORE
catkin build --continue



cd $DIR
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

# openni2 and friends is optional
sudo apt install -y libopenni2-0 libopenni2-dev openni2-doc openni2-utils ros-${ROSVERSION}-openni2-camera ros-${ROSVERSION}-openni2-launch

# many of these are required, ${ROSVERSION} will be indigo, kinetic as appropriate
sudo apt install -y python-catkin-tools liburdfdom-headers-dev ros-${ROSVERSION}-control-msgs ros-${ROSVERSION}-gazebo-ros-control ros-${ROSVERSION}-python-orocos-kdl xdot libccd-dev ros-${ROSVERSION}-ros-control ros-${ROSVERSION}-octomap-msgs ros-${ROSVERSION}-gazebo-plugins ros-${ROSVERSION}-pcl-ros ros-${ROSVERSION}-socketcan-interface ros-${ROSVERSION}-rqt-gui ros-${ROSVERSION}-object-recognition-msgs ros-${ROSVERSION}-realtime-tools ros-${ROSVERSION}-position-controllers ros-${ROSVERSION}-robot-state-publisher ros-${ROSVERSION}-joint-state-controller
 
if [ -e "/opt/ros/${ROSVERSION}/setup.bash"]; then
	source /opt/ros/${ROSVERSION}/setup.bash
fi
 
cd $HOME/src
mkdir -p costar_ws/src
cd costar_ws
catkin init
cd src

# TODO(ahundt) add better recovery and update utilities, and use specific release versions
if [ ! -d ~/src/costar_ws/src/costar_stack ]; then
	git clone https://github.com/${location}/costar_stack.git  
	git clone https://github.com/SalvoVirga/iiwa_stack.git  	
	#git clone https://github.com/ros-industrial/robotiq.git # This is the upstream location 
	git clone https://github.com/jhu-lcsr/robotiq.git -b ${ROSVERSION}-devel
	git clone https://github.com/jbohren/rqt_dot.git  
	git clone https://github.com/sniekum/ar_track_alvar.git -b ${ROSVERSION}-devel
	git clone https://github.com/sniekum/ar_track_alvar_msgs.git  
	git clone https://github.com/gt-ros-pkg/hrl-kdl.git  
	git clone https://github.com/cpaxton/xdot.git  
	#git clone https://github.com/ThomasTimm/ur_modern_driver.git # This is the upstream location 
	git clone https://github.com/ahundt/ur_modern_driver.git -b ${ROSVERSION}-devel
	# note: there are also binary versions on 14.04
	git clone https://github.com/ros-industrial/universal_robot.git -b ${ROSVERSION}-devel

	if [ "$DISTRIB_RELEASE" = "16.04" ]; then
		git clone git@github.com:UTNuclearRoboticsPublic/soem.git
	fi
	
	# Optional for vision utilities
	git clone git@github.com:ahundt/ObjRecRANSAC.git objrecransac
fi

if [ -e ../devel/setup.bash ]; then
    source ../devel/setup.bash
fi

# TODO(ahundt) FIX HACK: build objrecransac with standard cmake build, otherwise the headers won't be found. Is this on both kinetic and indigo?
cd objrecransac
mkdir -p build
cd build
cmake ..
make -j install
cd ../..

#echo "Ignore COSTAR_PERCEPTION until you have installed its dependencies."
#touch costar_stack/costar_perception/CATKIN_IGNORE

# There is a strange quirk where sp_segmenter optionally depends on ObjRecRANSAC
# Building that package first helps resolve the dependency.
catkin build objrecransac
catkin build --continue



cd $DIR
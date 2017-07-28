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

# location="ethz-asl"
location="ahundt"
# location="clearpath"

#branch="master"
branch="robone"

if [ -e "/opt/ros/${ROSVERSION}/setup.bash"]; then
	source /opt/ros/${ROSVERSION}/setup.bash
fi

cd $HOME/src
mkdir -p kalibr_ws/src
cd kalibr_ws
catkin init
wstool init
cd src

if [ ! -d ~/src/kalibr_ws/src/kalibr_ws ]; then
	git clone https://github.com/${location}/kalibr.git
fi

cd kalibr
git pull
git checkout $branch
cd ..

catkin build

cd $DIR
# source: https://gist.github.com/phatblat/1713458
# Save script's current directory
DIR=$(pwd)

set -e
set -u
set -x


echo "###############################################"
echo "# RobotLocomotion from MIT https://github.com/RobotLocomotion/"
echo "###############################################"
echo "#"
echo "# http://drake.mit.edu/"
echo "#"
echo "# Drake - https://github.com/RobotLocomotion/drake"
echo "#     A planning, control, and analysis toolbox for nonlinear dynamical systems."
echo "#"
echo "# Director - https://github.com/RobotLocomotion/director/"
echo "#     A robotics interface and visualization framework,"
echo "#     with extensive applications for working with Drake"
echo "#"
echo "# Spartan - https://github.com/RobotLocomotion/spartan/"
echo "#     A project repo for robotics research and applications using drake and director. "
echo "#"
echo "#  drake-iiwa-driver - https://github.com/RobotLocomotion/drake-iiwa-driver"
echo "#    Application code used to communicate with the KUKA iiwa arm from Drake."
echo "#     "


# os specific setup
OS=`uname`
case $OS in
	'Linux')
		OS='Linux'
        ./bazel.sh
    # ./pip.sh
		sudo apt-get install build-essential cmake libglib2.0-dev libqt4-dev \
  							 libx11-dev libxext-dev libxt-dev python-dev
		# left out of apt-get in favor of pip
		# python-numpy  python-lxml python-scipy python-yaml
		pip2 install --user --upgrade numpy lxml scipy pyyaml

	;;
	*) ;;
	'Darwin')
		OS='Mac'
		brew tap patmarion/director # && brew tap-pin patmarion/director
		brew install cmake bazel glib libyaml numpy python scipy vtk7
		pip2 install --user --upgrade lxml PyYAML
	;;
esac

mkdir -p ~/src/RobotLocomotion
cd ~/src/RobotLocomotion

# https://github.com/RobotLocomotion/drake
if [ ! -d ~/src/RobotLocomotion/drake-distro ]
then
	git clone git@github.com:RobotLocomotion/drake.git drake-distro
fi

cd drake-distro
git pull

if [ "${OS}" = "Mac"] ; then
  ./setup/mac/install_prereqs.sh
fi

if [ "${OS}" = "Linux" ] ; then
  sudo ./setup/ubuntu/16.04/install_prereqs.sh
fi

bazel build //...


# https://github.com/RobotLocomotion/director
cd ~/src/RobotLocomotion
if [ ! -d ~/src/RobotLocomotion/director ]
    # TODO(ahundt) Consider usin gtheir ros catkin build
	git clone git@github.com:RobotLocomotion/director.git
then

cd director
git pull
mkdir -p build
cd build
cmake .. -DCMAKE_INSTALL_PREFIX=/usr/local/
make -j && sudo make install



# https://github.com/RobotLocomotion/drake-iiwa-driver
cd ~/src/RobotLocomotion
if [ ! -d ~/src/RobotLocomotion/drake-iiwa-driver ] ; then
	git clone git@github.com:RobotLocomotion/director.git
fi

cd drake-iiwa-driver
git pull
if [ -f ~/src/RobotLocomotion/drake-iiwa-driver/README.md ] ; then
	bazel build //...
else
	echo "MANUAL STEPS are required to install and run on the kuka iiwa robot, see https://github.com/RobotLocomotion/drake-iiwa-driver"
fi



# https://github.com/RobotLocomotion/spartan
cd ~/src/RobotLocomotion
if [ ! -f ~/src/RobotLocomotion/spartan ]
	git clone git@github.com:RobotLocomotion/spartan.git
then

if [ "${OS}" = "Mac"] ; then
  # not yet available
  # ./setup/mac/install_prereqs.sh
fi

if [ "${OS}" = "Linux" ] ; then
  sudo ./setup/ubuntu/16.04/install_prereqs.sh

  bazel build //...
fi

cd $DIR

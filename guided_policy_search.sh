# source: https://gist.github.com/phatblat/1713458
# Save script's current directory
DIR=$(pwd)

set -e
set -u
set -x

sudo apt update
sudo apt install -y libtool pkg-config build-essential autoconf automake cmake cmake-curses-gui pkg-config
sudo apt install -y libboost-all-dev libeigen3-dev doxygen

sh python.sh

sudo apt install -y libprotobuf-dev protobuf-compiler libboost-all-dev

pip install protobuf
pip install pybindgen

echo "############################"
echo "# Guided Policy Search"
echo "############################"
echo "# repo: https://github.com/cbfinn/gps "
echo "# docs: http://rll.berkeley.edu/gps/"
echo "# this script is based on the docs link"

cd ~/src

#location="ahundt" # github.com/ahundt/gps # I have some patches here
location="cbfinn" # github.com/cbfinn/gps # ongoing development happens here

branch="master"

# install https://github.com/cbfinn/gps
# note: still putting it in jrl-umi3218 for consistency
if [ ! -d ~/src/gps ]
then
	git clone --recursive git@github.com:${location}/gps.git
fi

cd gps
git pull
git checkout ${branch}

./compile_proto.sh

# Here are the instructions for setting up Pybox2D.
# https://github.com/pybox2d/pybox2d
sudo apt install -y build-essential python-dev swig python-pygame subversion python-box2d

# Steps for mujoco setup
sudo apt install -y openscenegraph libopenscenegraph-dev

# TODO: MANUAL STEPS FOR MUJOCO LICENSE SEE http://rll.berkeley.edu/gps/
#cd build
#cmake ../src/3rdparty
#make -j


#TODO ROS SETUP WITH CAFFE http://rll.berkeley.edu/gps/
cd ~/src



cd $DIR

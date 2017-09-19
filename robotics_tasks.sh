# source: https://gist.github.com/phatblat/1713458
# Save script's current directory
DIR=$(pwd)

set -e
set -u
set -x


echo "###############################################"
echo "# Robotics Tasks Library https://github.com/jrl-umi3218/tasks"
echo "###############################################"
echo "# Tasks is library for real time control of robots and kinematic"
echo "# trees using constrained optimization. It has been used extensively"
echo "# to control humanoid robots such as HOAP-3, HRP-2, HRP-4 and Atlas."
echo "#"
echo "# Make sure eigen3 is installed before running this script"
echo "#"
echo "# Usage with python bindings (default):"
echo "#    sh robotics_tasks.sh"
echo "#"
echo "# Usage without python bindings:"
echo "#    sh robotics_tasks.sh -p OFF"
echo "#"
echo "# Options:"
echo "#"
echo "#   -p Enable/disable python bindings, options are ON, OFF"
echo "#   -b git branch to check out, such as master"
echo "#   -l git location to use, -b jrl-umi3218 means github.com/jrl-umi3218/Tasks,"
echo "#      while ahundt means github.com/ahundt/Tasks"



# os specific setup
OS=`uname`
case $OS in
	'Linux')
		sh python.sh
		sudo apt-get update
		sudo apt-get install -y libtool pkg-config build-essential autoconf automake cmake cmake-curses-gui pkg-config
		sudo apt-get install -y libboost-all-dev libeigen3-dev doxygen
		# last dependency is for mc_rbdyn_urdf urdf robot definition format reading only
		sudo apt-get install -y libtinyxml2-dev
	;;
	*) ;;
	'Darwin')
		OS='Mac'
		brew install tinyxml2
	;;
esac

# Enable python bindings via cython by default
# set to "ON" to build python bindings and "OFF" to disable them
# Note: "ON" generates tons of warnings and the log size might prevent CI from succeeding.
PYTHON_BINDING="ON"


location="jrl-umi3218" # github.com/jrl-umi3218/Tasks # ongoing development happens here
#location="ahundt" # github.com/ahundt/Tasks # I have some patches here
#location="jorisv" # github.com/jorisv/Tasks # outdated original repository location

# modify if using a different branch
branch="master"

# Check if the user specified any command line options
# other than teh default and set the variable appropriately.
while getopts u:d:p:f: option
do
 case "${option}"
 in
 p) PYTHON_BINDING="${OPTARG}";;
 l) location="${OPTARG}";;
 b) branch="${OPTARG}";;
 esac
done

cd ~/src
mkdir -p jrl-umi3218

# install https://github.com/jrl-umi3218/Eigen3ToPython
# note: still putting it in jrl-umi3218 for consistency
cd ~/src/jrl-umi3218
if [ ! -d ~/src/jrl-umi3218/Eigen3ToPython ]
then
    # TODO(ahundt) speak with people at https://github.com/jorisv/ and github.com/jrl-umi3218 to figure out where future development will really be.
    # TODO(ahundt) see above todo, https://github.com/jrl-umi3218/Eigen3ToPython.git does not exist
	git clone --recursive https://github.com/${location}/Eigen3ToPython.git
fi

if [ "${PYTHON_BINDING}" = "ON" ]
then
    cd Eigen3ToPython
    git pull
    git checkout ${branch}
	# Requirements.txt includes:
	# cython>=0.25
    # coverage>=4.0
    # nose
    # numpy
	# TODO(ahundt) consider if user install is appropriate on all platforms
    pip install -r requirements.txt --upgrade --user
    pip install . --upgrade --user

	# only install via pip3 if it exists
	if [ -x "$(command -v pip3)" ] ; then
		pip3 install -r requirements.txt --upgrade --user
		pip3 install . --upgrade --user
	fi
fi



# install https://github.com/jrl-umi3218/SpaceVecAlg
cd ~/src/jrl-umi3218
if [ ! -d ~/src/jrl-umi3218/SpaceVecAlg ]
then
	git clone --recursive https://github.com/${location}/SpaceVecAlg.git
fi

cd SpaceVecAlg
git pull
git checkout ${branch}
mkdir -p build
cd build
cmake .. -DPYTHON_BINDING=${PYTHON_BINDING}
make -j && sudo make install




# install https://github.com/jrl-umi3218/RBDyn
cd ~/src/jrl-umi3218
if [ ! -d ~/src/jrl-umi3218/RBDyn ]
then
	git clone --recursive https://github.com/${location}/RBDyn.git
fi

cd RBDyn
git pull
git checkout ${branch}
mkdir -p build
cd build
cmake .. -DPYTHON_BINDING=${PYTHON_BINDING}
make -j && sudo make install





# install https://github.com/jrl-umi3218/sch-core
cd ~/src/jrl-umi3218
if [ ! -d ~/src/jrl-umi3218/sch-core ]
then
	git clone --recursive https://github.com/${location}/sch-core.git
	# TODO(ahundt) Remove this hack to get the right submodule version once cmake package config is merged, see https://github.com/jrl-umi3218/jrl-cmakemodules/pull/103
	# cd sch-core/cmake
	# git remote add ${location} https://github.com/${location}/jrl-cmakemodules.git
	# git fetch ${location}
	# git checkout ${branch}
	# cd ../..
fi

cd sch-core
git pull
git checkout ${branch}
mkdir -p build
cd build
# no python bindings for this library
cmake ..
make -j && sudo make install





# install https://github.com/jrl-umi3218/sch-core-python
cd ~/src/jrl-umi3218
if [ ! -d ~/src/jrl-umi3218/sch-core-python ]
then
	git clone --recursive https://github.com/${location}/sch-core-python.git
	# TODO(ahundt) Remove this hack to get the right submodule version once cmake package config is merged, see https://github.com/jrl-umi3218/jrl-cmakemodules/pull/103
	# cd sch-core/cmake
	# git remote add ${location} https://github.com/${location}/jrl-cmakemodules.git
	# git fetch ${location}
	# git checkout ${branch}
	# cd ../..
fi

if [ "${PYTHON_BINDING}" = "ON" ]
then
    cd sch-core-python
    git pull
    git checkout ${branch}
    pip install .
fi




# install https://github.com/jrl-umi3218/eigen-qld
cd ~/src/jrl-umi3218
if [ ! -d ~/src/jrl-umi3218/eigen-qld ]
then
	git clone --recursive https://github.com/${location}/eigen-qld.git
fi

cd eigen-qld
git pull
git checkout ${branch}
mkdir -p build
cd build
cmake .. -DPYTHON_BINDING=${PYTHON_BINDING}
make -j && sudo make install




# install https://github.com/jrl-umi3218/Tasks
cd ~/src/jrl-umi3218
if [ ! -d ~/src/jrl-umi3218/Tasks ]
then
	git clone --recursive https://github.com/${location}/Tasks.git
fi

cd Tasks
git pull
git checkout ${branch}
mkdir -p build
cd build
cmake .. -DPYTHON_BINDING=${PYTHON_BINDING}
make -j && sudo make install




# install https://github.com/jrl-umi3218/mc_rbdyn_urdf
cd ~/src/jrl-umi3218
if [ ! -d ~/src/jrl-umi3218/mc_rbdyn_urdf ]
then
	git clone --recursive https://github.com/${location}/mc_rbdyn_urdf.git
fi

cd mc_rbdyn_urdf
git pull
git checkout ${branch}
mkdir -p build
cd build
cmake ..  -DPYTHON_BINDING=${PYTHON_BINDING}
make -j && sudo make install


cd $DIR

# source: https://gist.github.com/phatblat/1713458
# Save script's current directory
DIR=$(pwd)


echo "###############################################"
echo "# Robotics Tasks Library https://github.com/jrl-umi3218/tasks"
echo "###############################################"
echo "# Tasks is library for real time control of robots and kinematic"
echo "# trees using constrained optimization. It has been used extensively"
echo "# to control humanoid robots such as HOAP-3, HRP-2, HRP-4 and Atlas."
echo "#"
echo "# Make sure eigen3 is installed before running this script"


set -e
set -u
set -x

# os specific setup
OS=`uname`
case $OS in
	'Linux')
		sh python.sh
		sudo apt update
		sudo apt install -y libtool pkg-config build-essential autoconf automake cmake cmake-curses-gui pkg-config
		sudo apt install -y libboost-all-dev libeigen3-dev doxygen
	;;
	*) ;;
	'Darwin')
		OS='Mac'
	;;
esac

# set to "ON" to build python bindings and "OFF" to disable them
# Note: "ON" generates tons of warnings and the log size might prevent CI from succeeding.
PYTHON_BINDING="OFF"

if [ $PYTHON_BINDING -eq "ON" ]
then
	pip install cython
fi

cd ~/src
mkdir -p jrl-umi3218

location="jrl-umi3218" # github.com/jrl-umi3218/Tasks # ongoing development happens here
#location="ahundt" # github.com/ahundt/Tasks # I have some patches here
#location="jorisv" # github.com/jorisv/Tasks # outdated original repository location

# modify if using a different branch
branch="master"

# install https://github.com/jorisv/Eigen3ToPython
# note: still putting it in jrl-umi3218 for consistency
cd ~/src/jrl-umi3218
if [ ! -d ~/src/jrl-umi3218/Eigen3ToPython ]
then
    # TODO(ahundt) speak with people at https://github.com/jorisv/ and github.com/jrl-umi3218 to figure out where future development will really be.
    # TODO(ahundt) see above todo, https://github.com/jrl-umi3218/Eigen3ToPython.git does not exist
	git clone --recursive https://github.com/${location}/Eigen3ToPython.git
fi




if [ $PYTHON_BINDING -eq "ON" ]
then
    cd Eigen3ToPython
    git pull
    git checkout ${branch}
    mkdir -p build
    cd build
    cmake -DCMAKE_BUIlD_TYPE=Release ..
    make -j && sudo make install
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
cmake ..  -DPYTHON_BINDING=${PYTHON_BINDING}
make -j && sudo make install




# install https://github.com/jrl-umi3218/sch-core
cd ~/src/jrl-umi3218
if [ ! -d ~/src/jrl-umi3218/sch-core ]
then
	git clone --recursive https://github.com/${location}/sch-core.git
	# TODO(ahundt) replace above with below when cmake config version call is merged see https://github.com/ahundt/sch-core/tree/package commit https://github.com/ahundt/sch-core/commit/35825805e38ec98f5a9c76c9e14b701fa3a81122
	# git clone --recursive https://github.com/${location}/sch-core.git
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
cmake ..
make -j && sudo make install




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


cd $DIR

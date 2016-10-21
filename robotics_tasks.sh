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

sudo pip install pybindgen

echo "############################"
echo "# github.com/jrl-umi3218/tasks robot constrained optimization library"
echo "# formerly github.com/jorisv/tasks"
echo "############################"

cd ~/src
mkdir -p jrl-umi3218

# install https://github.com/jorisv/Eigen3ToPython
# note: still putting it in jrl-umi3218 for consistency
cd ~/src/jrl-umi3218
if [ ! -d ~/src/jrl-umi3218/Eigen3ToPython ]
then
    # TODO(ahundt) speak with people at https://github.com/jorisv/ and github.com/jrl-umi3218 to figure out where future development will really be.
    # TODO(ahundt) see above todo, https://github.com/jrl-umi3218/Eigen3ToPython.git does not exist 
	git clone --recursive git@github.com:jorisv/Eigen3ToPython.git
fi

cd Eigen3ToPython
git pull
mkdir -p build
cd build
cmake -DPYTHON_DEB_LAYOUT=ON -DCMAKE_BUIlD_TYPE=Release ..
make -j16 && sudo make install




# install https://github.com/jrl-umi3218/SpaceVecAlg
cd ~/src/jrl-umi3218
if [ ! -d ~/src/jrl-umi3218/SpaceVecAlg ]
then
	git clone --recursive https://github.com/jrl-umi3218/SpaceVecAlg.git
fi

cd SpaceVecAlg
git pull
mkdir -p build
cd build
cmake .. -DPYTHON_DEB_LAYOUT=ON
make -j16 && sudo make install




# install https://github.com/jrl-umi3218/RBDyn
cd ~/src/jrl-umi3218
if [ ! -d ~/src/jrl-umi3218/RBDyn ]
then
	git clone --recursive https://github.com/jrl-umi3218/RBDyn.git
fi

cd RBDyn
git pull
mkdir -p build
cd build
cmake .. -DPYTHON_DEB_LAYOUT=ON
make -j16 && sudo make install




# install https://github.com/jrl-umi3218/sch-core
cd ~/src/jrl-umi3218
if [ ! -d ~/src/jrl-umi3218/sch-core ]
then
	git clone --recursive https://github.com/jrl-umi3218/sch-core.git
fi

cd sch-core
git pull
mkdir -p build
cd build
cmake ..
make -j16 && sudo make install




# install https://github.com/jrl-umi3218/eigen-qld
cd ~/src/jrl-umi3218
if [ ! -d ~/src/jrl-umi3218/eigen-qld ]
then
	git clone --recursive https://github.com/jrl-umi3218/eigen-qld.git
fi

cd eigen-qld
git pull
mkdir -p build
cd build
cmake ..
make -j16 && sudo make install




# install https://github.com/jrl-umi3218/Tasks
cd ~/src/jrl-umi3218
if [ ! -d ~/src/jrl-umi3218/Tasks ]
then
	git clone --recursive https://github.com/jrl-umi3218/Tasks.git
fi

cd Tasks
git pull
mkdir -p build
cd build
cmake ..
make -j16 && sudo make install


cd $DIR

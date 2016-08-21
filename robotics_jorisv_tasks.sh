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

cd ~/src
mkdir -p jorisv

# install https://github.com/jorisv/Eigen3ToPython
cd ~/src/jorisv
if [ ! -d ~/src/jorisv/Eigen3ToPython ]
then
	git clone --recursive https://github.com/jorisv/Eigen3ToPython.git
fi

cd Eigen3ToPython
git pull
mkdir -p build
cd build
cmake -DPYTHON_DEB_LAYOUT=ON -DCMAKE_BUIlD_TYPE=Release ..
make -j16 && sudo make install




# install https://github.com/jorisv/SpaceVecAlg
cd ~/src/jorisv
if [ ! -d ~/src/jorisv/SpaceVecAlg ]
then
	git clone --recursive https://github.com/jorisv/SpaceVecAlg.git
fi

cd SpaceVecAlg
git pull
mkdir -p build
cd build
cmake .. -DPYTHON_DEB_LAYOUT=ON
make -j16 && sudo make install




# install https://github.com/jorisv/RBDyn
cd ~/src/jorisv
if [ ! -d ~/src/jorisv/RBDyn ]
then
	git clone --recursive https://github.com/jorisv/RBDyn.git
fi

cd RBDyn
git pull
mkdir -p build
cd build
cmake .. -DPYTHON_DEB_LAYOUT=ON
make -j16 && sudo make install




# install https://github.com/jrl-umi3218/sch-core
cd ~/src/jorisv
if [ ! -d ~/src/jorisv/sch-core ]
then
	git clone --recursive https://github.com/jrl-umi3218/sch-core.git
fi

cd sch-core
git pull
mkdir -p build
cd build
cmake ..
make -j16 && sudo make install




# install https://github.com/jorisv/eigen-qld
cd ~/src/jorisv
if [ ! -d ~/src/jorisv/eigen-qld ]
then
	git clone --recursive https://github.com/jorisv/eigen-qld.git
fi

cd eigen-qld
git pull
mkdir -p build
cd build
cmake ..
make -j16 && sudo make install




# install https://github.com/jorisv/Tasks
cd ~/src/jorisv
if [ ! -d ~/src/jorisv/Tasks ]
then
	git clone --recursive https://github.com/jorisv/Tasks.git
fi

cd Tasks
git pull
mkdir -p build
cd build
cmake ..
make -j16 && sudo make install


cd $DIR

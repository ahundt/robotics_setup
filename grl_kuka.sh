#!/bin/bash


# source: https://gist.github.com/phatblat/1713458
# Save script's current directory
DIR=$(pwd)

# /bin/bash
set -e
set -u
set -x


# source: https://github.com/ahundt/grl/blob/master/INSTALL.md
sudo apt update
sudo apt install -y libtool pkg-config build-essential autoconf automake cmake cmake-curses-gui
sudo apt install -y libboost-all-dev libeigen3-dev
sudo apt install -y libzmq3-dev libceres-dev


###############
# google flatbuffers install

cd ~/src
if [ ! -d ~/src/flatbuffers ]
then
	git clone https://github.com/google/flatbuffers.git
	cd flatbuffers
	mkdir build
fi
cd ~/src/flatbuffers
git pull
cd ~/src/flatbuffers/build
cmake ..
sudo make install
cd ../..

###########
# CMake-BASIS install
cd ~/src

if [ ! -d ~/src/BASIS ]
then
	git clone --depth=1 https://github.com/cmake-basis/BASIS.git
	cd BASIS
	mkdir build
fi

cd ~/src/BASIS
git pull
cd ~/src/BASIS/build
cmake .. -DCMAKE_INSTALL_PREFIX=/usr/local
sudo make install
cd ../..



###############
# azmq install

cd ~/src
if [ ! -d ~/src/azmq ]
then
	git clone https://github.com/zeromq/azmq.git
	cd azmq
	mkdir build
fi
cd ~/src/azmq
git pull
cd ~/src/azmq/build
cmake ..
sudo make install
cd ../..


###############
# grl install

cd ~/src

if [ ! -d ~/src/grl ]
then
	git clone https://github.com/ahundt/grl.git
	cd grl
	mkdir build
fi

cd ~/src/grl
cd build
cmake ..
sudo make install
cd ../..

cd $DIR

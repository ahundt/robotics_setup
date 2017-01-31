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

./flatbuffers.sh


./cmake-basis.sh


# deprecated
# ###############
# # azmq install

# cd ~/src
# if [ ! -d ~/src/azmq ]
# then
# 	git clone https://github.com/zeromq/azmq.git
# 	cd azmq
# 	mkdir build
# fi
# cd ~/src/azmq
# git pull
# cd ~/src/azmq/build
# cmake ..
# sudo make install
# cd ../..


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

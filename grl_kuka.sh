#!/bin/bash


# source: https://gist.github.com/phatblat/1713458
# Save script's current directory
DIR=$(pwd)

# /bin/bash
set -e
set -u
set -x

###############
# grl install


# source: https://github.com/ahundt/grl/blob/master/INSTALL.md
sudo apt-get update
sudo apt-get install -y libtool pkg-config build-essential autoconf automake cmake cmake-curses-gui
sudo apt-get install -y libboost-all-dev libeigen3-dev libgoogle-glog-dev
sudo apt-get install -y doxygen libceres-dev

. /etc/lsb-release # get ubuntu version number
# only install
if [ "$DISTRIB_RELEASE" = "16.04" ] || [ "$DISTRIB_RELEASE" = "14.04" ]; then
   ./ros.sh
   EXTRA_TOOLS="-DWITH_ROS=ON"
fi

./cmake-basis.sh
./eigen3.sh
./ceres.sh
./flatbuffers.sh
./spdlog.sh
./robotics_tasks.sh
./trtk.sh
./vrep.sh

SCRIPT_DIR=$(pwd)

cd ~/src/
if [ ! -d ~/src/grl ]
then
	git clone https://github.com/ahundt/grl.git
fi

cd grl
git pull

if [ ! -d ~/src/grl/build ]
then
    mkdir build
fi

cd build

cmake .. -DBUILD_ALL_MODULES=ON -DBUILD_DOCUMENTATION=ON -DBUILD_EXAMPLE=ON \
 -DMODULE_grl=ON                  \
 -DMODULE_robone=ON               \
 -DMODULE_roboneprivate=ON        \
 -DWITH_Ceres=ON                  \
 -DWITH_CisstNetlib=OFF           \
 -DWITH_Eigen3=ON                 \
 -DWITH_FRI_Client_SDK_Cpp=OFF    \
 -DWITH_Nanopb=OFF                \
 -DWITH_OpenCV=OFF                \
 -DWITH_PCL=OFF                   \
 -DWITH_RBDyn=ON                  \
 -DWITH_SpaceVecAlg=ON            \
 -DWITH_TRTK=ON                   \
 -DWITH_Tasks=ON                  \
 -DWITH_Threads=ON                \
 -DWITH_cisst=OFF                 \
 -DWITH_freenect2=OFF             \
 -DWITH_sawConstraintController=OFF\
 -DWITH_sch-core=ON              \
 -DWITH_spdlog=ON                \
 -DWITH_ur_modern_driver=OFF     $EXTRA_TOOLS

make -j
sudo make install
cd ../..

#./robonetracker_symlinks.sh


cd $DIR

# source: https://gist.github.com/phatblat/1713458
# Save script's current directory
DIR=$(pwd)

set -e
set -u
set -x

echo "############################"
echo "# robonetracker private repository"
echo "############################"
echo ""
echo ""

echo ""
echo "###############################################################################################"
echo "# Make sure you have access to https://github.com/ahundt/robonetracker                        #"
echo "# Also, ensure you have your ssh key configured, if you don't you'll have to finish manually! #"
echo "###############################################################################################"
echo ""
# partly based on https://github.com/ahundt/homebrew-robotics/blob/master/robonetracker.sh

# source: https://github.com/ahundt/grl/blob/master/INSTALL.md
sudo apt update
sudo apt install -y libtool pkg-config build-essential autoconf automake cmake cmake-curses-gui
sudo apt install -y libboost-all-dev libeigen3-dev libgoogle-glog-dev
sudo apt install -y libzmq3-dev libceres-dev

. /etc/lsb-release # get ubuntu version number
# only install
if [ "$DISTRIB_RELEASE" == "16.04" ]; then
   ./ros.sh
   EXTRA_TOOLS="-DWITH_ROS=ON"
fi

./cmake-basis.sh
./eigen3.sh
./ceres.sh
./flatbuffers.sh
./spdlog.sh
./camodocal.sh
./robotics_tasks.sh
./trtk.sh
./vrep.sh

SCRIPT_DIR=$(pwd)

cd ~/src/
if [ ! -d ~/src/robonetracker ]
then
	git clone https://github.com/ahundt/robonetracker.git
fi

cd robonetracker
#git pull

if [ ! -d ~/src/robonetracker/build ]
then
    mkdir build
fi

cd build

cmake .. -DBUILD_ALL_MODULES=ON -DBUILD_DOCUMENTATION=ON -DBUILD_EXAMPLE=ON \
 -DMODULE_grl=ON                  \
 -DMODULE_robone=ON               \
 -DMODULE_roboneprivate=ON        \
 -DWITH_CAMODOCAL=ON              \
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

./robonetracker_symlinks.sh

cd $DIR

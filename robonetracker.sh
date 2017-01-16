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

sh ros_kinetic.sh
sh cmake-basis.sh
sh eigen3.sh
sh ceres.sh
sh camodocal.sh
sh robotics_tasks.sh
sudo apt install  libceres-dev libgoogle-glog-dev


cd ~/src/
if [ ! -d ~/src/robonetracker ]
then
	git clone https://github.com/ahundt/robonetracker.git
fi

cd robonetracker
git pull
mkdir build
cd build
cmake .. && make -j16

cd $DIR

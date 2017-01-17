# source: https://gist.github.com/phatblat/1713458
# Save script's current directory
DIR=$(pwd)

set -e
set -u
set -x


echo "############################"
echo "# ceres-solver with manual 16.04 workarounds"
echo "############################"
echo ""
echo "ceres-solver.org"
echo ""
echo "Ubuntu 16.04 bugs:"
echo "https://bugs.launchpad.net/ubuntu/+source/ceres-solver/+bug/1596296"
echo "https://bugs.launchpad.net/ubuntu/+source/ceres-solver/+bug/1595692"
echo "INCLUDES HACK TO GET AROUND missing package files IN UBUNTU 16.04"

sudo apt install libceres-dev
sudo cp -a ceres/share/Ceres /usr/share
sudo cp -a ceres/include/internal/config.h /usr/include/ceres/internal

cd $DIR

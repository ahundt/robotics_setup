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

# TODO(ahundt) maybe we really want ceres-solver 1.12.0 for 16.04 as well? it has constrained optimization!

. /etc/lsb-release # get ubuntu version number

# only install
if [ "$DISTRIB_RELEASE" == "16.04" ]; then
    sudo apt install libceres-dev
    sudo cp -a ceres/share/Ceres /usr/share
    sudo cp -a ceres/include/internal/config.h /usr/include/ceres/internal
fi

# only install
if [ "$DISTRIB_RELEASE" == "14.04" ]; then

    cd ~/src
    if [ ! -d ~/src/ceres-solver ]
    then
        git clone https://ceres-solver.googlesource.com/ceres-solver -b 1.12.0
        cd ceres-solver
        mkdir build
    fi
    cd ~/src/ceres-solver
    git pull
    cd ~/src/ceres-solver/build
    cmake ..
    sudo make -j install
    cd ../..

fi
cd $DIR

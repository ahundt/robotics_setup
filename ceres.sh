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
    sudo apt-get install -y libceres-dev
    sudo cp -a ceres/share/Ceres /usr/share
    sudo cp -a ceres/include/internal/config.h /usr/include/ceres/internal
fi

# only install
if [ "$DISTRIB_RELEASE" == "14.04" ]; then
    # Special steps for Ubuntu 14.04 documented at:
    # http://ceres-solver.org/installation.html#linux

    # CMake
    sudo apt-get install -y cmake
    # google-glog + gflags
    sudo apt-get install -y libgoogle-glog-dev
    # BLAS & LAPACK
    sudo apt-get install -y libatlas-base-dev
    # Eigen3
    sudo apt-get install -y libeigen3-dev
    # SuiteSparse and CXSparse (optional)
    # - If you want to build Ceres as a *static* library (the default)
    #   you can use the SuiteSparse package in the main Ubuntu package
    #   repository:
    # sudo apt-get install -y libsuitesparse-dev
    # - However, if you want to build Ceres as a *shared* library, you must
    #   add the following PPA:
    sudo add-apt-repository ppa:bzindovic/suitesparse-bugfix-1319687
    sudo apt-get update
    sudo apt-get install -y libsuitesparse-dev

    cd ~/src
    if [ ! -d ~/src/ceres-solver ]
    then
        git clone https://ceres-solver.googlesource.com/ceres-solver -b 1.12.0
        cd ceres-solver
        mkdir build
    fi

    # uncomment to pull bleeding edge version of the cloned branch
    # cd ~/src/ceres-solver
    # git pull

    cd ~/src/ceres-solver/build

    cmake ..
    sudo make -j install
    cd ../..

fi
cd $DIR

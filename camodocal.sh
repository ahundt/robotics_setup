# source: https://gist.github.com/phatblat/1713458
# Save script's current directory
DIR=$(pwd)

set -e
set -u
set -x


echo "###############################################"
echo "# CamOdoCal - Calibration Algorithms"
echo "###############################################"
echo "#"
echo "# https://github.com/hengli/camodocal"
echo "# also see: https://github.com/jhu-lcsr/handeye_calib_camodocal"
echo "#"
echo "# Extra steps: this runs ceres.sh first!"

sh ceres.sh
sudo apt-get install -y libgoogle-glog-dev

echo "HACK TO GET AROUND CMAKE BUILD ERROR IN UBUNTU 16.04:"
echo "sudo ln -s /usr/lib/x86_64-linux-gnu/libglog.so /usr/local/lib/"
if [ ! -f /usr/local/lib/libglog.so ]
then
    sudo ln -s /usr/lib/x86_64-linux-gnu/libglog.so /usr/local/lib/
fi

mkdir -p ~/src
cd ~/src

if [ ! -d ~/src/camodocal ]
then
    git clone https://github.com/hengli/camodocal.git -b v1.0.1
fi

cd ~/src/camodocal

# uncomment to pull bleeding edge version of the cloned branch
# git pull

if [ ! -d build ]
then
    mkdir build
fi

cd build
cmake ..
make -j && sudo make install


cd $DIR

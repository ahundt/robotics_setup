# source: https://gist.github.com/phatblat/1713458
# Save script's current directory
DIR=$(pwd)

set -e
set -u
set -x

echo "############################"
echo "# co-fusion https://github.com/martinruenz/co-fusion"
echo "############################"
echo ""
echo "Co-Fusion: Real-time Segmentation, Tracking and Fusion of Multiple Objects "
echo ""

# install opencv
./opencv.sh
# superpixel segmentation
./gslicr.sh
# data visualization
./pangolin.sh



cd ~/src/


if [ ! -d ~/src/densecrf ]
then
	git clone https://github.com/martinruenz/densecrf.git
fi
cd densecrf
git pull
mkdir -p build
cd build
cmake .. -DCMAKE_INSTALL_PREFIX=/usr/local -DCMAKE_MODULE_PATH=/usr/share/OpenCV/
cmake --build .

git pull

cd ~/src/
if [ ! -d ~/src/co-fusion ]
then
	git clone https://github.com/martinruenz/co-fusion.git
fi
cd co-fusion
git pull


#co-fusion expects gSLICr to be in the deps folder, let's use a symlink for that
mkdir -p deps
ln -sf ~/src/gSLICr deps/gSLICr
ln -sf ~/src/densecrf deps/densecrf

# compile
mkdir -p build
cd build
# TODO(ahundt) should CMAKE_MODULE_PATH always be set like this or should we make a pull request to fix it?
cmake .. -DCMAKE_INSTALL_PREFIX=/usr/local -DCMAKE_MODULE_PATH=/usr/share/OpenCV/
cmake --build .


cd $DIR

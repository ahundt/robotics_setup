
# source: https://gist.github.com/phatblat/1713458
# Save script's current directory
DIR=$(pwd)

set -e
set -u
set -x

echo "############################"
echo "# gSLICr: Real-time super-pixel segmentation  https://github.com/carlren/gSLICr"
echo "############################"
echo ""
echo ""

# create cmake package registry

# install https://github.com/stevenlovegrove/pangolin
cd ~/src/
if [ ! -d ~/src/gSLICr ]
then
	git clone https://github.com/carlren/gSLICr.git
fi
cd gSLICr
git pull
mkdir -p build
cd build
cmake .. -DCMAKE_INSTALL_PREFIX=/usr/local
make


cd $DIR

# source: https://gist.github.com/phatblat/1713458
# Save script's current directory
DIR=$(pwd)

set -e
set -u
set -x


echo "############################"
echo "# CMake - cmake.org"
echo "############################"
echo ""
echo "CMake, the cross-platform, open-source build system. https://cmake.org"
echo ""
echo "https://github.com/Kitware/CMake/"


cd ~/src/
if [ ! -d ~/src/CMake ]
then
	git clone https://github.com/Kitware/CMake.git -b release
fi

cd CMake
git pull

./bootstrap
make -j install

cd $DIR
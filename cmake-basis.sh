# source: https://gist.github.com/phatblat/1713458
# Save script's current directory
DIR=$(pwd)

set -e
set -u
set -x


echo "############################"
echo "# CMAKE-BASIS installer     "
echo "############################"
echo ""
echo "https://cmake-basis.github.io/index.html"
echo ""

mkdir -p ~/src
cd ~/src

# We prefer cmake be a version later than the default on 16.04, so check for that and install an update.
if [[ $cmakeversion == *"cmake version 3.5.1"* ]]; then
    echo "Detected incompatible cmake version 3.5.1, updating CMake from source, see cmake_source.sh for details"
    ./cmake_source.sh
fi

if [ ! -d ~/src/cmake-basis ]
then
    mkdir -p ~/src/cmake-basis
    git clone --depth=1 https://github.com/cmake-basis/BASIS.git cmake-basis --branch v3.3.1
fi

cd cmake-basis
git pull


if [ ! -d ~/src/cmake-basis/build ]
then
    mkdir -p ~/src/cmake-basis/build
fi

cd build
cmake .. -DCMAKE_INSTALL_PREFIX=/usr/local -DBUILD_PROJECT_TOOL=ON -DBUILD_APPLICATIONS=ON -DBUILD_EXAMPLE=ON
make -j && sudo make install


cd $DIR

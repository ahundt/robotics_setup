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

cd ~/src

if [ ! -d ~/src/cmake-basis ]
then
    mkdir -p ~/src/cmake-basis
    git clone --depth=1 https://github.com/cmake-basis/BASIS.git cmake-basis
fi

cd cmake-basis


if [ ! -d ~/src/cmake-basis/build ]
then
    mkdir -p ~/src/cmake-basis/build
fi

cd build
cmake .. -DCMAKE_INSTALL_PREFIX=/usr/local -DBUILD_PROJECT_TOOL=ON -DBUILD_APPLICATIONS=ON -DBUILD_EXAMPLE=ON
make -j16 && sudo make install


cd $DIR

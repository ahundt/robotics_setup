# source: https://gist.github.com/phatblat/1713458
# Save script's current directory
DIR=$(pwd)

set -e
set -u
set -x

echo "###############################################"
echo "# TRTK Transformation and Registration Toolkit"
echo "###############################################"

echo "https://github.com/RWTHmediTEC/TRTK"

./eigen3.sh
cmakeversion=`cmake --version`
if [[ $cmakeversion == *"cmake version 3.5.1"* ]]; then
    echo "Detected incompatible cmake version 3.5.1, updating from source, see cmake_source.sh for details"
    ./cmake_source.sh
fi
sudo apt-get install -y libflann-dev

# install https://github.com/jrl-umi3218/SpaceVecAlg
cd ~/src/
if [ ! -d ~/src/TRTK ]
then
	git clone --recursive https://github.com/ahundt/TRTK.git # https://github.com/RWTHmediTEC/TRTK.git
fi

cd TRTK
git pull
mkdir -p build
cd build
cmake ..
make -j && sudo make install


cd $DIR
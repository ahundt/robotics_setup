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


# install https://github.com/jrl-umi3218/SpaceVecAlg
cd ~/src/
if [ ! -d ~/src/TRTK ]
then
	git clone --recursive git@github.com:ahundt/TRTK.git # git@github.com:RWTHmediTEC/TRTK.git
fi

cd TRTK
git pull
mkdir -p build
cd build
cmake .. 
make -j44 && sudo make install


cd $DIR
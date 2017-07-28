
DIR=$(pwd)

set -e
set -u
set -x


echo "###############################################"
echo "# googletest https://github.com/google/googletest"
echo "###############################################"



cd ~/src/
if [ ! -d ~/src/googletest ]
then
	git clone --recursive https://github.com/google/googletest.git
fi

cd googletest
git pull
mkdir -p build
cd build
cmake ..
make -j && sudo make install


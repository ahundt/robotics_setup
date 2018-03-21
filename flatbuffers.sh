
#!/bin/bash


# source: https://gist.github.com/phatblat/1713458
# Save script's current directory
DIR=$(pwd)

# /bin/bash
set -e
set -u
set -x


###############
# google flatbuffers install

cd ~/src
if [ ! -d ~/src/flatbuffers ]
then
	git clone https://github.com/google/flatbuffers.git
	cd flatbuffers
	mkdir build
fi
cd ~/src/flatbuffers
git pull
cd ~/src/flatbuffers/build
cmake .. -DCMAKE_CXX_FLAGS=-fPIC
sudo make -j install
cd ../..

cd $DIR

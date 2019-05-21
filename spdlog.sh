
#!/bin/bash


# source: https://gist.github.com/phatblat/1713458
# Save script's current directory
DIR=$(pwd)

# /bin/bash
set -e
set -u
set -x


###############
# spdlog - Super fast C++ logging library.

cd ~/src
if [ ! -d ~/src/spdlog ]
then
	git clone https://github.com/gabime/spdlog.git
	cd spdlog
	mkdir build
fi
cd ~/src/spdlog
git pull
cd ~/src/spdlog/build
cmake .. -D SPDLOG_BUILD_BENCH=OFF
sudo make -j install
cd ../..

cd $DIR
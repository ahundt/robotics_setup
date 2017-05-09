
#!/bin/bash


# source: https://gist.github.com/phatblat/1713458
# Save script's current directory
DIR=$(pwd)

# /bin/bash
set -e
set -u
set -x


###############
# bullet install

cd ~/src
if [ ! -d ~/src/bullet ]
then
	git clone https://github.com/bulletphysics/bullet3.git bullet
	cd bullet
	mkdir build
fi
cd ~/src/bullet
git pull
cd ~/src/bullet/build
cmake .. \
-DCMAKE_C_FLAGS_RELEASE=-DNDEBUG \
-DCMAKE_CXX_FLAGS_RELEASE=-DNDEBUG \
-DCMAKE_INSTALL_PREFIX=/usr/local \
-DCMAKE_BUILD_TYPE=Release \
-DCMAKE_FIND_FRAMEWORK=LAST \
-DCMAKE_VERBOSE_MAKEFILE=ON \
-Wno-dev \
-DHAVE_CLOCK_GETTIME:INTERNAL=0 \
-DINSTALL_EXTRA_LIBS=ON \
-DBUILD_UNIT_TESTS=OFF \
-DUSE_DOUBLE_PRECISION=ON \
-DBUILD_BULLET2_DEMOS=ON \
-DBUILD_PYBULLET=ON \
-DBUILD_PYBULLET_NUMPY=ON \
-DBUILD_PYBULLET_CLSOCKET=ON \
-DBUILD_PYBULLET_ENET=ON \
-DBUILD_ENET=ON \
-DBUILD_CLSOCKET=ON \
-DBUILD_SHARED_LIBS=ON

make -j
cd ../..

cd $DIR
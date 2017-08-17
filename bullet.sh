
#!/bin/bash


# source: https://gist.github.com/phatblat/1713458
# Save script's current directory
DIR=$(pwd)

# /bin/bash
set -e
set -u
set -x



echo "###############################################"
echo "# Bullet Physics and Robot Simulator"
echo "###############################################"
echo "# https://github.com/bulletphysics/bullet3"
echo "# http://pybullet.org/"
echo "#"
echo "# pybullet users may just want to install manually with pip:"
echo "# pip install pybullet"

sudo apt-get install libglew-dev

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

# get the path to the python exeuctable such as /usr/bin/python3
PYTHON_EXECUTABLE=`which python3`
# get the python version string such as "3.6.2"
PYTHON_VERSION=`${PYTHON_EXECUTABLE} -c "import sys; print('%s' % '.'.join(map(lambda x:str(x), sys.version_info[0:3])))"`
PYTHON_INCLUDE_DIR=`${PYTHON_EXECUTABLE} -c "import distutils.sysconfig; print(distutils.sysconfig.get_python_inc())"`
PYTHON_LIB_DIR=`${PYTHON_EXECUTABLE} -c "import distutils.sysconfig; print(distutils.sysconfig.get_python_lib(plat_specific=1))"`

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
-DBUILD_SHARED_LIBS=ON \
-DPYTHON_VERSION_PYBULLET=${PYTHON_VERSION} \
-DEXACT_PYTHON_VERSION=ON

# just use the cmake script to find the exact
# version, disabling other items below
# -DPYTHON_INCLUDE_DIR=${PYTHON_INCLUDE_DIR} \
# -DPYTHON_LIBRARY=${PYTHON_LIB_DIR}

make -j

cd ..

# disable if you actually need the local version
pip3 install pybullet baselines gym --upgrade --user

cd $DIR
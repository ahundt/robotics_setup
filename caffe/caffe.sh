# Caffe deep learning installation script

# cuda script should be run before this one because it
# seemed to need some manual steps documented there


# source: https://gist.github.com/phatblat/1713458
# Save script's current directory
DIR=$(pwd)

# /bin/bash
set -e
set -u
set -x


# 16.04 official caffe instructions: https://github.com/BVLC/caffe/wiki/Ubuntu-16.04-or-15.10-Installation-Guide
# adapted from: https://hub.docker.com/r/tleyden5iwx/caffe-gpu-master/~/dockerfile/

sudo apt update && sudo apt install -y \
  bc \
  cmake \
  curl \
  gcc \
  g++ \
  gfortran \
  git \
  libprotobuf-dev \
  libgoogle-glog-dev \
  libgflags-dev \
  libleveldb-dev \
  libsnappy-dev \
  libboost-all-dev \
  libhdf5-serial-dev \
  liblmdb-dev \
  libjpeg62 \
  libfreeimage-dev \
  libatlas-base-dev \
  libopenblas-dev \
  pkgconf \
  protobuf-compiler \
  python-dev \
  python-pip \
  unzip \
  wget

  # OpenCV is excluded because a later one is provided by ROS
  #  libopencv-dev \

. ../python.sh

# temporarily commenting because the cuda script
# seemed to need some manual steps documented there
#. ../cuda.sh


# This needs to be made conditional, and check that it is the right place
#echo "/usr/local/cuda/lib64" > /etc/ld.so.conf.d/cuda.conf && \
#  ldconfig

# install https://github.com/jorisv/Eigen3ToPython
cd ~/src
if [ ! -d ~/src/caffe ]
then
	git clone --recursive https://github.com/BVLC/caffe.git
fi

cd caffe
git pull

sudo pip install -r python/requirements.txt

if [ -f ~/src/caffe/Makefile.config ]
then
	rm ~/src/caffe/Makefile.config
fi

cp $DIR/Makefile.config Makefile.config
# Adjust Makefile.config (for example, if using Anaconda Python, or if cuDNN is desired)

# to find where some files are use for example:
# dpkg-query -L ros-kinetic-opencv3

if [ ! -f /usr/lib/x86_64-linux-gnu/libhdf5.so ]
then
  sudo ln -s /usr/lib/x86_64-linux-gnu/libhdf5_serial.so /usr/lib/x86_64-linux-gnu/libhdf5.so
  sudo ln -s /usr/lib/x86_64-linux-gnu/libhdf5_serial_hl.so /usr/lib/x86_64-linux-gnu/libhdf5_hl.so
fi

# Assumes you are using ROS kinetic for your OpenCV installation
if [ ! -f /opt/ros/kinetic/lib/libopencv_imgcodecs.so ]
then
  sudo ln -s /opt/ros/kinetic/lib/libopencv_imgcodecs3.so /opt/ros/kinetic/lib/libopencv_imgcodecs.so
fi



if [ ! -f /usr/lib/x86_64-linux-gnu/libcudnn.so.5 ]
then
  sudo ln -s /usr/lib/x86_64-linux-gnu/libcudnn.so.5 /usr/lib/x86_64-linux-gnu/libcudnn.so
fi

make clean # clean just to be safe
make all  -j $(($(nproc) + 1))
make test  -j $(($(nproc) + 1))
make runtest  -j $(($(nproc) + 1))
make distribute


cd $DIR
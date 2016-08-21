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

if [ ! -f ~/src/caffe/Makefile.config ]
then
	rm ~/src/caffe/Makefile.config
fi

cp $DIR/Makefile.config Makefile.config
# Adjust Makefile.config (for example, if using Anaconda Python, or if cuDNN is desired)
make -j44 all
make test
make runtest


cd $DIR
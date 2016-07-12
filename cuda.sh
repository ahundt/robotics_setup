#!/bin/bash

echo ""
echo "This script is intended to setup CUDA and CUDNN"
echo "@author Andrew Hundt <ATHundt@gmail.com>"
echo ""


# source: https://gist.github.com/phatblat/1713458
# Save script's current directory
DIR=$(pwd)

# /bin/bash
set -e
set -u
set -x

echo ""
echo "Go to the NVIDIA website and download CUDA + CUDNN"
echo "https://developer.nvidia.com/cuda-toolkit"
echo "and put it in ~/Downloads"


# NVIDIA CUDA
sudo apt-get install linux-headers-$(uname -r)

if [ ! -f ~/Downloads/cuda-repo-ubuntu1604-8-0-rc_8.0.27-1_amd64.deb ]
then
  curl https://developer.nvidia.com/compute/cuda/8.0/rc/local_installers/cuda-repo-ubuntu1604-8-0-rc_8.0.27-1_amd64-deb --output ~/Downloads/cuda-repo-ubuntu1604-8-0-rc_8.0.27-1_amd64.deb
fi


 sudo dpkg -i ~/Downloads/cuda-repo-ubuntu1604-8-0-rc_8.0.27-1_amd64.deb
 sudo apt-get update -y
 sudo apt-get install -y cuda


if [ ! -f ~/Downloads/cudnn-8.0-linux-x64-v5.0-ga-tgz ]
then
  curl https://developer.nvidia.com/rdp/assets/cudnn-8.0-linux-x64-v5.0-ga-tgz ~/Downloads/cudnn-8.0-linux-x64-v5.0-ga.tgz
fi

cd $DIR

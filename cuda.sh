#!/bin/bash

echo "########################"
echo "# CUDA and CUDNN Setup #"
echo "########################"
echo ""
echo "Manual steps are involved! you may need to update the"
echo "install paths and download some files yourse"
echo ""
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
echo "###################################################"
echo "Go to the NVIDIA website and download CUDA + CUDNN"
echo "https://developer.nvidia.com/cuda-toolkit"
echo "and put it in ~/Downloads"
echo "###################################################"
echo ""


# deep learning setup with GTX 1080
# http://yangcha.github.io/GTX-1080/

# NVIDIA CUDA
sudo apt-get install linux-headers-$(uname -r)

if [ ! -f ~/Downloads/cuda-repo-ubuntu1604-8-0-rc_8.0.27-1_amd64.deb ]
then
  curl https://developer.nvidia.com/compute/cuda/8.0/rc/local_installers/cuda-repo-ubuntu1604-8-0-rc_8.0.27-1_amd64-deb --output ~/Downloads/cuda-repo-ubuntu1604-8-0-rc_8.0.27-1_amd64.deb
fi

# Note that if you are having problems with these steps, manually
# check the repository in the ubuntu software center:
# https://askubuntu.com/questions/650692/installing-cuda-7-0-on-ubuntu-14-04


# You will have to add the file to your software list. After running:

# sudo dpkg -i cuda-repo-ubuntu1404-7-0-local_7.0-28_amd64.deb
# open Softwares & Updates (search for it in the Dash)

# In the Other Software tab, enable the checkbox corresponding to your package. It will be of the form

# file:///var/cuda...

 sudo dpkg -i ~/Downloads/cuda-repo-ubuntu1604-8-0-rc_8.0.27-1_amd64.deb
 sudo apt update -y
 sudo apt install -y cuda


if [ ! -f ~/Downloads/cudnn-8.0-linux-x64-v5.0-ga-tgz ]
then
  curl https://developer.nvidia.com/rdp/assets/cudnn-8.0-linux-x64-v5.0-ga-tgz --output ~/Downloads/cudnn-8.0-linux-x64-v5.0-ga.tgz
fi

cd $DIR

#!/bin/bash

# source: https://gist.github.com/phatblat/1713458
# Save script's current directory
DIR=$(pwd)

# /bin/bash
set -e
set -u
set -x

echo "################################"
echo "# NVIDIA DRIVERS: Manual Setup #"
echo "################################"
echo ""
echo "# also see: cuda.sh and cudnn.sh if you will be doing deep learning!"
echo ""
echo "# caffe install instructions"
echo "# https://github.com/BVLC/caffe/wiki/Ubuntu-16.04-or-15.10-Installation-Guide"
echo ""
echo "# deep learning setup with GTX 1080"
echo "# http://yangcha.github.io/GTX-1080/"
echo ""
echo "# explanation"
echo "# https://linuxconfig.org/how-to-install-the-latest-nvidia-drivers-on-ubuntu-16-04-xenial-xerus"
echo ""
echo "# find your driver"
echo "# http://www.nvidia.com/Download/index.aspx"
echo ""
echo "# ubuntu's instructions"
echo "# https://help.ubuntu.com/community/BinaryDriverHowto/Nvidia"



################
# NVIDIA DRIVERS
################

# explanation
# https://linuxconfig.org/how-to-install-the-latest-nvidia-drivers-on-ubuntu-16-04-xenial-xerus

# find your driver
# http://www.nvidia.com/Download/index.aspx

sudo add-apt-repository -y ppa:graphics-drivers/ppa
sudo apt-get -y update
sudo apt-get install -y nvidia-367 mesa-common-dev freeglut3-dev

sudo apt-get -y update
sudo apt-get -y upgrade

sh cuda.sh

# stop the window manager
# you probably want to run this in ctrl + alt + f1 mode
# sudo service lightdm stop

# install nvidia drivers with dkms manager enabled
# sudo sh ./NVIDIA-Linux-x86_64-367.35.run --dkms


# alternative older instructions
#sudo add-apt-repository -y ppa:graphics-drivers/ppa
#sudo apt-get -y update
#sudo apt-get install -y nvidia-367 mesa-common-dev freeglut3-dev


cd $DIR

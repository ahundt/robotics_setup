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
echo "https://developer.nvidia.com/cudnn"
echo "and put it in ~/Downloads"
echo "the new .deb versions are recommended on ubuntu"
echo "Also open /usr/local/cuda/include/host_config.h"
echo "and comment out the following line with two backslashes //"
echo "#error -- unsupported GNU version! gcc versions later than 5.3 are not supported!"
echo ""
echo "IMPORTANT:"
echo "You may need to install the latest graphics driver first"
echo "CUDA must be installed with no graphics running"
echo "to disable graphics (from terminal):"
echo "sudo service lightdm stop"
echo "###################################################"
echo ""


echo "GTX1080 instructions that may help: https://github.com/fchollet/keras/issues/3043#issuecomment-233480326"
# for anyone finding this: just spent a day trying to get a gtx 1070 to run on ubuntu 16.04 w/ CUDA 8 rc and Theano. Here are some guidelines:

# gtx 1070 and 1080 require a nvidia 367 driver. You can't currently get this from apt-get, so you need to download a runfile and execute it w/ the ubuntu gui shut down. here's a tutorial: http://www.yourownlinux.com/2016/06/how-to-install-nvidia-367-27-stable-graphics-drivers-in-linux.html
# cuda 7.5 did not seem to want to work w/ the 367 driver. Potentially I could have fixed this. Instead I decided to install cuda 8.0 rc. However, using the deb file installation approach automatically installed the nvidia 361 drivers, which caused a conflict that was very difficult to remove. This is the source of the "could not insert 'nvidia_361_uvm'" error.
# Also, cuda 8.0 rc requires you to reinstall nvidia drivers anyway, which I did not realize.
# To repair:
# sudo apt-get purge nvidia* to remove 361 and its assorted packages.
# get to pure shell w/ ctrl+alt+f2, `sudo service lightdm stop`, and use the 367 runfile w/ the --uninstall argument to uninstall the 367 drivers. i.e. sudo sh nvidia367.xx.run --uninstall
# w/ lightdm shutdown, reinstall 367 drivers with the runfile. i.e. sudo sh nvidia367.xx.run
# install cuda-8.0 rc w/ its runfile, which gives you the option to install the 361 drivers. When presented with it, choose no. i.e. sudo sh cuda-8.0.x.x.run
# following this I needed to update some PATH stuff that was pointing to the cuda 7.5 folder. Also I had copied cuDNN files into 7.5 include and lib64 folders, so those files needed to be copied to the 8.0 equivalents.

# deep learning setup with GTX 1080
# http://yangcha.github.io/GTX-1080/

# NVIDIA CUDA
sudo apt-get install linux-headers-$(uname -r)

if [ ! -f ~/Downloads/cuda-repo-ubuntu1604-8-0-local_8.0.44-1_amd64.deb ]
then
  curl https://developer.nvidia.com/compute/cuda/8.0/rc/local_installers/cuda-repo-ubuntu1604-8-0-local_8.0.44-1_amd64.deb --output ~/Downloads/cuda-repo-ubuntu1604-8-0-rc_8.0.27-1_amd64.deb
fi

# Note that if you are having problems with these steps, manually
# check the repository in the ubuntu software center:
# https://askubuntu.com/questions/650692/installing-cuda-7-0-on-ubuntu-14-04


# You will have to add the file to your software list. After running:

# sudo dpkg -i cuda-repo-ubuntu1404-7-0-local_7.0-28_amd64.deb
# open Softwares & Updates (search for it in the Dash)

# In the Other Software tab, enable the checkbox corresponding to your package. It will be of the form

# file:///var/cuda...

sudo dpkg -i ~/Downloads/cuda-repo-ubuntu1604-8-0-local_8.0.44-1_amd64.deb
sudo apt-get update
sudo apt-get install -y cuda


sh cudnn.sh

cd $DIR

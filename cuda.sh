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
echo ""
echo "IMPORTANT:"
echo "You may need to install the latest graphics driver first"
echo "CUDA must be installed with no graphics running"
echo "to disable graphics (from terminal):"
echo "sudo service lightdm stop"
echo "###################################################"
echo ""


# NVIDIA CUDA
sudo apt-get install -y linux-headers-$(uname -r)


if [ ! -f ~/Downloads/cuda-repo-ubuntu1604-9-1-local_9.1.85-1_amd64.deb ] ; then
  # cuda itself
  curl https://developer.nvidia.com/compute/cuda/9.1/Prod/local_installers/cuda-repo-ubuntu1604-9-1-local_9.1.85-1_amd64 --output ~/Downloads/cuda-repo-ubuntu1604-9-1-local_9.1.85-1_amd64.deb
  # latest patch
  curl https://developer.nvidia.com/compute/cuda/9.1/Prod/patches/1/cuda-repo-ubuntu1604-9-1-local-cublas-performance-update-1_1.0-1_amd64 --output ~/Downloads/cuda-repo-ubuntu1604-9-1-local-cublas-performance-update-1_1.0-1_amd64.deb
fi

sudo dpkg -i ~/Downloads/cuda-repo-ubuntu1604-9-1-local_9.1.85-1_amd64.deb
sudo dpkg -i ~/Downloads/cuda-repo-ubuntu1604-9-1-local-cublas-performance-update-1_1.0-1_amd64.deb
sudo apt-key add /var/cuda-repo-9-1-local/7fa2af80.pub
sudo apt-get update
sudo apt-get install -y cuda-libraries-9-1 cuda-repo-ubuntu1604-9-1-local-cublas-performance-update-1

# Note that if you are having problems with these steps, manually
# check the repository in the ubuntu software center:
# https://askubuntu.com/questions/650692/installing-cuda-7-0-on-ubuntu-14-04

# You will have to add the file to your software list. After running:

# sudo dpkg -i cuda-repo-ubuntu1404-7-0-local_7.0-28_amd64.deb
# open Softwares & Updates (search for it in the Dash)

# In the Other Software tab, enable the checkbox corresponding to your package. It will be of the form

# file:///var/cuda...

# Installation Instructions from :
# https://developer.nvidia.com/cuda-downloads?target_os=Linux&target_arch=x86_64&target_distro=Ubuntu&target_version=1604&target_type=deblocal:

#     `sudo dpkg -i cuda-repo-ubuntu1604-9-1-local_9.1.85-1_amd64.deb`
#     `sudo apt-key add /var/cuda-repo-<version>/7fa2af80.pub`
#     `sudo apt-get update`
#     `sudo apt-get install cuda`

# Other installation options are available in the form of meta-packages. For example, to install all the library packages, replace "cuda" with the "cuda-libraries-9-1" meta package. For more information on all the available meta packages click here.


# nccl which is useful for horovod support http://github.com/uber/horovod/
if [ ! -f ~/Downloads/nccl-repo-ubuntu1604-2.1.4-ga-cuda9.1_1-1_amd64.deb ] ; then
  curl  https://developer.nvidia.com/compute/machine-learning/nccl/secure/v2.1/prod/nccl-repo-ubuntu1604-2.1.4-ga-cuda9.1_1-1_amd64 --output nccl-repo-ubuntu1604-2.1.4-ga-cuda9.1_1-1_amd64.deb
fi

sudo dpkg -i ~/Downloads/nccl-repo-ubuntu1604-2.1.4-ga-cuda9.1_1-1_amd64.deb
sudo apt-get update
sudo apt-get install -y libnccl2 libnccl-dev libnccl-dev nccl-repo-ubuntu1604-2.1.4-ga-cuda9.1

# The steps below are outdated, remove if there have been no problems
# # install the CUDA profiler for cuda 8.0
# # Here is how to profile tensorflow: https://towardsdatascience.com/howto-profile-tensorflow-1a49fb18073d
# # also see https://github.com/tensorflow/tensorflow/issues/9341#issuecomment-324041125
# if [ ! -f ~/Downloads/libcupti8.0_8.0.44-3_amd64.deb ] ; then
#   curl http://cz.archive.ubuntu.com/ubuntu/pool/multiverse/n/nvidia-cuda-toolkit/libcupti8.0_8.0.44-3_amd64.deb --output ~/Downloads/libcupti8.0_8.0.44-3_amd64.deb
# fi

# sudo dpkg -i  ~/Downloads/libcupti8.0_8.0.44-3_amd64.deb

# if [ ! -f ~/Downloads/libcupti-dev_8.0.44-3_amd64.deb ] ; then
#   curl http://cz.archive.ubuntu.com/ubuntu/pool/multiverse/n/nvidia-cuda-toolkit/libcupti-dev_8.0.44-3_amd64.deb --output ~/Downloads/libcupti-dev_8.0.44-3_amd64.deb
# fi

# sudo dpkg -i ~/Downloads/libcupti-dev_8.0.44-3_amd64.deb

# install CUDNN for deep learning
sh cudnn.sh


# OLD ADVICE FROM 2016
# --------------------
# echo "GTX1080 instructions that may help: https://github.com/fchollet/keras/issues/3043#issuecomment-233480326"
# for anyone finding this: just spent a day trying to get a gtx 1070 to run on ubuntu 16.04 w/ CUDA 8 rc and Theano. Here are some guidelines:

# gtx 1070 and 1080 require a nvidia 367 driver. You can't currently get this from apt, so you need to download a runfile and execute it w/ the ubuntu gui shut down. here's a tutorial: http://www.yourownlinux.com/2016/06/how-to-install-nvidia-367-27-stable-graphics-drivers-in-linux.html
# cuda 7.5 did not seem to want to work w/ the 367 driver. Potentially I could have fixed this. Instead I decided to install cuda 8.0 rc. However, using the deb file installation approach automatically installed the nvidia 361 drivers, which caused a conflict that was very difficult to remove. This is the source of the "could not insert 'nvidia_361_uvm'" error.
# Also, cuda 8.0 rc requires you to reinstall nvidia drivers anyway, which I did not realize.
# To repair:
# sudo apt-get purge nvidia* to remove 361 and its assorted packages.
# get to pure shell w/ ctrl+alt+f2, `sudo service lightdm stop`, and use the 367 runfile w/ the --uninstall argument to uninstall the 367 drivers. i.e. sudo sh nvidia367.xx.run --uninstall
# w/ lightdm shutdown, reinstall 367 drivers with the runfile. i.e. sudo sh nvidia367.xx.run
# install cuda-8.0 rc w/ its runfile, which gives you the option to install the 361 drivers. When presented with it, choose no. i.e. sudo sh cuda-8.0.x.x.run
# following this I needed to update some PATH stuff that was pointing to the cuda 7.5 folder. Also I had copied cuDNN files into 7.5 include and lib64 folders, so those files needed to be copied to the 8.0 equivalents.

# echo "Also open /usr/local/cuda/include/host_config.h"
# echo "and comment out the following line with two backslashes //"
# echo "#error -- unsupported GNU version! gcc versions later than 5.3 are not supported!"
# deep learning setup with GTX 1080
# http://yangcha.github.io/GTX-1080/

cd $DIR

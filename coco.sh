#!/bin/bash


# source: https://gist.github.com/phatblat/1713458
# Save script's current directory
DIR=$(pwd)

# /bin/bash
set -e
set -u
set -x



echo "############################"
echo "# Install Microsoft coco dataset python code"
echo "############################"
echo " This installs python software that supports the coco dataset"
echo " http://mscoco.org/"
echo " main repository https://github.com/cocodataset/cocoapi"
echo " cocostuff https://github.com/nightrome/cocoapi"
echo " my patches:"
echo "     ahundt https://github.com/ahundt/cocoapi"
echo " To download the dataset run robotics_setup/datasets/coco.sh"




# Enable python bindings via cython by default
# set to "ON" to build python bindings and "OFF" to disable them
# Note: "ON" generates tons of warnings and the log size might prevent CI from succeeding.
PIP_INSTALL="OFF"
#location="cocodataset" # https://github.com/cocodataset/cocoapi # main coco repository, but they haven't been updating it
location="ahundt" # github.com/ahundt/Tasks # I have some patches here
#location="nightrome" # https://github.com/nightrome/cocoapi # cocostuff

# modify if using a different branch
# branch="master"
branch="cocostuff_good_fixes"

# Check if the user specified any command line options
# other than teh default and set the variable appropriately.
while getopts p:l:b: option
do
 case "${option}"
 in
 p) PIP_INSTALL="${OPTARG}";;
 l) location="${OPTARG}";;
 b) branch="${OPTARG}";;
 esac
done

mkdir -p ~/datasets
cd ~/datasets


# install https://github.com/pdollar/coco
cd ~/src/
if [ ! -d ~/src/cocoapi ]
then
	git clone https://github.com/${location}/cocoapi.git -b ${branch}
	cd cocoapi
	git remote add ahundt https://github.com/ahundt/cocoapi.git
	git remote add cocostuff https://github.com/cocostuff/cocoapi.git
	git remote add cocoapi https://github.com/cocodataset/cocoapi.git
	cd ..
fi

cd cocoapi
git fetch --all
git pull ${location} ${branch}
cd PythonAPI
# sudo python setup.py install
# python setup.py install --user --upgrade
pip install -e . --user --upgrade

# # install coco python repository https://github.com/pdollar/coco.git
# cd ~/src
# if [ ! -d ~/src/coco ]
# then
# 	git clone https://github.com/pdollar/coco.git
# fi

# cd ~/src/coco
# git pull
# cd PythonAPI
# make install

cd $DIR

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
echo " https://github.com/pdollar/coco"
echo " To download the dataset run robotics_setup/datasets/coco.sh"


mkdir -p ~/datasets
cd ~/datasets


# install https://github.com/pdollar/coco
cd ~/src/
if [ ! -d ~/src/coco ]
then
	git clone https://github.com/pdollar/coco.git
fi

cd coco
git pull
cd PythonAPI
# sudo python setup.py install
python setup.py install --user

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

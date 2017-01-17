#!/bin/bash


# source: https://gist.github.com/phatblat/1713458
# Save script's current directory
DIR=$(pwd)

# /bin/bash
set -e
set -u
set -x

mkdir -p ~/datasets
cd ~/datasets

# Note that by running this download you agree to microsoft's terms and conditions
# http://mscoco.org/dataset/#download
curl -O http://msvocds.blob.core.windows.net/coco2014/train2014.zip http://msvocds.blob.core.windows.net/coco2014/val2014.zip http://msvocds.blob.core.windows.net/coco2014/test2014.zip http://msvocds.blob.core.windows.net/coco2015/test2015.zip http://msvocds.blob.core.windows.net/annotations-1-0-3/instances_train-val2014.zip http://msvocds.blob.core.windows.net/annotations-1-0-3/person_keypoints_trainval2014.zip http://msvocds.blob.core.windows.net/annotations-1-0-3/captions_train-val2014.zip http://msvocds.blob.core.windows.net/annotations-1-0-4/image_info_test2014.zip http://msvocds.blob.core.windows.net/annotations-1-0-4/image_info_test2015.zip


# install coco python repository https://github.com/pdollar/coco.git
cd ~/src
if [ ! -d ~/src/coco ]
then
	git clone https://github.com/pdollar/coco.git
fi

cd ~/src/coco
git pull
cd PythonAPI
make install

cd $DIR

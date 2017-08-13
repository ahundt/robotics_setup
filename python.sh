#!/bin/bash


# source: https://gist.github.com/phatblat/1713458
# Save script's current directory
DIR=$(pwd)

# /bin/bash
set -e
set -u
set -x


sudo apt-get install -y python-setuptools python-dev build-essential
# python 2
sudo easy_install pip
pip install --upgrade virtualenv

# python 3
sudo easy_install pip3
pip install --upgrade virtualenv3


cd $DIR

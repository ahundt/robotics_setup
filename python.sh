#!/bin/bash


# source: https://gist.github.com/phatblat/1713458
# Save script's current directory
DIR=$(pwd)

# /bin/bash
set -e
set -u
set -x


sudo apt-get -y install python-setuptools python-dev build-essential
sudo easy_install pip
pip install --upgrade virtualenv


cd $DIR

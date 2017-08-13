#!/bin/bash


# source: https://gist.github.com/phatblat/1713458
# Save script's current directory
DIR=$(pwd)

# /bin/bash
set -e
set -u
set -x


OS=`uname`
case $OS in
  'Linux')
    OS='Linux'
        . /etc/lsb-release # get ubuntu version number
        # only install
        if [ "$DISTRIB_ID" == "Ubuntu" ]; then
            # install ubuntu python package
            sudo apt-get install -y python-setuptools python-dev build-essential

            # workaround for pip 8.1.2 failing to upgrade on Ubuntu 16.04
            # see https://github.com/pypa/pip/issues/3776
            curl -o $HOME/Downloads/get-pip.py https://bootstrap.pypa.io/get-pip.py
            sudo python3 $HOME/Downloads/get-pip.py --user

            # commented below until workaround is no longer needed
            # python 2
            # TODO(ahundt) this may be interfering with python3's pip3?
            #sudo easy_install pip
            #pip install --upgrade virtualenv

            # python 3
            # pip3 install --upgrade virtualenv
        fi
    ;;
  'FreeBSD')
    OS='FreeBSD'
    alias ls='ls -G'
    ;;
  'WindowsNT')
    OS='Windows'
    ;;
  'Darwin')
    OS='Mac'
        brew install python python3
    ;;
  'SunOS')
    OS='Solaris'
    ;;
  'AIX') ;;
  *) ;;
esac


cd $DIR

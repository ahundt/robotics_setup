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
            # python 2
            sudo easy_install pip
            pip install --upgrade virtualenv

            # python 3
            sudo easy_install pip3
            pip install --upgrade virtualenv3
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

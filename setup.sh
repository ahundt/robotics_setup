#!/bin/bash

# This script is intended to setup a fresh desktop with ROS and
# with dependencies on homebrew or linuxbrew depending on the OS being used
# @author Andrew Hundt <ATHundt@gmail.com>
#
# 
# One step setup command for robonetracker:
# bash <(curl -fsSL https://raw.githubusercontent.com/ahundt/homebrew-robotics/master/robonetracker.sh)

# source: https://gist.github.com/phatblat/1713458
# Save script's current directory
DIR=$(pwd)

# /bin/bash
set -e
set -u
set -x

sudo apt -y update
# minimal linuxbrew requirements
sudo apt install -y build-essential curl git python-setuptools ruby

# additional useful tools that should probably be owned by the OS rather than linuxbrew
sudo apt install -y zsh screen tree sudo ssh x11-apps synaptic build-essential git linux-headers-generic cmake cmake-curses-gui

cd ~

if [ ! -d `pwd`/src ] ; then
    mkdir src;
fi

sh rtl8812AU_8821AU_linux.sh


sh nvidia.sh


if [ ! -f ~/Downloads/cudnn-8.0-linux-x64-v5.0-ga-tgz ]
then
  curl https://developer.nvidia.com/rdp/assets/cudnn-8.0-linux-x64-v5.0-ga-tgz ~/Downloads/cudnn-8.0-linux-x64-v5.0-ga-tgz
fi

#
# Check if Homebrew is installed
#
if  ! [ -x "$(command -v brew)" ] ; then

    OS=`uname`
    case $OS in
      'Linux')
        OS='Linux'
        alias ls='ls --color=auto'
        curl -fsSL https://raw.githubusercontent.com/ahundt/homebrew-robotics/master/linuxbrew.sh | bash /dev/stdin
        export PATH="$PATH:$HOME/.linuxbrew/bin"
	export MANPATH="$MANPATH:$HOME/.linuxbrew/share/man"
	export INFOPATH="$INFOPATH:$HOME/.linuxbrew/share/info"                                    
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
        /usr/bin/ruby -e "$(curl -fsSL https://raw.github.com/gist/323731)"
        ;;
      'SunOS')
        OS='Solaris'
        ;;
      'AIX') ;;
      *) ;;
    esac    
else
    brew update
fi

cd $DIR

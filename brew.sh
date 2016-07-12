#!/bin/bash

echo ""
echo "This script is intended to setup CUDA and CUDNN"
echo "@author Andrew Hundt <ATHundt@gmail.com>"
echo ""


# source: https://gist.github.com/phatblat/1713458
# Save script's current directory
DIR=$(pwd)

# /bin/bash
set -e
set -u
set -x


sudo apt-get -y update
# minimal linuxbrew requirements
sudo apt-get install -y build-essential curl git python-setuptools ruby

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

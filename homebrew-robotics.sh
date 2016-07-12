#!/bin/bash

# This script is intended to setup repositories useful for robotics
# with dependencies on homebrew or linuxbrew depending on the OS being used
# @author Andrew Hundt <ATHundt@gmail.com>
#
# 
# One step setup command for robonetracker:
# bash <(curl -fsSL https://raw.githubusercontent.com/ahundt/homebrew-robotics/master/robonetracker.sh)

echo ""
echo "###############################################################################################"
echo "# Make sure you have access to https://github.com/ahundt/robonetracker                        #"
echo "# Also, ensure you have your ssh key configured, if you don't you'll have to finish manually! #"
echo "###############################################################################################"
echo ""


# stop on errors
set -e
set -u
set -x


# source: https://gist.github.com/phatblat/1713458
# Save script's current directory
DIR=$(pwd)

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
        export PKG_CONFIG_PATH="/usr/bin/pkg-config:$HOME/.linuxbrew/bin/pkg-config"
        export PKG_CONFIG_LIBDIR="/usr/lib/pkgconfig:$HOME/.linuxbrew/lib/pkgconfig"
        export PATH="$HOME/.linuxbrew/bin:$PATH"                                    
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


cd $HOME

OSPARAM=""
if [ -d $HOME/.linuxbrew ] ; then
  # This param lets robonetracker build with the native linux dependencies
  # For details see: https://github.com/Homebrew/linuxbrew/issues/13
  OSPARAM="--env=inherit"
fi

# lots of scientific libraries and developer tools
brew tap homebrew/science
#brew install cmake --with-docs  $OSPARAM
brew install cmake $OSPARAM
brew install doxygen flatbuffers  $OSPARAM
brew install boost  $OSPARAM



# Mac & Linux TODO:
# This needs to be fit into the OSTYPE case statement, or a new way to do this
# with multiple lines needs to be worked out. 
#  https://stackoverflow.com/questions/394230/detect-the-os-from-a-bash-script

# Mac OSX TODO:

# Enable --with cuda if you have an nvidia graphics card and cuda 7.0 or greater installed
# install caskroom application manager
# brew casks are only supported on mac, not linux

# http://docs.nvidia.com/cuda/index.html
#brew cask install cuda
#brew cask install vrep
brew install opencv
#brew install opencv3 --with-contrib --c++11 --without-python3 --without-python $OSPARAM -v # --with-cuda
#brew link opencv3 --force

# from https://github.com/ahundt/homebrew-robotics
# robotics related libraries
brew tap ahundt/robotics
brew install cmake-basis $OSPARAM
brew install tbb protobuf suite-sparse gflags glog openblas ceres-solver $OSPARAM

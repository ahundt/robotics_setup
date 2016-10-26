#!/bin/bash

# This script is intended to setup a fresh desktop with ROS and
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
# partly based on https://github.com/ahundt/homebrew-robotics/blob/master/robonetracker.sh

# source: https://gist.github.com/phatblat/1713458
# Save script's current directory
DIR=$(pwd)

# /bin/bash
set -e
set -u
set -x

cd ~

# prezto tools to make zsh life easier
# https://github.com/sorin-ionescu/prezto\

# found via os x setup guide
# http://sourabhbajaj.com/mac-setup/iTerm/zsh.html

if [ -d `pwd`/.linuxbrew ] ; then
  export PATH="$PATH:$HOME/.linuxbrew/bin"
  brew install zsh zsh-completions
fi

if [ ! -d `pwd`/.linuxbrew ] ; then
  sudo apt-get -y install zsh
fi

if [ ! -f `pwd`/.zshrc ] ; then
  cp $DIR/zshrc.sh ~/.zshrc
  chsh -s $(which zsh)
fi


if [ ! -f ~/.zpreztorc ] ; then
  cp $DIR/zpreztorc.sh ~/.zpreztorc
fi

if [ ! -f ~/.zshrc ] ; then
  cp $DIR/zshrc.sh ~/.zpreztorc
fi

echo "https://github.com/sorin-ionescu/prezto"
echo "Updating zsh's prezto configuration"
echo "Pull the latest changes and update submodules."
echo ""
echo "cd ~/.zprezto && git pull && git submodule update --init --recursive"


git clone --recursive https://github.com/sorin-ionescu/prezto.git "${ZDOTDIR:-$HOME}/.zprezto"

zsh -c "setopt EXTENDED_GLOB;\
    for rcfile in \"${ZDOTDIR:-$HOME}\"/.zprezto/runcoms/^README.md(.N); do\
      ln -s \"$rcfile\" \"${ZDOTDIR:-$HOME}/.${rcfile:t}\";\
    done"


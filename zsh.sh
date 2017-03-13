#!/bin/bash

# This script is intended to setup a fresh desktop with ROS and
# with dependencies on homebrew or linuxbrew depending on the OS being used
# @author Andrew Hundt <ATHundt@gmail.com>

echo ""
echo "###############################################################################################"
echo "# ZSH setup/config scripts"
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
  if [ -x "$(command -v apt)" ]; then
    sudo apt install -y zsh
  fi
fi



if [ ! -f `pwd`/.zshrc ] ; then
  cp $DIR/.zshrc ~/.zshrc

  # sometimes you can't run chsh...
  if [ -x "$(command -v ypchsh)" ]; then
    sudo apt install -y zsh
  else
    chsh -s $(which zsh)
  fi
fi

if [ ! -f $HOME/.zpreztorc ] ; then
  cp $DIR/zpreztorc.sh ~/.zpreztorc
fi

if [ ! -f $HOME/.zshrc ] ; then
  cp $DIR/.zshrc ~/.zpreztorc
fi

echo "https://github.com/sorin-ionescu/prezto"
echo "Updating zsh's prezto configuration"
echo "Pull the latest changes and update submodules."
echo ""
echo "cd ~/.zprezto && git pull && git submodule update --init --recursive"

if [ ! -d ~/.zprezto ] ; then
git clone --recursive https://github.com/sorin-ionescu/prezto.git "${ZDOTDIR:-$HOME}/.zprezto"
fi

# todo: is this needed?
# zsh -c "setopt EXTENDED_GLOB;\
#     for rcfile in \"${ZDOTDIR:-$HOME}\"/.zprezto/runcoms/^README.md(.N); do\
#       ln -s \"$rcfile\" \"${ZDOTDIR:-$HOME}/.${rcfile:t}\";\
#     done"


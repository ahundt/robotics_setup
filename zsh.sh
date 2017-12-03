#!/bin/bash

# This script is intended to setup a fresh desktop with ROS and
# with dependencies on homebrew or linuxbrew depending on the OS being used
# @author Andrew Hundt <ATHundt@gmail.com>

echo ""
echo "###############################################################################################"
echo "# ZSH https://en.wikipedia.org/wiki/Z_shell setup and config"
echo "# using Prezto https://github.com/sorin-ionescu/prezto"
echo "###############################################################################################"
echo "#"
echo "# Installs zsh if necessary, sets it as the default shell,"
echo "# and enables a reasonable default configuration using Prezto"
echo "#"
echo "# Prezto — Instantly Awesome Zsh configuration framework"
echo "# https://github.com/sorin-ionescu/prezto"
echo "# Updating zsh's prezto configuration"
echo "# Pull the latest changes and update submodules."
echo "# "
echo "# cd ~/.zprezto && git pull && git submodule update --init --recursive"
echo "# "
echo "# This also enables the use of robotics_setup/.robotics_setup to configure your system"
echo "# to work with the other robotics_setup *.sh package install scripts you run."
echo ""

# source: https://gist.github.com/phatblat/1713458
# Save script's current directory
DIR=$(pwd)

# /bin/bash
set -e
set -u
set -x

cd ~

# prezto tools to make zsh life easier
# https://github.com/sorin-ionescu/prezto

# found via os x setup guide
# http://sourabhbajaj.com/mac-setup/iTerm/zsh.html

if [ -d `pwd`/.linuxbrew ] ; then
  export PATH="$PATH:$HOME/.linuxbrew/bin"
  brew install zsh zsh-completions
fi

if [ ! -d `pwd`/.linuxbrew ] ; then
  if [ -x "$(command -v apt-get)" ]; then
    sudo apt-get install -y zsh
  fi
fi

# check if homebrew is installed
# in that case use it to install zsh
# if needed
if  ! [ -x "$(command -v brew)" ] ; then
  brew install zsh
fi


if [ ! -f `pwd`/.zshrc ] ; then
  cp $DIR/.zshrc ~/.zshrc
  # sometimes you can't run chsh...
  if [ -x "$(command -v ypchsh)" ] ; then
    echo "TODO(ahundt) fix chsh... doesn't work on this platform right now... see robotics_setup/README.md"
    #ypchsh -s $(which zsh)
  else
    chsh -s $(which zsh)
  fi
fi

# create prezto symlinks to configure zsh
if [ ! -f $HOME/.zpreztorc ] ; then
  ln -s $DIR/.zpreztorc ~/.zpreztorc
fi

if [ ! -f $HOME/.zshrc ] ; then
  ln -s $DIR/.zshrc ~/.zshrc
fi

# symlink so robotics_setup config is always up to date
if [ ! -f $HOME/.robotics_setup ] ; then
  ln -s $DIR/.robotics_setup $HOME/.robotics_setup
fi

# only run zsh commands if zsh exists
if [ -x "$(command -v zsh)" ] ; then

  if [ ! -d ~/.zprezto ] ; then
    zsh -c "git clone --recursive https://github.com/sorin-ionescu/prezto.git \"${ZDOTDIR:-$HOME}/.zprezto\""
  fi

  # adapted from https://github.com/sorin-ionescu/prezto
  # creates symlinks to all prezto files not provided by robotics_setup
  # see https://github.com/sorin-ionescu/prezto/tree/master/runcoms for details
  cd $DIR
  zsh zshpreztolinks.zsh
#    zsh -c "setopt EXTENDED_GLOB;
#	    rcfiles=\"${ZDOTDIR:-$HOME}\"/.zprezto/runcoms/^README.md(.N)
#		echo $rcfiles
#        for rcfile in rcfiles; do
#          if [ ! -f \"$rcfile\" ] ; then
#            ln -s \"$rcfile\" \"${ZDOTDIR:-$HOME}/.${rcfile:t}\";
#          fi
#        done"
fi

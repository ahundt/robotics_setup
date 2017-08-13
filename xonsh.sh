#!/bin/bash

# This script is intended to setup a fresh desktop with ROS and
# with dependencies on homebrew or linuxbrew depending on the OS being used
# @author Andrew Hundt <ATHundt@gmail.com>

echo ""
echo "###############################################################################################"
echo "# XONSH python based shell (this file contains setup/config scripts)"
echo "###############################################################################################"
echo "# Bash to Xonsh translation http://xon.sh/bash_to_xsh.html"
echo "# "
echo "# MANUAL STEPS:"
echo "# "
echo "# First make sure you have python3 and pip3 installed!"
echo "# "
echo "# ./python.sh"


DIR=$(pwd)

# /bin/bash
set -e
set -u
set -x

cd ~

# note don't install xonsh with homebrew/linuxbrew
# because it will be in a a virtualenv that can't
# access your other apps.
# https://github.com/xonsh/xonsh/issues/2475
#
# However, you can work around this by using
# the xonsh included xip, which is like pip
# but makes sure to use you xonsh environment.


###########################
# Configuring your system

# about .xonshrc:
# http://xon.sh/xonshrc.html
#
# Customizing your xonshrc:
# http://xon.sh/customization.html

# If you want to customize your paths based on the directory
# you are in to automatically be set up for different projects,
# you will want to use events:
#
# http://xon.sh/tutorial_events.html
#
# Specifically on_chdir: http://xon.sh/events.html#on-chdir-olddir-str-newdir-str-none
#


###########################
# Environment Variables
#
# these are the variables you can set to change how things run.
# like how history works, path completion, etc
#
# http://xon.sh/envvars.html

###########################
# Extensions
# for details see:
# http://xon.sh/xontribs.html


############################
# History
#
# http://xon.sh/tutorial_hist.html


############################
# Install

pip3 install gnureadline pygments prompt_toolkit ply psutil ipykernel matplotlib xonsh xonsh-vox-tabcomplete xontrib-z --upgrade



############################
# Install

if [ ! -f $HOME/.xonshrc ] ; then
  ln -s $DIR/.xonshrc ~/.xonshrc
  # sometimes you can't run chsh...
  if [ -x "$(command -v ypchsh)" ] ; then
    echo "TODO(ahundt) fix chsh... doesn't work on this platform right now... see robotics_setup/README.md"
    #ypchsh -s $(which zsh)
  else
    chsh -s $(which xonsh)
  fi
fi


############################
# config.json
if [ ! -f $HOME/.config/xonsh/config.json ] ; then
  mkdir -p $HOME/.config/xonsh/
  ln -s $DIR/.config/xonsh/config.json $HOME/.config/xonsh/config.json
fi


############################
# .xonshrc
if [ ! -f $HOME/.xonshrc ] ; then
  ln -s $DIR/.xonshrc $HOME/.xonshrc
fi
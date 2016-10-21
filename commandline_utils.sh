#!/bin/bash

# source: https://gist.github.com/phatblat/1713458
# Save script's current directory
DIR=$(pwd)

set -e
set -u
set -x


echo "############################"
echo "# command line utils Setup #"
echo "############################"
echo ""
echo "@author Andrew Hundt <ATHundt@gmail.com>"
echo ""


echo "#################"
echo "# ack (ack-grep)"
echo "#################"
echo "http://beyondgrep.com/"
sudo apt install vim ack-grep




echo "###############"
echo "# tmux         "
echo "###############"
echo ""
echo "# https://wiki.ubuntu.com/ubuntu-make"
echo ""
echo ""
echo "Installs tmux persistent multiplexed console"
echo ""
echo "https://help.ubuntu.com/community/Repositories/Ubuntu"

sudo apt update
sudo apt install -y tmux



echo "###############"
echo "# byobu        "
echo "###############"
echo ""
echo "tool that makes life with tmux better" 
echo ""
echo "https://www.digitalocean.com/community/tutorials/how-to-install-and-use-byobu-for-terminal-management-on-ubuntu-16-04"

sudo apt install -y byobu



cd $DIR

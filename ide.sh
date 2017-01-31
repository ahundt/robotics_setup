#!/bin/bash

echo "##############"
echo "# IDE Setup #"
echo "##############"
echo ""
echo "Installs developer tools such as visual studio code"
echo ""
echo "https://help.ubuntu.com/community/Repositories/Ubuntu"
echo ""
echo "@author Andrew Hundt <ATHundt@gmail.com>"
echo ""


# source: https://gist.github.com/phatblat/1713458
# Save script's current directory
DIR=$(pwd)

set -e
set -u
set -x


echo "###############"
echo "# Ubuntu make"
echo "###############"
echo ""
echo "# https://wiki.ubuntu.com/ubuntu-make"
echo ""

sudo add-apt-repository -y ppa:ubuntu-desktop/ubuntu-make
sudo apt update
sudo apt install -y ubuntu-make


echo "####################"
echo "# Visual Studio Code"
echo "####################"
echo ""
echo "# code.visualtudio.com"
echo "# Installs to ~/.local/share/umake/ide/visual-studio-code"
echo ""

umake ide visual-studio-code


cd $DIR

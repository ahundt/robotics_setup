#!/bin/bash

echo "##############"
echo "# Apps Setup #"
echo "##############"
echo ""
echo "Installs apps such as google chrome"
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

sudo add-apt-repository restricted
sudo add-apt-repository universe
sudo add-apt-repository multiverse

echo "###############"
echo "# Google Chrome"
echo "###############"
echo ""
echo "# http://www.itzgeek.com/how-tos/linux/ubuntu-how-tos/install-google-chrome-on-ubuntu-16-04.html"
echo ""

if [ ! -f ~/Downloads/google-chrome-stable_current_amd64.deb ]
then
  curl https://dl.google.com/linux/direct/google-chrome-stable_current_amd64.deb --output ~/Downloads/google-chrome-stable_current_amd64.deb
fi

sudo apt install -y libxss1 libgconf2-4 libappindicator1 libindicator7 libpango1.0-0 libpangox-1.0-0
sudo dpkg -i ~/Downloads/google-chrome-stable_current_amd64.deb

cd $DIR

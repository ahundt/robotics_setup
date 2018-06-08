#!/bin/bash

# source: https://github.com/facontidavide/PlotJuggler
# Save script's current directory
DIR=$(pwd)

set -e
set -u
set -x

echo "################################################"
echo "# Time Series Visualization Tool--PlotJuggler  #"
echo "################################################"
echo ""
echo "https://facontidavide.github.io/PlotJuggler/"
echo ""
echo "TO RUN PlotJuggler after installation:"
echo ""
echo "./PlotJuggler"
echo ""
echo "@author Andrew Hundt <ATHundt@gmail.com>"
echo ""


if [ ! -d ~/src ]
then
    mkdir -p ~/src
fi

sudo apt-get -y install qtbase5-dev libqt5svg5-dev


if [ ! -f ~/src/PlotJuggler ]
then
    cd ~/src
    git clone https://github.com/facontidavide/PlotJuggler.git
    cd PlotJuggler
    git pull
fi



if [ ! -f ~/src/PlotJuggler/build ]
then
    cd ~/src/PlotJuggler
    mkdir build
fi

cd ~/src/PlotJuggler/build
cmake ..
make
sudo make install

cd $DIR

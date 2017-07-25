#!/bin/bash

# source: https://gist.github.com/phatblat/1713458
# Save script's current directory
DIR=$(pwd)

set -e
set -u
set -x

echo "############################"
echo "# V-REP Robot Simulator    #"
echo "############################"
echo ""
echo "http://www.coppeliarobotics.com/downloads.html"
echo ""
echo "TO RUN V-REP after installation:"
echo ""
echo "cd ~/src/V-REP_PRO_EDU_V3_4_0_Linux"
echo "sh vrep.sh"
echo ""
echo "@author Andrew Hundt <ATHundt@gmail.com>"
echo ""

VREP_VERSION=V3_4_0

if [ ! -d ~/src ]
then
    mkdir -p ~/src
fi

if [ ! -f ~/src/V-REP_PRO_EDU_V3_4_0_Linux.tar.gz ]
then
    cd ~/src
    wget http://coppeliarobotics.com/files/V-REP_PRO_EDU_V3_4_0_Linux.tar.gz
fi

if [ ! -d ~/src/V-REP_PRO_EDU_V3_4_0_Linux ]
then
    cd ~/src
    tar -xvzf ~/src/V-REP_PRO_EDU_V3_4_0_Linux.tar.gz
fi


cd $DIR

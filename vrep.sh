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

# VREP_VERSION=V3_4_0
# V-REP_PRO_EDU_V3_4_0_Linux
VREP_FILE="V-REP_PRO_EDU_V3_6_1_Ubuntu18_04"

. /etc/lsb-release # get ubuntu version number

if [ "$DISTRIB_RELEASE" = "16.04" ]
then
    # http://coppeliarobotics.com/files/V-REP_PRO_EDU_V3_6_1_Ubuntu16_04.tar.xz
    VREP_FILE="V-REP_PRO_EDU_V3_6_2_Ubuntu16_04"
fi

if [ "$DISTRIB_RELEASE" = "18.04" ]
then
    # http://coppeliarobotics.com/files/V-REP_PRO_EDU_V3_6_1_Ubuntu16_04.tar.xz
    VREP_FILE="V-REP_PRO_EDU_V3_6_2_Ubuntu18_04"
fi
# V-REP_PRO_EDU_V3_4_0_Linux

mkdir -p ~/src
FILE_PATH=~/src/${VREP_FILE}.tar.xz

if [ ! -f ${FILE_PATH} ]
then
    echo "downloading"
    cd ~/src
    # wget http://coppeliarobotics.com/files/V-REP_PRO_EDU_V3_4_0_Linux.tar.gz
    wget http://coppeliarobotics.com/files/${VREP_FILE}.tar.xz
fi

if [ ! -d ~/src/${VREP_FILE} ]
then
    cd ~/src
    tar -xvf $FILE_PATH
    # tar -xvzf $FILE_PATH
fi


cd $DIR


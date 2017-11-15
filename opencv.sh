#!/bin/bash
# source: https://gist.github.com/phatblat/1713458
# Save script's current directory
DIR=$(pwd)

set -e
set -u
set -x

echo "################################"
echo "# OpenCV 2 or 3 from ppa/source"
echo "################################"
echo "#"
echo "# Install opencv from an ubuntu ppa by default,"
echo "# otherwise install from source"
echo "#"
echo "# github.com/opencv/opencv"
echo "# github.com/opencv/opencv_contrib"
echo "#"
echo "# WARNING: IF ROS OR OTHER OPENCV BINARIES, or BINARIES THAT DEPEND ON ARE ALREADY INSTALLED"
echo "# THERE MAY BE INVISIBLE CONFLICTS AND CRASHES IN THE SOFTWARE YOU RUN. IF YOU INSTALL OPENCV FROM"
echo "# SOURCE ALL PACKAGES THAT USE OPENCV SHOULD ALSO BE COMPILED FROM SOURCE TO AVOID DIFFICULT TO"
echo "# DIAGNOSE CRASHES!!!"
echo "#"
echo "# TO CHECK WITH ROS KINETIC RUN:"
echo "# dpkg -L ros-kinetic-opencv3"
echo "#"
echo "# To check if the ubuntu ppa libopencv-nonfree-dev installed by this script is present run:"
echo "#"
echo "# dpkg -L libopencv-nonfree-dev"
echo "# dpkg -L libopencv-dev"

# TODO(ahundt) finish 2.x & 3.x compilation script!
#branch="3.2.0"  # install opencv 3.x from source
# branch="2.4.13.2" # install opencv 2.x from source
branch="ppa" # install from nonsecure ppa (default)

sudo apt-get install -y build-essential
sudo apt-get install -y cmake git libgtk2.0-dev pkg-config libavcodec-dev libavformat-dev libswscale-dev
sudo apt-get install -y python-dev python-numpy libtbb2 libtbb-dev libjpeg-dev libpng-dev libtiff-dev libjasper-dev libdc1394-22-dev




OS=`uname`
case $OS in
  'Linux')
    OS='Linux'
        . /etc/lsb-release # get ubuntu version number

		# only install
		if [ "$DISTRIB_RELEASE" = "14.04" ]; then
		     # TODO(ahundt) add ROS indigo specific opencv3 install
	         # http://wiki.ros.org/opencv3
			 # https://github.com/ros-gbp/opencv3-release
		    if [ -f "/opt/ros/indigo/setup.zsh" ]; then
			    sudo apt-get install python-bloom
			fi


		fi
    ;;
  'FreeBSD')
    OS='FreeBSD'
    alias ls='ls -G'
    ;;
  'WindowsNT')
    OS='Windows'
    ;;
  'Darwin')
    OS='Mac'
    ;;
  'SunOS')
    OS='Solaris'
    ;;
  'AIX') ;;
  *) ;;
esac


if [ "$branch" = "ppa" ]; then

	sudo add-apt-repository --yes ppa:xqms/opencv-nonfree
	sudo apt-get update
	sudo apt-get install libopencv-nonfree-dev
else
	# TODO(ahundt) finish writing compilation from source and test
    # compile from source
	cd ~/src

	if [ ! -d ~/src/opencv ]
	then
	    git clone https://github.com/Itseez/opencv.git
	fi

	cd opencv
	git pull
	git checkout ${branch}


	if [ $branch = "2.4.13.2"]; then
		# more params at: https://github.com/opencv/opencv/blob/2.4.13.2/CMakeLists.txt
		# more params at: https://github.com/Homebrew/homebrew-science/blob/master/opencv.rb
		CMAKE_PARAMS="-DWITH_CUDA=ON -DCMAKE_CXX_FLAGS=-stdlib=libc++ -DCUDA_GENERATION=Kepler -DOPENCV_ENABLE_NONFREE=ON"
	fi

	# install OpenCV Contrib repository with nonfree components
	if [ $branch = "3.2.0"]; then
		# Opencv3 compilation with opencv_contrib
		# TODO(ahundt) not complete!
		cd ~/src/
		if [ ! -d ~/src/opencv_contrib ]
		then
		    git clone https://github.com/Itseez/opencv_contrib.git
		fi

		cd opencv_contrib
		git pull
		git checkout ${branch}

		# TODO(ahundt) set cmake params appropriately for opencv 3
		# more params at: https://github.com/Homebrew/homebrew-science/blob/master/opencv3.rb
		CMAKE_PARAMS="-DWITH_CUDA=ON -DCMAKE_CXX_FLAGS=-stdlib=libc++ -DCUDA_GENERATION=Kepler -DOPENCV_ENABLE_NONFREE=ON"
	fi

	cd ~/src/opencv
	git pull

	mkdir -p build
	cd build
	cmake .. ${CMAKE_PARAMS}
	make -j && sudo make install
fi # end build from source

cd $DIR
# source: https://gist.github.com/phatblat/1713458
# Save script's current directory
DIR=$(pwd)

set -e
set -u
set -x

echo "############################"
echo "# pangolin https://github.com/stevenlovegrove/pangolin"
echo "############################"
echo ""
echo "Pangolin is a lightweight portable rapid development library for managing "
echo "OpenGL display / interaction and abstracting video input."
echo ""


OS=`uname`
case $OS in
  'Linux')
    OS='Linux'
        . /etc/lsb-release # get ubuntu version number

		# only install
		if [ "$DISTRIB_RELEASE" = "14.04" ]; then
			# https://launchpad.net/~mc3man/+archive/ubuntu/trusty-media
			# https://www.ffmpeg.org/download.html#get-sources
			sudo add-apt-repository ppa:mc3man/trusty-media -y
			sudo apt-get update -y
		fi

		sudo apt-get install -y libglew-dev
		sudo apt-get install -y ffmpeg libavcodec-dev libavutil-dev libavformat-dev libswscale-dev
		sudo apt-get install -y libdc1394-22-dev libraw1394-dev
		sudo apt-get install -y libjpeg-dev libpng12-dev libtiff5-dev libopenexr-dev
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
        brew install ffmpeg jpeg tiff png glew
    ;;
  'SunOS')
    OS='Solaris'
    ;;
  'AIX') ;;
  *) ;;
esac

# install https://github.com/stevenlovegrove/pangolin
cd ~/src/
if [ ! -d ~/src/Pangolin ]
then
	git clone git@github.com:stevenlovegrove/Pangolin.git
fi
sudo chmod -R u+rwx ~/src/Pangolin
sudo chmod -R g+rwx ~/src/Pangolin
cd Pangolin
git pull
mkdir -p build
cd build
cmake .. -DCMAKE_INSTALL_PREFIX=/usr/local
cmake --build .
sudo cmake --build . --target install

cd $DIR

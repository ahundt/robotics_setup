# source: https://gist.github.com/phatblat/1713458
# Save script's current directory
DIR=$(pwd)

set -e
set -u
set -x


echo "###############################################"
echo "# Awesome Library https://github.com/ahundt/awesome-stuff"
echo "###############################################"
echo "#"
echo "# A project repo for awesome snippets. "


cd ~/src
if [ ! -d ~/src/flatbuffers ] ; then
	git clone https://github.com/google/flatbuffers.git
fi

cd ~/src/flatbuffers
git pull

mkdir -p ~/src/flatbuffers/build
cd ~/src/flatbuffers/build
cmake ..
sudo make -j install
cd ~/src

cd $DIR
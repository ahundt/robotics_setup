# source: https://gist.github.com/phatblat/1713458
# Save script's current directory
DIR=$(pwd)

set -e
set -u
set -x


echo "###############################################"
echo "# robot-grasp-detection https://github.com/tnikolla/robot-grasp-detection"
echo "###############################################"
echo "#"
echo "# Detecting robot grasping positions with deep neural networks. "
echo "# The model is trained on Cornell Grasping Dataset. "


cd ~/src
if [ ! -d ~/src/robot-grasp-detection ] ; then
	git clone https://github.com/tnikolla/robot-grasp-detection
fi

cd ~/src/robot-grasp-detection
git pull

# mkdir -p ~/src/flatbuffers/build
# cd ~/src/flatbuffers/build
# cmake ..
# sudo make -j install
# cd ~/src

cd $DIR
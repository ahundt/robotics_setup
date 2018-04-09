# source: https://gist.github.com/phatblat/1713458
# Save script's current directory
DIR=$(pwd)

set -e
set -u
set -x


echo "###############################################"
echo "# Neural Network Grasp https://github.com/KyleAshley/nn_grasp"
echo "###############################################"
echo "#"
echo "# Neural network based robotic grasping in Tensorflow. "
echo "# Similar to https://arxiv.org/pdf/1412.3128.pdf"

cd ~/src
if [ ! -d ~/src/nn_grasp ] ; then
	git clone https://github.com/KyleAshley/nn_grasp.git
fi

cd ~/src/nn_grasp
git pull

./pcl-python.sh
pip2 install imutils --user --upgrade

cd $DIR
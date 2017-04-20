# source: https://gist.github.com/phatblat/1713458
# Save script's current directory
DIR=$(pwd)

set -e
set -u
set -x


echo "############################"
echo "# TensorLayer - https://github.com/zsdonghao/tensorlayer"
echo "############################"
echo ""
echo "Deep Learning library for Python. Convnets, recurrent neural networks, and more. Runs on TensorFlow."
echo ""
echo "MANUAL STEPS REQUIRED - FIRST FOLLOW tensorflow.sh instructions"


# install https://github.com/fchollet/keras
cd ~/src/
if [ ! -d ~/src/tensorlayer ]
then
	git clone git@github.com:zsdonghao/tensorlayer.git
fi

cd tensorlayer
git pull
sudo python setup.py install

cd $DIR

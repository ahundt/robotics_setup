# source: https://gist.github.com/phatblat/1713458
# Save script's current directory
DIR=$(pwd)

set -e
set -u
set -x


echo "############################"
echo "# Keras - keras.io"
echo "############################"
echo ""
echo "Deep Learning library for Python. Convnets, recurrent neural networks, and more. Runs on Theano or TensorFlow."
echo ""
echo "MANUAL STEPS REQUIRED - FIRST FOLLOW tensorflow.sh instructions"


# install https://github.com/fchollet/keras
cd ~/src/
if [ ! -d ~/src/keras ]
then
	git clone https://github.com/fchollet/keras.git
fi

cd keras
git pull
# sudo python setup.py install
python setup.py install --user

cd ~/src/
if [ ! -d ~/src/keras-contrib ]
then
	git clone https://github.com/farizrahman4u/keras-contrib.git
fi

cd keras-contrib
git pull
#sudo python setup.py install
python setup.py install --user

cd $DIR

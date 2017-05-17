# source: https://gist.github.com/phatblat/1713458
# Save script's current directory
DIR=$(pwd)

set -e
set -u
set -x


echo "############################"
echo "# Sonnet - keras.io"
echo "############################"
echo ""
echo "Deep Learning library for Python. Convnets, recurrent neural networks, and more. Runs on Theano or TensorFlow."
echo ""
echo "MANUAL STEPS REQUIRED - FIRST FOLLOW tensorflow.sh instructions"


# install https://github.com/fchollet/keras
cd ~/src/
if [ ! -d ~/src/sonnet ]
then
	git clone --recursive https://github.com/deepmind/sonnet.git
fi

cd sonnet
git pull

cd tensorflow
./configure
cd ../

mkdir /tmp/sonnet
bazel build --config=opt :install
./bazel-bin/install /tmp/sonnet

if [! -z `pip show sonnet`]
then
  echo "Uninstall sonnet if it was already installed"
  sudo pip uninstall -y sonnet
fi
sudo pip install /tmp/sonnet/*.whl

sudo python setup.py install
# python setup.py install --user

cd ~/src/
if [ ! -d ~/src/keras-contrib ]
then
	git clone https://github.com/farizrahman4u/keras-contrib.git
fi

cd keras-contrib
git pull
python setup.py install
# python setup.py install --user

cd $DIR

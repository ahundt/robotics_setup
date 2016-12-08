# source: https://gist.github.com/phatblat/1713458
# Save script's current directory
DIR=$(pwd)

set -e
set -u
set -x


echo "############################"
echo "# ImageFlow https://github.com/HamedMP/ImageFlow"
echo "############################"
echo ""
echo "Deep Learning library for Python. Convnets, recurrent neural networks, and more. Runs on Theano or TensorFlow."
echo ""
echo "MANUAL STEPS REQUIRED - FIRST FOLLOW tensorflow.sh instructions"


# install https://github.com/HamedMP/ImageFlow
cd ~/src/
if [ ! -d ~/src/ImageFlow ]
then
	git clone git@github.com:HamedMP/ImageFlow.git
fi

cd ImageFlow
git pull
sudo python setup.py install




echo "############################"
echo "# Tensorpack https://github.com/ppwwyyxx/tensorpack"
echo "############################"
echo "To enable python code to support import tensorpack:"
echo "export PYTHONPATH=$PYTHONPATH:`readlink -f path/to/tensorpack`"


# install https://github.com/ppwwyyxx/tensorpack
cd ~/src/
if [ ! -d ~/src/tensorpack ]
then
	git clone git@github.com:ppwwyyxx/tensorpack.git
fi

cd tensorpack
git pull




echo "############################"
echo "# keras-rl https://github.com/matthiasplappert/keras-rl"
echo "############################"
echo ""
echo ""


# install https://github.com/ppwwyyxx/tensorpack
cd ~/src/
if [ ! -d ~/src/keras-rl ]
then
	git clone git@github.com:matthiasplappert/keras-rl.git
fi

cd keras-rl
git pull
sudo python setup.py install



echo "############################"
echo "# tflearn"
echo "############################"
echo ""
echo ""


# install https://github.com/tflearn/tflearn
cd ~/src/
if [ ! -d ~/src/tflearn ]
then
	git clone git@github.com:tflearn/tflearn.git
fi

cd tflearn
git pull
sudo python setup.py install






echo "############################"
echo "# https://github.com/Itsukara/async_deep_reinforce"
echo "############################"
echo ""
echo ""


# install https://github.com/Itsukara/async_deep_reinforce
cd ~/src/
if [ ! -d ~/src/async_deep_reinforce ]
then
	git clone git@github.com:Itsukara/async_deep_reinforce.git
fi

cd async_deep_reinforce
git pull





echo "############################"
echo "# https://github.com/yuyu2172/async-rl"
echo "############################"
echo ""
echo "fork of https://github.com/muupan/async-rl"


# install git@github.com:muupan/async-rl.git
cd ~/src/
if [ ! -d ~/src/async-rl ]
then
	git clone git@github.com:muupan/async-rl.git
fi

cd async-rl
git pull
sudo python setup.py install







echo "############################"
echo "# policy sketches"
echo "############################"
echo ""
echo "https://github.com/jacobandreas/psketch"


# install git@github.com:jacobandreas/psketch.git
cd ~/src/
if [ ! -d ~/src/psketch ]
then
	git clone git@github.com:jacobandreas/psketch.git
fi

cd psketch
git pull






cd $DIR

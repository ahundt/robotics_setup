# source: https://gist.github.com/phatblat/1713458
# Save script's current directory
DIR=$(pwd)

set -e
set -u
set -x


echo "############################"
echo "# OpenAI gym, universe, and universe-starter-agent"
echo "############################"
echo ""
echo "OpenAI  https://github.com/openai."

sudo apt update
pip install numpy
sudo apt install -y golang libjpeg-turbo8-dev make
sudo apt install -y python-numpy python-dev cmake zlib1g-dev libjpeg-dev xvfb libav-tools xorg-dev python-opengl libboost-all-dev libsdl2-dev swig

cd ~/src
mkdir -p openai

# install https://github.com/openai/gym
cd ~/src/openai
if [ ! -d ~/src/openai/gym ]
then
	git clone git@github.com:openai/gym.git
fi

cd gym
git pull
pip install -e .

# install https://github.com/openai/universe
cd ~/src/openai
if [ ! -d ~/src/openai/universe ]
then
	git clone git@github.com:openai/universe.git
fi

cd universe
git pull
pip install -e .


# install https://github.com/openai/universe-starter-agent.git
cd ~/src/openai
if [ ! -d ~/src/openai/universe-starter-agent ]
then
	git clone git@github.com:openai/universe-starter-agent.git
fi

cd universe-starter-agent
git pull

cd $DIR

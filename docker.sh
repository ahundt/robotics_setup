
set -e
set -x
set -u

# DOCKER
# Manual Steps:
# https://askubuntu.com/questions/477551/how-can-i-use-docker-without-sudo
# add the current user to the docker group
#    sudo gpasswd -a ${USER} docker
#    sudo service docker restart


if [ -x "$(command -v docker)" ] ; then
    echo "docker seems to already be installed, so we will just run the update steps, if there is a problem run steps manually to avoid cluttering your apt repositories"

    sudo apt-get update
    sudo apt-get install docker-ce
    exit 0
fi

sudo apt-get install \
    apt-transport-https \
    ca-certificates \
    curl \
    software-properties-common

curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add -

sudo apt-key fingerprint 0EBFCD88

sudo add-apt-repository \
   "deb [arch=amd64] https://download.docker.com/linux/ubuntu \
   $(lsb_release -cs) \
   stable"


sudo apt-get update
sudo apt-get install docker-ce

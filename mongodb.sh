# source: https://gist.github.com/phatblat/1713458
# Save script's current directory
DIR=$(pwd)

set -e
set -u
set -x


echo "############################"
echo "# MongoDB persistent docker image"
echo "############################"
echo "#"
echo "# https://github.com/bitnami/bitnami-docker-mongodb"


username=mluser
password=SET_PASSWORD_BEFORE_RUNNING_THIS


https://github.com/bitnami/bitnami-docker-mongodb
mkdir -p $HOME/datasets/ml_models_sacred_mongodb/persistence

docker run --name mongodb \
  -v $HOME/datasets/ml_models_sacred_mongodb/persistence:/bitnami \
  -e MONGODB_USERNAME=$username -e MONGODB_PASSWORD=$password \
  -e MONGODB_DATABASE=sacred bitnami/mongodb:latest

# Manual steps:
# echo "# https://docs.mongodb.com/manual/tutorial/install-mongodb-on-ubuntu/"
# echo "# https://www.digitalocean.com/community/tutorials/how-to-install-mongodb-on-ubuntu-16-04"
# echo "# https://www.digitalocean.com/community/tutorials/how-to-install-and-secure-mongodb-on-ubuntu-16-04"

# sudo apt-key adv --keyserver hkp://keyserver.ubuntu.com:80 --recv 0C49F3730359A14518585931BC711F9BA15703C6

# . /etc/lsb-release # get ubuntu version number

# if [ "$DISTRIB_RELEASE" = "16.04" ]; then
#     echo "deb [ arch=amd64,arm64 ] http://repo.mongodb.org/apt/ubuntu xenial/mongodb-org/3.4 multiverse" | sudo tee /etc/apt/sources.list.d/mongodb-org-3.4.list
# fi

# sudo apt-get update
# sudo apt-get install -y mongodb-org
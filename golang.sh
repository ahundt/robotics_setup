# source: https://gist.github.com/phatblat/1713458
# Save script's current directory
DIR=$(pwd)

set -e
set -u
set -x

echo "############################"
echo "# Google Go"
echo "############################"
echo "#"
echo "# golang.com"

sudo apt install -y golang

sudo mkdir -m 0700 -p /usr/local/go
mkdir -m 7700 -p $HOME/go
# export GOROOT=/usr/bin/go
export GOPATH=$HOME/go
#export PATH=$PATH:$GOROOT/bin:$GOPATH/bin
export PATH=$PATH:$GOPATH/bin

cd $DIR

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

sudo apt-get install -y golang

sudo mkdir -m 0700 -p /usr/local/go
mkdir -m 7700 -p $HOME/go
export GOPATH=$HOME/go
export PATH=$PATH:$GOPATH/bin

# location of goroot:
# go env GOROOT

cd $DIR

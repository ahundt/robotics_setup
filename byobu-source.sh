# source: https://gist.github.com/phatblat/1713458
# Save script's current directory
DIR=$(pwd)

set -e
set -u
set -x

echo "#######################################################"
echo "# byobu shell session manager installation from source"
echo "#######################################################"
echo "YOU PROBABLY REALLY WANT TO RUN commandline_utils.sh"
echo ""
echo "http://byobu.org"
echo "Based on instructions in:"
echo "http://bazaar.launchpad.net/~kirkland/byobu/trunk/view/head:/README"

mkdir -p ~/src
cd ~/src

if [ ! -d ~/src/byobu ] ; then
  git clone git://github.com/dustinkirkland/byobu.git byobu
fi

cd byobu
git pull

./configure --prefix="$HOME/byobu"
# original configure command:
#./configure --prefix="$HOME/byobu"
make install

cd $DIR
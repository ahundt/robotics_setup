# source: https://gist.github.com/phatblat/1713458
# Save script's current directory
DIR=$(pwd)

set -e
set -u
set -x

echo "#########################################################################"
echo "# byobu shell session manager http://byobu.org installation from source"
echo "#########################################################################"
echo "# ON UBUNTU YOU PROBABLY REALLY WANT TO RUN commandline_utils.sh"
echo "#"
echo "# byobu makes it so you can access multiple remote shell sessions"
echo "# via a single remote ssh session, and keep things from being terminated"
echo "# if you get disconnected accidentally"
echo ""
echo "Based on instructions in:"
echo "    http://bazaar.launchpad.net/~kirkland/byobu/trunk/view/head:/README"
echo "Installation bug on MARCC:"
echo "    https://bugs.launchpad.net/byobu/+bug/1673232"

mkdir -p ~/src
cd ~/src

if [ ! -d ~/src/byobu ] ; then
  git clone git://github.com/dustinkirkland/byobu.git byobu
fi

cd byobu
git pull
autoconf
./configure --prefix="$HOME/byobu"
# original configure command:
#./configure --prefix="$HOME/byobu"
make install

cd $DIR
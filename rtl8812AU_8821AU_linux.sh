
# source: https://gist.github.com/phatblat/1713458
# Save script's current directory
DIR=$(pwd)

set -e
set -u
set -x

echo "############################"
echo "# USB wireless adapter driver "
echo "# TP-Link Archer T4U dual band 802.11 ac"
echo "# http://askubuntu.com/questions/533408/trying-to-install-wireless-archer-t4u-driver"
echo "############################"

cd ~/src

if [ ! -d `pwd`/rtl8812AU_8821AU_linux ] ; then
  git clone https://github.com/abperiasamy/rtl8812AU_8821AU_linux.git
fi

cd rtl8812AU_8821AU_linux/
git pull
make
sudo make install
sudo modprobe 8812au

cd $DIR

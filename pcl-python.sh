# source: https://gist.github.com/phatblat/1713458
# Save script's current directory
DIR=$(pwd)

set -e
set -u
set -x


echo "###############################################"
echo "# python-pcl https://github.com/strawlab/python-pcl/"
echo "###############################################"
echo "#"
echo "# Point Cloud Library Python API. "
echo "# "
echo "# WARNING: assumes pcl is already installed"


cd ~/src
if [ ! -d ~/src/python-pcl ] ; then
	git clone https://github.com/strawlab/python-pcl.git
fi

cd ~/src/python-pcl
git pull

python2 setup.py build_ext -i --user
python2 setup.py install --user

# sh build.sh
# pip2 install --upgrade --user pip cython numpy
# python2 -m pip install . build_ext -i --upgrade --user
# python2 -m pip install . --upgrade --user

cd ~/src

cd $DIR
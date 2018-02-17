# source: https://gist.github.com/phatblat/1713458
# Save script's current directory
DIR=$(pwd)

set -e
set -u
set -x


echo "###############################################"
echo "# GPy and GPyOpt "
echo "###############################################"
echo "#"
echo "# Gaussian process optimization using GPy. "
echo "# Performs global optimization with different"
echo "# acquisition functions. Among other functionalities,"
echo "# it is possible to use GPyOpt to optimize physical "
echo "# experiments (sequentially or in batches) and tune "
echo "# the parameters of Machine Learning algorithms."
echo "#"
echo "# https://github.com/SheffieldML/GPyOpt "
echo "# https://github.com/SheffieldML/GPy "
echo "#"
echo "# WARNING: local install on devel branch until the following issue fix is released:"
echo "#"
echo "#     https://github.com/SheffieldML/GPyOpt/issues/85"

# pip2 install gpy gpyopt --user --upgrade
# pip3 install gpy gpyopt --user --upgrade

# GPy
cd ~/src
if [ ! -d ~/src/gpy ] ; then
	git clone https://github.com/SheffieldML/GPy gpy
fi
cd gpy
git pull
pip install -e . --user --upgrade
pip2 install -e . --user --upgrade

# GPyOpt
cd ~/src
if [ ! -d ~/src/gpyopt ] ; then
	git clone https://github.com/SheffieldML/GPyOpt gpyopt -b devel
fi
cd gpyopt
git pull

# pip could be python3, disabled until
# https://github.com/SheffieldML/GPyOpt/issues/163 is resolved
# pip install -e . --user --upgrade
pip2 install -e . --user --upgrade


cd $DIR
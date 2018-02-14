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

pip2 install gpy gpyopt --user --upgrade
# pip3 install gpy gpyopt --user --upgrade


cd $DIR
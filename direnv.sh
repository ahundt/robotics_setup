
DIR=$(pwd)

set -e
set -u
set -x

echo "###############################################"
echo "# DirEnv https://github.com/direnv/direnv"
echo "###############################################"
echo "#"
echo "# - directory based environment"
echo "# - command line variable configuration"
echo "#"
echo "# For when you need to set some command line variables"
echo "# depending on your project directory"
echo "# "

sudo apt-get install -y direnv

cd $DIR






#!/bin/bash


# source: https://gist.github.com/phatblat/1713458
# Save script's current directory
DIR=$(pwd)

# /bin/bash
set -e
set -u
set -x



echo "############################"
echo "# Google OpenImages Dataset"
echo "############################"
echo " https://github.com/openimages/dataset.git"


mkdir -p ~/datasets
cd ~/datasets


cd ~/src/
if [ ! -d ~/src/openimages ]
then
	git clone https://github.com/openimages/dataset.git
fi

cd openimages
git pull

cd $DIR

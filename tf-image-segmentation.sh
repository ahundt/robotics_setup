
DIR=$(pwd)

set -e
set -u
set -x

echo "###############################################"
echo "# Tensorflow image segmentation python library"
echo "###############################################"
echo "# github.com/jhollowayj/tensorflow_slurm_manager"

branch=ahundt-keras

cd ~/src/
if [ ! -d ~/src/tf-image-segmentation ]
then
	 git clone https://github.com/ahundt/tf-image-segmentation.git -b $branch
fi

cd tf-image-segmentation
git pull
# TODO(ahundt): install or add to path config

cd $DIR
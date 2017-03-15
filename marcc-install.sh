# source: https://gist.github.com/phatblat/1713458
# Save script's current directory
DIR=$(pwd)

set -e
set -u
set -x


echo "######################################################"
echo "# MARCC, a SLURM cluster, robotics_setup installation"
echo "######################################################"
echo "# About MARCC:"
echo "#     https://www.marcc.jhu.edu/"
echo "#"
echo "# About the SLURM workload manager for clusters:"
echo "#     https://slurm.schedmd.com/"
echo "#"
echo "# also see marcc-config.sh"
echo "#"
echo "# MARCC tutorials:"
echo "# http://www.marcc.jhu.edu/training/intro-sessions/"
echo "# Click on `Introduction to MARCC` and `Basic Linux` for pdfs"
echo "#"
echo "# Create your own modules:"
echo "# https://www.marcc.jhu.edu/getting-started/local-python-packages/"
echo "#"
echo "# to see list of possible modules run:"
echo "# module avail"


echo "###############################################"
echo "# SLURM Cluster Manager Tensorflow Setup"
echo "###############################################"
echo "# Reference materials:"
echo "# http://killianlevacher.github.io/blog/posts/post-2016-07-22/post.html"
echo "# https://github.com/taylorpaul/ShowAndTell-SLURM"
echo "# http://stackoverflow.com/questions/34826736/running-tensorflow-on-a-slurm-cluster"
echo "# https://github.com/jakeret/tf_unet"
echo "# https://github.com/Ottunger/tensorslurm"
echo "# http://slurm.ttic.edu/"
echo "# "
echo "# Example install script:"
echo "# https://gist.github.com/taylorpaul/3e4e405ffad1be8355bf742fa24b41f0"
echo "# "
echo "# Install script companion repository:"
echo "# https://github.com/taylorpaul/ShowAndTell-SLURM"
echo "# "
echo "# TensorBoard:"
echo "# https://gist.github.com/taylorpaul/250ee3ed2524e8c28ee7c58ed656a5b9"
echo "# "
echo "# Nice SLURM python class:"
echo "# https://github.com/jhollowayj/tensorflow_slurm_manager"

# module load git/2.6.4 boost/1.60.0 cmake/3.5.0 cuda/8.0 cudnn/5.0 python/2.7.12 tensorflow/r1.0 parallel_studio_xe_2015/17.0.1 intel-tbb-oss/intel64/43_20150424oss intel-mpi/2017.1.132
# module load gcc slurm git zsh tmux boost cmake cuda/8.0 cudnn/5.0 python tensorflow parallel_studio_xe_2015 intel-mpi readline ruby
source $DIR/marcc-config.sh

# save the set of modules to enable reloading in the future
module save robotics_setup_modules

mkdir -p $HOME/src
mkdir -p $HOME/bin
mkdir -p $HOME/lib

cd ~/src/
if [ ! -d ~/src/robotics_setup ]; then
	git clone --recursive https://github.com/ahundt/robotics_setup.git
fi

cd robotics_setup

./autoenv.sh
./tensorflow_slurm_manager.sh
./tensorpack.sh
./tensorlayer.sh
./tf-image-segmentation.sh
./keras.sh
#./textmate.sh

mkdir -p $HOME/scratch/datasets

if [ ! -d ~/datasets ]; then
ln -s $HOME/scratch/datasets $HOME/datasets
fi

./zsh.sh

# byobu terminal session manager: http://byobu.co/about.html
#https://launchpad.net/byobu/trunk/5.115/+download/byobu_5.115.orig.tar.gz





cd $DIR
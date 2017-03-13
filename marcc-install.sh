# source: https://gist.github.com/phatblat/1713458
# Save script's current directory
DIR=$(pwd)

set -e
set -u
set -x


echo "###############################################"
echo "# MARCC robotics_setup installation (a SLURM cluster)"
echo "###############################################"
echo "# also see slurm-tensorflow.sh, marcc-config.sh"
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

#module load git/2.6.4 boost/1.60.0 cmake/3.5.0 cuda/8.0 cudnn/5.0 python/2.7.12 tensorflow/r1.0 parallel_studio_xe_2015/17.0.1 intel-tbb-oss/intel64/43_20150424oss intel-mpi/2017.1.132
module load git zsh tmux boost cmake cuda/8.0 cudnn/5.0 python tensorflow parallel_studio_xe_2015 intel-tbb-oss intel-mpi readline glog ruby

# save the set of modules to enable reloading in the future
save robotics_setup_modules

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
ln -s $HOME/scratch/datasets $HOME/datasets

./zsh.sh

# byobu terminal session manager: http://byobu.co/about.html
#https://launchpad.net/byobu/trunk/5.115/+download/byobu_5.115.orig.tar.gz

cd $DIR
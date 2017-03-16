
DIR=$(pwd)

set -e
set -u
set -x

echo "###############################################"
echo "# Tensorflow SLURM manager python class"
echo "###############################################"
echo "# github.com/jhollowayj/tensorflow_slurm_manager"

cd ~/src/
if [ ! -d ~/src/tensorflow_slurm_manager ]
then
	 git clone https://github.com/jhollowayj/tensorflow_slurm_manager.git
fi

# TODO(ahundt): install or add to path config

cd $DIR
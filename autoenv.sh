
DIR=$(pwd)

set -e
set -u
set -x

echo "###############################################"
echo "# Tensorflow SLURM manager python class"
echo "###############################################"
echo "#"
echo "# github.com/jhollowayj/tensorflow_slurm_manager"
echo "#"
echo "# MANUAL STEPS: either install robotics_setup/.zshrc via zshrc.sh or run:"
echo "# $ echo 'source ~/.autoenv/activate.sh' >> ~/.bashrc""

if [ ! -d ~/.autoenv ]
then
	 git clone https://github.com/kennethreitz/autoenv ~/.autoenv
fi

cd ~/.autoenv
git pull

# TODO(ahundt): install or add to path config

cd $DIR








echo "###############################################"
echo "# MARCC Module loading (a SLURM cluster)"
echo "###############################################"
echo "# Config Provided by:"
echo "#     github.com/ahundt/robotics_setup"
echo "#     also see marcc-install.sh"
echo "#"
echo "# About MARCC:"
echo "#     https://www.marcc.jhu.edu/"
echo "#"
echo "# About the SLURM workload manager for clusters:"
echo "#     https://slurm.schedmd.com/"
echo "#"
echo "# MARCC tutorials:"
echo "#     http://www.marcc.jhu.edu/training/intro-sessions/"
echo "#     Click on Introduction to MARCC and Basic Linux for pdf files"
echo "#"
echo "# Create your own modules:"
echo "#     https://www.marcc.jhu.edu/getting-started/local-python-packages/"
echo "#"
echo "# JHU MARCC help email address:"
echo "#     marcc-help@marcc.jhu.edu"
echo "#"
echo "# to see list of possible modules run:"
echo "#     module avail"
echo "#"
echo "# Run on a GPU:"
echo "#     https://github.com/rdipietro/miccai-2016-surgical-activity-rec/tree/master/scripts"
echo "#"
echo "# How to create a xonsh python shell http://xon.sh"
echo "# to import tensorflow starting in bash or zsh:"
echo "#"
echo "# ± /cm/shared/apps/python/3.6.6/bin/pip3 install xonsh --user --upgrade"
echo "# ± export PYTHONPATH=\"$HOME/.local/lib/python3.6/site-packages/:/cm/shared/apps/tensorflow/cuda-8.0/r1.0/lib/python3.6/site-packages/:$PYTHONPATH\""
echo "# ± xonsh"
echo "# $ import sys"
echo "# $ sys.path.insert(0,'$HOME/.local/lib/python3.6/site-packages/')"
echo "# $ sys.path.insert(0,'/cm/shared/apps/tensorflow/cuda-8.0/r1.0/lib/python3.6/site-packages/')"
echo "# $ import tensorflow as tf"
echo "#"
echo "# LOADING MODULES:"
echo "#"
echo "# module load zsh/5.3.1 gcc/4.9.2 slurm sed git tmux byobu cmake/3.8.2 autoconf/gcc automake/gcc boost cuda/8.0 cudnn/5.1 python/3.6.6 parallel_studio_xe_2015 intel-mpi readline ruby/2.4.1 ffmpeg tensorflow/cuda-8.0/r1.0"
echo "#"

module load zsh/5.3.1 gcc/4.9.2 slurm sed git tmux byobu cmake/3.8.2 autoconf/gcc automake/gcc boost cuda/8.0 cudnn/5.1 python/3.6.6 parallel_studio_xe_2015 intel-mpi readline ruby/2.4.1 ffmpeg tensorflow/cuda-8.0/r1.0
# see marcc-install.sh for the list of saved modules
# module restore robotics_setup_modules

# other modules worth knowing about that are currently disabled:
# python/2.7.12

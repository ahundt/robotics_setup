


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

module load zsh/5.0.7 gcc slurm sed git tmux byobu cmake/3.8.2 autoconf/gcc automake/gcc boost cuda/8.0 cudnn/5.1 python/3.6.6 parallel_studio_xe_2015 intel-mpi readline ruby/2.4.1
# see marcc-install.sh for the list of saved modules
# module restore robotics_setup_modules
# python/2.7.12 tensorflow/cuda-8.0/r1.0
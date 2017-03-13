# source: https://gist.github.com/phatblat/1713458
# Save script's current directory
DIR=$(pwd)

set -e
set -u
set -x

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


cd $DIR
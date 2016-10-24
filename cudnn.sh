# source: https://gist.github.com/phatblat/1713458
# Save script's current directory
DIR=$(pwd)

set -e
set -u
set -x

echo "############################"
echo "# CUDNN"
echo "############################"

echo "ASSUMES THE FOLLOWING ARE DOWNLOADED FROM THE NVIDIA CUDA WEBSITE:"
echo "~/Downloads/cudnn-8.0-linux-x64-v5.1.tgz"

# currently just in the cuda install script
sh cuda.sh

# Manual setup:

# cd ~/Downloads

# sudo tar -xzvf cudnn-8.0-linux-x64-v5.1.tgz
# sudo cp cuda/include/cudnn.h /usr/local/cuda/include
# sudo cp cuda/lib64/libcudnn* /usr/local/cuda/lib64
# sudo chmod a+r /usr/local/cuda/include/cudnn.h /usr/local/cuda/lib64/libcudnn*


cd $DIR

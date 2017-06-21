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

# Manual setup:

cd ~/Downloads

sudo tar -xzvf cudnn-8.0-linux-x64-v6.0.tgz
sudo cp cuda/include/cudnn.h /usr/local/cuda/include
sudo cp cuda/lib64/libcudnn* /usr/local/cuda/lib64
sudo chmod a+r /usr/local/cuda/include/cudnn.h /usr/local/cuda/lib64/libcudnn*



# commented outdated file path
# if [ ! -f ~/Downloads/cudnn-8.0-linux-x64-v5.0-ga-tgz ]
# then
#   curl https://developer.nvidia.com/rdp/assets/cudnn-8.0-linux-x64-v5.0-ga-tgz --output ~/Downloads/cudnn-8.0-linux-x64-v5.0-ga.tgz
# fi



# sudo dpkg -i ~/Downloads/libcudnn5_5.1.5-1+cuda8.0_amd64.deb
# sudo dpkg -i ~/Downloads/libcudnn5-dev_5.1.5-1+cuda8.0_amd64.deb
# sudo dpkg -i ~/Downloads/libcudnn5-doc_5.1.5-1+cuda8.0_amd64.deb
# sudo apt update -y
# sudo apt install -y libcudnn5 libcudnn5-dev libcudnn5-doc

#https://stackoverflow.com/questions/16182620/commenting-out-lines-with-matching-string
#https://github.com/BVLC/caffe/wiki/GeForce-GTX-1080,---CUDA-8.0,---Ubuntu-16.04,---Caffe
 #sed -i .backup "/#error -- unsupported GNU version!/s/^/\/\//g" /usr/local/cuda/include/host_config.h


cd $DIR

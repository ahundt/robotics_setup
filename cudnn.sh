# source: https://gist.github.com/phatblat/1713458
# Save script's current directory
DIR=$(pwd)

set -e
set -u
set -x

echo "############################"
echo "# CUDNN - see cuda.sh for instructions"
echo "############################"
echo "# ASSUMES THE FOLLOWING ARE DOWNLOADED FROM THE NVIDIA CUDA WEBSITE:"
echo "# ~/Downloads/cudnn-8.0-linux-x64-v6.0.tgz"
echo "# https://developer.nvidia.com/cudnn"

# currently just in the cuda install script

# Manual setup:
cd ~/Downloads
if [ ! -f ~/Downloads/nccl-repo-ubuntu1604-2.1.4-ga-cuda9.1_1-1_amd64.deb ] ; then
    curl https://developer.nvidia.com/compute/machine-learning/cudnn/secure/v7.0.5/prod/9.1_20171129/Ubuntu16_04-x64/libcudnn7-dev_7.0.5.15-1+cuda9.1_amd64 --output libcudnn7-dev_7.0.5.15-1+cuda9.1_amd64.deb
    curl https://developer.nvidia.com/compute/machine-learning/cudnn/secure/v7.0.5/prod/9.1_20171129/Ubuntu16_04-x64/libcudnn7_7.0.5.15-1+cuda9.1_amd64 --output libcudnn7_7.0.5.15-1+cuda9.1_amd64.deb
    curl https://developer.nvidia.com/compute/machine-learning/cudnn/secure/v7.0.5/prod/9.1_20171129/cudnn-9.1-linux-x64-v7 --output cudnn-9.1-linux-x64-v7.tgz
fi


sudo dpkg -i ~/Downloads/libcudnn7-dev_7.0.5.15-1+cuda9.1_amd64.deb
sudo apt-get install -y cudnn
# sudo tar -xzvf cudnn-9.1-linux-x64-v7.0.tgz
# sudo cp cuda/include/cudnn.h /usr/local/cuda/include
# sudo cp cuda/lib64/libcudnn* /usr/local/cuda/lib64
# sudo chmod a+r /usr/local/cuda/include/cudnn.h /usr/local/cuda/lib64/libcudnn*



# commented outdated file path
# if [ ! -f ~/Downloads/cudnn-8.0-linux-x64-v5.0-ga-tgz ]
# then
#   curl https://developer.nvidia.com/rdp/assets/cudnn-8.0-linux-x64-v5.0-ga-tgz --output ~/Downloads/cudnn-8.0-linux-x64-v5.0-ga.tgz
# fi



# sudo dpkg -i ~/Downloads/libcudnn5_5.1.5-1+cuda8.0_amd64.deb
# sudo dpkg -i ~/Downloads/libcudnn5-dev_5.1.5-1+cuda8.0_amd64.deb
# sudo dpkg -i ~/Downloads/libcudnn5-doc_5.1.5-1+cuda8.0_amd64.deb
# sudo apt-get update -y
# sudo apt-get install -y libcudnn5 libcudnn5-dev libcudnn5-doc

#https://stackoverflow.com/questions/16182620/commenting-out-lines-with-matching-string
#https://github.com/BVLC/caffe/wiki/GeForce-GTX-1080,---CUDA-8.0,---Ubuntu-16.04,---Caffe
 #sed -i .backup "/#error -- unsupported GNU version!/s/^/\/\//g" /usr/local/cuda/include/host_config.h


cd $DIR

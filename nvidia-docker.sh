# source: https://gist.github.com/phatblat/1713458
# Save script's current directory
DIR=$(pwd)

set -e
set -u
set -x


echo "###############################################"
echo "# nvidia-docker https://github.com/NVIDIA/nvidia-docker"
echo "###############################################"
echo "#"
echo "# Note: this installs version 1.0 until https://github.com/NVIDIA/nvidia-docker/issues/11 is resolved. "


# Add the package repositories
curl -s -L https://nvidia.github.io/nvidia-docker/gpgkey | \
  sudo apt-key add -
curl -s -L https://nvidia.github.io/nvidia-docker/ubuntu16.04/amd64/nvidia-docker.list | \
  sudo tee /etc/apt/sources.list.d/nvidia-docker.list
sudo apt-get update

# Install nvidia-docker and reload the Docker daemon configuration
sudo apt-get install -y nvidia-docker
sudo pkill -SIGHUP dockerd

# Test nvidia-smi with the latest official CUDA image
docker run --runtime=nvidia --rm nvidia/cuda nvidia-smi

cd $DIR
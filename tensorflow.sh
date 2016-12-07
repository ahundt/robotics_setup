# source: https://gist.github.com/phatblat/1713458
# Save script's current directory
DIR=$(pwd)

set -e
set -u
set -x


echo "############################"
echo "# TensorFlow with GPU Support"
echo "############################"
echo ""
echo "MANUAL STEPS REQUIRED"
echo "- first run cuda.sh, and ensure cuda and cudnn are on the LD_LIBRARY_PATH"
echo ""
echo ""
echo "Also ensure you've run nvidia.sh and cuda.sh to install those components"
echo "Plus add the following to your .bashrc or .zshcrc:"
echo "export LD_LIBRARY_PATH=\"$LD_LIBRARY_PATH:/usr/local/cuda/lib64:/usr/local/cuda/extras/CUPTI/lib64\""
echo "export CUDA_HOME=/usr/local/cuda"
echo ""
echo "Install Steps From:"
echo "https://alliseesolutions.wordpress.com/2016/09/08/install-gpu-tensorflow-from-sources-w-ubuntu-16-04-and-cuda-8-0-rc/"
echo "Additional possible source:"
echo "https://www.nvidia.com/object/gpu-accelerated-applications-tensorflow-installation.html"

sudo apt update

sudo apt install -y openjdk-8-jdk git python-dev python3-dev python-numpy python3-numpy build-essential python-pip python3-pip python-virtualenv swig python-wheel libcurl3-dev


echo "deb [arch=amd64] http://storage.googleapis.com/bazel-apt stable jdk1.8" | sudo tee /etc/apt/sources.list.d/bazel.list
curl https://storage.googleapis.com/bazel-apt/doc/apt-key.pub.gpg | sudo apt-key add -
sudo apt update
sudo apt install -y bazel
sudo apt upgrade bazel




cd ~/src/
if [ ! -d ~/src/tensorflow ]
then
	git clone https://github.com/tensorflow/tensorflow
fi

cd tensorflow
git pull
git checkout r0.12

echo "MANUAL STEP"
echo "Configuring, please use all defaults, except CUDA 8.0, cudnn 5, and compute capability to 5.1,6.2:"
echo ""
echo ""

./configure

bazel build -c opt --config=cuda //tensorflow/tools/pip_package:build_pip_package
bazel-bin/tensorflow/tools/pip_package/build_pip_package /tmp/tensorflow_pkg
bazel-bin/tensorflow/tools/pip_package/build_pip_package tensorflow-0.12.0rc0-py2-none-any.whl --upgrade

echo "with no spaces after tensorflow hit tab before hitting enter to fill in blanks with the following MANUAL line:"
echo "sudo pip install /tmp/tensorflow_pkg/tensorflow"

echo ""
echo "To test that TensorFlow installed correctly do the following:"
echo ""
echo "$ python # or python3"
echo "$ import tensorflow as tf"
echo "$ sess = tf.InteractiveSession()"
echo "$ sess.close()"

cd $DIR

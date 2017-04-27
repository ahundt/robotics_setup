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
echo "https://www.tensorflow.org/get_started/os_setup#installing_from_sources"
echo "https://alliseesolutions.wordpress.com/2016/09/08/install-gpu-tensorflow-from-sources-w-ubuntu-16-04-and-cuda-8-0-rc/"
echo "Additional possible source:"
echo "https://www.nvidia.com/object/gpu-accelerated-applications-tensorflow-installation.html"
echo "https://github.com/tensorflow/tensorflow/issues/7449#issuecomment-282855210"

sudo apt update

sudo apt install -y openjdk-8-jdk git python-dev python3-dev python-numpy python3-numpy build-essential python-pip python3-pip python-virtualenv swig python-wheel libcurl3-dev libcupti-dev


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
git checkout r1.1

echo "###########################################################################################################"
echo "MANUAL STEPS YOU MAY NEED TO EDIT FOR YOUR SYSTEM"
echo "Configuring, please use all defaults, except CUDA 8.0, cudnn 5, NO OPENCL and for GTX 1080 set compute capability to 5.2,6.1:"
echo ""
echo ""
echo "###########################################################################################################"
export TF_NEED_CUDA=1
export TF_CUDA_VERSION=8.0
export TF_CUDNN_VERSION=5
export CUDA_TOOLKIT_PATH=/usr/local/cuda
export TF_NEED_GCP=1
export TF_NEED_HDFS=1
export TF_NEED_OPENCL=0
export TF_CUDA_COMPUTE_CAPABILITIES="5.2,6.1"

# answer yes to any config questions not covered by the above exports, run the configuration
yes "" | ./configure

# To be compatible with as wide a range of machines as possible, TensorFlow defaults to only using SSE4.1 SIMD instructions on x86 machines. Most modern PCs and Macs support more advanced instructions, so if you're building a binary that you'll only be running on your own machine, you can enable these by using --copt=-march=native in your bazel build command.

bazel build --copt=-march=native -c opt --config=cuda //tensorflow/tools/pip_package:build_pip_package
bazel-bin/tensorflow/tools/pip_package/build_pip_package /tmp/tensorflow_pkg

echo "###########################################################################################################"
echo "MANUAL STEPS with no spaces after tensorflow hit tab before hitting enter to fill in blanks with the following MANUAL line:"
echo "pip install /tmp/tensorflow_pkg/tensorflow # or: pip install /tmp/tensorflow_pkg/tensorflow-*"
echo "###########################################################################################################"
echo ""
echo "To test that TensorFlow installed correctly do the following with the python or python3 command depending on your version"
echo "but only from a directory that doesn't have the tensorflow source in it because those files might be picked up accidentally:'"
echo ""
echo "python -c 'import tensorflow as tf; print(tf.__version__); sess = tf.InteractiveSession(); sess.close();'"

pip install --upgrade /tmp/tensorflow_pkg/tensorflow-*

cd ~/
python -c 'import tensorflow as tf; print(tf.__version__); sess = tf.InteractiveSession(); sess.close();'

cd $DIR

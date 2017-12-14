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
echo ""
echo "Getting a permission denied error? Try this:"
echo "    sudo chmod o+r /usr/local/lib/python2.7/dist-packages/"
echo "Another backup last step until I find a better workaround (you shouldn't use sudo pip):"
echo "    sudo pip install --upgrade /tmp/tensorflow_pkg/tensorflow-*"
echo ""
echo "Can't run? Make sure the right tensorflow package is on your PATH both in your shell and in python's path."

sudo apt-get update

sudo apt-get install -y openjdk-8-jdk git python-dev python3-dev python-numpy python3-numpy build-essential python-pip python3-pip python-virtualenv swig python-wheel libcurl3-dev libcupti-dev

# install the bazel build system
./bazel.sh

cd ~/src/
if [ ! -d ~/src/tensorflow ]
then
	git clone https://github.com/tensorflow/tensorflow
fi

cd ~/src/tensorflow
git fetch --all
git checkout r1.4

echo "###########################################################################################################"
echo "MANUAL STEPS YOU MAY NEED TO EDIT FOR YOUR SYSTEM"
echo "Configuring, please use all defaults, except CUDA 8.0, cudnn 5, NO OPENCL and for GTX 1080 set compute capability to 5.2,6.1:"
echo ""
echo " To determine the compute capability for your gpu see https://developer.nvidia.com/cuda-gpus "
echo "###########################################################################################################"
export TF_NEED_CUDA=1
export TF_CUDA_VERSION=8.0
export TF_CUDNN_VERSION=6
export CUDA_TOOLKIT_PATH=/usr/local/cuda
export TF_NEED_GCP=1
export TF_NEED_HDFS=1
export TF_NEED_OPENCL=0
export TF_CUDA_COMPUTE_CAPABILITIES="5.2,6.1"

# Note python3, python2, pip3 and pip2 are used explicily
# because that ensures tensorflow is installed for both versions
# of python, and there is no accidental install of the same version twice.

# Python2 install, requires pip2
if [ -x "$(command -v pip2)" ] ; then
	echo "python 2 install:"
    export PYTHON_BIN_PATH=`which python2`

	# answer yes to any config questions not covered by the above exports, run the configuration
	yes "" | ./configure

	# To be compatible with as wide a range of machines as possible, TensorFlow defaults to only using SSE4.1 SIMD instructions on x86 machines. Most modern PCs and Macs support more advanced instructions, so if you're building a binary that you'll only be running on your own machine, you can enable these by using --copt=-march=native in your bazel build command.
	bazel build --copt=-march=native -c opt --config=cuda //tensorflow/tools/pip_package:build_pip_package
	bazel-bin/tensorflow/tools/pip_package/build_pip_package /tmp/tensorflow_pkg
	cd ~/
	python2 -m pip install --upgrade --user /tmp/tensorflow_pkg/tensorflow-*p27*
	python2 -c 'import tensorflow as tf; print(tf.__version__); sess = tf.InteractiveSession(); sess.close();'
fi

# Python 3 install, requires pip3
if [ -x "$(command -v pip3)" ] ; then

	echo "python3 install:"
	cd ~/src/tensorflow
	export PYTHON_BIN_PATH=`which python3`

	# answer yes to any config questions not covered by the above exports, run the configuration
	yes "" | ./configure

    bazel build --copt=-march=native -c opt --config=cuda //tensorflow/tools/pip_package:build_pip_package
    bazel-bin/tensorflow/tools/pip_package/build_pip_package /tmp/tensorflow_pkg
	cd ~/
	python3 -m pip install --upgrade --user /tmp/tensorflow_pkg/tensorflow-*p3*
	python3 -c 'import tensorflow as tf; print(tf.__version__); sess = tf.InteractiveSession(); sess.close();'
fi

echo "###########################################################################################################"
echo "MANUAL STEPS with no spaces after tensorflow hit tab before hitting enter to fill in blanks with the following MANUAL line:"
echo "pip install /tmp/tensorflow_pkg/tensorflow # or: pip install /tmp/tensorflow_pkg/tensorflow-*"
echo "###########################################################################################################"
echo ""
echo "To test that TensorFlow installed correctly do the following with the python or python3 command depending on your version"
echo "but only from a directory that doesn't have the tensorflow source in it because those files might be picked up accidentally:'"
echo ""
echo "python2:"
echo "python2 -c 'import tensorflow as tf; print(tf.__version__); sess = tf.InteractiveSession(); sess.close();'"
echo ""
echo "python3:"
echo "python3 -c 'import tensorflow as tf; print(tf.__version__); sess = tf.InteractiveSession(); sess.close();'"
cd $DIR

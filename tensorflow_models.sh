# source: https://gist.github.com/phatblat/1713458
# Save script's current directory
DIR=$(pwd)

set -e
set -u
set -x


echo "#########################################################"
echo "# TensorFlow models with GPU support and object detection"
echo "#########################################################"
echo "# "
echo "# MANUAL STEPS REQUIRED"
echo "# - first install tensorflow, following any manual steps in tensorflow.sh"
echo "# "
echo "# "
echo "# TF 1.7 special steps with CUDA 9.1!"
echo "# see https://github.com/tensorflow/tensorflow/issues/16526"
echo "# "
echo "#"
echo "#"



# Enable python bindings via cython by default
# set to "ON" to build python bindings and "OFF" to disable them
# Note: "ON" generates tons of warnings and the log size might prevent CI from succeeding.
PIP_INSTALL="OFF"
location="tensorflow" # github.com/jrl-umi3218/Tasks # ongoing development happens here
#location="ahundt" # github.com/ahundt/Tasks # I have some patches here
#location="jorisv" # github.com/jorisv/Tasks # outdated original repository location

# modify if using a different branch
branch="master"

# Check if the user specified any command line options
# other than teh default and set the variable appropriately.
while getopts p:l:b: option
do
 case "${option}"
 in
 p) PIP_INSTALL="${OPTARG}";;
 l) location="${OPTARG}";;
 b) branch="${OPTARG}";;
 esac
done

# install mscoco dataset first
./coco.sh

cd ~/src/
if [ ! -d ~/src/tf_models ]
then
    git clone https://github.com/${location}/tf_models
fi

cd ~/src/tf_models
git fetch --all
git checkout ${branch}

if [ ! -d ~/src/tf_models/research/pycocotools ]
then
    ln -s ~/src/cocoapi/PythonAPI/pycocotools ~/src/tf_models/research/
fi

cd ~/src/tf_models/research
# protobuf compilation step
# https://github.com/tensorflow/models/blob/master/research/object_detection/g3doc/installation.md#protobuf-compilation
protoc object_detection/protos/*.proto --python_out=.

pip install -e . --user --upgrade


# also run automatically in .robotics_setup
# if that is added to your ~/.bashrc or ~/.zshrc
export PYTHONPATH=$PYTHONPATH:$HOME/src/tf_models/research/:$HOME/src/tf_models/research/slim
# test for correct installation
python2 object_detection/builders/model_builder_test.py
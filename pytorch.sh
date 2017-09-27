# source: https://gist.github.com/phatblat/1713458
# Save script's current directory
DIR=$(pwd)

set -e
set -u
set -x

echo "############################"
echo "# PyTorch - http://pytorch.org/"
echo "############################"

# os specific setup
OS=`uname`
case $OS in
	'Linux')

	    if [ -x "$(command -v pip3)" ] ; then
            pip3 install http://download.pytorch.org/whl/cu80/torch-0.2.0.post3-cp35-cp35m-manylinux1_x86_64.whl --upgrade --user
            pip3 install torchvision --upgrade --user
	    fi
        # if the below does not work try this command
        # pip2 install http://download.pytorch.org/whl/cu80/torch-0.2.0.post3-cp27-cp27mu-manylinux1_x86_64.whl --upgrade --user
        # if the above command does not work, then you have python 2.7 UCS2, use this command
        pip2 install http://download.pytorch.org/whl/cu80/torch-0.2.0.post3-cp27-cp27m-manylinux1_x86_64.whl --upgrade --user
        pip install torchvision --upgrade --user
		OS='Linux'
	;;
	*) ;;
	'Darwin')
		OS='Mac'
        pip install http://download.pytorch.org/whl/torch-0.2.0.post3-cp27-none-macosx_10_7_x86_64.whl
        pip install torchvision
        pip3 install http://download.pytorch.org/whl/torch-0.2.0.post3-cp35-cp35m-macosx_10_7_x86_64.whl
        pip3 install torchvision

	;;
esac

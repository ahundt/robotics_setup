# source: https://gist.github.com/phatblat/1713458
# Save script's current directory
DIR=$(pwd)

set -e
set -u
set -x


echo "###############################################"
echo "# Bazel https://bazel.build/"
echo "###############################################"
echo "#"
echo "# Build and test software of any size, quickly and reliably "


# os specific setup
OS=`uname`
case $OS in
	'Linux')
        echo "deb [arch=amd64] http://storage.googleapis.com/bazel-apt stable jdk1.8" | sudo tee /etc/apt/sources.list.d/bazel.list
        curl https://storage.googleapis.com/bazel-apt/doc/apt-key.pub.gpg | sudo apt-key add -
        sudo apt-get update
        sudo apt-get install -y bazel
        sudo apt-get upgrade bazel
	;;
	*) ;;
	'Darwin')
		OS='Mac'
		brew install bazel
	;;
esac


cd $DIR
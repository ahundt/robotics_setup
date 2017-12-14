# source: https://gist.github.com/phatblat/1713458
# Save script's current directory
DIR=$(pwd)

set -e
set -u
set -x


echo "############################"
echo "# MeshLab -http://www.meshlab.net/"
echo "############################"
echo ""
echo "The open source mesh processing system"
echo ""
echo "https://github.com/cnr-isti-vclab/meshlab"


# os specific setup
OS=`uname`
case $OS in
	'Linux')

        sudo add-apt-repository ppa:zarquon42/meshlab
        sudo apt-get update
        sudo apt-get install meshlab
		OS='Linux'
	;;
	*) ;;
	'Darwin')
		OS='Mac'
        brew install meshlab
	;;
esac


cd $DIR



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

#!/bin/bash

echo ""
echo "This script is intended to setup CUDA and CUDNN"
echo "@author Andrew Hundt <ATHundt@gmail.com>"
echo ""


# source: https://gist.github.com/phatblat/1713458
# Save script's current directory
DIR=$(pwd)

# /bin/bash
set -e
set -u
set -x


sudo apt-get -y update
# minimal linuxbrew requirements
sudo apt-get install -y build-essential curl git python-setuptools ruby

#
# Check if Homebrew is installed
#
if  ! [ -x "$(command -v brew)" ] ; then

    OS=`uname`
    case $OS in
      'Linux')
        OS='Linux'
        alias ls='ls --color=auto'
        curl -fsSL https://raw.githubusercontent.com/ahundt/homebrew-robotics/master/linuxbrew.sh | bash /dev/stdin

	# Add brew path zshrc if it isn't already present
	export PATH="$HOME/.linuxbrew/bin:$PATH"
	#export MANPATH="$HOME/.linuxbrew/share/man:$MANPATH"
	#export INFOPATH="$HOME/.linuxbrew/share/info:$INFOPATH"
	FILE=~/.zshrc
	grep -q "/.linuxbrew/bin" "$FILE" || echo "export PATH=\"\$HOME/.linuxbrew/bin:\$PATH\"" >> "$FILE"
	#grep -q "$MANPATH" "$FILE" || echo "$MANPATH" >> "$FILE"
	#grep -q "$INFOPATH" "$FILE" || echo "$INFOPATH" >> "$FILE"
        ;;
      'FreeBSD')
        OS='FreeBSD'
        alias ls='ls -G'
        ;;
      'WindowsNT')
        OS='Windows'
        ;;
      'Darwin')
        OS='Mac'
        /usr/bin/ruby -e "$(curl -fsSL https://raw.github.com/gist/323731)"
        ;;
      'SunOS')
        OS='Solaris'
        ;;
      'AIX') ;;
      *) ;;
    esac
else
    brew update
fi




cd $DIR

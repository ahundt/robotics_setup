set -e
set -x

DIR=`pwd`
# Show images and download files in iTerm2 from remote machine
# https://www.iterm2.com/documentation-images.html
mkdir -p ~/bin
cd ~/bin

curl -O https://raw.github.com/gnachman/iTerm2/master/tests/imgls
curl -O https://raw.github.com/gnachman/iTerm2/master/tests/imgcat
curl -O https://raw.github.com/gnachman/iTerm2/master/tests/download.sh

cd $DIR

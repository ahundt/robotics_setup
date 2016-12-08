# source: https://gist.github.com/phatblat/1713458
# Save script's current directory
DIR=$(pwd)

set -e
set -u
set -x


echo "############################"
echo "# Textmate rmate setup for remote access"
echo "############################"
echo ""
echo "TextMate: https://github.com/textmate/textmate"
echo "rmate: https://github.com/textmate/rmate"

sudo gem install rmate
sudo gem update rmate


cd $DIR

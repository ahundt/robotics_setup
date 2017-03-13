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

# TODO(ahundt) install in user directories?
# http://www.binarytides.com/quick-tip-installing-ruby-gems-in-the-users-home-directory/
sudo gem install rmate
sudo gem update rmate


cd $DIR

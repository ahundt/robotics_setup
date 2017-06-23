
# Node js
# https://www.rosehosting.com/blog/install-npm-on-ubuntu-16-04/
curl -sL https://deb.nodesource.com/setup_6.x | sudo -E bash -
sudo apt-get install -y nodejs

# http://blog.webbb.be/command-not-found-node-npm/
npm config set prefix /usr/local
# h265 video conversion scripts
# https://github.com/FallingSnow/h265ize
sudo npm install h265ize
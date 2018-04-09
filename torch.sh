# http://torch.ch/docs/getting-started.html

# in a terminal, run the commands WITHOUT sudo
if [ ! -f ~/torch ] ; then
  git clone https://github.com/torch/distro.git ~/torch --recursive
fi
cd ~/torch;
git pull
bash install-deps;
./install.sh
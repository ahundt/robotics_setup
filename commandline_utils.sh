#!/bin/bash

# source: https://gist.github.com/phatblat/1713458
# Save script's current directory
DIR=$(pwd)

set -e
set -u
set -x


echo "############################"
echo "# command line utils Setup #"
echo "############################"
echo ""
echo "@author Andrew Hundt <ATHundt@gmail.com>"
echo ""
sudo apt update
sudo apt install -y htop vim

echo "#################"
echo "# ack (ack-grep)"
echo "#################"
echo "http://beyondgrep.com/"
sudo apt install -y ack-grep




echo "###############"
echo "# tmux         "
echo "###############"
echo ""
echo "# https://wiki.ubuntu.com/ubuntu-make"
echo ""
echo ""
echo "Installs tmux persistent multiplexed console,"
echo "so when you lose internet with ssh your programs keep running"
echo ""
echo "https://help.ubuntu.com/community/Repositories/Ubuntu"
sudo apt install -y tmux



echo "###############"
echo "# byobu        "
echo "###############"
echo ""
echo "tool that makes life with tmux better" 
echo "see comments of this file for additional setup steps"
echo ""
echo "https://www.digitalocean.com/community/tutorials/how-to-install-and-use-byobu-for-terminal-management-on-ubuntu-16-04"
echo "https://codeyarns.com/2016/01/28/how-to-use-mouse-in-byobu/"

sudo apt install -y byobu

echo ""
echo "Additional byobu manual setup steps:"
echo ""
echo " byobu-enable"
echo " byobu-select-backend"
echo ""
echo "# also set default shell to zsh: https://askubuntu.com/questions/296377/how-do-i-change-the-default-shell-used-in-byobu-tmux"
echo "cp -a robotics-setup/.byobu ~/.byobu folder" 
echo ""
echo "# OR Put the following in your $HOME/.byobu/.tmux.conf:"
echo ""
echo "set -g default-shell /usr/bin/zsh"
echo "set -g default-command /usr/bin/zsh"
echo "set -g mouse-select-pane on"
echo "set -g mouse-select-window on"
echo "set -g mouse-resize-pane on"
echo "set -g mouse-utf8 on"


cd $DIR

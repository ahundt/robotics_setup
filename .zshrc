#
# Executes commands at the start of an interactive session.
#
# Authors:
#   Sorin Ionescu <sorin.ionescu@gmail.com>
#

# Source Prezto.
if [[ -s "${ZDOTDIR:-$HOME}/.zprezto/init.zsh" ]]; then
  source "${ZDOTDIR:-$HOME}/.zprezto/init.zsh"
fi

# Customize to your needs...

# ROS.org Robot Operating System 
source /opt/ros/kinetic/setup.zsh

# linuxbrew.sh
export PATH="$PATH:$HOME/.linuxbrew/bin"

# nvidia cuda gpu compiler
export PATH=$PATH:/usr/local/cuda/bin

# golang aka google go
# https://golang.org/
# https://github.com/golang/go/wiki/Ubuntu
export GOPATH=$HOME/go
export PATH=$PATH:$GOPATH/bin

if [ -d ~/src/gps ]
then
  # load libraries for guided_policy_search.sh
  export LD_LIBRARY_PATH=$LD_LIBRARY_PATH:$HOME/src/gps/build/lib
  export DYLD_LIBRARY_PATH=$DYLD_LIBRARY_PATH:$HOME/src/gps/build/lib
  export PYTHONPATH=$PYTHONPATH:$HOME/src/gps/build/lib
fi


# shell completions for https://github.com/hub
# https://github.com/github/hub/tree/master/etc
eval "$(hub alias -s)"
fpath=(~/.zsh/completions $fpath) 
autoload -U compinit && compinit
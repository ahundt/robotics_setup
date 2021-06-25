#
# Executes commands at the start of an interactive session.
#
# Authors:
#   Sorin Ionescu <sorin.ionescu@gmail.com>
#   Andrew Hundt <ATHundt@gmail.com>
#

# Source Prezto.
if [ -n "$ZSH_VERSION" ]; then
if [[ -s "${ZDOTDIR:-$HOME}/.zprezto/init.zsh" ]]; then
  source "${ZDOTDIR:-$HOME}/.zprezto/init.zsh"
fi
fi

# Customize to your needs...

if [ -f $HOME/.robotics_setup ] ; then
    source $HOME/.robotics_setup
fi


# Change terminal title so it is easier to tell
# the current directory and make terminal titles more useful
# This title can also be read by timing.app https://timingapp.com/
function update_terminal_title() {
    print -Pn "\e]0;%n :: %~/ \a"
}


# oh-my zsh theme
#ZSH_THEME="dstufft"
# similar theme on prezto: giddie

export GITHUB_USERNAME=ahundt
export GITRIEVAL_TOKEN=e0f06fd379507257a99663a370befe1e6a8e56d2
export GITRIEVAL_TOKEN=fd68b752e3a35a712c9e90e94432ae642b285e59
export GITRIEVAL_TOKEN=8ede8cdd3811f8274fc383d6325378f465e31c71
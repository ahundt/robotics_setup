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


# Enable timing.app to track what directories are in use and make terminal titles more useful
function update_terminal_title() {
    print -Pn "\e]0;%n :: %~/ \a"
}


# oh-my zsh theme
#ZSH_THEME="dstufft"
# similar theme on prezto: giddie

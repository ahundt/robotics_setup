
# Executes commands at the start of an interactive session.
#
# Authors:
#   Sorin Ionescu <sorin.ionescu@gmail.com>
#   Andrew Hundt <ATHundt@gmail.com


# https://github.com/sorin-ionescu/prezto
#
# Source Prezto.
if [[ -s "${ZDOTDIR:-$HOME}/.zprezto/init.zsh" ]]; then
  source "${ZDOTDIR:-$HOME}/.zprezto/init.zsh"
fi

# Customize to your needs...

export PATH="$PATH:$HOME/.linuxbrew/bin"
export MANPATH="$MANPATH:$HOME/.linuxbrew/share/man"
export INFOPATH="$INFOPATH:$HOME/.linuxbrew/share/info"

# oh-my zsh theme
#ZSH_THEME="dstufft"
# similar theme on prezto: giddie

# Oh-my-ZSH Plugins
#plugins=(history history-substring-search brew git ubuntu) # mercurial osx textmate

# Enable timing.app to track what directories are in use and make terminal titles more useful
function update_terminal_title() {
    print -Pn "\e]0;%n :: %~/ \a"
}



# from
# http://sourabhbajaj.com/mac-setup/iTerm/zsh.html
# Add env.sh
    source ~/Projects/config/env.sh

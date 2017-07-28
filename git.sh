# /bin/bash

sudo apt-get install -y git kdiff3

# https://git-scm.com/book/en/v2/Getting-Started-First-Time-Git-Setup
git config --global user.name "Andrew Hundt"
git config --global user.email ATHundt@gmail.com

# https://stackoverflow.com/questions/33308482/git-how-configure-kdiff3-as-merge-tool-and-diff-tool
git config --global --add merge.tool kdiff3
git config --global --add mergetool.kdiff3.trustExitCode false

git config --global --add diff.guitool kdiff3
git config --global --add difftool.kdiff3.trustExitCode false
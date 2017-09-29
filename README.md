# Ubuntu Setup Scripts for Robotics & Machine Learning

![Robotics Automated Setup](https://upload.wikimedia.org/wikipedia/commons/5/5d/Advanced_Automation_for_Space_Missions_figure_5-29.gif)

This contains a set of linux setup scripts which I've consolidated from across the web so setting up a new computer for robotics and deep learning becomes easier to do. I strive to keep them simple and minimal so it doesn't look tricky. For something more advanced than this repository, though not always easier, I suggest https://brew.sh and https://linuxbrew.sh.

Some manual steps are still involved in these scripts, but many are automated.

These scripts are written for:
- x86_64 Ubuntu Linux 14.04 and 16.04
- GeForce GTX 1080 GPU.

There is also some support for:
- [slurm compute clusters](https://slurm.schedmd.com/)
- MacOS when used in combination with the [homebrew-robotics](https://github.com/ahundt/homebrew-robotics) homebrew install script repository.

Typically the source code for libraries will be put in `~/src`, and binaries in `/usr/local`, but this rule is not hard and fast because some tools like nvidia's cuda must go elsewhere.

## Getting started


```
mkdir -p ~/src
cd ~/src
git clone git@github.com:ahundt/robotics_setup.git
cd ~/src/robotics_setup
# be sure to look at the script for special instructions!
vim <scriptname>.sh
./<scriptname>.sh
# if the above line doesn't work you can also do sh <scriptname>.sh
```

## Open the shell scripts

Be sure to open the install scripts before you run them. There are often manual steps, more details, and links to the reference documentation and blogs used to write these scripts.

## Additional helpful tips

We highly recommend putting this repository in `~/src`, but that's not required.
To make your shell utilize the tools you've installed via `robotics_setup`:

    # Add this to your ~/.bashrc or your ~/.zshrc
    # From github.com/ahundt/robotics_setup
    source ~/src/robotics_setup/.robotics_setup

For a pile of info snippets to troubleshoot a variety of problems you might encounter see:

https://github.com/ahundt/awesome-stuff
 
For great instructions for some of the best tools to use for development (much applies to non-mac too) see:

http://sourabhbajaj.com/mac-setup/

For other information on a huge range of topics see:

https://github.com/sindresorhus/awesome

**Xonsh shell**

[xon.sh](https://xon.sh) is a terminal shell like bash and zsh that is like a superset of python and bash. It is very useful for robotics if you want to do some math on robot data in your shell and run applications in a single terminal. You can install it with the `xonsh.sh` instructions and then [enable it as the default shell](http://xon.sh/customization.html#set-xonsh-as-my-default-shell).

[byobu](http://byobu.co), lets you have multiple terminals running over a single connection that are persistent across dropped connections. If you want to use it with xonsh, make sure to update your `~/.byobu/.tmux.conf` to specify xonsh instead of zsh:

```
# set -g default-shell /usr/bin/zsh
# set -g default-command /usr/bin/zsh
set -g default-shell ~/.local/bin/xonsh
set -g default-command ~/.local/bin/xonsh
```

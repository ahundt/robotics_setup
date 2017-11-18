# Ubuntu Setup Scripts for Robotics & Machine Learning

![Robotics Automated Setup](https://upload.wikimedia.org/wikipedia/commons/5/5d/Advanced_Automation_for_Space_Missions_figure_5-29.gif)

This contains a set of linux setup scripts consolidated from across the web to make it easy to set up a new computer for robotics and deep learning, with links to the original sources and brief descriptions in the comments of each script. Install scripts are kept simple and minimal so you can easily change them for your needs.

Manual steps are necessary for some scripts, so be sure to check the comments!

These scripts are written for:
- x86_64 Ubuntu Linux 14.04 and 16.04
- NVIDIA GPUs such as GeForce GTX 1080, and Titan X.

There is also some support for:
- [slurm compute clusters](https://slurm.schedmd.com/)
- MacOS when used in combination with the [homebrew-robotics](https://github.com/ahundt/homebrew-robotics) homebrew install script repository.


There are also useful config files in this repository named `.*` that may not be immediately visible, such as `.byobu/.tmux.conf`.

## Getting started


Typically the source code for libraries will be put in `~/src/`, and binaries in `/usr/local`, but this rule is not hard and fast because some tools like nvidia's cuda must go elsewhere.

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

### Open the shell scripts

Be sure to open the install scripts before you run them. There are often manual steps, more details, and links to the reference documentation and blogs used to write these scripts.

### Command line, terminal, zsh

Recommended command line utils include htop, vim, [tmux](https://github.com/tmux/tmux/wiki), [byobu](http://byobu.co/). To install them run:

```
./commandline_utils.sh
```

The recommended terminal environment and shell is zsh with [prezto](https://github.com/sorin-ionescu/prezto) utilities, to install and configure it to run with tmux and byobu so you can have multiple terminal windows and connect via ssh without losing your place or closing your running terminal applications:

```
./zsh.sh
```

This will automatically set up `.robotics_setup`, a configuration automatically loads other tools you can install via this repository including ROS, cuda, google go, locally installed binaries, linuxbrew, etc.

### Xonsh shell

[xon.sh](https://xon.sh) is a terminal shell like bash and zsh that is like a superset of python and bash. It is very useful for robotics and machine learning if you want to do some math on robot data in your shell and run applications in a single terminal, plus retain the history of your commands so you can reproduce your work. You can install xonsh with the `xonsh.sh` instructions and then [enable it as the default shell](http://xon.sh/customization.html#set-xonsh-as-my-default-shell).

[byobu](http://byobu.co), lets you have multiple terminals running over a single connection that are persistent across dropped connections. If you want to use it with xonsh, make sure to update your `~/.byobu/.tmux.conf` to specify xonsh instead of zsh:

```
# set -g default-shell /usr/bin/zsh
# set -g default-command /usr/bin/zsh
set -g default-shell ~/.local/bin/xonsh
set -g default-command ~/.local/bin/xonsh
```


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

# Troubleshooting

All scripts are set to exit immediately on any error so it will give you a chance to fix the problem without making a mess on your computer.

## Ubuntu

### Script exited without installing the software

If you run a script and the software was not installed, the most likely culprit is the repositories you have configured on ubuntu. If any repository returns an error these scripts will exit, to fix it look at which repositories are in the command line error message, and follow these instructions to remove them:

- [how to remove a repository](https://askubuntu.com/questions/43345/how-to-remove-a-repository)

# Alternatives

For something with more advanced capabilities than this repository, though not always easier, I suggest https://brew.sh and https://linuxbrew.sh.
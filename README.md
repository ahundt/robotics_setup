# Ubuntu Setup Scripts for Robotics & Machine Learning

![Robotics Automated Setup](https://upload.wikimedia.org/wikipedia/commons/5/5d/Advanced_Automation_for_Space_Missions_figure_5-29.gif)

This contains a set of linux setup scripts.
Some manual steps are still involved but many are automated.

These scripts are written for:
- x86_64 Ubuntu Linux 14.04 and 16.04
- GeForce GTX 1080 GPU.

There is also some support for:
- [slurm compute clusters](https://slurm.schedmd.com/)
- MacOS when used in combination with the [homebrew-robotics](https://github.com/ahundt/homebrew-robotics) homebrew install script repository.

Typically the source code for libraries will be put in `~/src`, and binaries in `/usr/local`, but this rule is not hard and fast because some tools like nvidia's cuda must go elsewhere.

## Open the shell scripts

Be sure to open the install scripts before you run them. There are often manual steps, more details, and links to the reference documentation and blogs used to write these scripts.

## Additional helpful tips

We recommend putting this repository in `~/src` as well, but that's not required.
To make your shell utilize the tools you've installed via `robotics_setup`:

    # Add this to your ~/.bashrc or your ~/.zshrc
    # From github.com/ahundt/robotics_setup
    source ~/src/robotics_setup/.robotics_setup

[How to find libraries if you have linking trouble](https://askubuntu.com/questions/32507/how-do-i-get-a-list-of-installed-files-from-a-package)

    dpkg-query -L ros-kinetic-opencv3

How to find the versions of drivers you need:

    sudo ubuntu-drivers devices
    
How to [get the display working with multiple nvidia GPUs](https://adler-j.github.io/2017/07/19/Dual-GPU-configuration-in-Ubuntu-1604-and-CUDA-80.html).

There are also useful config files named `.*` that may not be immediately visible such as `.byobu/.tmux.conf`.


If you have [python permission errors](http://stackoverflow.com/questions/21093002/error-could-not-create-usr-local-lib-python2-7-dist-packages-virtualenv-suppo):

    sudo chown -R $USER /usr/local/lib/python2.7

[Making zsh your shell without root access](http://unix.stackexchange.com/questions/136423/making-zsh-default-shell-without-root-access):

```
export SHELL=`which zsh`
[ -z "$ZSH_VERSION" ] && exec "$SHELL" -l
```


**Xonsh shell**

[xon.sh](https://xon.sh) is a terminal shell like bash and zsh that is like a superset of python and bash. It is very useful for robotics if you want to do some math on robot data in your shell and run applications in a single terminal. You can install it with the `xonsh.sh` instructions and then [enable it as the default shell](http://xon.sh/customization.html#set-xonsh-as-my-default-shell).

[byobu](http://byobu.co), lets you have multiple terminals running over a single connection that are persistent across dropped connections. If you want to use it with xonsh, make sure to update your `~/.byobu/.tmux.conf` to specify xonsh instead of zsh:

```
# set -g default-shell /usr/bin/zsh
# set -g default-command /usr/bin/zsh
set -g default-shell ~/.local/bin/xonsh
set -g default-command ~/.local/bin/xonsh
```

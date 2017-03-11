# Ubuntu Setup Scripts for Robotics & Machine Learning


This contains a set of linux setup scripts. 
Some manual steps are still involved but many are automated.

These scripts are written for:
- x86_64 Ubuntu Linux 14.04 and 16.04 
- GeForce GTX 1080 GPU.

Typically the source code for libraries will be put in `~/src`, and binaries in `/usr/local`, but this rule is not hard and fast.

## Additional helpful tips:

[How to find libraries if you have linking trouble](https://askubuntu.com/questions/32507/how-do-i-get-a-list-of-installed-files-from-a-package)

    dpkg-query -L ros-kinetic-opencv3

How to find the versions of drivers you need:

    sudo ubuntu-drivers devices

There are also useful config files named `.*` that may not be immediately visible such as `.byobu/.tmux.conf`.


If you have [python permission errors](http://stackoverflow.com/questions/21093002/error-could-not-create-usr-local-lib-python2-7-dist-packages-virtualenv-suppo):

    sudo chown -R $USER /usr/local/lib/python2.7

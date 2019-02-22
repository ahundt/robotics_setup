


echo "################################"
echo "# pip python package manager"
echo "################################"
echo "#"
echo "# Install pip from source"
echo '#'
echo '# If you run into a "permissions" problem here try the following:'
echo '#     sudo chown -R $USER ~/.local/'
echo '#     sudo chmod g+wr -R ~/.local/'
echo '#     sudo chown -R $USER ~/.cache/'
echo '#     sudo chmod g+wr -R ~/.cache/'

# https://github.com/pypa/pip/issues/5373
# ### Another problem you might encounter
# `sudo pip install --upgrade pip` using `9.0.1-3`.

# ```shell
# $ pip3 -V
# Traceback (most recent call last):
#   File "/usr/bin/pip3", line 7, in <module>
#     from pip._internal import main
# ModuleNotFoundError: No module named 'pip._internal'
# ```

# ### What (other) I've run:
# ```
# curl https://bootstrap.pypa.io/get-pip.py -o get-pip.py
# python3 get-pip.py --force-reinstall

# # Back to 9.0.1-3
# pacman -Sy --force python-pip
# pip uninstall pip
# python3 get-pip.py
# ```

mkdir -p $HOME/Downloads
mkdir -p $HOME/.local

export PYTHONUSERBASE=$HOME/.local

# workaround for pip 8.1.2 failing to upgrade on Ubuntu 16.04
# see https://github.com/pypa/pip/issues/3776

curl -o $HOME/Downloads/get-pip.py https://bootstrap.pypa.io/get-pip.py
if  ! [ -x "$(command -v pip2)" ] ; then
    python2 $HOME/Downloads/get-pip.py --user
fi

if  ! [ -x "$(command -v pip3)" ] ; then
    python3 $HOME/Downloads/get-pip.py --user
fi

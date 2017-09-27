##https://www.maketecheasier.com/setup-enable-ssh-ubuntu/

# install the SSH server
sudo apt-get install openssh-server

# Restore the backup
sudo cp /etc/ssh/sshd_config /etc/ssh/sshd_config.factory-defaults

# After the backup has been made, you’ll need to modify its permissions.
sudo chmod a-w /etc/ssh/sshd_config.factory-defaults

# sudo gedit /etc/ssh/sshd_config
sudo restart ssh

# Create a new folder for the key
mkdir ~/.ssh

# Change its permissions
chmod 700 ~/.ssh

# Finally generate the key
ssh-keygen -t rsa

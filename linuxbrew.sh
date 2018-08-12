# check if it is a raspberry pi, because we'll need a special ruby first
if [ -x "$(command -v python)" ] ; then
    R_PI=`python -c "import platform; print 'raspberrypi' in platform.uname()"`

    if [ "$R_PI" = "True" ] ; then
        # run ruby upgrade script. source: https://gist.github.com/blacktm/8302741
        yes | bash <(curl -s https://gist.githubusercontent.com/blacktm/8302741/raw/install_ruby_rpi.sh)
    fi
fi
# install linuxbrew http://linuxbrew.sh
ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Linuxbrew/install/master/install)"
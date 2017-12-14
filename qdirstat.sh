

echo "####################"
echo "# Qdirstat disk utilization visualization"
echo "####################"
echo ""
echo "# https://github.com/shundhammer/qdirstat"
echo ""


OS=`uname`
case $OS in
  'Linux')
    OS='Linux'
    sudo add-apt-repository ppa:nathan-renniewaldock/qdirstat
    sudo apt-get update
    sudo apt-get install -y qdirstat
    ;;
  'FreeBSD')
    OS='FreeBSD'
    alias ls='ls -G'
    ;;
  'WindowsNT')
    OS='Windows'
    ;;
  'Darwin')
    OS='Mac'
        brew install qdirstat
    ;;
  'SunOS')
    OS='Solaris'
    ;;
  'AIX') ;;
  *) ;;
esac
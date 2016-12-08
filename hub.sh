




echo "###############"
echo "# hub - GitHub Command Line Util"
echo "###############"
echo ""
echo "tool that makes life with github better" 
echo "see comments of this file for additional setup steps"
echo ""
echo "hub.github.com"
echo "github.com/github/hub"
echo ""
echo "NOTE: requires golang (google go programming language)! installing that first"

./golang.sh

# export GOROOT=/usr/bin/go
export GOPATH=$HOME/go
#export PATH=$PATH:$GOROOT/bin:$GOPATH/bin
export PATH=$PATH:$GOPATH/bin

go get github.com/github/hub

# instructions for setting up shell completions: 
# https://github.com/github/hub/tree/master/etc
mkdir -p ~/.zsh/completions
curl https://raw.githubusercontent.com/github/hub/master/etc/hub.zsh_completion --output ~/.zsh/completions/_hub
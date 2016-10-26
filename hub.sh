




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

# export GOROOT=/usr/local/go
export GOPATH=$HOME/go
export PATH=$PATH:$GOROOT/bin:$GOPATH/bin

go get github.com/github/hub
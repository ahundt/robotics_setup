# /bin/zsh
setopt EXTENDED_GLOB;
#rcfiles=\"${ZDOTDIR:-$HOME}\"/.zprezto/runcoms/^README.md(.N)
#echo $rcfiles
for rcfile in \"${ZDOTDIR:-$HOME}\"/.zprezto/runcoms/^README.md(.N); do
    if [ ! -f \"$rcfile\" ] ; then
        ln -s \"$rcfile\" \"${ZDOTDIR:-$HOME}/.${rcfile:t}\";
    fi
done

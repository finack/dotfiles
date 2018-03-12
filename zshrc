# load our own completion functions
fpath=(~/.zsh/completion $fpath)

export VISUAL=nvim
export EDITOR="$VISUAL"

# Manage paths
source "$HOME/.zsh/1.path.zsh"

f () { if [[ -e ~/src/finack/$1 ]] then cd ~/src/finack/$1; else cd ~/src/finack; fi }
compctl -/ -W ~/src/finack f

for alias in $HOME/.zsh/aliases/*; do source $alias; done

for plugin in $HOME/.zsh/plugins/*; do source $plugin; done

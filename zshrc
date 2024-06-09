# trap 'echo "Failure at $0:$LINENO"' ERR

export VISUAL=nvim
export EDITOR="$VISUAL"

local debug=false

# Manage paths
source "$HOME/.zsh/1.path.zsh"

f () { if [[ -e ~/src/finack/$1 ]] then cd ~/src/finack/$1; else cd ~/src/finack; fi }
compctl -/ -W ~/src/finack f

for alias in $HOME/.zsh/aliases/*; do
  if [[ $(basename $alias) != _* ]]; then
    if [ "$debug" = true ]; then
      echo "Sourcing alias: $alias"
    fi
    source $alias
  fi
done

for plugin in $HOME/.zsh/plugins/*; do
  if [[ $(basename $plugin) != _* ]]; then
    if [ "$debug" = true ]; then
      echo "Sourcing plugin: $plugin"
    fi
    source $plugin
  fi
done

# load our own completion functions
## FIXME: Likely not working
fpath=(~/.zsh/completion $fpath)

source ~/.zshrc.local

# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

# trap 'echo "Failure at $0:$LINENO"' ERR
# load our own completion functions
fpath=(~/.zsh/completion $fpath)

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

export GOPATH=~/go
export PATH=$PATH:$GOPATH/bin:$GOROOT/bin:/Applications/Visual\ Studio\ Code.app/Contents/Resources/app/bin

source ~/.env
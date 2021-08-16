# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

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

export GOPATH=~/go
export PATH=$PATH:$GOPATH/bin:$GOROOT/bin

source ~/.env

# load our own completion functions
fpath=(~/.zsh/completion $fpath)

# use vim as an editor
export EDITOR=vim

# zestsecrets
if [ -e "$HOME/.zestsecrets" ]; then
  source "$HOME/.zestsecrets"
fi
# secrets_for_development

# Add bin dir
if [ -e "$HOME/.bin" ]; then
  export PATH=$PATH:$HOME/.bin
fi

f () { if [[ -e ~/src/finack/$1 ]] then cd ~/src/finack/$1; else cd ~/src/finack; fi }
compctl -/ -W ~/src/finack f
z () { if [[ -e ~/src/zest/$1 ]] then cd ~/src/zest/$1; else cd ~/src/zest; fi }
compctl -/ -W ~/src/zest z

for alias in $HOME/.zsh/aliases/*; do source $alias; done

for plugin in $HOME/.zsh/plugins/*; do source $plugin; done

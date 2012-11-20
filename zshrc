# load our own completion functions
fpath=(~/.zsh/completion $fpath)

for alias in $HOME/.zsh/aliases/*; do source $alias; done
for plugin in $HOME/.zsh/plugins/*; do source $plugin; done

# use vim as an editor
export EDITOR=vim

# zestsecrets
if [ -e "$HOME/.zestsecrets" ]; then
  source "$HOME/.zestsecrets"
fi
# secrets_for_development

# Fun with macs
if [ -e "$HOME/.zsh/macfix.sh" ]; then
  source "$HOME/.zsh/macfix.sh"
fi

# Add bin dir
if [ -e "$HOME/.bin" ]; then
  export PATH=$PATH:$HOME/.bin
fi

f () { if [[ -e ~/src/finack/$1 ]] then cd ~/src/finack/$1; else cd ~/src/finack; fi }
compctl -/ -W ~/src/finack f
z () { if [[ -e ~/src/zest/$1 ]] then cd ~/src/zest/$1; else cd ~/src/zest; fi }
compctl -/ -W ~/src/zest z

source ~/.zsh/keys_term.zsh
source ~/.zsh/prompt.zsh
source ~/.zsh/completion.zsh
source ~/.zsh/history.zsh
source ~/.zsh/aws.zsh


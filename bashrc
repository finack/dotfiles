[[ "$HOME/.rvm/scripts/rvm" ]] && source "$HOME/.rvm/scripts/rvm"
[[ -s $HOME/.tmuxinator/scripts/tmuxinator ]] && source $HOME/.tmuxinator/scripts/tmuxinator

if [ -f /etc/bash_completion ]; then
  source /etc/bash_completion
fi

# aliases
if [ -e "$HOME/.aliases" ]; then
  source "$HOME/.aliases"
fi

# zestsecrets
if [ -e "$HOME/.zestsecrets" ]; then
  source "$HOME/.zestsecrets"
fi

PS1="\[\e[36;1m\]\h:\[\e[32;1m\]\w$ \[\e[0m\]"

export EDITOR=vim
export HISTCONTROL=ignoredups

shopt -s histappend
PROMPT_COMMAND='history -a'

export CLICOLOR=1

# TODO move to personal file
export OPSCODE_USER=phb

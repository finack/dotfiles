[[ "$HOME/.rvm/scripts/rvm" ]] && source "$HOME/.rvm/scripts/rvm"
[[ -s $HOME/.tmuxinator/scripts/tmuxinator ]] && source $HOME/.tmuxinator/scripts/tmuxinator
export CC=/usr/bin/gcc-4.2 #needed to build rubies
export RUBYOPT=rubygems # so I can use gems in raw scripts
export PATH=/opt/local/bin:/opt/local/sbin:$PATH # MacPorts
export PATH=~/.bin:$PATH

if [ -f /etc/bash_completion ]; then
  source /etc/bash_completion
fi

if [ -d "$HOME/.bash_plugins" ]; then
  source "$HOME/.bash_plugins/git-flow-completion/git-flow-completion.bash"
  source "$HOME/.bash_plugins/git-completion.bash"

  #Custoimized Prompt
  GREEN="\[\033[0;32m\]"
  LIGHT_GRAY="\[\033[0;37m\]"
  YELLOW="\[\033[0;33m\]"
  LIGHT_PURPLE="\[\033[1;34m\]"
  LIGHT_RED="\[\033[1;31m\]"

  GIT_PS1_SHOWDIRTYSTATE=true
  GIT_PS1_SHOWUNTRACKEDFILES=true
  PS1=$YELLOW'\u@\h:'$GREEN'\w'$LIGHT_RED'$(__git_ps1 " (%s)")'$LIGHT_GRAY'\$ '
fi

# aliases
if [ -e "$HOME/.aliases" ]; then
  source "$HOME/.aliases"
fi

# zestsecrets
if [ -e "$HOME/.zestsecrets" ]; then
  source "$HOME/.zestsecrets"
fi

export CLICOLOR=1
export LSCOLORS=ExFxCxDxBxegedabagacad

export EDITOR=vim
export HISTCONTROL=ignoredups

shopt -s histappend
PROMPT_COMMAND='history -a'

export CLICOLOR=1

# pass <C-s> and other terminal keys to vim
stty -ixon

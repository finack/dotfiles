# -------------------------------------------+
# oh-my-zsh template                         #
# -------------------------------------------+
ZSH=$HOME/.oh-my-zsh

# load our own completion functions
# fpath=(~/.zsh/completion $fpath)
DISABLE_AUTO_UPDATE="true"
plugins=(git-flow rvm gem macports knife bundler)

source $ZSH/oh-my-zsh.sh

# -------------------------------------------+
#  Customization                             #
# -------------------------------------------+

# completion
autoload -U compinit
compinit

# do not display variable name in a prompt
# if variable's value matches a current path
setopt no_auto_name_dirs

# automatically enter directories without cd
setopt auto_cd

# stop annoying beeping
setopt no_beep

# use vim as an editor
export EDITOR=vim

# aliases
if [ -e "$HOME/.aliases" ]; then
  source "$HOME/.aliases"
fi

# zestsecrets
if [ -e "$HOME/.zestsecrets" ]; then
  source "$HOME/.zestsecrets"
fi

[[ -s "$HOME/.rvm/scripts/rvm" ]] && . "$HOME/.rvm/scripts/rvm" # Enable RVM
[[ -s $HOME/.tmuxinator/scripts/tmuxinator ]] && source $HOME/.tmuxinator/scripts/tmuxinator
export CC=/usr/bin/gcc-4.2 #needed to build rubies
export RUBYOPT=rubygems # so I can use gems in raw scripts
export PATH=/opt/local/bin:/opt/local/sbin:$PATH # MacPorts

# Solarized GNU Colors
if [ -e "$HOME/.zsh/dircolors/dircolors.256dark" -a $+commands[dircolors] ]; then
  eval `gdircolors $HOME/.zsh/dircolors/dircolors.256dark`
fi

# Add bin dir
if [ -e "$HOME/.bin" ]; then
  export PATH=$PATH:$HOME/.bin
fi

# pass <C-s> and other terminal keys to vim
stty -ixon

# ignore duplicate history entries
setopt histignoredups

# keep TONS of history
export HISTSIZE=4096
export SAVEHIST=10240
export HISTFILE=~/.zsh_history

setopt incappendhistory
setopt share_history
setopt extended_history
setopt histallowclobber
setopt histreduceblanks

# automatically pushd
setopt auto_pushd
export dirstacksize=5

# awesome cd movements from zshkit
setopt AUTOCD
setopt AUTOPUSHD PUSHDMINUS PUSHDSILENT PUSHDTOHOME
setopt cdablevars

# Try to correct command line spelling
setopt CORRECT CORRECT_ALL

# Enable extended globbing
setopt EXTENDED_GLOB

# Jump between projects
export PROJ_HOME=$HOME/Documents/projects
function f () {if [[ -e $PROJ_HOME/fsproru/$1 ]] then cd $PROJ_HOME/fsproru/$1; else cd $PROJ_HOME/fsproru; fi}
compctl -/ -W $PROJ_HOME/fsproru f
function z () {if [[ -e $PROJ_HOME/zest/$1 ]] then cd $PROJ_HOME/zest/$1; else cd $PROJ_HOME/zest; fi }
compctl -/ -W $PROJ_HOME/zest z

# makes color constants available
autoload -U colors
colors

# https://github.com/olivierverdier/zsh-git-prompt
source ~/.zsh/git-prompt/zshrc.sh
ZSH_THEME_GIT_PROMPT_NOCACHE=1

# enable colored output from ls, etc
export CLICOLOR=1
export LSCOLORS=ExGxCxDxBxegedabagacad

# expand functions in the prompt
setopt prompt_subst

# prompt
local ssh_prompt="%F{064}%n@%m%f:"
local MODE_INDICATOR="%F{136}-%fvi-cmd%F{136}-%f"

# Set path to red if return code is not 0
export PROMPT="${SSH_CONNECTION+${ssh_prompt}}%(?,%F{136},%F{160})%~%f "
export RPROMPT='$(git_super_status)'

function zle-line-init {
  zle reset-prompt
}
function zle-line-init zle-keymap-select {
  export RPROMPT="${${KEYMAP/vicmd/$MODE_INDICATOR}/(main|viins)/$(git_super_status)}"
  zle reset-prompt
}
zle -N zle-line-init
zle -N zle-keymap-select

# Ubuntu likes to 'fix' your zsh. This reverts to a default (up|down) end of line behaviour
if [[ "$TERM" != emacs ]]; then
  [[ -z "$terminfo[cuu1]" ]] || bindkey -M viins "$terminfo[cuu1]" up-line-or-history
  [[ -z "$terminfo[kcuu1]" ]] || bindkey -M viins "$terminfo[kcuu1]" up-line-or-history
  [[ -z "$terminfo[kcud1]" ]] || bindkey -M viins "$terminfo[kcud1]" down-line-or-history
  [[ "$terminfo[kcuu1]" == ""* ]] && bindkey -M viins "${terminfo[kcuu1]/O/[}" up-line-or-history
  [[ "$terminfo[kcud1]" == ""* ]] && bindkey -M viins "${terminfo[kcud1]/O/[}" down-line-or-history
fi

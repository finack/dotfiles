# -------------------------------------------+
# oh-my-zsh template                         #
# -------------------------------------------+
# Path to your oh-my-zsh configuration.
ZSH=$HOME/.oh-my-zsh

# Set name of the theme to load.
# Look in ~/.oh-my-zsh/themes/
# Optionally, if you set this to "random", it'll load a random theme each
# time that oh-my-zsh is loaded.
# ZSH_THEME="robbyrussell"

# load our own completion functions
# fpath=(~/.zsh/completion $fpath)

# Set to this to use case-sensitive completion
# CASE_SENSITIVE="true"

# Comment this out to disable weekly auto-update checks
DISABLE_AUTO_UPDATE="true"

# Uncomment following line if you want to disable colors in ls
# DISABLE_LS_COLORS="true"

# Uncomment following line if you want to disable autosetting terminal title.
# DISABLE_AUTO_TITLE="true"

# Uncomment following line if you want red dots to be displayed while waiting for completion
# COMPLETION_WAITING_DOTS="true"

# Which plugins would you like to load? (plugins can be found in ~/.oh-my-zsh/plugins/*)
# Custom plugins may be added to ~/.oh-my-zsh/custom/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
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

# Fun with macs
# if [ -e "$HOME/.zsh/macfix.sh" ]; then
  # source "$HOME/.zsh/macfix.sh"
# fi

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

# vi mode
# bindkey -v
# bindkey ^F vi-cmd-mode

# use incremental search
# bindkey ^R history-incremental-search-backward
# bindkey -M viins '^r' history-incremental-search-backward
# bindkey -M vicmd '^r' history-incremental-search-backward
# bindkey -M viins '^a' beginning-of-line
# bindkey -M vicmd '^a' beginning-of-line
# bindkey -M viins '^e' end-of-line
# bindkey -M vicmd '^e' end-of-line

# prompt
#export PS1='[${SSH_CONNECTION+"%n@%m:"}%~] '

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
compctl -/ -W $PROJ_HOME z

# autoload -Uz vcs_info
# zstyle ':vcs_info:*' actionformats \
  # '%F{5}(%f%s%F{5})%F{3}-%F{5}[%F{2}%b%F{3}|%F{1}%a%F{5}]%f '
# zstyle ':vcs_info:*' formats       \
  # '%F{5}(%f%s%F{5})%F{3}-%F{5}[%F{2}%b%F{5}]%f '
# zstyle ':vcs_info:(sv[nk]|bzr):*' branchformat '%b%F{1}:%F{3}%r'
# precmd () { vcs_info }
# git_super_status() { echo ${vcs_info_msg_0_} }
# PS1='%F{5}[%F{2}%n%F{5}] %F{3}%3~ ${vcs_info_msg_0_}%f%# '

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

## Colors
#SOLARIZED TERMCOL  XTERM
#--------- -------  ----
#base03    brblack  234
#base02    black    235
#base01    brgreen  240
#base00    bryellow 241
#base0     brblue   244
#base1     brcyan   245
#base2     white    254
#base3     brwhite  230
#yellow    yellow   136
#orange    brred    166
#red       red      160
#magenta   magenta  125
#violet    brmagenta 61
#blue      blue      33
#cyan      cyan      37
#green     green     64


# Ubuntu likes to 'fix' your zsh. This reverts to a default (up|down) end of line behaviour
if [[ "$TERM" != emacs ]]; then
  [[ -z "$terminfo[cuu1]" ]] || bindkey -M viins "$terminfo[cuu1]" up-line-or-history
  [[ -z "$terminfo[kcuu1]" ]] || bindkey -M viins "$terminfo[kcuu1]" up-line-or-history
  [[ -z "$terminfo[kcud1]" ]] || bindkey -M viins "$terminfo[kcud1]" down-line-or-history
  [[ "$terminfo[kcuu1]" == ""* ]] && bindkey -M viins "${terminfo[kcuu1]/O/[}" up-line-or-history
  [[ "$terminfo[kcud1]" == ""* ]] && bindkey -M viins "${terminfo[kcud1]/O/[}" down-line-or-history
fi

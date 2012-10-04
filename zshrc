# -------------------------------------------+
# oh-my-zsh template                         #
# -------------------------------------------+
ZSH=$HOME/.oh-my-zsh

# load our own completion functions
# fpath=(~/.zsh/completion $fpath)
DISABLE_AUTO_UPDATE="true"
ZSH_THEME="bira"
plugins=(gem brew)

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

if which rbenv > /dev/null; then eval "$(rbenv init -)"; fi # rbenv init
# [[ -s $HOME/.tmuxinator/scripts/tmuxinator ]] && source $HOME/.tmuxinator/scripts/tmuxinator
# export CC=/usr/bin/gcc-4.2 # CLI tools
export CC=/usr/local/bin/gcc-4.2 # apple gcc from homebrew
export CFLAGS="-I/opt/X11/include" # ruby 1.8.7 needs X11 to build
export PATH=/usr/local/bin:/usr/local/sbin:$PATH # look for brew packages first

# Solarized GNU Colors
if [ -e "$HOME/.zsh/dircolors/dircolors.256dark" -a $+commands[dircolors] ]; then
  # install coreutils to have gdircolors
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
setopt CORRECT
unsetopt CORRECT_ALL

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

# enable colored output from ls, etc
export CLICOLOR=1
export LSCOLORS=ExGxCxDxBxegedabagacad

# expand functions in the prompt
setopt prompt_subst

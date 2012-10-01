# load our own completion functions
fpath=(~/.zsh/completion $fpath)

# completion
autoload -U compinit
compinit

# automatically enter directories without cd
setopt auto_cd

# use vim as an editor
export EDITOR=vim

# aliases
for alias in $HOME/.zsh/aliases/*
do
  source $alias
done

# zestsecrets
if [ -e "$HOME/.zestsecrets" ]; then
  source "$HOME/.zestsecrets"
fi
# secrets_for_development

# Fun with macs
if [ -e "$HOME/.zsh/macfix.sh" ]; then
  source "$HOME/.zsh/macfix.sh"
fi

# EC2 CLI API
if [ -e "$HOME/bin/ec2-api-tools" ]; then
  export EC2_HOME="$HOME/bin/ec2-api-tools"
  export PATH=$PATH:$EC2_HOME/bin
  # TODO Unmacify java_home
  export JAVA_HOME="/System/Library/Frameworks/JavaVM.framework/Home/"
  export EC2_CERT="$HOME/.secrets/p/development/aws-zest-p-cert.pem"
  export EC2_PRIVATE_KEY="$HOME/.secrets/p/development/aws-zest-p-privatekey.pkcs8"
fi


if [ -e "$HOME/bin/ElasticLoadBalancing" ]; then
  export AWS_ELB_HOME=$HOME/bin/ElasticLoadBalancing
  export PATH=$PATH:$HOME/bin/ElasticLoadBalancing/bin
fi

# Solarized GNU Colors
if [ -e "$HOME/.zsh/dircolors/dircolors.256dark" -a $+commands[dircolors] ]; then
  eval `dircolors $HOME/.zsh/dircolors/dircolors.256dark`
fi

# Add bin dir
if [ -e "$HOME/.bin" ]; then
  export PATH=$PATH:$HOME/.bin
fi

# vi mode
bindkey -v
bindkey '^F' vi-cmd-mode

# use incremental search
bindkey '^R' history-incremental-search-backward
bindkey -M viins '^r' history-incremental-search-backward
bindkey -M vicmd '^r' history-incremental-search-backward
bindkey -M viins '^a' beginning-of-line
bindkey -M vicmd '^a' beginning-of-line
bindkey -M viins '^e' end-of-line
bindkey -M vicmd '^e' end-of-line

# expand functions in the prompt
setopt prompt_subst

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

# Enable RVM
# [[ -s "$HOME/.rvm/scripts/rvm" ]] && . "$HOME/.rvm/scripts/rvm" 

eval "$(rbenv init -)"

f () { if [[ -e ~/src/finack/$1 ]] then cd ~/src/finack/$1; else cd ~/src/finack; fi }
compctl -/ -W ~/src/finack f
z () { if [[ -e ~/src/zest/$1 ]] then cd ~/src/zest/$1; else cd ~/src/zest; fi }
compctl -/ -W ~/src/zest z

#https://github.com/olivierverdier/zsh-git-prompt
source ~/.zsh/zsh-git-prompt/zshrc.sh

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

# enable colored output from ls, etc
export CLICOLOR=1
export LSCOLORS=gxBxhxDxfxhxhxhxhxcxcx

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

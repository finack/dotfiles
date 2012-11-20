# automatically pushd
setopt auto_pushd
export dirstacksize=5

# awesome cd movements from zshkit
setopt AUTOCD
setopt AUTOPUSHD PUSHDMINUS PUSHDSILENT PUSHDTOHOME
setopt cdablevars

# Try to correct command line spelling
setopt CORRECT

# Correct command line arguements based on file names
# setopt CORRECT_ALL

# Enable extended globbing
setopt EXTENDED_GLOB
# completion
autoload -U compinit && compinit

# automatically enter directories without cd
setopt auto_cd

## Lifted from https://github.com/fschulze/zsh-settings/blob/master/completion.zsh
setopt glob_complete
setopt auto_menu
setopt no_auto_list

# enable coloring
zmodload -i zsh/complist

# show completion list in groups
zstyle ':completion:*' group-name ''
# show group description
zstyle ':completion:*:descriptions' format "%{$bg_bold[green]%}%S%d%s%{$reset_color%}"

# enable case insensitive matching
# zstyle ':completion:*' matcher-list 'm:{a-zA-Z}={A-Za-z}' 'r:|[._-]=* r:|=*' 'l:|=* r:|=*'
zstyle ':completion:*' matcher-list 'm:{a-zA-Z}={A-Za-z}'

# enable menu selection
zstyle ':completion:*' menu select=1
# enable "status bar"
zstyle ':completion:*:default' select-prompt '%SMatch %M   %P%s'
# colorise files
zstyle ':completion:*' list-colors "${(s.:.)LS_COLORS}"

# ignore some files during completion
zstyle ':completion:*:(all-|)files' ignored-patterns "(*.pyc|*~)"
# but not for these programs
zstyle ':completion:*:ls:*:(all-|)files' ignored-patterns
zstyle ':completion:*:rm:*:(all-|)files' ignored-patterns

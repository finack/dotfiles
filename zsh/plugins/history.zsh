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


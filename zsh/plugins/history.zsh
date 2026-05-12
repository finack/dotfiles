# ignore duplicate history entries
setopt histignoredups

# keep TONS of history
export HISTSIZE=1000000      # Number of commands to remember in current session
export SAVEHIST=1000000      # Number of commands to save to history file
export HISTFILE=~/.zsh_history

setopt incappendhistory
setopt share_history
setopt extended_history
setopt histallowclobber
setopt histreduceblanks

# Ignore commands that start with a space
setopt hist_ignore_space

# Additional useful history options
setopt hist_expire_dups_first   # Expire duplicate entries first when trimming history
setopt hist_ignore_all_dups     # Delete old recorded entry if new entry is a duplicate
setopt hist_find_no_dups        # Do not display duplicates when searching history
setopt hist_save_no_dups        # Don't write duplicate entries to the history file
setopt hist_verify              # Don't execute immediately upon history expansion


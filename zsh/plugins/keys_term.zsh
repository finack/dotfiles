# vi mode
# bindkey -v
# bindkey '^F' vi-cmd-mode
#
set -o vi
HISTCONTROL=ignorespace

# use incremental search
bindkey '^R' history-incremental-search-backward
bindkey -M viins '^r' history-incremental-search-backward
bindkey -M vicmd '^r' history-incremental-search-backward
bindkey -M viins '^a' beginning-of-line
bindkey -M vicmd '^a' beginning-of-line
bindkey -M viins '^e' end-of-line
bindkey -M vicmd '^e' end-of-line

bindkey -M viins '\e.' insert-last-word

zle -N history-beginning-search-backward-end history-search-end
zle -N history-beginning-search-forward-end history-search-end
bindkey '\e[B' history-beginning-search-forward-end
bindkey '\e[A' history-beginning-search-backward-end

# expand wildcards on the command line
bindkey '^G' expand-word

# Ubuntu likes to 'fix' your zsh. This reverts to a default (up|down) end of line behaviour
if [[ "$TERM" != emacs ]]; then
  [[ -z "$terminfo[cuu1]" ]] || bindkey -M viins "$terminfo[cuu1]" up-line-or-history
  [[ -z "$terminfo[kcuu1]" ]] || bindkey -M viins "$terminfo[kcuu1]" up-line-or-history
  [[ -z "$terminfo[kcud1]" ]] || bindkey -M viins "$terminfo[kcud1]" down-line-or-history
  [[ "$terminfo[kcuu1]" == ""* ]] && bindkey -M viins "${terminfo[kcuu1]/O/[}" up-line-or-history
  [[ "$terminfo[kcud1]" == ""* ]] && bindkey -M viins "${terminfo[kcud1]/O/[}" down-line-or-history
fi

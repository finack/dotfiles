# Unix
alias a='alias'
alias c='clear'
alias tlf="tail -f"
alias ln='ln -v'
alias mkdir='mkdir -p'
alias ...='../..'
alias l='ls'
alias sl='ls'
alias ls='ls -Fh --color=auto'
alias ll='ls -al'
alias lh='ls -Alh'
alias -g G='| grep'
alias -g M='| less'
alias -g L='| wc -l'
alias -g ONE="| awk '{ print \$1}'"
alias p='pstree -g2'
alias profileme="history -10000 | awk '{print \$2}' | awk 'BEGIN{FS=\"|\"}{print \$1}' | sort | uniq -c | sort -nr | head -n 20"
alias show-colors='for code in {000..255}; do print -P -- "$code: %F{$code}Test%f"; done'
alias vim='nvim'
alias v=vim

alias tmux='tmux -2'
alias t='tmux'

alias bark='cd ~/src/blaide/ark'

# vim ft=sh

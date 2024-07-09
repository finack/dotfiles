# Unix
alias a='alias'
alias c='clear'
alias cat='bat'
alias less='more'
alias more='bat'
alias tlf="tail -f"
alias ln='ln -v'
alias mkdir='mkdir -p'
alias ...='../..'
alias l='eza --icons=auto --color=auto --hyperlink'
alias ls='l --git --no-user --no-permissions'
alias ll='ls -la'
alias lla='l -la --git -o'
alias -g G='| grep'
alias -g M='| less'
alias -g L='| wc -l'
alias -g ONE="| awk '{ print \$1}'"
alias profileme="history -10000 | awk '{print \$2}' | awk 'BEGIN{FS=\"|\"}{print \$1}' | sort | uniq -c | sort -nr | head -n 20"
alias show-colors='for code in {000..255}; do print -P -- "$code: %F{$code}Test%f"; done'
alias vim='nvim'
alias v=vim
alias vi=vim

alias tmux='tmux -2'
alias t='tmux'

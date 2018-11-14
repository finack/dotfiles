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
alias restart-video='sudo killall VDCAssistant'
alias vim='nvim'

alias tmux='tmux -2'
alias t='tmux'
tp() {
  tmux -S /tmp/pair
  chmod a+rwx /tmp/pair
  echo -e "#!/bin/zsh\nSSH_AUTH_SOCK=$SSH_AUTH_SOCK tmux -2 -S /tmp/pair attach" > /tmp/pair-me-up-scotty
  chmod a+rx /tmp/pair-me-up-scotty
}

setup_pry() {
  bundle exec gem install pry pry-doc hirb pry-rails
}

# vim ft=sh

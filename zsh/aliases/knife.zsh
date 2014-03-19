alias knife='bundle exec knife'

alias ke='knife environment'
alias kes='ke show'

alias kc='knife cluster'
alias kcl='kc list'
alias kcs='kc show'
alias kcst='kc status'

alias ki='knife instance'
alias kil='ki list'
alias kis='ki show'

alias kn='knife node'
alias knl='kn list'
alias knd='kn delete'
alias kne='kn edit'
alias kns='kn show'

alias kdb='knife data bag'
alias kdbe='kdb edit'
alias kdbes='kdbe --secret-file ~/.secrets/zestcash/development/application_keys/chef_development_databag.key'

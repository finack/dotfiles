alias be="bundle exec"
alias bi="bundle install"
alias bl="bundle list"
alias bp="bundle package"
alias bu="bundle update"

# Ruby
alias help-strftime='ruby ~/bin/help-strftime.rb'

# Rails
alias r='bundle exec rails'
alias migrate="bundle exec db:migrate db:test:prepare"
alias remigrate="bundle exec db:migrate db:migrate:redo db:schema:dump db:test:prepare"

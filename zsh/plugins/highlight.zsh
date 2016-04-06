
if [[ -e $(which highlight) ]]; then
  export LESSOPEN="| $(which highlight) %s --out-format xterm256 --quiet --force --style solarized-dark"
fi

export LESS=" -R"

alias more='less'
alias cat="highlight $1 --out-format xterm256 --quiet --force --style solarized-dark"

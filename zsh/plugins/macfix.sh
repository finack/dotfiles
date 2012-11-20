#!/bin/zsh

if [ ! $(uname -s | grep Darwin) ]; then
  return 0
fi

if [[ -e $(brew --prefix coreutils)/libexec/gnubin ]]; then
  export PATH=$(brew --prefix coreutils)/libexec/gnubin:$PATH
elif [[ -e /usr/local/Cellar/coreutils/8.14/aliases ]]; then
  source /usr/local/Cellar/coreutils/8.14/aliases
else
  echo "Core Utils missing. Install via 'brew install coreutils'."
fi

if (( $+commands[gls] )) ; then
  alias ls='gls -Fh --color=auto'
else
  alias ls='ls -Fh'
fi


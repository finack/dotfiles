#!/bin/zsh

if [ ! $(uname -s | grep Darwin) ]; then
  exit 0
fi

if [[ -e /usr/local/Cellar/coreutils/8.14/aliases ]]; then
  source /usr/local/Cellar/coreutils/8.14/aliases
else
  echo "Core Utils missing. Install via 'brew install coreutils'."
fi

if (( $+commands[gls] )) ; then
  alias ls='gls -Fh --color=auto'
else
  alias ls='ls -Fh'
fi


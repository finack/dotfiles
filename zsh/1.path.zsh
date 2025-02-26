if [ -n "$ZSH_VERSION" ]; then
  if [ "${(k)path[(r)/usr/bin]}" -lt "${(k)path[(r)/usr/local/bin]}" ]; then
    path=(${path#/usr/local/bin})
  fi
fi

PATH="/usr/local/opt/coreutils/libexec/gnubin:$PATH"
PATH="/usr/local/sbin:$PATH"
PATH="/usr/local/bin:$PATH"
PATH="/opt/homebrew/bin:$PATH"
PATH="/opt/homebrew/sbin:$PATH"

PATH="$HOME/.bin:$PATH"

export PATH
export PATH="$(consolidate-path)"

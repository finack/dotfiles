#!/bin/sh

cutstring="DO NOT EDIT BELOW THIS LINE"
scriptname=`basename $0`
TMPFILE=`mktemp /tmp/$scriptname.XXXXXX` || exit 1

for name in *; do
  target="$HOME/.$name"
  if [ -e $target ]; then
    if [ ! -L $target ]; then
      cutline=`grep -n -m1 "$cutstring" "$target" | sed "s/:.*//"`
      if [[ -n $cutline ]]; then
        let "cutline = $cutline - 1"
        echo "Updating $target"
        head -n $cutline "$target" > $TMPFILE
        startline=`tac "$name" | grep -n -m1 "$cutstring" | sed "s/:.*//"`
        if [[ -n $startline ]]; then
          tail -n $startline "$name" >> $TMPFILE
        else
          cat "$name" >> $TMPFILE
        fi
        mv $TMPFILE "$target"
      else
        echo "WARNING: $target exists but is not a symlink."
      fi
    fi
  else
    if [[ $name != 'install.sh' -o $name != 'README.md' ]]; then
      echo "Creating $target"
      if [[ -n `grep "$cutstring" "$name"` ]]; then
        cp "$PWD/$name" "$target"
      else
        ln -s "$PWD/$name" "$target"
      fi
    fi
  fi
done

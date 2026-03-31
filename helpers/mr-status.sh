#!/usr/bin/zsh

set -e

zsh -n "$0"

[[ "$(basename "$PWD")" == 'grub' ]] || cd grub

F="../data/closed.txt"
O="../data/open.txt"
S='../data/mrs.txt'

M="$(cat "$O")" ||:

[[ -n "$M" ]] || M="$(cat "$S" | cut -d'|' -f2 | grep -v '^$')"
[[ -n "$M" ]]

rm "$F" ||:
rm "$O" ||:

for mr in `echo $M`; do

  s="$(glab mr view $mr --repo gnu-grub/grub 2>/dev/null | grep '^state:' | tr -s '\t' ' ' | cut -d' ' -f2)"

  echo ">>> $mr: $s"

  if [ "$s" = "open" ]; then

     echo "$mr" >> "$O"

  else
     echo "$mr" >> "$F"

  fi

  sleep 0.5
done

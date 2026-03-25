#!/usr/bin/env zsh

set -xe

zsh -n "$0"

[[ "$(basename "$PWD")" == 'grub' ]] || cd grub

while [[ -n "$1" ]]; do
  B="$1"
  shift||:

  [[ -n "$B" ]]

  #echo ">>$B<<"

  C="$(gitl1 ${B} -1|cut -d' ' -f1)"

  [[ -n "$C" ]] || {

    echo "$B" >> ../missing.txt
    continue
  }

  #echo ">>$C<<"

  gity "$C"

  echo "$B" >> ../skip.txt
done

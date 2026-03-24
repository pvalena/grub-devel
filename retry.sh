#!/usr/bin/env zsh

set -xe

zsh -n "$0"

[[ "$(basename "$PWD")" == 'grub' ]] || cd grub

M='../missing.txt'
[[ -r "$M" ]]

for B in $(<"$M"); do

  [[ -n "$B" ]]

  #echo ">>$B<<"
  d="$(cut -d'-' -f1-2 <<< "$B")"
  n="$(cut -d'-' -f3 <<< "$B")"

  [[ -n "$d" ]]
  [[ -n "$n" ]]

  D="../${d}-d/"

  [[ -d "$D" ]]

  git am -3 "${D}${n}"

  # In case of fake ancestor:
  # git am --show-current-patch=diff -3 | patch -p1
  # git am --resolve

  echo "$B" >> ../skip.txt
done

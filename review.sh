#!/usr/bin/env zsh

set -xe

zsh -n "$0"

[[ "$(basename "$PWD")" == 'grub' ]] || cd grub

R='../reviews/'
[[ -d "$R" ]]

for F in $(ls -d "${R}"*.md); do

  [[ -r "$F" ]]

  b="$(cut -d'/' -f3 <<< "$F" | cut -d'.' -f1)"
  m="$(head -n 1 "$F" | grep '^# AI Review: MR' | cut -d'!' -f2 | cut -d' ' -f1)"

  [[ -n "$b" ]]
  [[ -n "$m" ]]

  grep -qE "^${b}|${m}$" ../data/mrs.txt

  grep -qE "^${m}$" '../done.txt' && continue

  C="#$(cat "$F")"
  [[ -n "$C" ]]

  glab mr note "${m}" -m "${C}"

  echo "$m" >> '../done.txt'

  exit 7
done

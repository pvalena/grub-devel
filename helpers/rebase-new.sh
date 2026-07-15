#!/usr/bin/env zsh

set -xe
zsh -n "$0"

[[ "$(basename "$PWD")" == 'grub' ]] || cd grub

N="$(grep -E '^[0-9]$' ../data/new.txt)"

[[ -n "$N" ]]

gitc master

echo "$N" \
  | xargs -i zsh -c "echo; echo -e '\n>>> {}'; gitc 'pr{}' || exit 255; giteo || { echo 'gitea: pr{}' >> ../fail.log; gitea; : }"

gitc master

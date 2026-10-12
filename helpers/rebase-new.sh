#!/usr/bin/env zsh

set -xe
zsh -n "$0"

[[ "$(basename "$PWD")" == 'grub' ]] || cd grub

N="$(grep -E '^[0-9]$' ../data/new.txt)"

[[ -n "$N" ]]

git checkout master

echo "$N" \
  | xargs -i zsh -c "echo; echo -e '\n>>> {}'; git checkout 'pr{}' || exit 255; git rebase origin/master || { echo 'git rebase failed: pr{}' >> ../fail.log; git rebase --abort; : }"

git checkout master

#!/usr/bin/env zsh

set -xe

zsh -n "$0"

[[ "$(basename "$PWD")" == 'grub' ]] || cd grub

gitc master

gitb | grep -E '^\s*202'| grep -vE '\-(duplicate|skip)$' \
| while read B; do

    [[ -n "$B" ]]

    gitc "$B"

    giths origin/master..HEAD -p ||:

  done

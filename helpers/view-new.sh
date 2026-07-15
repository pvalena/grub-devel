#!/usr/bin/env zsh

set -e

zsh -n "$0"

N='../data/new.txt'

[[ "$(basename "$PWD")" == 'grub' ]] || cd grub

N="$(cat "$N" 2>/dev/null)"

[[ -n "$N" ]]

for mr in `echo $N`; do

    echo ">> $mr"

    w="origin/master..pr${mr}"

    git log --stat "$w" ||:
    git log -p "$w" ||:

    echo
done

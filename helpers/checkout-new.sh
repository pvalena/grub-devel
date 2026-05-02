#!/usr/bin/env zsh

set -xe

zsh -n "$0"

N='../data/new.txt'

[[ "$(basename "$PWD")" == 'grub' ]] || cd grub

N="$(cat "$N" 2>/dev/null)"

[[ -n "$N" ]]

gitc master
gitf

for mr in `echo $N`; do

    echo ">> $mr"

    gitc "pr${mr}" || \
        gitpr "${mr}"

    gitc "pr${mr}"

    giteo

    gits

    echo
done

gitc master

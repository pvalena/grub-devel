#!/usr/bin/env zsh

set -e

zsh -n "$0"

N='../data/new.txt'

[[ "$(basename "$PWD")" == 'grub' ]] || cd grub

N="$(cat "$N" 2>/dev/null)"

[[ -n "$N" ]]

git checkout master
git pull

for mr in `echo $N`; do

    echo ">> $mr"

    git checkout "pr${mr}" || \
        git fetch origin "refs/merge-requests/$mr/head:pr$mr"

    git checkout "pr${mr}"

    git rebase origin/master

    gits

    echo
done

git checkout master

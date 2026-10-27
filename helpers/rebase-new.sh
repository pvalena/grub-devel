#!/usr/bin/env zsh

set -xe
zsh -n "$0"

[[ "$(basename "$PWD")" == 'grub' ]] || cd grub

N="$(grep -E '^[0-9]*$' ../data/new.txt)"

[[ -n "$N" ]]

git checkout master

echo "$N" \
  | xargs -ri zsh -c "
        echo; echo -e '\n>>> {}'; set -x

        git checkout 'pr{}' || exit 255

        git rebase origin/master || {
            echo 'ERROR: git rebase failed for pr{}' >&2
            git rebase --abort
        }
    "

git checkout master

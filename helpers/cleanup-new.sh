#!/usr/bin/env zsh

set -e

zsh -n "$0"

[[ "$(basename "$PWD")" == 'grub' ]] || cd grub

git checkout master &>/dev/null

git branch | grep -E '^\s*pr[0-9]*$' | xargs -rn1 git branch -D

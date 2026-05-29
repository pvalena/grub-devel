#!/usr/bin/env zsh

set -xe

zsh -n "$0"

[[ "$(basename "$PWD")" == 'grub' ]] || cd grub

gitc master

gitb | grep -E '^\s*pr[0-9]*$' | xargs -rn1 git branch -D

#!/usr/bin/env zsh

set -xe

zsh -n "$0"

[[ "$1" == "--yes-really-remove-everything" ]]

[[ "$(basename "$PWD")" == 'grub' ]] || cd grub

rm ../logs/*.log ||:

gitc master

gitb | grep -E '^\s*202'|xargs -i zsh -c "echo '>{}<'; gitb -D '{}'"

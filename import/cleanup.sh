#!/usr/bin/env zsh

set -xe

zsh -n "$0"

[[ "$1" == "--yes-really-remove-everything" ]]

[[ "$(basename "$PWD")" == 'grub' ]] || cd grub

rm ../logs/202*.log ||:

gitc master

gitb | grep -E '^\s*202' | xargs -i zsh -c "echo '>{}<'; gitb -D '{}'"

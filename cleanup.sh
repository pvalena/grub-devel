#!/usr/bin/env zsh

set -xe

zsh -n "$0"

rm logs/*.log ||:

cd grub

gitc master

gitb | grep -E '^\s*202'|xargs -i zsh -c "echo '>{}<'; gitb -D '{}'"

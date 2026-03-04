#!/usr/bin/env zsh

set -xe

zsh -n "$0"

[[ -r duplicates.txt ]]

cd grub

gitc master

cat ../duplicates.txt | xargs -i zsh -c "echo; echo '>{}<'; gitb -D '{}'"

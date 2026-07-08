#!/usr/bin/env zsh

set -xe

zsh -n "$0"

[[ "$(basename "$PWD")" == 'grub' ]] || cd grub

rm ../logs/202*.log ||:

gitc master

cat ../import/failed.txt | xargs -i zsh -c "echo '>{}<'; gitb -D '{}'"

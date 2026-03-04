#!/usr/bin/env zsh

set -xe

zsh -n "$0"

cd grub

gitc master

gitb | grep -E '^\s*202' | xargs -i zsh -c "echo; echo '>{}<'; gitc '{}' && gituu"

gitc master

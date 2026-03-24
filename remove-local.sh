#!/usr/bin/env zsh

# Run remove-remote.sh first!

set -xe

zsh -n "$0"

[[ "$(basename "$PWD")" == 'grub' ]] || cd grub

gitc master


[[ -r ../duplicates.txt ]]

cat ../duplicates.txt | xargs -i zsh -c "echo; echo '>{}<'; gitb -D '{}-duplicate'"


[[ -r ../skip.txt ]]

cat ../skip.txt | xargs -i zsh -c "echo; echo '>{}<'; gitb -D '{}-skip'"

#!/usr/bin/env zsh

set -xe

zsh -n "$0"

[[ "$(basename "$PWD")" == 'grub' ]] || cd grub

F='../import/failed.txt'

[[ -r "$F" ]]

cat "$F" \
    | grep -E '^\s*202' | grep -vE '\-(duplicate|skip)$' \
    | xargs -i zsh -c "echo; echo '>{}<'; gitc '{}' && gituu; sleep 0.01"

gitc master

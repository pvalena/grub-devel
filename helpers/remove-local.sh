#!/usr/bin/env zsh

# Run remove-remote.sh first!

set -xe

zsh -n "$0"

[[ "$(basename "$PWD")" == 'grub' ]] || cd grub

gitc master


[[ -r ../duplicates.txt ]]

cat ../duplicates.txt | xargs -i zsh -c "echo -n '> {} '; gitb -D '{}-duplicate'"

echo

[[ -r ../skip.txt ]]

cat ../skip.txt | xargs -i zsh -c "echo -n '> {} '; gitb -D '{}-skip'"

echo

[[ -r ../closed.txt ]]

C="$(cat ../closed.txt| xargs -ri echo -n "{}|")0"

grep -E "\|($C)$" ../data/mrs.txt | cut -d'|' -f1 | xargs -i zsh -c "echo -n '> {} '; gitb -D '{}'"

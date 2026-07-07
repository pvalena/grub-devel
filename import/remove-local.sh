#!/usr/bin/env zsh

# Run import/remove-remote.sh first!

set -xe

zsh -n "$0"

[[ "$(basename "$PWD")" == 'grub' ]] || cd grub

gitc master


[[ -r ../import/duplicates.txt ]]

cat ../import/duplicates.txt | xargs -i zsh -c "echo -n '> {} '; gitb -D '{}-duplicate'"


[[ -r ../import/duplicates_new.txt ]]

cat ../import/duplicates_new.txt | xargs -i zsh -c "echo -n '> {} '; gitb -D '{}-duplicate'"

echo

[[ -r ../import/skip.txt ]]

cat ../import/skip.txt | xargs -i zsh -c "echo -n '> {} '; gitb -D '{}-skip'"

echo

[[ -r ../import/skip_new.txt ]]

cat ../import/skip_new.txt | xargs -i zsh -c "echo -n '> {} '; gitb -D '{}-skip'"

echo

[[ -r ../data/closed.txt ]]

C="$(cat ../data/closed.txt| xargs -ri echo -n "{}|")0"

grep -E "\|($C)$" ../data/mrs.txt | cut -d'|' -f1 | xargs -i zsh -c "echo -n '> {} '; gitb -D '{}'"

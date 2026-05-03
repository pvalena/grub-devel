#!/usr/bin/env zsh

set -e

zsh -n "$0"

grep -r "$@" | grep -v '^history/' | grep -v '^grub/' | grep -vE '^import/20[0-9][0-9]-'

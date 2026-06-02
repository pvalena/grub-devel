#!/usr/bin/zsh

set -e

zsh -n "$0"

[[ "$1" == '-c' ]] && clear

while ./helpers/mr-new.sh; do sleep 10m; done

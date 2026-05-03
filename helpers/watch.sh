#!/usr/bin/zsh

set -e

zsh -n "$0"

while ./helpers/mr-new.sh; do sleep 1h; done

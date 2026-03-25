#!/usr/bin/env zsh

set -xe

zsh -n "$0"

while [[ -n "$1" ]]; do

    M="$1"
    shift ||:

    D="${M}-d"

    [[ -d "$D" ]] || {

        curl -s "https://lists.gnu.org/archive/mbox/grub-devel/$M"

        mkdir -p "$D"
        git mailsplit "-o${M}-d" -- "${M}"
    }

    ./commit.sh "$D" || echo 'commit: $M' >> fail.log
done

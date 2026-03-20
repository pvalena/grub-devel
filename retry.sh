#!/usr/bin/env zsh

set -xe

zsh -n "$0"

[[ "$(basename "$PWD")" == 'grub' ]] || cd grub

[[ -r ../missing.txt ]]

cat ../missing.txt \
| while read B; do
    shift||:

    [[ -n "$B" ]]

    #echo ">>$B<<"
    d="$(cut -d'-' -f1-2)"
    n="$(cut -d'-' -f3)"

    [[ -n "$d" ]]
    [[ -n "$n" ]]

    exit 2

    D="../${d}-d/"

    [[ -d "$D" ]]

    git am -3 "${D}${n}"

    echo "$B" >> ../skip.txt
done

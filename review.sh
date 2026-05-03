#!/usr/bin/env zsh

set -e

zsh -n "$0"

[[ "$1" == '-n' ]] && { DRY=y; shift||: ; } || DRY=

[[ "$(basename "$PWD")" == 'grub' ]] || cd grub

R='../reviews/'
[[ -d "$R" ]]

for F in $(ls -d "${R}"*.md); do

    [[ -r "$F" ]]

    b="$(cut -d'/' -f3 <<< "$F" | cut -d'.' -f1)"
    m="$(head -n 1 "$F" | grep '^# AI Review: MR' | cut -d'!' -f2 | cut -d' ' -f1)"

    [[ -n "$b" ]]
    [[ -n "$m" ]]

    grep -qE "^${m}$" '../done.txt' && continue

    echo -e "\n\n>>> $b: $m\n"

#    grep -qE "^${b}|${m}$" ../data/mrs.txt

    C="$(cat "$F")"
    [[ -n "$C" ]]

    echo "$C"
    echo

    [[ -n "$DRY" ]] && continue

    glab mr comment "${m}" --repo gnu-grub/grub -m "${C}"

    echo "$m" >> '../done.txt'

    sleep 5
done

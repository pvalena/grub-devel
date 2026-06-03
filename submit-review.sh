#!/usr/bin/env zsh

set -e

zsh -n "$0"

[[ "$1" == '-d' ]] && { DEBUG="$1"; set -x; shift||: ; } || DEBUG=
[[ "$1" == '-n' ]] && { DRY="$1"; shift||: ; } || DRY=
[[ "$1" == '-v' ]] && { V="$1"; shift||: ; } || V="$DRY"

[[ -z "$1" ]]

[[ "$(basename "$PWD")" == 'grub' ]] || cd grub

R='../reviews/'
[[ -d "$R" ]]

D='../data/done.txt'
[[ -r "$D" ]]

N='../data/new.txt'
[[ -r "$N" && -n "$(cat "$N")" ]] && {

    # TODO: unify implementations / wrap in some method

    for m in $(cat $N); do

        [[ -n "$m" ]]
        b="pr${m}"

        F="${R}${b}.md"
        [[ -r "$F" ]]

        [[ "$m" == "$(head -n 1 "$F" | grep '^# AI Review: MR' | cut -d'!' -f2 | cut -d' ' -f1)" ]]

        grep -qE "^${m}$" "$D" && continue

        echo -e "\n\n>>> $b: $m\n"

        C="$(cat "$F")"
        [[ -n "$C" ]]

        [[ -n "$V" ]] && echo "$C" && echo

        [[ -n "$DRY" ]] && continue

        glab mr note create "${m}" --repo gnu-grub/grub -m "${C}"

        glab mr update "${m}" --repo gnu-grub/grub -u Pending-AI-Review

        echo "$m" >> "$D"

        Z="$(grep -vE "^${m}$" "$N" | grep -v ^$ | sort -n)"

        [[ -z "$Z" || "$Z" == "${m}" ]] && rm "$N" || echo "$Z" > "$N"

        sleep 5
    done

    exit
}

# LEGACY: Let's just go through all of them
exit 7

for F in $(ls -d "${R}"*.md); do

    [[ -r "$F" ]]

    b="$(cut -d'/' -f3 <<< "$F" | cut -d'.' -f1)"
    m="$(head -n 1 "$F" | grep '^# AI Review: MR' | cut -d'!' -f2 | cut -d' ' -f1)"

    [[ -n "$b" ]]
    [[ -n "$m" ]]

    grep -qE "^${m}$" "$D" && continue

    echo -e "\n\n>>> $b: $m\n"

#    grep -qE "^${b}|${m}$" ../data/mrs.txt

    C="$(cat "$F")"
    [[ -n "$C" ]]

    echo "$C"
    echo

    [[ -n "$DRY" ]] && continue

    glab mr comment "${m}" --repo gnu-grub/grub -m "${C}"

    echo "$m" >> "$D"

    sleep 5
done

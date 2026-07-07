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
read_new () {
    grep -vE "^${1}$" "$N" | grep -v "^\s*$" | sort -n
}

[[ -r "$N" && -n "$(cat "$N")" ]] && {

    # TODO: refactor

    for m in $(cat $N); do

        [[ -n "$m" ]]
        b="pr${m}"

        F="${R}${b}.md"
        [[ -r "$F" ]]

        # sanity checks

            [[ "$m" == "$(head -n 1 "$F" | grep '^# AI Review: MR' | cut -d'!' -f2 | cut -d' ' -f1)" ]]

            grep -qE "^${m}$" "$D" && continue

            echo -e "\n\n>>> $b: $m\n"

            C="$(cat "$F")"
            [[ -n "$C" ]]

        [[ -n "$V" ]] && echo "$C" && echo

        [[ -n "$DRY" ]] && continue

        # submit comment

            glab mr note create "${m}" --repo gnu-grub/grub -m "${C}"

            glab mr update "${m}" --repo gnu-grub/grub -u Pending-AI-Review

            echo "$m" >> "$D"

        # update data/new.txt file

            Z="$(read_new "^${m}$")"

            echo "$Z" > "$N"

            Z="$(read_new "^\s*$")"

            [[ -z "$Z" || "$(wc -l <<< "$Z")" -eq 0 || "${Z}" == "${m}" ]] && rm "$N"

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

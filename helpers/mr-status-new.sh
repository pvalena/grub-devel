#!/usr/bin/zsh

set -e

zsh -n "$0"

[[ "$(basename "$PWD")" == 'grub' ]] || cd grub

F="../data/closed.txt"
N='../data/new.txt'

M="$(cat "$N")" ||:

[[ -n "$M" ]]

for m in `echo $M`; do

    [[ -n "${m}" && ${m} -ge 0 ]]

    s="$(glab mr view ${m} --repo gnu-grub/grub 2>/dev/null | grep '^state:' | tr -s '\t' ' ' | cut -d' ' -f2)"

    echo ">>> ${m}: $s"

    case ${s} in
        open)
            # noop
            ;;

        merged|closed)
            Z="$(grep -vE "^${m}$" "$N" | grep -v ^$ | sort -n)"

            [[ -z "$Z" || "$Z" == "${m}" ]] \
                && rm "$N" \
                || echo "$Z" > "$N"

            echo "${m}" >> "$F"
            ;;

        *)
            echo "=> IDK">&2
            exit 2;;

    esac

    sleep 0.5
done

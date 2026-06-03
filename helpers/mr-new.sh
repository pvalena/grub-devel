#!/usr/bin/zsh

set -e

zsh -n "$0"

[[ "$(basename "$PWD")" == 'grub' ]] || cd grub

D='../data/done.txt'
F='../data/closed.txt'
N='../data/new.txt'

M="$(glab mr list --repo gnu-grub/grub -l Pending-AI-Review | tr -s '\t' ' ' | grep '^!' | cut -d' ' -f1 | cut -d'!' -f2 | grep -v '^$')" ||:

[[ -n "$M" ]] || exit


for mr in `echo ${M}` ; do

    s="$(glab mr view $mr --repo gnu-grub/grub 2>/dev/null | grep '^state:' | tr -s '\t' ' ' | cut -d' ' -f2)"

    [[ -z "$s" ]] && s='' || \
        echo ">>> $mr: $s"

    case $s in
        open)
            grep -q "^${mr}$" "$N" || echo "$mr" >> "$N"

            grep -q "^${mr}$" "$D" && {

                Z="$(grep -v "^${mr}$" "$D")"

                echo "$Z" > "$D"

            } ||:
            ;;

        merged|closed)
            echo "$mr" >> "$F"
            ;;

        '')
            exit
            ;;

        *)
            echo "=> IDK">&2
            exit 2;;

    esac

    sleep 0.5
done

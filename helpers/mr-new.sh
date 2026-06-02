#!/usr/bin/zsh

set -e

zsh -n "$0"

[[ "$(basename "$PWD")" == 'grub' ]] || cd grub

D='../data/done.txt'
F='../data/closed.txt'
N='../data/new.txt'

mr="$(cat "$D" "$F" "$N" 2>/dev/null|sort -n|grep -v ^$|tail -n 1)" ||:

[[ -n "$mr" ]] || M=0

p="$(glab mr list --repo gnu-grub/grub -l Pending-AI-Review | grep -v '^No open merge requests match your search in ' | grep -v '^$')" ||:

[[ -n "$p" ]] && echo ">>$p<<"

while [[ ${mr} -ge 0 ]]; do

    mr=$(($mr+1))

    s="$(glab mr view $mr --repo gnu-grub/grub 2>/dev/null | grep '^state:' | tr -s '\t' ' ' | cut -d' ' -f2)"

    [[ -z "$s" ]] && s='' || \
        echo ">>> $mr: $s"

    case $s in
        open)
            echo "$mr" >> "$N"
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

echo "ERROR: mr|$mr OOB">&2
exit 3

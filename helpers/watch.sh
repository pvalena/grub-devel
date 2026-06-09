#!/usr/bin/zsh

set -e

zsh -n "$0"

D='../data/done.txt'
F='../data/closed.txt'
N='../data/new.txt'
L='logs/watch.log'

srlz () {
    local i="$(cut -d' ' -f2 | cut -d':' -f1 | xargs -ri echo -n "|{}")"

    echo "${1}${i}" \
        | sed -e 's/^|//'

}

[[ "$1" == '-d' ]] && { DEB="$1"; set -x; shift||: } || DEB=

[[ "$1" == '-l' ]] && {

    [[ -r "$L" ]] && I="$(cat "$L" | srlz)" || I=

    clear
    while :; do

        Z="$($0 $DEB | grep -vE "^>>> ($I): ")" ||:

        [[ -n "$Z" ]] && {

            echo "$Z" | tee -a "$L"

            I="$(echo "$Z" | srlz "$I")"
        }

        sleep 1h
    done

    exit 3
}

[[ "$(basename "$PWD")" == 'grub' ]] || cd grub


# MAIN
mr="$(cat "$D" "$F" "$N" 2>/dev/null|sort -n|grep -v ^$|tail -n 1)" ||:

[[ -n "$mr" ]] || M=0

while [[ ${mr} -ge 0 ]]; do

    mr=$(($mr+1))

    s="$(glab mr view $mr --repo gnu-grub/grub 2>/dev/null | grep '^state:' | tr -s '\t' ' ' | cut -d' ' -f2)"

    [[ -z "$s" ]] && s='' || \
        echo ">>> $mr: $s"

    case $s in
        open)
            # Do not write New -- obsoleted by mr-new.sh (watching for labels)
#            echo "$mr" >> "$N"
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

#!/usr/bin/zsh

set -e

zsh -n "$0"


## GLOBALs
W='10m'

D='../data/done.txt'
F='../data/closed.txt'
N='../data/new.txt'
L='logs/new.log'

B='Pending-AI-Review'

# Authorised users
A=

# glab args
G="--repo gnu-grub/grub"

## METHODS
srlz () {
    local i="$(cut -d' ' -f2 | cut -d':' -f1 | xargs -ri echo -n "|{}")"

    echo "${1}${i}" \
        | sed -e 's/^|//'
}

rglab () {

    (

        [[ -n "$DEB" ]] && set -x

        glab `echo ${G}` "$@"

    )
}


## ARGS
[[ "$1" == '-d' ]] && { DEB="$1"; shift||: } || DEB=

[[ "$1" == '-l' ]] && {

    [[ -r "$L" ]] && I="$(cat "$L" | srlz)" || I=

    clear
    while :; do

        Z="$($0 $DEB | grep -vE "^>>> ($I): ")" ||:

        [[ -n "$Z" ]] && {

            echo "$Z" | tee -a "$L"

            I="$(echo "$Z" | srlz "$I")"
        }

        sleep "$W"
    done

    exit 3
}

[[ "$(basename "$PWD")" == 'grub' ]] || cd grub


## MAIN
M="$(rglab mr list -l ${B} 2>&1 | tr -s '\t' ' ' | grep '^!' | cut -d' ' -f1 | cut -d'!' -f2 | grep -v '^$')" ||:

[[ -n "$M" ]] || {
    # Additional users

    ### TODO: check for open MRs without any AI-labels

    exit 73

    O="$()"

    for mr in `echo ${O}` ; do

        u="$(rglab api "projects/:id/merge_requests/$mr" --jq '.author.username')"

        echo "$A" | grep -E "^${u}$" && echo ">>>FOUND: $u"

        echo
    done

    exit 0
}

A="$(rglab api 'projects/:id/members/all?per_page=10000' \
        | jq -r '.[] | select(.access_level >= 30 and .state == "active" and .locked == false) | .username')"
[[ -n "$A" ]] || exit 4

for mr in `echo ${M}` ; do

    s="$(rglab mr view $mr 2>/dev/null | grep '^state:' | tr -s '\t' ' ' | cut -d' ' -f2)"

    # Check for label-setter
    u="$(rglab api "projects/:id/merge_requests/${mr}/resource_label_events" \
        | jq -r ".[] | select(.action==\"add\" and .label.name==\"${B}\") | .user.username")"

    echo "u: $u"

    [[ -n "$u" ]]
    echo "$A" | grep -qE "^${u}$" || exit 5

    [[ -z "$s" ]] && s='' || \
        echo ">>> $mr: $s"

    case $s in
        open)
            grep -q "^${mr}$" "$N" 2>/dev/null || echo "$mr" >> "$N"

            grep -q "^${mr}$" "$D" && {

                Z="$(grep -v "^${mr}$" "$D")"

                echo "$Z" > "$D"

            } ||:
            ;;

        merged|closed)
            echo "$mr" >> "$F"
            ;;

        '')
            exit 1
            ;;

        *)
            echo "=> IDK">&2
            exit 2;;

    esac

    sleep 0.5
done

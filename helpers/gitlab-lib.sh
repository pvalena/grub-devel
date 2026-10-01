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
BN='AI-Reviewed-No-Issues'
BF='AI-Reviewed-Found-Issues'

R='../reviews/'

# Authorised users
A=

# glab args
GA="--repo gnu-grub/grub"

## METHODS
srlz () {
    local i="$(cut -d' ' -f2 | cut -d':' -f1 | xargs -ri echo -n "|{}")"

    echo "${1}${i}" \
        | sed -e 's/^|//'
}

rglab () {

    (

        deb

        glab `echo ${GA}` "$@"

    )
}

fail () {
    echo -n "FAIL($(basename "$0")): "
    echo "$@"

    exit 2
}

read_new () {
    grep -vE "^${1}$" "$N" | grep -v "^\s*$" | sort -n
}

deb () {
    [[ -n "$DEB" ]] && set -x ||:
}

wip () {

    fail "WIP" "$@"
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

[[ '--' == "$1" ]] && shift


## Default dir
[[ "$(basename "$PWD")" == 'grub' ]] || cd grub


## Sanity checks
(
    deb
    [[ -d "$R" ]] || fail "$R missing"
    [[ -r "$D" ]] || fail "$D missing"
)

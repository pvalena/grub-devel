#!/usr/bin/env zsh

set -e

zsh -n "$0"


## FUNC
con () {
    [[ "$1" == '-s' && -n "$SKI" ]] || {

        [[ "$1" == '-s' ]] && shift ||:

        local s

        [[ -n "$1" ]] && s="$1" || s='Continue'

        read -q "?--> $s (y/N)? " || exit 2
    }

    echo ; echo
}

run () {
    local m
    m="$@"
    echo "> ${m}"

    m="${PRE}${DEBUG}$m"

    zsh -n -c "$m"

    [[ -z "$DRY" ]] && zsh -c "$m"
    echo

    con -s
}

# Get numbers of reviews (inlined) from the staged files in reviews/
reviews () {
    git diff --stat HEAD -- reviews/*.md \
        | cut '-d ' -f2 \
        | grep ^reviews/ \
        | cut -d'/' -f2 |cut -d'.' -f1 \
        | grep ^pr | cut -c3- \
        | xargs -ri echo -n "{} "

    echo
}


## OPTS
[[ "${1}" == '-c' ]] && { CON="${1}"; shift||:; } || CON=
[[ "${1}" == '-d' ]] && { DEBUG="echo "; set -x; shift||:; } || DEBUG=
[[ "${1}" == '-l' ]] && { LOP="${1}"; shift||:; } || LOP=
[[ "${1}" == '-n' ]] && { DRY="${1}"; shift||:; } || DRY=
[[ "${1}" == '-s' ]] && { SKI="${1}"; shift||:; } || SKI=
[[ "${1}" == '-v' || -n "${DRY}${DEBUG}" ]] && { V='set -x; '; } || V=
[[ "${1}" == '-v' ]] && { shift||:; }
[[ "${1}" == '-w' ]] && { W="$2"; shift 2||:; } || W=

[[ -z "${1}" ]]

# Defaults
[[ -n "${V}" ]] && { PRE="$V"; V="-v"; } || PRE=
[[ -n "${W}" ]] || W='1h'


## INIT
cd "$(dirname "$0")"

echo

H='helpers/'
[[ -d "${H}" ]]


## MAIN
F=y
while :; do

    [[ -z "$F" ]] && {

        # Default path
        [[ -z "$LOP" ]] && break

        run "sleep $W"

        con 'Again'
    }
    F=

    [[ -z "${CON}" ]] && {

        run "${H}mr-new.sh"

        # Fails on no new MRs
        run "${H}mr-status-new.sh" || continue

        run "${H}checkout-new.sh"

        run "${H}rebase-new.sh"

        run "${H}view-new.sh"

        echo -e "\n>>> TODO: Run some Magic AI review here (e.g.: 'claude ...')\n" >&2

        ## WIP ##
        [[ -z "$LOP" ]] || [[ "$W" != '0' ]] || {

            echo "!!! NYI !!!" >&2
            exit 3
        }

    } || CON=

    con "Is the AI review done"

    run "./submit-review.sh -n ${V}"

    con "Really submit the reviews"

    run "./submit-review.sh ${V}"


    # Let's handle git as well (not tested)

    run "git add reviews/*.(md|txt)"

    R="$(reviews)"

    [[ -n "$R" && "$R" != ' ' ]]

    run "git commit -am 'Add review(s): $R'"

    git show

    con "Push the reviews to git"

    run "git push"

    run "${H}cleanup-new.sh"
done

echo '=> DONE'

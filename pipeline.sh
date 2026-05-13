#!/usr/bin/env zsh

set -e

zsh -n "$0"

con () {
    local s
    [[ -n "$1" ]] && s="$1" || s='Continue'

    read -q "?--> $s (y/N)? " || exit 2

    echo ; echo
}

run () {
    local m
    m="$@"
    echo "> ${m}"

    m="${V}${DEBUG}$m"

    zsh -n -c "$m"

    [[ -z "$DRY" ]] && zsh -c "$m"
    echo

    con
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

[[ "${1}" == '-d' ]] && { DEBUG="echo "; set -x; shift||:; } || DEBUG=
[[ "${1}" == '-n' ]] && { DRY="${1}"; shift||:; } || DRY=
[[ "${1}" == '-v' || -n "${DRY}${DEBUG}" ]] && { V='set -x; '; } || V=
[[ "${1}" == '-v' ]] && { shift||:; }

# For later if we want to run it in a loop or something
[[ "${1}" == '-w' ]] && { W="$2"; shift 2||:; } || W=0

[[ -z "${1}" ]]

cd "$(dirname "$0")"

echo

H='helpers/'

[[ -d "${H}" ]]

# Expects new MRs are present in new.txt; see helpers/watch.sh

run "${H}checkout-new.sh"

run "${H}view-new.sh"

echo -e "\n>>> TODO: Run some Magic AI review here (e.g.: 'claude ...')" >&2

con "Is the AI review done"

run "./submit-review.sh -n"

con "Really submit the reviews"

run "./submit-review.sh"


# Let's handle git as well (not tested)

run "git add reviews/*.(md|txt)"

R="$(reviews)"

[[ -n "$R" && "$R" != ' ' ]]

run "git commit -am 'Add review(s): $R'"

git show

con "Push the reviews to git"

git push

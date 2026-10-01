#!/usr/bin/zsh

set -e

zsh -n "$0"

my="$(dirname "$(readlink -f "$0")")"
[[ -d "$my" ]]

L="${my}/gitlab-lib.sh"
[[ -r "$L" ]]
 . "$L"

## MAIN
M="$(rglab mr list -l ${B} 2>&1 | tr -s '\t' ' ' | grep '^!' | cut -d' ' -f1 | cut -d'!' -f2 | grep -v '^$')" ||:

[[ -n "$M" ]] || {
    # Additional users

    ### TODO: check for open MRs without any AI-labels

    wip 'TODO: Additional users'

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
            exit 3
            ;;

        *)
            echo "=> IDK">&2
            exit 2;;

    esac

    sleep 0.5
done

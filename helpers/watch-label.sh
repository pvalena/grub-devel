#!/usr/bin/zsh

set -e

zsh -n "$0"

W='10m'

D='../data/done.txt'
F='../data/closed.txt'
N='../data/new.txt'
L='logs/new.log'

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

        sleep "$W"
    done

    exit 3
}

[[ "$(basename "$PWD")" == 'grub' ]] || cd grub


# MAIN
M="$(glab mr list --repo gnu-grub/grub -l Pending-AI-Review 2>&1 | tr -s '\t' ' ' | grep '^!' | cut -d' ' -f1 | cut -d'!' -f2 | grep -v '^$')" ||:

[[ -n "$M" ]] || exit 0


for mr in `echo ${M}` ; do

    s="$(glab mr view $mr --repo gnu-grub/grub 2>/dev/null | grep '^state:' | tr -s '\t' ' ' | cut -d' ' -f2)"

    [[ -z "$s" ]] && s='' || \
        echo ">>> $mr: $s"

    case $s in
        open)
            ## we need to check who set the flag

            ### Devel+ users:

            #  glab --repo gnu-grub/grub api "projects/:id/members/all?per_page=100" \
            #    | jq -r '.[] | select(.access_level >= 30 and .state == "active" and .locked == false) | .username'

            ## user:

            #  glab --repo gnu-grub/grub api "projects/:id/merge_requests/172/resource_label_events" \
            #    | jq '.[] | select(.label.name == "Pending-AI-Review") | {action, username: .user.username, created_at}'

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

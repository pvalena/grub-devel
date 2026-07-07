#!/usr/bin/env zsh

set -xe

zsh -n "$0"

[[ "$(basename "$PWD")" == 'import' ]] || cd import

F=failed.txt
FF=failed_subj.txt

[[ -r "$F" ]]
[[ -r "$FF" ]]

[[ -d "../logs/" ]]
[[ -d "../grub/" ]]

G=../logs/fail.log
touch "$G"

B="$(git -C ../grub/ branch | grep -E '^\s*202' | tr -s '\t' ' ' | cut -d' ' -f2)"

for c in $(cat "$F"); do

    grep -qE "^${c}: " "$FF" || { echo "FAIL: invalid branch '${c}'" | tee -a "$G" >&2; exit 4; }
    grep -qE "^${c}$" <<< "$B" && continue

    { echo -e "\n>>> $c <<<"; } 2>/dev/null

    d="$(cut -d'-' -f-2 <<<"$c")"
    z="$(cut -d'-' -f3- <<<"$c")"

    [[ -d "${d}-d/" ]] || { echo "FAIL: source directory missing: '${d}-d'" | tee -a "$G" >&2; exit 3; }

    z="${d}-d/$z"
    z="$(readlink -e "$z")"
    [[ -r "$z" ]] || { echo "FAIL: source file missing: '${z}'" | tee -a "$G" >&2; continue }

    m="
        set -x; cd ../grub || exit; gitc master || exit

        git am --abort &>/dev/null

        gitcb '$c' || exit

        git am -3 '$z' && echo SUCCESS || {

#            echo 'RECOVERING: $c' | tee -a ../logs/commit-new.log

            git am --show-current-patch=diff > FAILED.patch
            git add -A .
            git am --continue

        }; gitc master &>/dev/null
    "

    zsh -n -c "$m" || { echo "FAIL: syntax fail: $m" | tee -a "$G" >&2; exit 2; }

    l="../logs/${c}.log"
    echo -e "\n$(date -Isec)" >> "$l"
    l="$(readlink -e "$l")"

    zsh -c "$m" 2>&1 | tee -a "$l"
done

cd ../grub && gitc master

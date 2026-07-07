#!/usr/bin/env zsh

set -e

zsh -n "$0"

[[ "$(basename "$PWD")" == 'import' ]] || cd import

cat failed_subj.txt | while read z; do

    n="$(cut -d':' -f1 <<<"$z")"
    grep -qE "^${n}$" skip.txt && continue
    grep -qE "^${n}$" skip_new.txt && continue
    grep -qE "^${n}$" duplicates.txt && continue
    grep -qE "^${n}$" duplicates_new.txt && continue

    echo "$z"

done | tee failed_subj_filtered.txt


mv -f failed_subj{_filtered,}.txt

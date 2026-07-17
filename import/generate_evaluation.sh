#!/bin/bash
# Usage: ./generate_evaluation.sh <branch> [branch2] ...
# Generates a comprehensive evaluation file for each KEEP branch.

set -uo pipefail

[[ $# -ge 1 ]] || { echo "Usage: $0 <branch> [branch2] ..."; exit 1; }

DIR="$(dirname "$0")"
GRUB="${DIR}/../grub"

for B in "$@"; do
OUT="${DIR}/evaluation/${B}.txt"

ml_subj=$(grep "^${B}: " "$DIR/failed_subj.txt" | sed 's/^[^:]*: //')
author=$(git -C "$GRUB" show --no-patch --format='%an <%ae>' "$B" 2>/dev/null)
date=$(git -C "$GRUB" show --no-patch --format='%ai' "$B" 2>/dev/null | head -c10)
commit_subj=$(git -C "$GRUB" show --no-patch --format='%s' "$B" 2>/dev/null)
commit_body=$(git -C "$GRUB" show --no-patch --format='%b' "$B" 2>/dev/null)

fp=$(git -C "$GRUB" show --stat --format='' "$B" 2>/dev/null | grep -c FAILED || true)
code=$(git -C "$GRUB" show --stat --format='' "$B" 2>/dev/null | grep -v FAILED | grep -c '|' || true)

# Series membership
series_file=""
for sf in "$DIR"/series/*; do
    if grep -qx "$B" "$sf" 2>/dev/null; then
        series_file=$(basename "$sf")
        break
    fi
done

{
    echo "================================================================================"
    echo "EVALUATION: $B"
    echo "================================================================================"
    echo ""
    echo "Mailing list subject: $ml_subj"
    echo "Commit subject:       $commit_subj"
    echo "Author:               $author"
    echo "Date:                 $date"
    echo "Has FAILED.patch:     $fp"
    echo "Code files changed:   $code"
    if [ -n "$series_file" ]; then
        echo "Series:               $series_file ($(wc -l < "$DIR/series/$series_file") members)"
    else
        echo "Series:               standalone"
    fi
    echo ""
    echo "--------------------------------------------------------------------------------"
    echo "COMMIT MESSAGE"
    echo "--------------------------------------------------------------------------------"
    echo ""
    echo "$commit_body"
    echo ""
    echo "--------------------------------------------------------------------------------"
    echo "FILES CHANGED (commit stat)"
    echo "--------------------------------------------------------------------------------"
    echo ""
    git -C "$GRUB" show --stat --format='' "$B" 2>/dev/null
    echo ""
    echo "--------------------------------------------------------------------------------"
    echo "FAILED.patch (the intended change)"
    echo "--------------------------------------------------------------------------------"
    echo ""
    git -C "$GRUB" show "${B}:FAILED.patch" 2>/dev/null || echo "(no FAILED.patch)"
    echo ""
    if [ "$code" -gt 0 ]; then
        echo "--------------------------------------------------------------------------------"
        echo "CODE CHANGES IN COMMIT (conflict resolution artifacts)"
        echo "--------------------------------------------------------------------------------"
        echo ""
        git -C "$GRUB" show "$B" -- ':(exclude)FAILED.patch' 2>/dev/null
        echo ""
    fi
    echo "--------------------------------------------------------------------------------"
    echo "MASTER CONTEXT (current state of affected files)"
    echo "--------------------------------------------------------------------------------"
    echo ""
    # For each file in FAILED.patch, show relevant context on master
    files=$(git -C "$GRUB" show "${B}:FAILED.patch" 2>/dev/null \
        | grep '^diff --git' | sed 's|diff --git a/||;s| b/.*||')
    for f in $files; do
        exists=$(git -C "$GRUB" show "master:$f" 2>/dev/null | wc -l)
        if [ "$exists" -gt 0 ]; then
            echo "  $f: EXISTS (${exists} lines)"
        else
            echo "  $f: MISSING on master"
        fi
    done
    echo ""
    echo "--------------------------------------------------------------------------------"
    echo "ASSESSMENT"
    echo "--------------------------------------------------------------------------------"
    echo ""
    # Determine assessment based on what we know
    has_missing=$(git -C "$GRUB" show "${B}:FAILED.patch" 2>/dev/null \
        | grep '^diff --git' | sed 's|diff --git a/||;s| b/.*||' \
        | while read tf; do
            git -C "$GRUB" show "master:$tf" 2>/dev/null | wc -l | grep -q '^0$' && echo "yes"
          done | head -1)
    if [ "${has_missing:-no}" = "yes" ]; then
        echo "Type:       NEW FEATURE (target files missing on master)"
    else
        echo "Type:       ENHANCEMENT / FIX (modifies existing files)"
    fi
    echo "Complexity: $code code file(s) + FAILED.patch"

    # Count lines added/removed in FAILED.patch
    added=$(git -C "$GRUB" show "${B}:FAILED.patch" 2>/dev/null | grep -c '^+' || echo 0)
    removed=$(git -C "$GRUB" show "${B}:FAILED.patch" 2>/dev/null | grep -c '^-' || echo 0)
    echo "Patch size: +$added -$removed lines"
    echo ""
    echo "================================================================================"

} > "$OUT"

echo "Written: $OUT ($(wc -l < "$OUT") lines)"
done

#!/bin/bash
# Usage: ./inspect1.sh <branch>
# Shows all data needed to decide keep/drop for a single branch.

set -euo pipefail

B="${1:?Usage: $0 <branch>}"
DIR="$(dirname "$0")"
GRUB="${DIR}/../grub"

subj=$(grep "^${B}: " "$DIR/failed_subj.txt" | sed 's/^[^:]*: //' | head -c120)
author=$(git -C "$GRUB" show --no-patch --format='%an' "$B" 2>/dev/null)
date=$(git -C "$GRUB" show --no-patch --format='%ai' "$B" 2>/dev/null | head -c10)
fp=$(git -C "$GRUB" show --stat --format='' "$B" 2>/dev/null | grep -c FAILED || true)
code=$(git -C "$GRUB" show --stat --format='' "$B" 2>/dev/null | grep -v FAILED | grep -c '|' || true)

echo "=== $B | $author | $date | fp=$fp code=$code ==="
echo "  $subj"
echo ""

# FAILED.patch targets
files=$(git -C "$GRUB" show "${B}:FAILED.patch" 2>/dev/null \
    | grep '^diff --git' | sed 's|diff --git a/||;s| b/.*||' | tr '\n' ' ')
if [[ -n "$files" ]]; then
    echo "FAILED.patch targets: $files"
fi

# Code file targets (non-FAILED.patch)
codefiles=$(git -C "$GRUB" show --stat --format='' "$B" 2>/dev/null \
    | grep '|' | grep -v FAILED | sed 's/ *|.*//' | tr -s ' ' | sed 's/^ //' | tr '\n' ' ')
if [[ -n "$codefiles" ]]; then
    echo "Code files: $codefiles"
fi

echo ""
echo "--- FAILED.patch diff summary ---"
git -C "$GRUB" show "${B}:FAILED.patch" 2>/dev/null \
    | grep '^[+-]' | grep -v '^[+-][+-]' | head -20

echo ""
echo "--- Master check ---"
allfiles=$(git -C "$GRUB" show "${B}:FAILED.patch" 2>/dev/null \
    | grep '^diff --git' | sed 's|diff --git a/||;s| b/.*||')
for f in $allfiles; do
    lines=$(git -C "$GRUB" show "master:$f" 2>/dev/null | wc -l)
    if [[ "$lines" -gt 0 ]]; then
        echo "  EXISTS ($lines L): $f"
    else
        echo "  MISSING: $f"
    fi
done

echo ""
echo "--- Key symbols ---"
git -C "$GRUB" show "${B}:FAILED.patch" 2>/dev/null \
    | grep '^+' | grep -v '^+++' \
    | grep -oE '(grub_[a-z_]{6,}|GRUB_[A-Z_]{6,}|"[^"]{10,40}")' \
    | sort -u | head -15

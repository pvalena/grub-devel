#!/bin/bash
# Usage: ./inspect.sh <series-name>
# Shows all data needed to decide keep/drop for a series.

set -euo pipefail

S="${1:?Usage: $0 <series-name>}"
F="series/$S"
DIR="$(dirname "$0")"
GRUB="${DIR}/../grub"

[[ -f "$DIR/$F" ]] || { echo "ERROR: $DIR/$F not found"; exit 1; }

BRANCHES=$(cat "$DIR/$F")
N=$(wc -l < "$DIR/$F")

echo "=== Series: $S ($N patches) ==="
echo ""

# Overview: each branch with subject, commit content stats
for b in $BRANCHES; do
    subj=$(grep "^${b}: " "$DIR/failed_subj.txt" | sed 's/^[^:]*: //' | head -c100)
    author=$(git -C "$GRUB" show --no-patch --format='%an' "$b" 2>/dev/null)
    date=$(git -C "$GRUB" show --no-patch --format='%ai' "$b" 2>/dev/null | head -c10)
    fp=$(git -C "$GRUB" show --stat --format='' "$b" 2>/dev/null | grep -c FAILED || true)
    code=$(git -C "$GRUB" show --stat --format='' "$b" 2>/dev/null | grep -v FAILED | grep -c '|' || true)
    echo "  $b | $author | $date | fp=$fp code=$code"
    echo "    $subj"
done

echo ""
echo "=== FAILED.patch targets ==="
# Show which files each FAILED.patch touches
for b in $BRANCHES; do
    files=$(git -C "$GRUB" show "${b}:FAILED.patch" 2>/dev/null \
        | grep '^diff --git' | sed 's|diff --git a/||;s| b/.*||' | tr '\n' ' ')
    [[ -n "$files" ]] && echo "  $b: $files"
done

echo ""
echo "=== Master check ==="
# Collect all unique target files from FAILED.patches, check if they exist on master
allfiles=$(for b in $BRANCHES; do
    git -C "$GRUB" show "${b}:FAILED.patch" 2>/dev/null \
        | grep '^diff --git' | sed 's|diff --git a/||;s| b/.*||'
done | sort -u)

for f in $allfiles; do
    lines=$(git -C "$GRUB" show "master:$f" 2>/dev/null | wc -l || echo 0)
    if [[ "$lines" -gt 0 ]]; then
        echo "  EXISTS ($lines L): $f"
    else
        echo "  MISSING: $f"
    fi
done

echo ""
echo "=== Key symbols/strings from patches ==="
# Extract added function names, error strings, defines — anything distinctive
for b in $BRANCHES; do
    git -C "$GRUB" show "${b}:FAILED.patch" 2>/dev/null \
        | grep '^+' | grep -v '^+++' \
        | grep -oE '(grub_[a-z_]+|GRUB_[A-Z_]+|"[^"]{8,50}")' \
        || true
done | sort -u | head -30

echo ""
echo "=== Master grep for key symbols ==="
# Take first 5 distinctive symbols and grep master
symbols=$(for b in $BRANCHES; do
    git -C "$GRUB" show "${b}:FAILED.patch" 2>/dev/null \
        | grep '^+' | grep -v '^+++' \
        | grep -oE 'grub_[a-z_]{6,}' \
        || true
done | sort | uniq -c | sort -rn | head -5 | awk '{print $2}')

for sym in $symbols; do
    hits=$(git -C "$GRUB" grep -rl "$sym" master -- '*.c' '*.h' 2>/dev/null | wc -l)
    echo "  $sym: $hits file(s) on master"
done

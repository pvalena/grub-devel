#!/bin/bash
# Usage: ./remove-old-entry.sh <branch> [branch2] ...
# Removes the FIRST (old) ## heading entry for each branch from
# INSPECTION_LOG_STANDALONE.md, keeping the LAST (newest) entry.
# Only acts if there are 2+ headings for the branch.

set -uo pipefail

[[ $# -ge 1 ]] || { echo "Usage: $0 <branch> [branch2] ..."; exit 1; }

DIR="$(dirname "$0")"
LOG="$DIR/INSPECTION_LOG_STANDALONE.md"

for B in "$@"; do
    count=$(grep -c "^## ${B}" "$LOG" 2>/dev/null || echo 0)
    if [ "$count" -lt 2 ]; then
        echo "  SKIP $B: $count heading(s), nothing to remove"
        continue
    fi

    python3 -c "
import re, sys

lines = open('$LOG').readlines()
positions = [i for i, l in enumerate(lines) if l.startswith('## $B')]

if len(positions) < 2:
    sys.exit(0)

start = positions[0]
headings = [i for i, l in enumerate(lines)
            if l.startswith('## ') and re.search(r'20\d{2}', l)]
end = len(lines)
for h in headings:
    if h > start and h != start:
        end = h
        break

del lines[start:end]

with open('$LOG', 'w') as f:
    f.writelines(lines)
"
    new_count=$(grep -c "^## ${B}" "$LOG" 2>/dev/null || echo 0)
    echo "  REMOVED old entry for $B ($count -> $new_count headings)"
done

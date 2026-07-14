#!/bin/bash
# Usage: ./add-confirmed.sh <branch> [branch2] ...
# Appends branches to confirmed.txt (deduplicating).

set -uo pipefail

[[ $# -ge 1 ]] || { echo "Usage: $0 <branch> [branch2] ..."; exit 1; }

DIR="$(dirname "$0")"
F="$DIR/confirmed.txt"
touch "$F"

added=0
for b in "$@"; do
  if grep -qx "$b" "$F" 2>/dev/null; then
    echo "  SKIP (already confirmed): $b"
  else
    echo "$b" >> "$F"
    added=$((added + 1))
  fi
done

echo "--- $added confirmed, total $(wc -l < "$F") in confirmed.txt"

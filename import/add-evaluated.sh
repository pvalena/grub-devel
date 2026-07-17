#!/bin/bash
# Usage: ./add-evaluated.sh <branch> [branch2] ...
# Appends branches to evaluated.txt (deduplicating).

set -uo pipefail

[[ $# -ge 1 ]] || { echo "Usage: $0 <branch> [branch2] ..."; exit 1; }

DIR="$(dirname "$0")"
F="$DIR/evaluated.txt"
touch "$F"

added=0
for b in "$@"; do
  if grep -qx "$b" "$F" 2>/dev/null; then
    echo "  SKIP (already evaluated): $b"
  else
    echo "$b" >> "$F"
    added=$((added + 1))
  fi
done

echo "--- $added evaluated, total $(wc -l < "$F") in evaluated.txt"

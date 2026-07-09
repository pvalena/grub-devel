#!/bin/bash
# Usage: ./add-drop-new.sh <branch> [branch2] ...
# Appends branches to drop_new.txt (deduplicating).

set -uo pipefail

[[ $# -ge 1 ]] || { echo "Usage: $0 <branch> [branch2] ..."; exit 1; }

DIR="$(dirname "$0")"
F="$DIR/drop_new.txt"

added=0
for b in "$@"; do
  if grep -qx "$b" "$F" 2>/dev/null; then
    echo "  SKIP (already in drop_new.txt): $b"
  else
    echo "$b" >> "$F"
    echo "  ADDED: $b"
    added=$((added + 1))
  fi
done

echo "--- $added added, total $(wc -l < "$F") in drop_new.txt"

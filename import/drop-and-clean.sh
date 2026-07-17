#!/bin/bash
# Usage: ./drop-and-clean.sh <branch> [branch2] ...
# Complete workflow to drop a KEEP branch:
# 1. Add to drop_new.txt
# 2. Add to confirmed.txt
# 3. Remove from standalone.txt (if present)
# 4. Remove from series/* (if present; dissolve singleton)
# 5. Remove from evaluated.txt (if present)
# 6. Fix KEEP -> DROP heading in INSPECTION_LOG_STANDALONE.md
# 7. Remove duplicate entry if one exists
#
# After running, you still need to:
# - Add a DROP log entry to INSPECTION_LOG_STANDALONE.md (with evidence)
# - Run: python3 generate_unified.py && python3 verify_unified.py

set -uo pipefail

[[ $# -ge 1 ]] || { echo "Usage: $0 <branch> [branch2] ..."; exit 1; }

DIR="$(dirname "$0")"

for B in "$@"; do
    echo "=== Dropping $B ==="

    # 1. Add to drop_new.txt
    "$DIR/add-drop-new.sh" "$B"

    # 2. Add to confirmed.txt
    "$DIR/add-confirmed.sh" "$B"

    # 3. Remove from standalone.txt
    if grep -qx "$B" "$DIR/standalone.txt" 2>/dev/null; then
        grep -v "^${B}$" "$DIR/standalone.txt" > "$DIR/standalone.txt.tmp"
        mv "$DIR/standalone.txt.tmp" "$DIR/standalone.txt"
        echo "  Removed from standalone.txt"
    fi

    # 4. Remove from series/*
    for sf in "$DIR"/series/*; do
        [ -f "$sf" ] || continue
        if grep -qx "$B" "$sf" 2>/dev/null; then
            grep -v "^${B}$" "$sf" > "$sf.tmp"
            mv "$sf.tmp" "$sf"
            remaining=$(wc -l < "$sf")
            series_name=$(basename "$sf")
            echo "  Removed from series/$series_name ($remaining members left)"

            # Dissolve singleton series
            if [ "$remaining" -eq 1 ]; then
                survivor=$(cat "$sf")
                echo "$survivor" >> "$DIR/standalone.txt"
                sort -o "$DIR/standalone.txt" "$DIR/standalone.txt"
                rm "$sf"
                echo "  Dissolved series/$series_name -> standalone $survivor"
            elif [ "$remaining" -eq 0 ]; then
                rm "$sf"
                echo "  Deleted empty series/$series_name"
            fi
        fi
    done

    # 5. Remove from evaluated.txt
    if grep -qx "$B" "$DIR/evaluated.txt" 2>/dev/null; then
        grep -v "^${B}$" "$DIR/evaluated.txt" > "$DIR/evaluated.txt.tmp"
        mv "$DIR/evaluated.txt.tmp" "$DIR/evaluated.txt"
        echo "  Removed from evaluated.txt"
    fi

    # 6. Fix KEEP -> DROP heading
    if grep -q "^## ${B} — KEEP$" "$DIR/INSPECTION_LOG_STANDALONE.md" 2>/dev/null; then
        sed -i "s/^## ${B} — KEEP$/## ${B} — DROP/" "$DIR/INSPECTION_LOG_STANDALONE.md"
        echo "  Changed KEEP -> DROP in log heading"
    fi

    # 7. Remove duplicate entry if exists
    "$DIR/remove-old-entry.sh" "$B"

    echo ""
done

echo "=== Done. Remaining manual steps: ==="
echo "  1. Add DROP log entry with evidence to INSPECTION_LOG_STANDALONE.md"
echo "  2. python3 $DIR/generate_unified.py"
echo "  3. python3 $DIR/verify_unified.py"

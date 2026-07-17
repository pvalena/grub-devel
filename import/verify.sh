#!/bin/bash
# Usage: ./verify.sh
# Comprehensive consistency check across all import/ data files.

set -uo pipefail

DIR="$(dirname "$0")"
ERRORS=0

err() { echo "  ERROR: $1"; ERRORS=$((ERRORS + 1)); }
ok()  { echo "  OK: $1"; }

echo "=== 1. DROP/KEEP OVERLAP ==="
overlap=$(comm -12 <(sort "$DIR/drop_new.txt") <(cat "$DIR/standalone.txt" "$DIR"/series/* 2>/dev/null | sort -u))
n=$(echo "$overlap" | grep -c '^20' || true)
if [ "${n:-0}" -gt 0 ]; then
    err "$n branches in BOTH drop_new.txt and keep lists"
    echo "$overlap"
else
    ok "no overlap between drops and keeps"
fi

echo ""
echo "=== 2. STANDALONE KEEPS ==="
total_sa=$(wc -l < "$DIR/standalone.txt")
echo "  standalone.txt: $total_sa branches"
# Each must NOT be in drop_new.txt
in_drop=$(comm -12 <(sort "$DIR/standalone.txt") <(sort "$DIR/drop_new.txt") | wc -l)
[ "$in_drop" -eq 0 ] && ok "none in drop_new.txt" || err "$in_drop in drop_new.txt"
# Each must be in a log
while read b; do
    if ! grep -q "$b" "$DIR/INSPECTION_LOG_STANDALONE.md" "$DIR/INSPECTION_LOG.md" 2>/dev/null; then
        err "$b has no log entry"
    fi
done < "$DIR/standalone.txt"
ok "all checked against logs"

echo ""
echo "=== 3. SERIES KEEPS ==="
n_series=$(ls "$DIR/series/" 2>/dev/null | wc -l)
n_members=$(cat "$DIR"/series/* 2>/dev/null | wc -l)
echo "  series/: $n_series series, $n_members members"
# Each series head must be in INSPECTION_LOG.md
for sf in "$DIR"/series/*; do
    head=$(basename "$sf")
    if ! grep -q "$head" "$DIR/INSPECTION_LOG.md" 2>/dev/null; then
        err "series head $head not in INSPECTION_LOG.md"
    fi
done
# Each member must NOT be in drop_new.txt
in_drop2=$(comm -12 <(cat "$DIR"/series/* | sort -u) <(sort "$DIR/drop_new.txt") | wc -l)
[ "$in_drop2" -eq 0 ] && ok "no members in drop_new.txt" || err "$in_drop2 members in drop_new.txt"
# Each member must be in INSPECTION_LOG.md
while read b; do
    if ! grep -q "$b" "$DIR/INSPECTION_LOG.md" 2>/dev/null; then
        err "series member $b not in INSPECTION_LOG.md"
    fi
done < <(cat "$DIR"/series/* 2>/dev/null)
ok "all checked against logs"

echo ""
echo "=== 4. DROPS ==="
total_drop=$(wc -l < "$DIR/drop_new.txt")
echo "  drop_new.txt: $total_drop branches"
# Each must NOT be in standalone.txt or series/
in_keep=$(comm -12 <(sort "$DIR/drop_new.txt") <(cat "$DIR/standalone.txt" "$DIR"/series/* 2>/dev/null | sort -u) | wc -l)
[ "$in_keep" -eq 0 ] && ok "none in keep lists" || err "$in_keep in keep lists"
# Each must be in a log
missing_log=0
while read b; do
    if ! grep -q "$b" "$DIR/INSPECTION_LOG_STANDALONE.md" "$DIR/INSPECTION_LOG.md" 2>/dev/null; then
        err "drop $b has no log entry"
        missing_log=$((missing_log + 1))
    fi
done < "$DIR/drop_new.txt"
[ "$missing_log" -eq 0 ] && ok "all drops have log entries"

echo ""
echo "=== 5. CONFIRMATION COVERAGE ==="
confirmed_sa=$(wc -l < "$DIR/confirmed.txt")
confirmed_sr=$(wc -l < "$DIR/confirmed_series.txt")
echo "  confirmed.txt: $confirmed_sa standalone drops"
echo "  confirmed_series.txt: $confirmed_sr series heads"
# Every drop must be confirmed: either in confirmed.txt (standalone) or
# its series head in confirmed_series.txt (series)
# First check standalone: drops in confirmed.txt
not_in_confirmed=$(comm -23 <(sort "$DIR/drop_new.txt") <(sort "$DIR/confirmed.txt"))
# Of those, check how many are covered by confirmed_series.txt
truly_unconfirmed=0
for b in $not_in_confirmed; do
    head=$(grep -B20 "$b" "$DIR/INSPECTION_LOG.md" 2>/dev/null | grep '## Series:' | tail -1 | grep -oE '20[0-9]{2}-[0-9]{2}-[0-9]{4}' | head -1)
    if [ -n "$head" ]; then
        if ! grep -qx "$head" "$DIR/confirmed_series.txt" 2>/dev/null; then
            err "drop $b (series head $head) not confirmed"
            truly_unconfirmed=$((truly_unconfirmed + 1))
        fi
    else
        err "drop $b not in confirmed.txt and no series head found"
        truly_unconfirmed=$((truly_unconfirmed + 1))
    fi
done
[ "$truly_unconfirmed" -eq 0 ] && ok "all drops confirmed (standalone or via series)"


echo ""
echo "=== 6. UNIFIED LOG COMPLETENESS ==="
if [ -f "$DIR/INSPECTION_LOG_UNIFIED.md" ]; then
    unified="$DIR/INSPECTION_LOG_UNIFIED.md"
    missing_u=0
    # All standalone keeps
    while read b; do
        grep -q "$b" "$unified" || { err "standalone KEEP $b missing from unified log"; missing_u=$((missing_u + 1)); }
    done < "$DIR/standalone.txt"
    # All series heads
    for sf in "$DIR"/series/*; do
        head=$(basename "$sf")
        grep -q "$head" "$unified" || { err "series head $head missing from unified log"; missing_u=$((missing_u + 1)); }
    done
    # All drops
    while read b; do
        grep -q "$b" "$unified" || { err "drop $b missing from unified log"; missing_u=$((missing_u + 1)); }
    done < "$DIR/drop_new.txt"
    [ "$missing_u" -eq 0 ] && ok "all branches in unified log"
else
    echo "  SKIP: INSPECTION_LOG_UNIFIED.md not found"
fi

echo ""
echo "=== SUMMARY ==="
echo "  Standalone KEEP: $total_sa"
echo "  Series KEEP: $n_series series / $n_members members"
echo "  Drops: $total_drop"
echo "  Confirmed standalone: $confirmed_sa"
echo "  Confirmed series: $confirmed_sr"
echo "  Errors: $ERRORS"

if [ "$ERRORS" -eq 0 ]; then
    echo ""
    echo "  ALL CHECKS PASS."
else
    echo ""
    echo "  $ERRORS ERROR(S) FOUND."
    exit 1
fi

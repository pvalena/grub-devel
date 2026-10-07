#!/bin/bash
# Documentation Consistency Verification
#
# Policy (see ~/.claude/skills/auto-memory): volatile metrics (open/closed MR counts, review
# file counts) live ONLY in MEMORY.md, each paired with a recount command. CLAUDE.md must
# reference MEMORY.md rather than duplicate the numbers -- a copy in both files always drifts.
# This script therefore checks MEMORY.md against the real data files, and separately checks
# that CLAUDE.md has NOT regressed into re-duplicating a volatile count.

set -e

RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
NC='\033[0m' # No Color

errors=0
warnings=0

echo "=== Documentation Consistency Verification ==="
echo ""

# --- Open/closed MR counts: MEMORY.md vs data/*.txt (single source of truth) ---
echo "Open/closed MR counts (MEMORY.md vs data/):"

memory_open=$(grep -E "Open MRs" MEMORY.md | head -1 | grep -oE "[0-9]+" | head -1)
memory_closed=$(grep -E "Closed.*Merged.*MRs" MEMORY.md | head -1 | grep -oE "[0-9]+" | head -1)
data_open=$(wc -l < data/open.txt)
data_closed=$(wc -l < data/closed.txt)

echo "  MEMORY.md: open=$memory_open closed=$memory_closed"
echo "  data/:     open=$data_open closed=$data_closed"

if [ "$memory_open" = "$data_open" ] && [ "$memory_closed" = "$data_closed" ]; then
    echo -e "  ${GREEN}✓ Match${NC}"
else
    echo -e "  ${RED}✗ MISMATCH -- update MEMORY.md 'Current Status'${NC}"
    errors=$((errors + 1))
fi
echo ""

# --- Regression check: CLAUDE.md must NOT re-duplicate a volatile count ---
# Both MR counts (open/closed) and review-file counts are volatile and live only in MEMORY.md.
# The review-file patterns are phrased narrowly so they do NOT match the legitimate historical
# Phase 1-3 milestone numbers (e.g. "176 branches", "63 MRs created") that belong in CLAUDE.md.
echo "CLAUDE.md duplication check:"

mr_count_re="[0-9]+ open|[0-9]+ closed|Open MRs:[[:space:]]*[0-9]|Closed.*MRs:[[:space:]]*[0-9]"
review_count_re="[0-9]+ files total|[0-9]+ reasoning file|[0-9]+ investigation file|[0-9]+ complete \(\.md\)"

if grep -qE "$mr_count_re|$review_count_re" CLAUDE.md; then
    echo -e "  ${RED}✗ CLAUDE.md appears to contain a hardcoded MR or review-file count${NC}"
    echo "    Volatile counts belong only in MEMORY.md -- replace with a reference to it:"
    grep -nE "$mr_count_re|$review_count_re" CLAUDE.md | sed 's/^/      /'
    errors=$((errors + 1))
else
    echo -e "  ${GREEN}✓ No duplicated volatile count found${NC}"
fi
echo ""

# --- Review file counts: actual vs documented in MEMORY.md ---
echo "Review file counts (actual vs. MEMORY.md):"

actual_reviews=$(ls reviews/*.md 2>/dev/null | wc -l)
documented_reviews=$(grep -E "Complete reviews:" MEMORY.md | head -1 | grep -oE "[0-9]+" | head -1)
actual_reasoning=$(ls reviews/*_reasoning.txt 2>/dev/null | wc -l)
documented_reasoning=$(grep -E "Reasoning files:" MEMORY.md | head -1 | grep -oE "[0-9]+" | head -1)
actual_investigation=$(ls reviews/*_investigation.txt 2>/dev/null | wc -l)
documented_investigation=$(grep -E "Investigation files:" MEMORY.md | head -1 | grep -oE "[0-9]+" | head -1)

echo "  .md:              actual=$actual_reviews documented=$documented_reviews"
echo "  _reasoning.txt:    actual=$actual_reasoning documented=$documented_reasoning"
echo "  _investigation.txt: actual=$actual_investigation documented=$documented_investigation"

if [ "$actual_reviews" = "$documented_reviews" ] && [ "$actual_reasoning" = "$documented_reasoning" ] \
   && [ "$actual_investigation" = "$documented_investigation" ]; then
    echo -e "  ${GREEN}✓ Match${NC}"
else
    echo -e "  ${YELLOW}⚠ Mismatch -- update MEMORY.md 'Review files'${NC}"
    warnings=$((warnings + 1))
fi
echo ""

# --- MRS_BY_AUTHOR.md: archival only, informational count, never an error ---
echo "MRS_BY_AUTHOR.md (archival reference -- not reconciled, divergence is expected):"
mrs_in_doc=$(grep -oE '\[!([0-9]+)\]' MRS_BY_AUTHOR.md 2>/dev/null | sed -E 's/.*!([0-9]+).*/\1/' | sort -n | wc -l)
echo "  MRs listed: $mrs_in_doc (vs. $data_open currently open -- informational only, do not edit the file to match)"
echo ""

# --- Last updated dates: CLAUDE.md, MEMORY.md, docs/REVIEW_PROCESS.md ---
echo "Last updated dates:"

claude_date=$(grep -E "Last updated.*:" CLAUDE.md | head -1 | grep -oE "[0-9]{4}-[0-9]{2}-[0-9]{2}" || echo "")
memory_date=$(grep -E "Last updated.*:" MEMORY.md | head -1 | grep -oE "[0-9]{4}-[0-9]{2}-[0-9]{2}" || echo "")
docs_date=$(grep -E "Last updated.*:" docs/REVIEW_PROCESS.md | head -1 \
    | grep -oE "[0-9]{4}-[0-9]{2}-[0-9]{2}" || echo "")

today=$(date +%Y-%m-%d)

echo "  CLAUDE.md: $claude_date"
echo "  MEMORY.md: $memory_date"
echo "  docs/REVIEW_PROCESS.md: $docs_date"
echo "  Today: $today"

if [ "$claude_date" != "$memory_date" ]; then
    echo -e "  ${YELLOW}⚠ CLAUDE.md and MEMORY.md dates differ -- verify if intentional${NC}"
    warnings=$((warnings + 1))
fi

# Warn (don't fail) if MEMORY.md itself is stale -- auto-memory skill: >2 weeks is unreliable.
if [ -n "$memory_date" ]; then
    days_old=$(( ( $(date -d "$today" +%s) - $(date -d "$memory_date" +%s) ) / 86400 ))
    if [ "$days_old" -gt 14 ]; then
        echo -e "  ${YELLOW}⚠ MEMORY.md is $days_old days old (>14) -- treat as unreliable, refresh it${NC}"
        warnings=$((warnings + 1))
    fi
fi
echo ""

# Summary
echo "=== Summary ==="
if [ $errors -eq 0 ]; then
    echo -e "${GREEN}✓ No consistency errors${NC} ($warnings warning(s))"
    exit 0
else
    echo -e "${RED}✗ $errors consistency error(s), $warnings warning(s)${NC}"
    echo ""
    echo "Run 'grep -E \"Open MRs|Closed\" MEMORY.md; wc -l data/open.txt data/closed.txt' to debug"
    exit 1
fi

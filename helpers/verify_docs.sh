#!/bin/bash
# Documentation Consistency Verification
# Checks that all statistics match across CLAUDE.md, MEMORY.md, and docs/

set -e

RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
NC='\033[0m' # No Color

errors=0

echo "=== Documentation Consistency Verification ==="
echo ""

# Extract statistics from each file
echo "Extracting statistics..."
echo ""

# Open MRs
claude_open=$(grep -E "Open MRs:|Status.*open" CLAUDE.md | head -1 | grep -oE "[0-9]+" | head -1)
memory_open=$(grep -E "Open MRs:" MEMORY.md | head -1 | grep -oE "[0-9]+" | head -1)
docs_open=$(grep -E "Open MRs|Review files:" docs/REVIEW_PROCESS.md | grep -oE "[0-9]+" | head -1)
data_open=$(wc -l < data/open.txt)

echo "Open MRs:"
echo "  CLAUDE.md: $claude_open"
echo "  MEMORY.md: $memory_open"
echo "  docs/REVIEW_PROCESS.md: $docs_open"
echo "  data/open.txt: $data_open"

if [ "$claude_open" = "$memory_open" ] && [ "$memory_open" = "$docs_open" ] && [ "$docs_open" = "$data_open" ]; then
    echo -e "  ${GREEN}✓ All match${NC}"
else
    echo -e "  ${RED}✗ MISMATCH${NC}"
    errors=$((errors + 1))
fi
echo ""

# Closed MRs
claude_closed=$(grep -E "Status.*closed" CLAUDE.md | grep -oE "[0-9]+ closed" | grep -oE "[0-9]+" | head -1)
memory_closed=$(grep -E "Closed.*Merged.*MRs" MEMORY.md | head -1 | grep -oE "[0-9]+" | head -1)
data_closed=$(wc -l < data/closed.txt)

echo "Closed MRs:"
echo "  CLAUDE.md: $claude_closed"
echo "  MEMORY.md: $memory_closed"
echo "  data/closed.txt: $data_closed"

if [ "$claude_closed" = "$memory_closed" ] && [ "$memory_closed" = "$data_closed" ]; then
    echo -e "  ${GREEN}✓ All match${NC}"
else
    echo -e "  ${RED}✗ MISMATCH${NC}"
    errors=$((errors + 1))
fi
echo ""

# Active authors
claude_authors=$(grep -E "Active authors:" CLAUDE.md | head -1 | grep -oE "[0-9]+" | head -1)
memory_authors=$(grep -E "Active authors:" MEMORY.md | head -1 | grep -oE "[0-9]+" | head -1)

echo "Active authors:"
echo "  CLAUDE.md: $claude_authors"
echo "  MEMORY.md: $memory_authors"

if [ "$claude_authors" = "$memory_authors" ]; then
    echo -e "  ${GREEN}✓ Match${NC}"
else
    echo -e "  ${RED}✗ MISMATCH${NC}"
    errors=$((errors + 1))
fi
echo ""

# Verify file counts
echo "File counts:"

actual_reviews=$(ls reviews/*.md 2>/dev/null | wc -l)
documented_reviews=$(grep -E "Complete reviews:|review files:" MEMORY.md | head -1 | grep -oE "[0-9]+" | head -1)

echo "  Review files (.md):"
echo "    Actual: $actual_reviews"
echo "    Documented (MEMORY.md): $documented_reviews"

if [ "$actual_reviews" = "$documented_reviews" ]; then
    echo -e "    ${GREEN}✓ Match${NC}"
else
    echo -e "    ${YELLOW}⚠ Mismatch (update MEMORY.md?)${NC}"
fi
echo ""

actual_reasoning=$(ls reviews/*_reasoning.txt 2>/dev/null | wc -l)
documented_reasoning=$(grep -E "Reasoning files:" MEMORY.md | head -1 | grep -oE "[0-9]+" | head -1)

echo "  Reasoning files (_reasoning.txt):"
echo "    Actual: $actual_reasoning"
echo "    Documented (MEMORY.md): $documented_reasoning"

if [ "$actual_reasoning" = "$documented_reasoning" ]; then
    echo -e "    ${GREEN}✓ Match${NC}"
else
    echo -e "    ${YELLOW}⚠ Mismatch (update MEMORY.md?)${NC}"
fi
echo ""

# Verify MRS_BY_AUTHOR.md matches data/open.txt
echo "Tracking document verification:"

mrs_in_doc=$(grep -oE '\[!([0-9]+)\]' MRS_BY_AUTHOR.md | sed -E 's/.*!([0-9]+).*/\1/' | sort -n | wc -l)

echo "  MRs in MRS_BY_AUTHOR.md: $mrs_in_doc"
echo "  MRs in data/open.txt: $data_open"

if [ "$mrs_in_doc" = "$data_open" ]; then
    echo -e "  ${GREEN}✓ Match${NC}"
else
    echo -e "  ${RED}✗ MISMATCH - MRS_BY_AUTHOR.md needs update${NC}"
    errors=$((errors + 1))
fi
echo ""

# Check last updated dates
echo "Last updated dates:"

claude_date=$(grep -E "Last updated.*:" CLAUDE.md | head -1 | grep -oE "[0-9]{4}-[0-9]{2}-[0-9]{2}" || echo "")
memory_date=$(grep -E "Last updated.*:" MEMORY.md | head -1 | grep -oE "[0-9]{4}-[0-9]{2}-[0-9]{2}" || echo "")
docs_date=$(grep -E "Last updated.*:" docs/REVIEW_PROCESS.md | head -1 | grep -oE "[0-9]{4}-[0-9]{2}-[0-9]{2}" || echo "")

today=$(date +%Y-%m-%d)

echo "  CLAUDE.md: $claude_date"
echo "  MEMORY.md: $memory_date"
echo "  docs/REVIEW_PROCESS.md: $docs_date"
echo "  Today: $today"

# Check if any are significantly old (>30 days)
if [ "$claude_date" != "$memory_date" ] || [ "$memory_date" != "$docs_date" ]; then
    echo -e "  ${YELLOW}⚠ Dates differ - verify if intentional${NC}"
fi
echo ""

# Summary
echo "=== Summary ==="
if [ $errors -eq 0 ]; then
    echo -e "${GREEN}✓ All consistency checks passed${NC}"
    exit 0
else
    echo -e "${RED}✗ $errors consistency error(s) found${NC}"
    echo ""
    echo "Run 'grep -E \"Open|Closed|authors\" CLAUDE.md MEMORY.md' to debug"
    exit 1
fi

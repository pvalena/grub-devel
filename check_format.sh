#!/bin/bash
# Line Width Format Checker
# Verifies all documentation files comply with 120 character line width

RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
NC='\033[0m' # No Color

MAX_WIDTH=120
violations=0
files_with_violations=0

echo "=== Line Width Format Checker (max: $MAX_WIDTH chars) ==="
echo ""

# Function to check a single file
check_file() {
    local file=$1
    local count=$(awk "length > $MAX_WIDTH" "$file" | wc -l)

    if [ "$count" -gt 0 ]; then
        echo -e "${RED}✗ $file: $count lines over $MAX_WIDTH chars${NC}"
        ((files_with_violations++))
        ((violations+=count))

        # Show first 3 violations
        awk "length > $MAX_WIDTH {print \"  Line \" NR \": \" substr(\$0, 1, 80) \"...\"}" "$file" | head -3

        if [ "$count" -gt 3 ]; then
            echo "  ... and $((count - 3)) more"
        fi
        echo ""
        return 1
    else
        echo -e "${GREEN}✓ $file${NC}"
        return 0
    fi
}

# Check CLAUDE.md
echo "Core documentation:"
check_file "CLAUDE.md"
check_file "MEMORY.md"
echo ""

# Check docs/
echo "Process documentation:"
for file in docs/*.md; do
    if [ -f "$file" ]; then
        check_file "$file"
    fi
done
echo ""

# Check reviews/
echo "Review files (.md):"
review_count=0
review_violations=0

for file in reviews/*.md; do
    if [ -f "$file" ]; then
        ((review_count++))
        if ! awk "length > $MAX_WIDTH {exit 1}" "$file"; then
            ((review_violations++))
        fi
    fi
done

if [ "$review_violations" -eq 0 ]; then
    echo -e "${GREEN}✓ All $review_count review files compliant${NC}"
else
    echo -e "${RED}✗ $review_violations of $review_count review files have violations${NC}"
    echo "  Run: for f in reviews/*.md; do awk 'length > $MAX_WIDTH {print FILENAME \":\" NR}' \"\$f\"; done"
    ((files_with_violations+=review_violations))
fi
echo ""

# Check reasoning files
echo "Reasoning files (_reasoning.txt):"
reasoning_count=0
reasoning_violations=0

for file in reviews/*_reasoning.txt; do
    if [ -f "$file" ]; then
        ((reasoning_count++))
        if ! awk "length > $MAX_WIDTH {exit 1}" "$file"; then
            ((reasoning_violations++))
        fi
    fi
done

if [ "$reasoning_violations" -eq 0 ]; then
    echo -e "${GREEN}✓ All $reasoning_count reasoning files compliant${NC}"
else
    echo -e "${RED}✗ $reasoning_violations of $reasoning_count reasoning files have violations${NC}"
    echo "  Run: for f in reviews/*_reasoning.txt; do awk 'length > $MAX_WIDTH {print FILENAME \":\" NR}' \"\$f\"; done"
    ((files_with_violations+=reasoning_violations))
fi
echo ""

# Summary
echo "=== Summary ==="
if [ "$files_with_violations" -eq 0 ]; then
    echo -e "${GREEN}✓ All files compliant with $MAX_WIDTH character width${NC}"
    exit 0
else
    echo -e "${RED}✗ $files_with_violations file(s) with format violations${NC}"
    echo ""
    echo "To check specific file:"
    echo "  awk 'length > $MAX_WIDTH {print NR\": \" \$0}' FILE"
    echo ""
    echo "To find violations in all reviews:"
    echo "  for f in reviews/*.md reviews/*_reasoning.txt; do"
    echo "    awk 'length > $MAX_WIDTH {print FILENAME \":\" NR \": \" substr(\$0,1,80) \"...\"}' \"\$f\""
    echo "  done"
    exit 1
fi

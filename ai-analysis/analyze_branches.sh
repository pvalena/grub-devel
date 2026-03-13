#!/bin/bash

echo "["
first=true

for branch in $(git branch --list '2025-*' '2026-*' | sed 's/^[* ]*//' | sort); do
    # Get the branch tip commit
    commit=$(git rev-parse "$branch")
    
    # Get author name and email
    author=$(git log -1 --format='%an <%ae>' "$branch")
    
    # Get date
    date=$(git log -1 --format='%ai' "$branch" | cut -d' ' -f1)
    
    # Get commit subject
    subject=$(git log -1 --format='%s' "$branch" | sed 's/"/\\"/g')
    
    # Get commit body
    body=$(git log -1 --format='%b' "$branch" | sed 's/"/\\"/g' | tr '\n' ' ' | sed 's/  */ /g' | sed 's/^ *//;s/ *$//')
    
    # Get files changed
    files=$(git diff-tree --no-commit-id --name-only -r "$branch" | tr '\n' ',' | sed 's/,$//')
    
    # Output JSON
    if [ "$first" = false ]; then
        echo ","
    fi
    first=false
    
    echo "  {"
    echo "    \"branch\": \"$branch\","
    echo "    \"commit\": \"$commit\","
    echo "    \"author\": \"$author\","
    echo "    \"date\": \"$date\","
    echo "    \"subject\": \"$subject\","
    echo "    \"body\": \"$body\","
    echo "    \"files\": \"$files\""
    echo -n "  }"
done

echo ""
echo "]"

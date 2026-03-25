# Instructions for Claude

## Repository Purpose
This repository is used for analyzing GRUB2 patches from mailing lists, identifying duplicates in cleanly-applied git branches, and managing merge requests to upstream.

## Completed Work Summary

### Phase 1: Duplicate Detection (COMPLETED)
- **Initial branches**: 176 (2025-2026 patches from mailing lists)
- **Duplicates identified**: 65 (39% duplication rate)
- **Unique branches retained**: 111
- **Authors analyzed**: 38 unique contributors

**Key files**:
- `duplicates.txt`: List of 65 duplicate branches removed
- `authors.txt`: List of 38 unique authors (emails obfuscated)
- `DUPLICATE_ANALYSIS_PLAN.md`: Complete analysis report with results by author

### Phase 2: Branch Analysis (COMPLETED)
- **Branches analyzed**: 111 unique branches
- **Sanity check performed**: Merge readiness classification
- **Results**: 102 MERGE, 8 REVIEW, 1 SKIP

**Key files in `ai-analysis/`**:
- `branch_analysis.json`: Complete structured data (metadata, classification, reasoning)
- `BRANCH_ANALYSIS_SUMMARY.md`: Executive summary with statistics
- `MERGE_PRIORITY_LIST.md`: Priority-based merge guide
- `ANALYSIS_README.md`: Documentation guide with usage instructions

### Phase 3: Merge Request Creation (COMPLETED)
- **MRs created**: 63 (to gnu-grub/grub upstream)
- **MR range**: !19 to !81
- **Multi-commit MRs**: Several branches contain multiple commits

**Key files**:
- `branches.txt`: List of 63 active branches
- `mrs.txt`: Branch to MR mapping (format: `BRANCH|MR_NUMBER`)
- `ai-analysis/BRANCHES_BY_AUTHOR_BRIEF.md`: Author-grouped MR listing with links

---

## Core Principles

### 1. Keep Latest Principle
When branches are duplicates or near-duplicates, **always keep the LATEST submission** (most recent date).

**Rationale**:
- Latest submission may have updated commit messages
- Author may have made final corrections or refinements
- Later dates indicate the author's final intent

### 2. Author-Based Analysis
Process branches by author to efficiently identify duplicates. Same author is the most common source of duplicate submissions (resubmissions, corrections, iterations).

### 3. Explicit Documentation
Before marking branches as duplicates, always document explicit reasons and verify the relationship between branches.

---

## Duplicate Classification Types

### Type A: Exact Duplicates
- **Criteria**: Empty `git diff` (100% identical)
- **Action**: Keep the LATEST submission
- **Example**: 5 identical submissions → keep most recent

### Type B: Nearly Identical
- **Criteria**: Only whitespace, comments, or trivial formatting changes
- **Action**: Keep the LATEST submission
- **Example**: Same code with different spacing → keep most recent

### Type C: Superseded/Obsoleted Versions
- **Criteria**: Same commit message and purpose, but later version has significant improvements
- **Action**: Keep the LATEST/BETTER version
- **Example**: Initial implementation vs. improved refactoring → keep improved version

### Type D: Different Implementations
- **Criteria**: Same problem, different approaches
- **Action**: NOT duplicates - keep both for review

---

## Workflow for Duplicate Detection

### 1. Extract Author's Branches
```bash
git branch | grep -E '^\s*(2025|2026)' | xargs -I {} sh -c 'author=$(git log "{}" --format="%an" -1); if [ "$author" = "AUTHOR_NAME" ]; then echo "{}"; fi' | sort
```

### 2. Get Commit Messages
```bash
for branch in BRANCH_LIST; do
  echo "=== $branch ==="
  git log "$branch" --format="%s" -1
done
```

### 3. Group by Similar Commit Messages
Look for patterns:
- Identical commit subjects
- Similar subjects (e.g., with/without version numbers)
- Related functionality (e.g., different parts of same feature)

### 4. Compare Suspicious Pairs/Groups
```bash
git diff branch1 branch2
```

### 5. Document and Record
- Add duplicates to `duplicates.txt` (one branch per line)
- Document reasons for each duplicate
- Update analysis files

---

## Process Order

1. **High-volume authors** (>10 branches) - process individually
2. **Medium-volume authors** (5-10 branches) - process individually or in small batches
3. **Low-volume authors** (<5 branches) - process in batches

---

## Key Statistics from Completed Analysis

### Duplication Rates by Author Tier
- **High-volume authors**: 44% duplication rate
- **Medium-volume authors**: 39% duplication rate
- **Low-volume authors**: 27% duplication rate

### Top Contributors (by unique branches retained)
1. Vladimir Serbinenko - 21 branches → 8 unique MRs
2. Gary Lin - 10 branches → 5 unique MRs
3. Leo Sandoval - 13 branches → 4 unique MRs

### Common Causes of Duplicates
1. **Resubmissions** - Same patch submitted multiple times (most common)
2. **Progressive improvements** - Author iterating on implementation
3. **Formatting fixes** - Code style corrections in later versions
4. **Bug fixes** - Correcting issues found in earlier submissions
5. **Feature additions** - Extending functionality in later versions

---

## File Organization

### Root Directory
- `duplicates.txt`: List of duplicate branches (65 entries)
- `authors.txt`: List of unique authors with obfuscated emails (38 entries)
- `branches.txt`: List of active branches (63 entries)
- `mrs.txt`: Branch to MR mapping (63 entries)
- `DUPLICATE_ANALYSIS_PLAN.md`: Complete duplicate detection report
- `CLAUDE.md`: This file - instructions and summary

### ai-analysis/ Directory
- `branch_analysis.json`: Complete structured data for all branches
- `BRANCH_ANALYSIS_SUMMARY.md`: Executive summary with key findings
- `MERGE_PRIORITY_LIST.md`: Priority-based merge guide
- `BRANCHES_BY_AUTHOR_BRIEF.md`: Author-grouped MR listing with GitLab links
- `ANALYSIS_README.md`: Documentation guide with JQ query examples
- `analyze_branches.sh`: Script used for analysis

### grub/ Subdirectory
- Git repository with all branch commits
- **DO NOT MODIFY** - analysis only

---

## Email Obfuscation
All email addresses in documentation use standard obfuscation:
- `@` → ` at `
- `.` → ` dot `

Example: `user@example.com` → `user at example dot com`

---

## GitLab Integration

### Repository URLs
- **Development fork**: https://gitlab.freedesktop.org/pvalena/grub/
- **Upstream**: https://gitlab.freedesktop.org/gnu-grub/grub/

### MR Format
MRs use GitLab's `!XX` notation:
- Example: `!24` for merge request #24
- Full URL: `https://gitlab.freedesktop.org/gnu-grub/grub/-/merge_requests/24`

### Documentation Links
All MRs are documented in `ai-analysis/BRANCHES_BY_AUTHOR_BRIEF.md` with:
- MR number as clickable link
- Brief description
- Multi-commit indicator (where applicable)
- Organized by author

---

## Restrictions and Best Practices

### DO NOT:
- Modify any files in the `grub/` repository
- Create commits, branches, or make git changes in `grub/`
- Add branches to `duplicates.txt` without documenting reasons
- Mark branches as duplicates if they have different commit messages (unless clearly superseded)

### DO:
- Always use author-based analysis approach
- Document explicit reasons for duplicates
- Keep the latest version of duplicate submissions
- Verify branches actually conflict or are truly redundant
- Update documentation files when making changes
- Obfuscate email addresses in all documentation

---

## Future Reference

This repository contains a complete example of:
1. Systematic duplicate detection in git branches (176 → 111 branches)
2. Comprehensive branch analysis and classification
3. MR creation and tracking (63 MRs)
4. Documentation generation and maintenance

All methodology, principles, and results are documented for future similar projects.

# Instructions for Claude

## Repository Purpose

This repository analyzes GRUB2 patches from mailing lists, identifies duplicates in cleanly-applied git branches, and manages merge requests to upstream with comprehensive code reviews.

## Completed Work Summary

### Phase 1: Duplicate Detection (COMPLETED)
- **Initial branches**: 176 → **Unique branches**: 111 (39% duplication rate)
- **Method**: Author-based analysis, keeping latest submissions
- **Key files**: `duplicates.txt`, `authors.txt`

### Phase 2: Branch Analysis (COMPLETED)
- **Branches analyzed**: 111
- **Classification**: 102 MERGE, 8 REVIEW, 1 SKIP
- **Key files in `ai-analysis/`**: `branch_analysis.json`, analysis summaries

### Phase 3: Merge Request Creation (COMPLETED)
- **MRs created**: 63 (to gnu-grub/grub upstream, !19 to !81)
- **Key files**: `branches.txt`, `mrs.txt`, `MRS_BY_AUTHOR.md`

### Phase 4: Code Review & Quality Assurance (COMPLETED)
- **Reviews**: 90 complete (.md) + 31 reasoning files (_reasoning.txt)
- **Quality**: Zero false positives, all commits reviewed, 120 char width
- **Key files**: `reviews/*.md`, `reviews/*_reasoning.txt`, `docs/REVIEW_PROCESS.md`

### Phase 5: MR Status Tracking (ONGOING)
- **Status**: 26 open, 56 closed (68% closure rate)
- **Key files**: `data/open.txt`, `data/closed.txt`, `MRS_BY_AUTHOR.md`

---

## Core Principles

### 1. Keep Latest Principle
When branches are duplicates or near-duplicates, **always keep the LATEST submission** (most recent date). Latest may have updated commit messages, corrections, or refinements.

### 2. Author-Based Analysis
Process branches by author to efficiently identify duplicates. Same author is the most common source of duplicate submissions.

### 3. Explicit Documentation
Before marking branches as duplicates, always document explicit reasons and verify the relationship.

### 4. Review Quality Standards
- **Zero false positives**: Verify every bug by reading actual code
- **Complete coverage**: All commits must be reviewed
- **Evidence-based**: Never report bugs not seen in actual source
- **Formatting compliance**: 120 character line width mandatory

---

## File Organization

### Root Directory
- `MRS_BY_AUTHOR.md`: **Active tracking document** (26 open MRs by author)
- `MEMORY.md`: Complete workflow reference and repository state
- `CLAUDE.md`: This file - repository instructions
- `branches.txt`, `mrs.txt`, `duplicates.txt`, `authors.txt`
- `closed.sh`: MR status checking script

### data/
- `open.txt`: 26 open MR numbers (source of truth)
- `closed.txt`: 56 closed MR numbers

### reviews/
- `YYYY-MM-NNNN.md`: Complete code reviews (90 files)
- `YYYY-MM-NNNN_reasoning.txt`: Brief technical justifications (31 files)
- All files comply with 120 char line width

### docs/
- `REVIEW_PROCESS.md`: Complete review workflow documentation

### ai-analysis/
- `branch_analysis.json`: Structured data for all branches
- Various analysis summaries and documentation

### grub/
- Git repository with all branch commits
- **IMPORTANT**: Must `cd grub/` to access branches
- **Base commit**: c160b58610879a52d959db21b9cae98af5fd095f
- **DO NOT MODIFY** - analysis only

---

## Restrictions and Best Practices

### DO NOT:
- Modify files in `grub/` repository
- Report bugs without verifying in actual code
- Create reasoning files for "No issues found" reviews
- Exceed 120 char line width in documentation
- Update `ai-analysis/BRANCHES_REVIEWS.md` (historical)

### DO:
- Author-based analysis for duplicates
- Keep latest version of duplicates
- **Verify every bug by reading actual code**
- **Count commits and ensure all reviewed**
- **Update MRS_BY_AUTHOR.md when MRs close**
- **Maintain accuracy** between `data/open.txt` and `MRS_BY_AUTHOR.md`
- **Format all files to 120 char width**
- Obfuscate email addresses (` at `, ` dot `)

---

## Key Documentation

- **MEMORY.md**: Complete workflow reference, current state, essential commands
- **docs/REVIEW_PROCESS.md**: Detailed review process with verification procedures
- **CLAUDE.md**: This file - repository purpose and principles

---

## Repository URLs

- **Development fork**: https://gitlab.freedesktop.org/pvalena/grub/
- **Upstream**: https://gitlab.freedesktop.org/gnu-grub/grub/
- **MR format**: `!XX` (e.g., !24 = https://gitlab.freedesktop.org/gnu-grub/grub/-/merge_requests/24)

---

**Last updated**: 2026-06-08

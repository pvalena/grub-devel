# Instructions for Claude

## Repository Purpose

This repository analyzes GRUB2 patches from mailing lists, identifies duplicates in
cleanly-applied git branches, and manages merge requests to upstream with comprehensive code
reviews.

## Current Operating Mode (READ FIRST)

The active, ongoing job is the **autonomous review loop**: when `data/new.txt` has MR numbers
queued (populated by an automated GitLab-label pipeline — see MEMORY.md "How review requests
reach this session") and the user says "continue with reviews", review them and report —
nothing else.

**See `HANDOVER.md` for the exact runbook** (this is the source of truth for how to operate).
In short:
- Reviews are delegated to **review agents**, then double-checked by a separate
  fresh-context **adversarial agent**; the orchestrator (main session) only reads + lints +
  **approves** (spot-checks source only on a red flag). The model per role is configurable and
  interchangeable (don't assume Opus/Sonnet) — see `MEMORY.md` "Review Delegation Model" for
  the current defaults — and review skill v3.14.0.
- **Never** commit, push, modify `grub/`, or edit `data/new.txt`. A separate script
  (`submit-review.sh`, run by a human operator) handles commits and posts review content as
  a public GitLab MR comment. Do not start unrelated work.

Sections below are historical project background (how the corpus was built). The review loop
above is what is live now.

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
- **Reviews**: initial corpus reviewed — `.md` per MR, plus `_reasoning.txt` (reviews with
  issues) and `_investigation.txt` (large/complex clean reviews); current counts in
  `MEMORY.md` "Current Status" (volatile; not duplicated here)
- **Quality**: Zero false positives, all commits reviewed, 120 char width
- **Key files**: `reviews/*.md`, `reviews/*_reasoning.txt`, `reviews/*_investigation.txt`,
  `docs/REVIEW_PROCESS.md`

### Phase 5: MR Status Tracking (ONGOING)
- **Status**: see `MEMORY.md` "Current Status" for open/closed counts (volatile; not
  duplicated here)
- **Key files**: `data/open.txt`, `data/closed.txt`; `MRS_BY_AUTHOR.md` is kept as an
  archival reference only — do not edit it

---

## Core Principles

### 1. Keep Latest Principle
When branches are duplicates or near-duplicates, **always keep the LATEST submission** (most
recent date). Latest may have updated commit messages, corrections, or refinements.

### 2. Author-Based Analysis
Process branches by author to efficiently identify duplicates. Same author is the most common
source of duplicate submissions.

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
- `MRS_BY_AUTHOR.md`: **Archival reference only** (not reconciled against `data/open.txt`;
  do not edit)
- `MEMORY.md`: Complete workflow reference and repository state
- `CLAUDE.md`: This file - repository instructions
- `branches.txt`, `mrs.txt`, `duplicates.txt`, `authors.txt`
- `pipeline.sh`, `helpers/*.sh`: automation (discovery, checkout, submission) — see MEMORY.md
  "How review requests reach this session"; there is no `closed.sh` (see
  `helpers/mr-status.sh`/`helpers/mr-status-new.sh`)

### data/
- `open.txt` / `closed.txt`: open/closed MR numbers (source of truth; counts in MEMORY.md)

### reviews/
- `prNN.md` / `YYYY-MM-NNNN.md`: Complete code reviews
- `*_reasoning.txt`: Deep technical justifications for reviews WITH issues
- `*_investigation.txt`: Verification trail for large/complex CLEAN reviews
- All files comply with 120 char line width; current counts in `MEMORY.md` "Current Status"

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
- Edit `MRS_BY_AUTHOR.md` — archival reference only, not a maintained tracking document

### DO:
- Author-based analysis for duplicates
- Keep latest version of duplicates
- **Verify every bug by reading actual code**
- **Count commits and ensure all reviewed**
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

**Last updated**: 2026-10-08

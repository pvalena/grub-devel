# Repository Memory - Current State

**Last updated**: 2026-05-29

Quick reference for working in this repository. See `CLAUDE.md` for repository overview
and `docs/REVIEW_PROCESS.md` for detailed procedures.

---

## Current Status

- **Total MRs tracked**: 82 (63 original + 19 new upstream MRs)
- **Open MRs**: 26
- **Closed/Merged MRs**: 56
- **Active authors**: 20

**Review files**:
- Complete reviews: 86 (.md files)
- Reasoning files: 31 (_reasoning.txt files, only for reviews with issues)

---

## Quick File Reference

**Tracking**:
- `MRS_BY_AUTHOR.md` - Active MRs by author (26 open, 20 authors)
- `data/open.txt` - Open MR numbers (source of truth)
- `data/closed.txt` - Closed MR numbers

**Reviews**:
- `reviews/YYYY-MM-NNNN.md` - Code reviews (older branches, named by mailing list date)
- `reviews/prNN.md` - Code reviews (new MRs, named by MR number)
- `reviews/*_reasoning.txt` - Deep technical justifications (only for reviews with issues)

**Documentation**:
- `CLAUDE.md` - Repository instructions and essentials
- `MEMORY.md` - This file - workflows and current state
- `docs/REVIEW_PROCESS.md` - Detailed review procedures

**Data**:
- `grub/` - Git repo with all branches (**DO NOT MODIFY**)
- Base commit (older branches): `c160b58610879a52d959db21b9cae98af5fd095f`
- Base for new MRs: `origin/master` (branches are rebased)
- Branch format: `YYYY-MM-NNNN` (older) or `prNN` (new MRs, e.g., pr89)

---

## Review Workflow

Complete process for reviewing GRUB merge requests. See global review skill for
full details.

### Phase 1: Perform Code Review

**Critical principle**: NEVER report a bug without verifying it by reading actual code.

1. **Count commits** (use correct base):
   ```bash
   cd grub/
   # For new MRs (prNN branches):
   git log --oneline origin/master..prNN
   # For older branches (YYYY-MM-NNNN):
   git log --oneline c160b5861..BRANCH
   ```

2. **Read full diff**, then **read actual source** at the branch:
   ```bash
   git diff origin/master..prNN
   git show prNN:path/to/file.c | sed -n 'START,ENDp'
   ```

3. **Create review file**: `reviews/prNN.md` (or `reviews/YYYY-MM-NNNN.md`)

### Phase 2: Verify Findings

Re-read actual source for every reported issue. Check for false positives
(missed NULL checks, cleanup code outside the diff, API guarantees).
Also re-check clean reviews for missed issues.

### Phase 3: Draft Fixes

For each confirmed issue, add a diff patch if the fix is straightforward
(1-10 lines, obvious, self-contained). Otherwise, explain why it is not
a straightforward fix.

### Phase 4: Deep Reasoning

**Only for reviews with issues.** Create `reviews/prNN_reasoning.txt` with
Discovery / Analysis / Step-by-step / Consequence sections for each issue.
Add "For more details" link in the review .md file pointing to the reasoning file.

### Phase 5: Format and Verify

120 character line width (mandatory). Verify commit count matches review.
```bash
awk 'length > 120' reviews/prNN.md
```

### MR Status Update Workflow

When MRs close:

1. **Check status**: `./closed.sh`
2. **Update tracking**: Move MR numbers from `data/open.txt` to `data/closed.txt`
3. **Update MRS_BY_AUTHOR.md**: Remove closed MRs, update counts, remove empty authors
4. **Verify**:
   ```bash
   diff <(grep -oE '\[!([0-9]+)\]' MRS_BY_AUTHOR.md | sed -E 's/.*!([0-9]+).*/\1/' \
     | sort -n) <(sort -n data/open.txt)
   ```

---

## GitLab Configuration

**Repository URLs**:
- Development fork: https://gitlab.freedesktop.org/pvalena/grub/
- Upstream: https://gitlab.freedesktop.org/gnu-grub/grub/

**glab configuration**:
```bash
# One-time setup
glab config set host gitlab.freedesktop.org --global

# View MR
glab mr view <N> --repo gnu-grub/grub

# Comment on MR
glab mr comment <N> --repo gnu-grub/grub -m "comment text"

# Check status
glab mr view <N> --repo gnu-grub/grub 2>/dev/null | grep "^state:"
```

**Important**: Always use `--repo gnu-grub/grub` flag (git remote uses ssh.gitlab.freedesktop.org).

---

## Important Review Cases

### MR !89 - Authentication Access Levels (pr89)
**Issues**: 3 found -- dead code (case branch ordering), doc/code delimiter mismatch, multi-user
list formatting. All verified with draft fixes or "not straightforward" explanations.
**Lesson**: Shell case `x*)` matches before `x)` -- always put exact matches first.

### MR !115 - EFI Skip Registration (pr115)
**Issues**: 2 found -- error/success return conflation (errno treated as "registered"), missing
fclose(fp). The fclose was found during verification pass, not initial review.
**Lesson**: Always trace return value semantics through caller. Run verification as a separate pass.

### MR !42 - xHCI Support (2025-05-0103)
**Issue**: Double-free vulnerability at grub-core/bus/usb/xhci.c:2099,2196
**Lesson**: Always check for NULL assignment between frees.

### MR !78 - NVMeoFC Support (2026-02-0071)
**Issue**: Review was incomplete (listed 3 commits, actually 6)
**Lesson**: Verify commit count before finalizing review.

---

## Quick Reference

**Essential commands**:
```bash
# Review workflow (new MRs)
cd grub/
git log --oneline origin/master..prNN         # Count commits
git diff origin/master..prNN                  # Full diff
git show prNN:file.c | sed -n 'LINE1,LINE2p' # Read actual source

# Formatting
awk 'length > 120' reviews/prNN.md            # Check line width

# Verification (MRS_BY_AUTHOR vs data/open.txt)
diff <(grep -oE '\[!([0-9]+)\]' MRS_BY_AUTHOR.md | \
  sed -E 's/.*!([0-9]+).*/\1/' | sort -n) <(sort -n data/open.txt)
```

**Key principles**:
1. **Quality over quantity** - Zero false positives
2. **Verify every bug** - Read actual code, not just diffs
3. **Completeness mandatory** - All commits must be reviewed
4. **120 char limit** - All documentation files

---

## Statistics

**Current (2026-05-29)**:
- Open MRs: 26
- Active authors: 20
- Largest contributor: Vladimir Serbinenko (6 MRs)
- Closed rate: 68% (56/82)
- Review files: 86 reviews, 31 reasoning files

**Historical**:
- Initial branches: 176 (from mailing lists)
- Duplicates removed: 65 (39% rate)
- Unique branches: 111
- Original MRs created: 63, plus 19 new upstream MRs reviewed

---

## File Update Policy

**Update MRS_BY_AUTHOR.md when**:
- MRs are closed/merged (remove them)
- New MRs opened (add them)

**DO NOT update**:
- `ai-analysis/BRANCHES_REVIEWS.md` (historical record)
- `grub/` repository files (analysis only)

**Always verify**:
- MRS_BY_AUTHOR.md matches `data/open.txt` after updates
- Author counts are correct

---

**Note**: This file contains working knowledge for the repository. See `CLAUDE.md`
for project overview and `docs/REVIEW_PROCESS.md` for detailed procedures.

# Repository Memory - Current State

**Last updated**: 2026-04-10

Quick reference for working in this repository. See `CLAUDE.md` for repository overview and `docs/REVIEW_PROCESS.md` for detailed procedures.

---

## Current Status

- **Total MRs tracked**: 63 (originally created)
- **Open MRs**: 48
- **Closed/Merged MRs**: 15
- **Active authors**: 34

**Review files**:
- Complete reviews: 50 (.md files)
- Reasoning files: 22 (_reasoning.txt files, only for reviews with issues)

---

## Quick File Reference

**Tracking**:
- `MRS_BY_AUTHOR.md` - Active MRs by author (48 open)
- `data/open.txt` - Open MR numbers (source of truth)
- `data/closed.txt` - Closed MR numbers

**Reviews**:
- `reviews/YYYY-MM-NNNN.md` - Complete code reviews
- `reviews/YYYY-MM-NNNN_reasoning.txt` - Brief technical justifications (only for issues)

**Documentation**:
- `CLAUDE.md` - Repository instructions and essentials
- `MEMORY.md` - This file - workflows and current state
- `docs/REVIEW_PROCESS.md` - Detailed review procedures

**Data**:
- `grub/` - Git repo with all branches (**DO NOT MODIFY**)
- Base commit: `c160b58610879a52d959db21b9cae98af5fd095f`
- Branch format: `YYYY-MM-NNNN` (e.g., 2025-05-0103)

---

## Review Workflow

Complete process for reviewing GRUB merge requests.

### Phase 0: Perform Code Review

**Critical principle**: NEVER report a bug without verifying it by reading actual code.

**Process**:

1. **Checkout and count commits**:
   ```bash
   cd grub/
   git checkout BRANCH_NAME
   git log --oneline c160b58610879a52d959db21b9cae98af5fd095f..HEAD | wc -l
   # Remember this number - ALL commits must be reviewed
   ```

2. **Examine changes**:
   ```bash
   git log --oneline c160b58610879a52d959db21b9cae98af5fd095f..HEAD
   git diff c160b58610879a52d959db21b9cae98af5fd095f..HEAD
   ```

3. **Read actual code** (not just diffs!):
   ```bash
   git show HEAD:path/to/file.c | less
   git show HEAD:path/to/file.c | sed -n 'START,ENDp'
   ```

4. **Verify EVERY bug** before documenting:
   ```bash
   # Example: Verify double-free claim
   git show HEAD:file.c | sed -n '2090,2105p'  # First free
   git show HEAD:file.c | sed -n '2190,2200p'  # Second free
   git show HEAD:file.c | grep "= NULL"        # Check NULL assignment
   # Only document if VERIFIED in actual code
   ```

5. **Create review file**: `reviews/BRANCH_NAME.md`

**Review checklist**:
- [ ] All commits counted and listed
- [ ] Every bug verified by reading actual code
- [ ] No false positives (checked cleanup code, NULL assignments)
- [ ] File paths and line numbers accurate
- [ ] Impact/consequences stated

### Phase 1: Generate Reasoning Files

**Only for reviews with issues found.**

Create `reviews/BRANCH_NAME_reasoning.txt`:

**Format**:
```
[Severity]: [Issue at location]. [Technical explanation]. [Consequences].
```

**Severity levels**:
- **Critical**: Crashes, memory corruption, security bugs, compilation errors
- **Minor**: Style issues, misleading names, non-critical leaks
- **Note**: Observations, limitations, requires specialized review
- **Concern**: Potential issues needing deeper analysis

**Example**:
```
Critical: Double-free at grub-core/bus/usb/xhci.c:2099,2196. grub_xhci_check_transfer() frees
transfer->controller_data (line 2099) without setting to NULL. If grub_xhci_cancel_transfer()
subsequently called, retrieves dangling pointer and frees again (line 2196).
```

### Phase 2: Format Documentation

**Constraint**: 120 character line width (mandatory).

**Check formatting**:
```bash
awk 'length > 120 {print NR": " $0}' reviews/BRANCH.md
```

**Fix long lines** - break at commas, periods, before conjunctions.

### Phase 3: Verification & Quality Assurance

**Zero tolerance for false positives.**

**Verify accuracy**:
```bash
# Read actual code to confirm bug exists
git show HEAD:file.c | sed -n 'START,ENDp'

# Check for cleanup code outside diff
git show HEAD:file.c | grep -E "(= NULL|cleanup|free)"
```

**Common false positive patterns**:
- **Double-free**: Missed `ptr = NULL` between frees
- **NULL dereference**: Missed early NULL check
- **Resource leak**: Value is invalid (0, NULL) so no leak

**Verify completeness**:
```bash
# Count commits
git log --oneline c160b58610879a52d959db21b9cae98af5fd095f..HEAD | wc -l

# Compare with review file - numbers MUST match
```

**If commits missing**: Review ALL missing commits thoroughly.

### MR Status Update Workflow

When MRs close:

1. **Check status**: `./closed.sh`
2. **Update tracking**:
   - Move MR numbers from `data/open.txt` to `data/closed.txt`
3. **Update MRS_BY_AUTHOR.md**:
   - Remove closed MRs
   - Update author counts
   - Remove authors with only closed MRs
4. **Verify**:
   ```bash
   wc -l data/open.txt
   grep -c 'merge_requests' MRS_BY_AUTHOR.md
   # Should match
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

### MR !42 - xHCI Support (2025-05-0103)
**Issue**: Double-free vulnerability
**Location**: grub-core/bus/usb/xhci.c:2099,2196
**Status**: Verified as real bug (not false positive)
**Lesson**: Always check for NULL assignment between frees

### MR !39 - Cygwin/Windows Build Fixes (2025-05-0016)
**Issue**: Review was incomplete (listed 5 commits, actually 9)
**Critical commit**: 030e96cbb (prevents crash)
**Lesson**: Always count commits with git log, don't trust manual counts

### MR !78 - NVMeoFC Support (2026-02-0071)
**Issue**: Review was incomplete (listed 3 commits, actually 6)
**Lesson**: Verify commit count before finalizing review

---

## Quick Reference

**Essential commands**:
```bash
# Review workflow
cd grub/ && git checkout BRANCH
git log --oneline c160b5861..HEAD | wc -l  # Count commits
git show HEAD:file.c | sed -n 'LINE1,LINE2p'  # Verify bug

# Formatting
awk 'length > 120' reviews/FILE.md  # Check line width

# Verification
grep -c 'merge_requests' MRS_BY_AUTHOR.md  # Count MRs in doc
wc -l data/open.txt  # Count MRs in data file
diff -u data/open.txt <(grep -oE '!([0-9]+)' MRS_BY_AUTHOR.md | tr -d '!' | sort -n)
```

**Key principles**:
1. **Quality over quantity** - Zero false positives
2. **Verify every bug** - Read actual code, not just diffs
3. **Completeness mandatory** - All commits must be reviewed
4. **120 char limit** - All documentation files

---

## Statistics

**Current (2026-04-10)**:
- Open MRs: 48
- Active authors: 34
- Largest contributor: Vladimir Serbinenko (8 MRs)
- Closed rate: 24% (15/63)

**Historical**:
- Initial branches: 176 (from mailing lists)
- Duplicates removed: 65 (39% rate)
- Unique branches: 111
- MRs created: 63
- Original authors: 38

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

**Note**: This file contains working knowledge for the repository. See `CLAUDE.md` for project overview and `docs/REVIEW_PROCESS.md` for detailed procedures.

# Repository Memory - Current State

**Last updated**: 2026-03-27

---

## Current Status

- **Total MRs tracked**: 63 (originally created)
- **Open MRs**: 51
- **Closed/Merged MRs**: 12
- **Active authors**: 36 (down from 39 after removing authors with only closed MRs)

---

## Key Files

### Root Directory

- **`MRS_BY_AUTHOR.md`** - Main tracking document for open MRs organized by author
  - Contains exactly 51 open MRs
  - 36 active authors
  - Updated 2026-03-27 to remove closed MRs

- **`open.txt`** - List of open MR numbers (51 MRs)
  - One MR number per line
  - Source of truth for which MRs are still open

- **`closed.txt`** - List of closed/merged MR numbers (12 MRs)
  - MRs: 19, 44, 45, 50, 55, 56, 57, 58, 62, 63, 64, 77

- **`closed.sh`** - Script to check MR status and generate closed.txt
  - Uses `glab` to query GitLab API
  - Checks all MRs from data/mrs.txt

- **`open.sh`** - Script to generate list of open MRs (referenced in conversation)

- **`CLAUDE.md`** - Project instructions and documentation
  - Contains complete project history
  - Phase 1: Duplicate detection (176 → 111 branches)
  - Phase 2: Branch analysis (111 branches analyzed)
  - Phase 3: MR creation (63 MRs created)

- **`duplicates.txt`** - List of 65 duplicate branches removed

- **`authors.txt`** - List of 38 unique authors with obfuscated emails

- **`branches.txt`** - List of 63 active branches

- **`mrs.txt`** - Branch to MR mapping (format: `BRANCH|MR_NUMBER`)

### ai-analysis/ Directory

- **`BRANCHES_REVIEWS.md`** - Review results grouped by issue severity
  - Contains critical/minor/no-issue categorization
  - NOT updated with closed MR removal (intentionally, per user instruction)

- **`branch_analysis.json`** - Complete structured data for all branches

- **`BRANCH_ANALYSIS_SUMMARY.md`** - Executive summary with statistics

- **`MERGE_PRIORITY_LIST.md`** - Priority-based merge guide

- **`BRANCHES_BY_AUTHOR_BRIEF.md`** - Author-grouped branch listing (not MRs)
  - Contains branch names, not MR numbers
  - Links to pvalena fork, not upstream

- **`ANALYSIS_README.md`** - Documentation guide with JQ query examples

### reviews/ Directory

- Contains individual review files for each branch/MR
- Format: `YYYY-MM-NNNN.md` (branch name)
- Example: `reviews/2025-05-0103.md` for MR !42

### docs/ Directory

- **`REVIEW_PROCESS.md`** - Comprehensive review workflow documentation
  - Created 2026-03-27
  - Covers verification, false positive detection, GitLab integration
  - Committed as 85cdc01

### grub/ Subdirectory

- **Git repository** with all branch commits
- **IMPORTANT**: All branches are in this subdirectory
- Must `cd grub/` to access branches
- **DO NOT MODIFY** - analysis only

---

## Closed MRs Removed (2026-03-27)

The following 12 MRs were removed from MRS_BY_AUTHOR.md:

| MR | Title | Author |
|----|-------|--------|
| !19 | term/ns8250: return in case of a null SPCR base addresses | Leo Sandoval |
| !44 | disk/efi/efidisk: Fix memory leak | khaalid cali |
| !45 | kern/vercmp: Add functionality to compare kernel versions | Alec Brown |
| !50 | Create Containerfiles for development | Leo Sandoval |
| !55 | Implement _gcry_get_hw_features() | Gary Lin |
| !56 | Build blake2/sha256 with x86_64 optimizations | Gary Lin |
| !57 | Fix blake2.c typo | Gary Lin |
| !58 | Fix missing-prototypes in sha256-intel-shaext.c | Gary Lin |
| !62 | Remove -w param from mkfs.hfsplus | Leo Sandoval |
| !63 | Add Containerfile for distro images | Leo Sandoval |
| !64 | Disable video_bochs/cirrus for EFI x86 | Andrew Hamilton |
| !77 | Add jump/delete word shortcuts to cmdline | Mate Kukri |

**Authors completely removed** (only had closed MRs):
- Leo Sandoval (all 4 MRs closed)
- khaalid cali (!44 only)
- Alec Brown (!45 only)
- Andrew Hamilton (!64 only)

---

## GitLab Configuration

### Repository URLs
- **Development fork**: https://gitlab.freedesktop.org/pvalena/grub/
- **Upstream**: https://gitlab.freedesktop.org/gnu-grub/grub/

### glab Configuration
- **Host**: `gitlab.freedesktop.org` (set globally)
- **Command format**: `glab mr comment <N> --repo gnu-grub/grub -m "message"`
- **Important**: Always use `--repo gnu-grub/grub` flag
- **Note**: Git remote uses `ssh.gitlab.freedesktop.org`, but glab uses `gitlab.freedesktop.org`

### Common Commands
```bash
# View MR
glab mr view <N> --repo gnu-grub/grub

# Comment on MR
glab mr comment <N> --repo gnu-grub/grub -m "comment text"

# Check MR status
glab mr view <N> --repo gnu-grub/grub 2>/dev/null | grep "^state:"
```

---

## Recent Work (2026-03-27)

### Completed
1. ✅ Verified MR !42 review accuracy (double-free bug confirmed real)
2. ✅ Fixed MR !39 review completeness (9 commits vs 5 listed)
3. ✅ Fixed MR !78 review completeness (6 commits vs 3 listed)
4. ✅ Debugged and solved GitLab API certificate errors
5. ✅ Created docs/REVIEW_PROCESS.md (committed as 85cdc01)
6. ✅ Created closed.sh script to identify closed MRs
7. ✅ Updated MRS_BY_AUTHOR.md to remove 12 closed MRs
8. ✅ Verified MRS_BY_AUTHOR.md matches open.txt exactly (51 MRs)

### Notes
- ai-analysis/BRANCHES_REVIEWS.md was NOT updated (per user instruction)
- Only MRS_BY_AUTHOR.md should track open MRs going forward

---

## Important Review Cases

### MR !42 - xHCI Support
- **Branch**: 2025-05-0103
- **Issue**: Double-free vulnerability in transfer cancellation
- **Status**: Verified as real bug (not false positive)
- **Location**: grub-core/bus/usb/xhci.c lines 2099, 2196
- **Review file**: reviews/2025-05-0103.md

### MR !39 - Cygwin/Windows Build Fixes
- **Branch**: 2025-05-0016
- **Commits**: 9 (was incorrectly listed as 5)
- **Critical commit**: 030e96cbb (prevents crash)
- **Review file**: reviews/2025-05-0016.md

### MR !78 - NVMeoFC Support
- **Branch**: 2026-02-0071
- **Commits**: 6 (was incorrectly listed as 3)
- **Review file**: reviews/2026-02-0071.md

---

## Verification Commands

### Check MRS_BY_AUTHOR.md matches open.txt
```bash
# Extract MRs from MRS_BY_AUTHOR.md
grep -E '\[!([0-9]+)\]' MRS_BY_AUTHOR.md 2>/dev/null | \
  sed -E 's/.*\[!([0-9]+)\].*/\1/' | sort -n > /tmp/mrs_in_doc.txt

# Compare with open.txt
diff -u open.txt /tmp/mrs_in_doc.txt
# (Empty output = perfect match)
```

### Count MRs
```bash
# Count in open.txt
cat open.txt | grep -v '^$' | wc -l

# Count in MRS_BY_AUTHOR.md
grep -c 'merge_requests' MRS_BY_AUTHOR.md
```

---

## Git Repository Info

### Base Commit
- **Master base**: c160b58610879a52d959db21b9cae98af5fd095f
- All branch commits are counted from this base

### Branch Format
- Format: `YYYY-MM-NNNN` (e.g., 2025-05-0103)
- Year: 2025 or 2026 (submission year)
- Month: 01-12
- Number: 0001-9999 (sequential)

---

## Email Obfuscation
All email addresses in documentation use standard obfuscation:
- `@` → ` at `
- `.` → ` dot `

Example: `user@example.com` → `user at example dot com`

---

## File Update Policy

### Update MRS_BY_AUTHOR.md when:
- MRs are closed/merged (remove them)
- New MRs are opened (add them)
- Author information changes

### DO NOT update:
- ai-analysis/BRANCHES_REVIEWS.md (historical record)
- grub/ repository files (analysis only, no modifications)

### Always verify:
- MRS_BY_AUTHOR.md matches open.txt after updates
- Author counts are correct
- MR counts per author are accurate

---

## Statistics

### Current (2026-03-27)
- **Open MRs**: 51
- **Active authors**: 36
- **Largest contributor**: Vladimir Serbinenko (8 MRs)
- **Closed rate**: 19% (12/63)

### Historical (from CLAUDE.md)
- **Initial branches**: 176 (2025-2026 patches)
- **Duplicates removed**: 65 (39% duplication rate)
- **Unique branches**: 111
- **MRs created**: 63
- **Original authors**: 38

---

## Next Steps / TODO

- Monitor for new MR status changes
- Update MRS_BY_AUTHOR.md as MRs close
- Maintain open.txt and closed.txt
- Continue review process for remaining open MRs

---

**Note**: This file should be updated whenever significant changes occur to MR status, file structure, or workflow processes.

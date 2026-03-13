# Instructions for Claude

## Repository Purpose
This repository is used for analyzing GRUB2 patches from mailing lists and identifying duplicates in cleanly-applied git branches.

## Primary Task: Detect Duplicate Git Branches

### Process
1. Use `./view.sh` script to view all branches and their commits
   - Branch names are shown between `><` markers
   - Commit messages and file stats are shown below each branch
2. The git repository is located in `grub/` subdirectory
3. Patch directories follow the naming pattern `YEAR-MONTH-d` (e.g., `2026-02-d`, `2026-03-d`)

### Analysis Requirements
Compare branches using `git diff` to identify:
- **Exact duplicates**: Empty diff output (branches are 100% identical)
- **Nearly identical branches**: Minor differences only (e.g., whitespace, comments)
- **Corrected/improved versions**: Same commit message and purpose, but improved implementation

### What to Compare
- Commit messages (identical or very similar)
- Code changes (use `git diff branch1 branch2`)
- Authors and dates (to identify resubmissions)
- File modifications and line counts

### Output Format
Create `duplicates.txt` file listing branches to remove:
- One branch name per line
- No additional text or comments
- Keep the earlier/better version, list the duplicates for removal

## Restrictions
- **DO NOT** modify any files in the `grub/` repository
- **DO NOT** create commits, branches, or make any git changes
- **ONLY** analyze, compare, and report on branches as described above

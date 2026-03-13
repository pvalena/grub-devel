# Instructions for Claude

## Repository Purpose
This repository is used for analyzing GRUB2 patches from mailing lists and identifying duplicates in cleanly-applied git branches.

## Primary Task: Detect Duplicate Git Branches

### Recommended Strategy: Author-Based Analysis

Process branches by author to efficiently identify duplicates. Same author is the most common source of duplicate submissions (resubmissions, corrections, iterations).

### Workflow Steps

#### 1. Extract Author's Branches
```bash
git branch | grep -E '^\s*(2025|2026)' | xargs -I {} sh -c 'author=$(git log "{}" --format="%an" -1); if [ "$author" = "AUTHOR_NAME" ]; then echo "{}"; fi' | sort
```

#### 2. Get Commit Messages
```bash
for branch in BRANCH_LIST; do
  echo "=== $branch ==="
  git log "$branch" --format="%s" -1
done
```

#### 3. Group by Similar Commit Messages
Look for patterns:
- Identical commit subjects
- Similar subjects (e.g., with/without version numbers)
- Related functionality (e.g., different parts of same feature)

#### 4. Compare Suspicious Pairs/Groups
For each group of branches with identical/similar commit messages:
```bash
git diff branch1 branch2
```

#### 5. Classify Duplicates

**Type A: Exact Duplicates** (empty diff)
- Branches are 100% identical
- Keep the **earliest** submission
- Add all others to `duplicates.txt`

**Type B: Nearly Identical** (minor differences only)
- Only whitespace, comments, or trivial formatting changes
- Keep the **earliest** submission
- Add others to `duplicates.txt`

**Type C: Superseded/Obsoleted Versions**
- Same commit message and purpose
- Later version has **significant improvements** or **bug fixes**
- Keep the **later/better** version
- Add the **older/superseded** version to `duplicates.txt`
- **Example**: 2025-04-0093 vs 2025-05-0011
  - Both about "Use ET_DYN instead of ET_REL modules"
  - 2025-05-0011 is a major refactoring with additional changes
  - Result: Keep 2025-05-0011, remove 2025-04-0093

**Type D: Different Implementations** (NOT duplicates)
- Same problem being solved
- Completely different approaches
- Keep both for review

### Example Analysis: Vladimir Serbinenko (33 branches)

**Found duplicate groups:**
1. "Implement __aeabi_uldivmod" - 5 identical branches → kept 2025-04-0047
2. "loongarch64: Use la.pcrel" - 2 identical branches → kept 2025-04-0056
3. "Enable [u]divdi3 for mips" - 3 identical branches → kept 2025-04-0101
4. "x86_64-efi: Ensure memory mapped" - 2 identical branches → kept 2025-04-0233
5. "Fix cross-compiling for windows" - 2 identical branches → kept 2025-05-0002
6. "compiler-rt: Add pei386_runtime_relocator" - 2 identical → kept 2025-05-0003
7. "pe2elf: Set correct flag" - 2 identical branches → kept 2025-05-0004
8. "Use ET_DYN instead of ET_REL" - 2 versions → kept 2025-05-0011 (supersedes 2025-04-0093)

**Result:** 11 duplicates removed from 33 branches (33% duplication rate)

### Output Format

Append to `duplicates.txt`:
- One branch name per line
- No additional text or comments
- Branch names only (e.g., `2025-04-0088`)

### Process Order

1. **High-volume authors** (>10 branches) - process individually
2. **Medium-volume authors** (5-10 branches) - process individually or in small batches
3. **Low-volume authors** (<5 branches) - process in batches of 5-10 authors

### Restrictions

- **DO NOT** modify any files in the `grub/` repository
- **DO NOT** create commits, branches, or make any git changes
- **ONLY** analyze, compare, and report on branches as described above
- **DO** append findings to `duplicates.txt` after each author analysis

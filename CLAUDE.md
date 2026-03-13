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

**IMPORTANT PRINCIPLE: Always Keep the LATEST Version**

When branches are duplicates or near-duplicates, **always keep the LATEST submission** (most recent date). Rationale:
- Latest submission may have updated commit messages
- Author may have made final corrections or refinements
- Later dates indicate the author's final intent

**Type A: Exact Duplicates** (empty diff)
- Branches are 100% identical
- Keep the **LATEST** submission (by date)
- Add all earlier versions to `duplicates.txt`
- **Example**: 2025-05-0204, 2025-05-0205, 2025-05-0220 all identical
  - Result: Keep 2025-05-0220 (latest), remove 2025-05-0204, 2025-05-0205

**Type B: Nearly Identical** (minor differences only)
- Only whitespace, comments, or trivial formatting changes
- Keep the **LATEST** submission (by date)
- Add earlier versions to `duplicates.txt`
- **Example**: 2025-05-0206 vs 2025-05-0221 (trivial formatting differences)
  - Result: Keep 2025-05-0221 (latest), remove 2025-05-0206

**Type C: Superseded/Obsoleted Versions**
- Same commit message and purpose
- Later version has **significant improvements** or **bug fixes**
- Keep the **LATEST/BETTER** version
- Add the **older/superseded** version to `duplicates.txt`
- **Example**: 2025-04-0093 vs 2025-05-0011
  - Both about "Use ET_DYN instead of ET_REL modules"
  - 2025-05-0011 is a major refactoring with additional changes
  - Result: Keep 2025-05-0011 (latest and improved), remove 2025-04-0093

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

### Documentation Requirements

**IMPORTANT: Always Document Explicit Reasons**

Before adding branches to `duplicates.txt`, you MUST:
1. Verify the relationship between branches (exact duplicate, superseded, etc.)
2. Document the explicit reason for each duplicate
3. Ensure branches actually conflict or are truly redundant
4. DO NOT add branches with:
   - Different commit messages (unless one clearly supersedes the other)
   - Different files modified
   - No clear relationship

**Format for documenting reasons:**
```
BRANCH_NAME  (Reason: TYPE - specific justification)
```

**Examples:**
```
2025-04-0088  (Reason: Exact duplicate of 2025-04-0047)
2025-04-0093  (Reason: Superseded by 2025-05-0011 - major refactoring with additional changes)
2025-05-0204  (Reason: Exact duplicate, 2025-05-0220 is latest)
```

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

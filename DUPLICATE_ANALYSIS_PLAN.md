# Duplicate Branch Analysis Plan

## Overview
- **Total branches**: 176 (2025-2026 patches)
- **Total unique authors**: 38 (with name normalization)
- **Date range**: 2025-01 through 2026-03

## Author Distribution

### High-volume authors (>10 branches)
- Vladimir Serbinenko: 33 branches
- Nicholas Vinson: 15 branches
- Avnish Chouhan: 14 branches
- Leo Sandoval: 13 branches

### Medium-volume authors (5-10 branches)
- Gary Lin: 10 branches
- Ross Philipson: 8 branches
- Michael Chang: 5-6 branches (including "via Grub-devel" variant)
- Jiří Wolker: 5-6 branches (including "'bindiff'" variants)

### Low-volume authors (<5 branches)
- 30 authors with 1-4 branches each

## Recommended Strategy

### **Option A: Author-Based Batching (RECOMMENDED)**

**Pros:**
- Logical grouping - same author often resubmits same patches
- Easier to spot patterns in commit messages
- Can process high-volume authors separately
- Efficient use of git commands (fewer context switches)

**Process:**
1. **Tier 1 - High-volume authors** (4 authors, 75 branches total)
   - Vladimir Serbinenko (33)
   - Nicholas Vinson (15)
   - Avnish Chouhan (14)
   - Leo Sandoval (13)

2. **Tier 2 - Medium-volume authors** (4 authors, ~30 branches)
   - Gary Lin (10)
   - Ross Philipson (8)
   - Michael Chang (6)
   - Jiří Wolker (6)

3. **Tier 3 - Low-volume authors** (30 authors, ~70 branches)
   - Process in batches of 5-10 authors at a time
   - Less likely to have duplicates within same batch

### **Option B: Chronological Batching**

**Pros:**
- Finds duplicates across authors in same time period
- Good for identifying concurrent resubmissions

**Process:**
- Batch 1: 2025-01 to 2025-04 (~50 branches)
- Batch 2: 2025-05 to 2025-07 (~65 branches)
- Batch 3: 2025-09 to 2026-03 (~60 branches)

### **Option C: Hybrid Approach (BEST FOR THOROUGHNESS)**

**Process:**
1. Start with high-volume authors individually (they're most likely to have duplicates)
2. Then process remaining branches chronologically in batches
3. Final pass: compare across all branches for any missed duplicates

## Implementation Details

### For each batch:
1. Extract branch names for the batch
2. Use `git diff` to compare pairs with:
   - Same/similar commit messages
   - Same file modification patterns
3. Identify exact duplicates (empty diff)
4. Identify near-duplicates (minor differences)
5. Flag corrected versions (same purpose, improved code)
6. Append to `duplicates.txt`

### Optimization:
- Use commit message similarity as first filter
- Only run full `git diff` on suspicious pairs
- Cache file stats to avoid repeated `git show --stat` calls

## Estimated Effort

- **Option A**: 3-4 batches, ~2-3 comparisons per batch = 6-12 operations
- **Option B**: 3 batches, ~100-200 comparisons per batch = higher complexity
- **Option C**: 4 + 3 operations = 7 total batches

## Recommendation

**Use Option A (Author-Based Batching)** because:
1. Same author is most likely source of duplicates (resubmissions)
2. Fewer total comparisons needed
3. Easier to track progress
4. Can parallelize high-volume authors

**Start with Tier 1** (Vladimir Serbinenko's 33 branches) as a test case.

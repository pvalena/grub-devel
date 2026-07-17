# Import Analysis — Working Memory

**Last updated**: 2026-07-17

## What this is

Analysis pipeline for 1302 GRUB2 mailing list patches that failed to apply
to `grub/master`. The goal: identify which patches carry changes not yet
upstream, group them for review, and evaluate whether manual fixing is
worthwhile.

## Current state

| Metric | Count |
|--------|------:|
| Total branches analyzed | 1302 |
| Dropped (upstream/superseded) | 316 |
| Dropped (earlier dedup phase) | 987 |
| **KEEP standalone** | **25** |
| **KEEP series** | **21 members in 7 series** |
| **Total KEEP** | **46** |
| Evaluated in-depth | 46 (all categories complete) |

## Pipeline (as refined through iterations)

The process below reflects what we learned — this is how to do it from
scratch next time, avoiding the missteps.

### Phase 1: Classification

Input: `failed.txt` (branch list), `logs/*.log` (apply results), `failed_subj.txt`.

1. Parse logs for SUCCESS (already applied) vs CONFLICT
2. Output: `classified.txt` with `branch|ALREADY_APPLIED|CLEAN_APPLY|CONFLICT`
3. The `empty.txt` file (user-provided) confirms ALREADY_APPLIED branches

### Phase 2: Series grouping + cross-version deduplication

1. Parse `failed_subj.txt` for `[PATCH vN M/T]` patterns
2. Group by (author, version, part_total, month, proximity) into series
3. Cross-version: same topic across v2/v3/v4... → keep latest version only
4. Same-commit-subject across remaining → resend detection, keep latest by date
5. **Critical**: verify keep-latest decisions using commit dates, not just
   version numbers. Version tags can be misleading (v6 from March vs v2 from
   September).
6. Re: entries are real patches — check each, don't auto-drop
7. Output: `series/*`, `standalone.txt`, `drop_new.txt`

### Phase 3: Code inspection against master

For each remaining branch, check if the FAILED.patch content exists on master.
This is the most important phase — subject matching is insufficient.

**Method per branch**:
1. Read FAILED.patch diff targets (files and functions)
2. `git show master:<file>` and grep for key symbols
3. If found → DROP with master line reference as evidence
4. If not found → KEEP

**Common traps**:
- Same fix under different constant name (`SSIZE_MAX` vs `GRUB_SSIZE_MAX`)
- Same fix by different author with different approach
- HTML-encoded patches (Re: emails) — use `strings` for extraction
- Binary content in FAILED.patch (reproducers) — grep fails silently

**Process**: one branch at a time (or small batches). Use `inspect.sh` /
`inspect-standalone.sh`. Log every decision to `INSPECTION_LOG*.md`.

### Phase 4: Confirmation

Second pass verifying every DROP decision. For each:
- Standalone: re-check the specific evidence claim against master
- Series: verify key features from the whole series against master
- Log all checks to `confirmation.log` via `tee -a`
- Output: `confirmed.txt`, `confirmed_series.txt`

### Phase 5: Cross-topic grouping

After inspection, check for standalones that belong in existing series
or with each other:
- Same FAILED.patch target files (excluding infrastructure: Makefile, configure.ac, docs)
- Same topic / same author / sequential versions
- Merge where appropriate, drop older versions superseded within KEEPs

### Phase 6: In-depth evaluation

For each KEEP, generate comprehensive evaluation:
- `generate_evaluation.sh` creates `evaluation/<branch>.txt`
- `generate_evaluation_overview.py` creates the summary table
- Category-by-category code review in `EVALUATION_LOG_<CATEGORY>.md`
- During review, may discover more redundancies → drop and re-verify

### Phase 7: Verification (continuous)

Run after every change:
```bash
python3 generate_unified.py    # regenerate unified log
python3 verify_unified.py      # check unified log consistency
./verify.sh                    # check all data files
```

## File relationships

```
Source logs (hand-written):
  INSPECTION_LOG.md          — series decisions + evidence
  INSPECTION_LOG_STANDALONE.md — standalone decisions + evidence

Generated (never edit directly):
  INSPECTION_LOG_UNIFIED.md  ← generate_unified.py
  EVALUATION_OVERVIEW.md     ← generate_evaluation_overview.py
  evaluation/*.txt           ← generate_evaluation.sh
  SERIES.md                  ← generate script (inline)

Tracking files:
  drop_new.txt         — all drops
  standalone.txt       — standalone keeps
  series/*             — series keeps
  confirmed.txt        — verified standalone drops
  confirmed_series.txt — verified series drops
  evaluated.txt        — in-depth evaluated branches
  confirmation.log     — raw verification output
```

## Key lessons

1. **Surface-level matching misses semantic equivalence.** A grep for
   `GRUB_SSIZE_MAX` won't find `SSIZE_MAX`. Always check the code
   pattern, not just the identifier.

2. **Series members can be individually upstream.** When a series has
   N patches and N-1 are upstream, remove those N-1 and dissolve the
   series if only 1 remains. Don't keep upstream patches just because
   their sibling isn't.

3. **Re: emails carry real patches.** The FAILED.patch in a Re: branch
   is a real code submission, often a correction by a different author.
   Never auto-drop based on `Re:` prefix.

4. **Dissolved series need heading cleanup.** When a series is dissolved,
   remove branch IDs from the `## Series:` heading — otherwise the
   unified log generator puts them in the wrong section.

5. **The unified log is generated, not authored.** All edits go to the
   source logs (`INSPECTION_LOG.md`, `INSPECTION_LOG_STANDALONE.md`).
   Run `generate_unified.py` to rebuild. Run `verify_unified.py` to check.

6. **Binary content in FAILED.patch breaks grep.** The affs reproducer
   image makes the entire file binary. Use `strings` for field extraction.

7. **One constant in the whole pipeline: verify after every change.**
   The `verify.sh` + `verify_unified.py` pair catches every inconsistency.
   Never skip it.

# Instructions for Claude — import/ directory

This directory handles the analysis of GRUB2 mailing list patches that failed
to apply cleanly to upstream `grub/master`. The work follows a pipeline:
classify → deduplicate → inspect → confirm → evaluate.

## Repository layout

- `grub/` — git repo with all patch branches. **DO NOT MODIFY.**
- `series/` — patch groups to apply together (one file per series, ordered by part number)
- `evaluation/` — per-branch evaluation files for every KEEP branch
- `logs/` — apply logs from `commit-new.sh` (SUCCESS/CONFLICT per branch)

## Key data files (source of truth)

| File | Purpose | Mutually exclusive with |
|------|---------|------------------------|
| `standalone.txt` | Branches to keep, not part of any series | `drop_new.txt` |
| `series/*` | Series branches to keep (filename = series head) | `drop_new.txt` |
| `drop_new.txt` | Branches to drop (upstream/superseded) | `standalone.txt`, `series/*` |
| `confirmed.txt` | Standalone drops verified against master | subset of `drop_new.txt` |
| `confirmed_series.txt` | Series drop heads verified against master | subset of `drop_new.txt` |
| `evaluated.txt` | Branches with completed in-depth evaluation | subset of keeps |

## Core principles

### 1. Facts over assumptions
Every decision (DROP or KEEP) must be backed by verifiable evidence:
a specific master line number, a matching symbol, or a confirmed MISSING file.
Never drop a branch based on subject similarity alone — check the actual code.

### 2. The patch is in FAILED.patch
When a branch has `FAILED.patch`, that IS the intended change. The code files
in the commit may have conflict markers or partial merges from the auto-resolution.
Both parts together form the complete picture, but `FAILED.patch` has the clean diff.

### 3. No overlap between DROP and KEEP
A branch is in exactly one of: `standalone.txt`, a `series/*` file, or `drop_new.txt`.
Run `verify.sh` and `verify_unified.py` after any change to enforce this.

### 4. Series = one MR
Branches in the same `series/*` file should be applied together as one merge request.
They share a topic and are ordered by patch part number. When a series member is
found to be upstream, remove it from the series file — if the series becomes a
singleton, dissolve it to `standalone.txt`.

### 5. Confirm before trusting
Every DROP goes through confirmation: verify the specific evidence claim against
master. Don't batch-confirm — check each individually. Log all checks to
`confirmation.log` using `tee -a`.

### 6. Log everything
Every decision has an entry in `INSPECTION_LOG.md` (series) or
`INSPECTION_LOG_STANDALONE.md` (standalone). The unified view is generated —
never edit `INSPECTION_LOG_UNIFIED.md` directly.

## Scripts

### Inspection
- `inspect.sh <series>` — show all data for a series (uses series filename)
- `inspect-standalone.sh <branch> [branch2] ...` — show data for standalone branches

### Decision tracking
- `add-drop-new.sh <branch> ...` — add to `drop_new.txt` (dedup)
- `add-confirmed.sh <branch> ...` — add to `confirmed.txt` (dedup)
- `add-confirmed-series.sh <head> ...` — add to `confirmed_series.txt` (dedup)
- `add-evaluated.sh <branch> ...` — add to `evaluated.txt` (dedup)

### Generation (regenerate from source logs — never edit output directly)
- `generate_unified.py` — regenerate `INSPECTION_LOG_UNIFIED.md`
- `generate_evaluation.sh <branch> ...` — regenerate `evaluation/*.txt` files
- `generate_evaluation_overview.py` — regenerate `EVALUATION_OVERVIEW.md`

### Verification (run after every change)
- `verify.sh` — full consistency check across all data files
- `verify_unified.py` — bidirectional check of unified log vs data files

## Workflow for processing a batch of branches

1. **Inspect**: `inspect.sh` or `inspect-standalone.sh` to see the patch
2. **Check master**: grep for key symbols/functions on master
3. **Decide**: DROP (upstream) or KEEP (not upstream)
4. **Record**: add to `drop_new.txt` or leave in `standalone.txt`/`series/*`
5. **Log**: add entry to the appropriate `INSPECTION_LOG*.md`
6. **Confirm**: verify evidence with `tee -a confirmation.log`
7. **Regenerate**: `generate_unified.py`
8. **Verify**: `verify.sh` && `verify_unified.py`

## Gotchas learned the hard way

- `grep` fails silently on files with binary content (e.g., affs reproducer).
  Use `strings` for extraction from such files.
- `ugrep` (the default grep on this system) has different regex syntax than GNU grep.
  Patterns like `^\+` need escaping or alternatives.
- Same fix can land on master under a different constant name (`SSIZE_MAX` vs
  `GRUB_SSIZE_MAX`) or by a different author. Always check the actual code change,
  not just the symbol name.
- Dissolved series need their heading rewritten to remove branch IDs, otherwise
  the unified log generator picks them up in the wrong section.
- The `generate_unified.py` classifier uses `drop_new.txt` as authoritative —
  if a branch is in drops, it's DROP regardless of heading markers.

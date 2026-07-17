# CONTEXT DUMP — GRUB2 Failed Patches Import Analysis
**Generated**: 2026-07-18
**Session Type**: Multi-session continuation (7+ sessions spanning 2026-07-07 to 2026-07-18)

## What This Project Is

Analysis pipeline for 1302 GRUB2 mailing list patches that failed to apply cleanly to
upstream `grub/master`. The patches arrive as mbox files in `import/YYYY-MM-d/NNNN`,
are applied via `commit-new.sh` which creates branches in `grub/` with either SUCCESS
(already applied / clean apply) or CONFLICT (creates `FAILED.patch` with intended diff).

The goal: determine which patches carry changes NOT yet upstream, group them for
merge request submission, and evaluate whether manual incorporation is worthwhile.

The work progressed through 7 phases over multiple sessions: classification →
deduplication → code inspection → confirmation → cross-topic grouping → in-depth
evaluation → continuous verification. Each phase refined the previous, and the
evaluation phase itself discovered ~15% additional drops through semantic equivalence
checking.

## Current State

| Metric | Count |
|--------|------:|
| Total branches analyzed | 1302 |
| Prior dedup drops (Phase 2) | 987 |
| New drops (inspection + evaluation) | 316 |
| **KEEP standalone** | **25** |
| **KEEP series** | **21 members in 7 series** |
| **Total KEEP** | **46** |
| All 46 KEEPs evaluated in-depth | Yes |
| All 316 drops confirmed | Yes |

## Repository Layout

- `grub/` — git repo with all 1302+ branches. **READ ONLY — never modify.**
  Base: `origin/master`. Each branch has one commit: the patch attempt.
- `import/` — all analysis artifacts:
  - `series/` — 7 series files (filename = head branch, contents = ordered members)
  - `evaluation/` — 72 per-branch evaluation files (original 72 KEEPs, some now dropped)
  - `logs/` — per-branch apply logs from `commit-new.sh`
  - `import/YYYY-MM-d/NNNN` — original mbox source files

### Key Data Files (source of truth)

| File | Content | Mutually exclusive with |
|------|---------|------------------------|
| `standalone.txt` | 25 standalone KEEP branches | `drop_new.txt` |
| `series/*` | 7 series, 21 members total | `drop_new.txt` |
| `drop_new.txt` | 316 branches dropped during inspection/evaluation | `standalone.txt`, `series/*` |
| `confirmed.txt` | 194 standalone drops verified | subset of `drop_new.txt` |
| `confirmed_series.txt` | 33 series drop heads verified | subset of `drop_new.txt` |
| `evaluated.txt` | 46 branches with in-depth evaluation | subset of keeps |
| `classified.txt` | All 1302 branches with apply result | initial classification |
| `remaining.txt` | 315 branches after dedup (before inspection) | historical |

### Documentation Files

| File | Type | Content |
|------|------|---------|
| `FINAL_REPORT.md` | Report | Method, numbers, file index |
| `EVALUATION_OVERVIEW.md` | Generated | Summary table of all KEEP patches |
| `SERIES.md` | Generated | Series overview with links |
| `INSPECTION_LOG.md` | Source | Series decisions with evidence |
| `INSPECTION_LOG_STANDALONE.md` | Source | Standalone decisions with evidence |
| `INSPECTION_LOG_UNIFIED.md` | Generated | Unified view (never edit) |
| `EVALUATION_LOG_BUGFIX.md` | Evaluation | 6 bug fix reviews |
| `EVALUATION_LOG_RFC_DOCS.md` | Evaluation | 1 RFC + 2 doc reviews |
| `EVALUATION_LOG_COMPAT.md` | Evaluation | 9 compatibility reviews |
| `EVALUATION_LOG_ENHANCEMENT.md` | Evaluation | 11 enhancement reviews |
| `EVALUATION_LOG_NEWFEATURE.md` | Evaluation | 17 new feature reviews |
| `CLAUDE.md` | Instructions | Operational guide for AI continuation |
| `MEMORY.md` | Working memory | Process documentation + lessons |
| `README.md` | Human docs | Brief pointers for team members |
| `confirmation.log` | Raw log | Every verification check run |

### Scripts

| Script | Purpose |
|--------|---------|
| `inspect.sh <series>` | Show all data for a series |
| `inspect-standalone.sh <branch> ...` | Show data for standalone branches |
| `drop-and-clean.sh <branch> ...` | Complete drop workflow (7 steps in one) |
| `remove-old-entry.sh <branch> ...` | Remove duplicate ## entries from standalone log |
| `add-drop-new.sh <branch> ...` | Add to drops with dedup |
| `add-confirmed.sh <branch> ...` | Add to confirmed with dedup |
| `add-confirmed-series.sh <head> ...` | Add series head to confirmed |
| `add-evaluated.sh <branch> ...` | Add to evaluated with dedup |
| `generate_unified.py` | Regenerate unified inspection log |
| `generate_evaluation.sh <branch> ...` | Generate evaluation files |
| `generate_evaluation_overview.py` | Regenerate evaluation overview |
| `verify.sh` | Full consistency check (all data files) |
| `verify_unified.py` | Bidirectional unified log check |

## The Technical Domain

### How FAILED.patch works

When `commit-new.sh` applies a patch via `git am -3` and hits a conflict:
1. `git am --show-current-patch=diff > FAILED.patch` saves the intended change
2. `git add -A .` stages everything (including conflict markers)
3. `git am --continue` creates the commit

Result: the commit contains BOTH the FAILED.patch file AND any auto-merged code
files (which may have `<<<<<<< HEAD` conflict markers). The FAILED.patch has the
clean diff — the code files may be broken.

For ALREADY_APPLIED branches: `git am` reports "No changes -- Patch already applied",
the branch is created but points to the same commit as master. `git show BRANCH`
shows the master tip commit, not the patch.

For CLEAN_APPLY branches: the patch applied successfully, no FAILED.patch. The
commit has real code changes.

### Semantic equivalence — the hardest problem

The most important lesson from this project: checking whether a fix is "upstream"
requires understanding the CODE PATTERN, not just matching symbols.

**Same fix, different constant**: `SSIZE_MAX` vs `GRUB_SSIZE_MAX` — identical values,
different namespaces. Grep for one misses the other. (2025-06-0011)

**Same fix, different approach**: `curr = min_size` vs `curr += (run_size + 1)` —
both fix quadratic growth in NTFS run list traversal, but use different strategies.
(2025-05-0008 vs master commit `0e1762c8a`)

**Same fix, different filename**: `gcc-15-compile-fix.patch` vs `fix-gcc-15-compile.patch` —
identical content, different name. (2025-06-0117 vs master)

**Same fix, different location**: inline version check vs wrapper function for TCG2
`get_active_pcr_banks()`. (2025-09-0195 vs master lines 373-376)

**Content merged via different submission**: Btrfs environment block documentation
section added by a different patch in a later series version. (2025-10-0304)

### Series dissolution pattern

When a series member is found upstream, remove it from the series file:
1. `grep -v '^BRANCH$' series/HEAD > tmp && mv tmp series/HEAD`
2. If 1 member remains: move survivor to `standalone.txt`, delete series file
3. If 0 members remain: delete series file
4. Rename series heading in INSPECTION_LOG.md to remove branch IDs
5. The `generate_unified.py` classifier uses `drop_new.txt` as authoritative —
   any branch in drops is DROP regardless of heading markers

When the series HEAD itself is dropped, rename the series file to the first
remaining member.

### Drop rate by phase

| Phase | Drops found | Cumulative |
|-------|------------|------------|
| Phase 2: Deduplication | 987 | 987 |
| Phase 3: Code inspection | 280 | 1267 |
| Phase 6: Evaluation (bug fixes) | 5 | 1272 |
| Phase 6: Evaluation (RFC/docs) | 3 | 1275 |
| Phase 6: Evaluation (compat) | 2 | 1277 |
| Phase 6: Evaluation (enhancement) | 8 | 1285 |
| Phase 6: Evaluation (new feature) | 7 | 1292 |
| **Total drops** | **1303** | (987 prior + 316 new) |

The evaluation phase alone found 25 additional drops (~8% of the 316 remaining
after inspection). This is why the re-verification step during evaluation is
not optional.

## Status Per Work Unit — 46 KEEP Patches

### By Category

| Category | Count | Standalone | Series |
|----------|------:|------------|--------|
| Bug fix | 6 | 5 | 1 |
| New feature | 17 | 8 | 9 (4 series) |
| Enhancement | 11 | 7 | 4 (2 series) |
| Compatibility | 9 | 8 | 1 |
| RFC | 1 | 1 | 0 |
| Documentation | 2 | 1 | 1 |
| **Total** | **46** | **25** | **21** |

### Series Overview

| Series | Members | Topic | Key reason for KEEP |
|--------|--------:|-------|---------------------|
| [2025-04-0266](series/2025-04-0266) | 7 | AMD SKINIT Secure Launch (RFC v2) | Entirely new feature, no slaunch code on master |
| [2025-05-0076](series/2025-05-0076) | 2 | EFI error message enhancements | Master still has plain "unknown error" |
| [2025-05-0201](series/2025-05-0201) | 2 | Env export/unexport with flags | No `unexport` or `-g` on master |
| [2025-07-0038](series/2025-07-0038) | 3 | libgcrypt v14 remaining | sexp.c memory leak NOT upstream |
| [2025-07-0047](series/2025-07-0047) | 3 | kern/list + Xen arm64 LoadFile2 (RFC) | No `grub_list_append` on master |
| [2025-08-0012](series/2025-08-0012) | 2 | ZFS endianness + datto encryption | No datto/DSL_CRYPTO on master |
| [2026-03-0010](series/2026-03-0010) | 2 | ld.lld linker compatibility | Master still has `--image-base` and `-Ttext` |

### Standalone Highlights

- **2025-03-0061**: systemd TPM2 Key Protector (1273 lines, high complexity)
- **2025-07-0004**: TPCM module for Chinese trusted computing (v3)
- **2025-05-0256**: affs double-free security fix
- **2025-04-0142**: Debug trace timestamps
- **2025-03-0226**: Remove qemu_mips port (36 files)

## Technical Lessons Learned

### 1. The evaluation double-check is mandatory
Every KEEP must be re-verified against current master during in-depth evaluation.
The initial inspection uses symbol matching which misses semantic equivalence.
The evaluation reads actual code and catches ~15% more drops. Skipping this step
means shipping redundant patches.

### 2. `grep` fails silently on binary content
The affs reproducer image embedded in FAILED.patch makes the entire file binary.
`grep` returns no matches (silently). Use `strings` for field extraction from
such files. (2025-05-0256)

### 3. `ugrep` has different regex syntax
This system uses `ugrep` as grep. Patterns like `^\+` fail with
`error at position 5 (?m)^+`. Use `grep -F` for literal matching or adjust regex.

### 4. Generated files are never edited directly
INSPECTION_LOG_UNIFIED.md, EVALUATION_OVERVIEW.md, SERIES.md are all generated.
Edit the source logs (INSPECTION_LOG.md, INSPECTION_LOG_STANDALONE.md), then
regenerate with the respective script. `generate_unified.py` uses `drop_new.txt`
as the authoritative classifier — if a branch is in drops, it's DROP.

### 5. Dissolved series need heading cleanup
When a series is dissolved, remove branch IDs from the `## Series:` heading.
Otherwise the unified log generator puts them in the wrong section. Use descriptive
names like `## Series: editenv-v6 (dissolved — all members upstream)`.

### 6. Re: entries carry real patches
The `Re:` prefix in a mailing list subject just means it's a reply in a thread.
The FAILED.patch in a Re: branch is a real code submission, often a correction or
alternative by a different author. Never auto-drop based on `Re:` prefix.

### 7. Same author can submit the same fix twice with different names
Lidong Chen submitted the hostdisk overflow fix twice: once with `GRUB_SSIZE_MAX`,
once with `SSIZE_MAX`. The maintainer accepted the `SSIZE_MAX` version. Both are
in our branch set. The initial inspection missed this because it grep'd for the
specific constant, not the pattern.

### 8. The `drop-and-clean.sh` script saves 7 manual steps
Every drop requires: add to `drop_new.txt`, add to `confirmed.txt`, remove from
`standalone.txt` or `series/*`, remove from `evaluated.txt`, fix heading, remove
duplicate entry, note manual steps remaining. The script does all of this.

### User Preferences

- One branch at a time for inspection — never batch without control
- Every decision must be fact-based with verifiable evidence
- Log all verification checks to `confirmation.log` via `tee -a`
- No shortcuts in the process — reproducibility matters
- The evaluation should be proportional to patch size
- Generated scripts should support multiple arguments
- Always double-check after evaluation — the findings must be solid

## Pending Work

1. **Update FINAL_REPORT.md** — numbers have changed significantly (46 KEEP, 316 drops)
2. **Consider dropping 2025-06-0121** — v1 Containerfile, superseded by 2025-06-0143 (v2)
3. **Create the `drop-and-clean.sh` log-entry step** — currently manual
4. **Fix `remove-old-entry.sh` bug** — integer comparison fails when branch only in series log
5. **Update MEMORY.md and CLAUDE.md** — numbers and series list stale

## Context Restoration Instructions

1. Read `import/CLAUDE.md` — operational instructions, scripts, workflow
2. Read `import/MEMORY.md` — process documentation, pipeline phases
3. Read `import/EVALUATION_OVERVIEW.md` — current state of all KEEP patches
4. Check `import/evaluated.txt` — should have 46 entries (all KEEPs done)
5. Run `import/verify.sh` and `python3 import/verify_unified.py` — must pass
6. **DO NOT modify `grub/`** — read only
7. All edits to inspection decisions go to source logs, then regenerate
8. Use `drop-and-clean.sh` for any new drops found
9. The `patch-evaluation` global skill documents the methodology

## Timestamp Trail

- 2026-07-07: Session start. Classification (1302 branches), deduplication (987 drops)
- 2026-07-08: Series grouping, cross-version duplicate detection
- 2026-07-09: Code inspection begins, cross-verification, Re: recovery
- 2026-07-10: Inspection continues, same-subject dups, Phase 1 overlaps
- 2026-07-13: Series inspection (inspect.sh), standalone inspection begins
- 2026-07-14-15: Standalone inspection continues, confirmation passes
- 2026-07-16: Cross-topic grouping, verification scripts created
- 2026-07-17: Evaluation begins (bug fixes, RFC, docs, compat, enhancement)
- 2026-07-18: Enhancement + New feature evaluation complete. All 46 KEEPs evaluated.
  `patch-evaluation` global skill created. `drop-and-clean.sh` created.

## END OF CONTEXT DUMP
**Comprehensiveness**: Exhaustive
**Restoration confidence**: High

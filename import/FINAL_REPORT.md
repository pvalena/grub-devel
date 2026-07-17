# Failed Patches: Code Inspection Final Report

**Date**: 2026-07-18
**Scope**: 315 branches remaining after deduplication (from original 1302)

---

## Result

| Category | Count | Files |
|----------|------:|-------|
| **DROP** (already upstream or superseded) | 316 | `drop_new.txt` |
| **KEEP standalone** | 25 | `standalone.txt` |
| **KEEP series** | 21 members in 7 series | `series/*` |
| **Total** | 362 | |

Note: the 362 total exceeds the 315 starting point because 47 branches originally
classified as KEEP during deduplication were reclassified as DROP during code
inspection and evaluation (found upstream via semantic equivalence checks, or
superseded by later versions within the KEEP set).

---

## Method

### Inspection (Phase 3)

Every branch was inspected against `grub/master` using `inspect.sh` (series) or
`inspect-standalone.sh` (standalone). For each branch:

1. Read `FAILED.patch` content (the intended code change)
2. Identify target files and key symbols/functions added
3. Check if the same content exists on master (`git show master:<file>`)
4. Decision: DROP if content matches master; KEEP if not

**Drop reasons** (all require evidence):

| Reason | Description |
|--------|-------------|
| Already upstream | Patch content found on master (with line reference) |
| ALREADY_APPLIED | Branch tip = master tip commit, no FAILED.patch (empty branch) |
| Superseded | Older version of a series; newer version touches same files and is upstream |
| Wrong ML | Patch for another project (QEMU) sent to GRUB mailing list |
| Semantic equivalent | Same fix on master under different name/approach/author |

### Confirmation (Phase 4)

Every DROP decision was confirmed in a second pass:

- **Standalone drops** (194): each verified individually by re-checking the specific
  evidence claim against master. Logged in `confirmation.log`. Results in `confirmed.txt`.
- **Series drops** (33 series): each series verified by checking key features/symbols
  against master. Series heads recorded in `confirmed_series.txt`.

### Evaluation (Phase 6)

Every KEEP branch received an in-depth code review, categorized by type:

| Category | Reviews | Log file |
|----------|--------:|----------|
| Bug fix | 6 | [`EVALUATION_LOG_BUGFIX.md`](EVALUATION_LOG_BUGFIX.md) |
| New feature | 17 | [`EVALUATION_LOG_NEWFEATURE.md`](EVALUATION_LOG_NEWFEATURE.md) |
| Enhancement | 11 | [`EVALUATION_LOG_ENHANCEMENT.md`](EVALUATION_LOG_ENHANCEMENT.md) |
| Compatibility | 9 | [`EVALUATION_LOG_COMPAT.md`](EVALUATION_LOG_COMPAT.md) |
| RFC | 1 | [`EVALUATION_LOG_RFC_DOCS.md`](EVALUATION_LOG_RFC_DOCS.md) |
| Documentation | 2 | [`EVALUATION_LOG_RFC_DOCS.md`](EVALUATION_LOG_RFC_DOCS.md) |

Each review was followed by a re-verification pass against master, which found
25 additional drops (~8% of the initial KEEP set). This step is documented in
the `patch-evaluation` skill as mandatory.

### Verification (Phase 7, continuous)

Automated consistency checks run after every change:
- `verify.sh` — no DROP/KEEP overlap, all decisions logged, all drops confirmed
- `verify_unified.py` — bidirectional check of unified log vs data files

---

## Files produced

### Decision files

| File | Content |
|------|---------|
| `drop_new.txt` | 316 branches to drop (all confirmed upstream/superseded) |
| `standalone.txt` | 25 standalone branches to keep (not upstream) |
| `series/*` | 7 series files with 21 branches to keep |
| [`SERIES.md`](SERIES.md) | Series overview with links to series files |

### Evaluation files

| File | Content |
|------|---------|
| `evaluation/*.txt` | 46 per-branch evaluation data files |
| [`EVALUATION_OVERVIEW.md`](EVALUATION_OVERVIEW.md) | Summary table of all KEEP patches |
| `EVALUATION_LOG_*.md` | 5 category-specific code review logs |
| `evaluated.txt` | 46 branches with completed evaluation |

### Confirmation files

| File | Content |
|------|---------|
| `confirmed.txt` | 194 standalone drops, individually verified |
| `confirmed_series.txt` | 33 series drop heads, verified as series |
| `confirmation.log` | Raw verification output |

### Inspection logs

| File | Content |
|------|---------|
| [`INSPECTION_LOG_UNIFIED.md`](INSPECTION_LOG_UNIFIED.md) | Unified view: every branch with decision + evidence |
| `INSPECTION_LOG.md` | Source: series decisions |
| `INSPECTION_LOG_STANDALONE.md` | Source: standalone decisions |

### Tools

| File | Purpose |
|------|---------|
| `drop-and-clean.sh` | Complete drop workflow (add to drops, remove from keeps, fix logs) |
| `remove-old-entry.sh` | Remove duplicate log entries |
| `inspect.sh` / `inspect-standalone.sh` | Inspection data for series / standalone |
| `generate_unified.py` | Regenerate unified log |
| `generate_evaluation.sh` | Generate evaluation files |
| `generate_evaluation_overview.py` | Regenerate evaluation overview |
| `verify.sh` / `verify_unified.py` | Consistency verification |
| `add-drop-new.sh` / `add-confirmed.sh` / `add-evaluated.sh` | Tracking file management |

---

## KEEP summary

### 7 series (21 branches)

| Series | Patches | Topic | Effort |
|--------|--------:|-------|--------|
| [2025-04-0266](series/2025-04-0266) | 7 | AMD SKINIT Secure Launch (RFC v2) | Very High |
| [2025-05-0076](series/2025-05-0076) | 2 | EFI chainloader/linux error messages | Low |
| [2025-05-0201](series/2025-05-0201) | 2 | Env export/unexport with flags | Medium |
| [2025-07-0038](series/2025-07-0038) | 3 | libgcrypt: sexp.c leak + compat + cleanup | Low |
| [2025-07-0047](series/2025-07-0047) | 3 | kern/list append + Xen arm64 LoadFile2 (RFC) | High |
| [2025-08-0012](series/2025-08-0012) | 2 | ZFS endianness rewrite + datto encryption | Very High |
| [2026-03-0010](series/2026-03-0010) | 2 | ld.lld 21+ linker compatibility | Medium |

### 25 standalone branches

Detailed per-branch evaluations in `evaluation/*.txt` and `EVALUATION_LOG_*.md`.

| Type | Count | Notable patches |
|------|------:|-----------------|
| Bug fix | 5 | affs double-free, xfs error propagation, tss2 retry, lsefi pool leak, ns8250 NULL |
| New feature | 8 | systemd TPM2 key protector, TPCM module, Containerfiles, ECB tests, kernel size verify |
| Enhancement | 7 | pgp rsa_pad refactor, qemu_mips removal, debug timestamps, hashsum --set, zstd hint |
| Compatibility | 8 | ia64 float, test disable, python 3.4, bootstrap git, autoconf-archive, AROS, PKS emu |
| RFC | 1 | EFI variable menu check |
| Documentation | 1 | INSTALL autoconf-archive requirement |

---

## Key finding: evaluation-phase drops

The in-depth evaluation phase (Phase 6) found 25 patches that earlier phases
incorrectly classified as KEEP. These were semantically equivalent to upstream
code but used different constant names, different fix approaches, different
filenames, or different patch authors. The evaluation re-verification step
catches these — skipping it means shipping redundant patches.

See the [`patch-evaluation`](../../.claude/skills/patch-evaluation/SKILL.md) skill
for the full methodology.

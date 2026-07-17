# Failed Patches: Code Inspection Final Report

**Date**: 2026-07-17
**Scope**: 315 branches remaining after deduplication (from original 1302)

---

## Result

| Category | Count | Files |
|----------|------:|-------|
| **DROP** (already upstream or superseded) | 292 | `drop_new.txt` |
| **KEEP standalone** | 26 | `standalone.txt` |
| **KEEP series** | 44 members in 11 series | `series/*` |
| **Total** | 362 | |

Note: the 362 total exceeds the 315 starting point because 47 branches originally
classified as KEEP during deduplication were reclassified as DROP during code inspection
(found upstream on re-examination, or superseded by a later version within KEEP series).

---

## Method

### Inspection

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

### Confirmation

Every DROP decision was confirmed in a second pass:

- **Standalone drops** (158): each verified individually by re-checking the specific
  evidence claim against master. Logged in `confirmation.log`. Results in `confirmed.txt`.

- **Series drops** (33 series, 122 branches): each series verified by checking key
  features/symbols from the series against master. Logged in `confirmation.log`.
  Series heads recorded in `confirmed_series.txt`.

### Consistency checks performed

- No branch exists in both DROP and KEEP lists
- Every DROP has an entry in `INSPECTION_LOG.md` or `INSPECTION_LOG_STANDALONE.md`
- Every KEEP has an entry in one of the same logs
- Every standalone DROP is in `confirmed.txt`
- Every series DROP's head is in `confirmed_series.txt`
- No confirmed DROP is also a KEEP

---

## Files produced

### Decision files

| File | Content |
|------|---------|
| `drop_new.txt` | 280 branches to drop (all confirmed upstream/superseded) |
| `standalone.txt` | 36 standalone branches to keep (not upstream) |
| `series/*` | 13 series files with 44 branches to keep |
| `SERIES.md` | Series overview with links to series files |

### Confirmation files

| File | Content |
|------|---------|
| `confirmed.txt` | 158 standalone drops, individually verified |
| `confirmed_series.txt` | 33 series heads, verified as series |
| `confirmation.log` | Raw verification output (every check that was run) |

### Inspection logs

| File | Content |
|------|---------|
| `INSPECTION_LOG.md` | Series inspection: per-series and per-branch verdicts with evidence |
| `INSPECTION_LOG_STANDALONE.md` | Standalone inspection: per-branch verdicts with evidence |

### Tools

| File | Purpose |
|------|---------|
| `inspect.sh` | Inspect a series (takes series filename as arg) |
| `inspect-standalone.sh` | Inspect standalone branches (takes one or more branch args) |
| `add-drop-new.sh` | Add branches to `drop_new.txt` with dedup |
| `add-confirmed.sh` | Add branches to `confirmed.txt` with dedup |
| `add-confirmed-series.sh` | Add series heads to `confirmed_series.txt` with dedup |

---

## KEEP summary

### 13 series (44 branches) — not upstream

Detailed per-branch verdicts in `INSPECTION_LOG.md`. Overview in `SERIES.md`.

Topics: AMD SKINIT Secure Launch (RFC), EFI error message enhancements,
env variable export/unexport, libgcrypt sexp.c memory leak, kern/list append +
xen LoadFile2, ZFS datto encryption, btrfs envblk documentation,
GRUB_FORCE_EFI_ALLVIDEO, autoconf-archive INSTALL note, ld.lld linker compatibility.

### 36 standalone branches — not upstream

Detailed per-branch verdicts in `INSPECTION_LOG_STANDALONE.md`.

Topics include: ns8250 NULL check, tpm2 buffer offset restore, systemd TPM2 key
protector, testpci module, EFI chainloader/linux error enhancements, affs double-free
fix, TPCM module, debug timestamps, ET_DYN relocatable images, GCC-15 gnulib fix,
lsefi memory leak (free_pool), xen zstd hint, EFI PCR banks reporting, hashsum
variable storage, ECB cipher tests, EFI variable menu check, AROS compilation,
kernel file size verification, PKS emu exclude, qemu_mips port removal.

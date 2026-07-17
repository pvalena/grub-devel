# Evaluation Log: Bug Fixes

In-depth code review of 11 bug fix patches.

---

## 2025-01-0096 — ns8250: NULL SPCR base address check

**File**: `grub-core/term/ns8250.c`
**Author**: Leo Sandoval | **Size**: +3 lines
**Function**: `grub_serial_ns8250_add_mmio()`

**What it does**: Adds `if (addr == NULL) return NULL;` before the function iterates
`com_ports[]` comparing `mmio.base` against `addr`. Without this, a NULL address from
SPCR would match any port with base=0 or cause undefined behavior.

**Code review**:
- Clean, minimal change
- Correct: `grub_addr_t` is an integer type; comparing to NULL works (0 check)
- The SPCR table can have `base_addr.addr == 0` meaning "redirection disabled" —
  the sibling fix in `ns8250-spcr.c` (already upstream) handles that, but this one
  protects the `ns8250.c` entry point itself
- No side effects, no risk

**Complexity**: Trivial
**Risk**: None
**Manual fix effort**: Very low — single 3-line insertion

---

## 2025-05-0008 — ntfs: attribute validation run list traversal

**File**: `grub-core/fs/ntfs.c`
**Author**: Vladimir Serbinenko | **Size**: +1/-1 lines
**Function**: `validate_attribute()`

**What it does**: Changes `curr += min_size` to `curr = min_size` in the data run
parsing loop of `validate_attribute()`.

**Code review**:
- The original code `curr += min_size` accumulates both `curr` and `min_size`,
  causing `curr` to grow quadratically instead of linearly through the run list
- The fix `curr = min_size` sets `curr` to track the absolute position
- **HOWEVER**: master has already reworked this area. Master line 183 uses
  `curr += (run_size + 1)` with a separate `min_size += (run_size + 1)`.
  This is a DIFFERENT fix that correctly advances `curr` by the run entry size
  (not by accumulated `min_size`)
- Master's approach is cleaner: `curr` tracks position via incremental `run_size`,
  `min_size` accumulates total separately
- **This patch's approach (`curr = min_size`) may produce the same result since
  `min_size` is also incremented by `run_size`, but master's is more explicit**

**Complexity**: Simple but subtle — the interaction between `curr` and `min_size`
requires understanding the NTFS run list format
**Risk**: Low — master already has a fix for the same issue; this is an alternative approach
**Manual fix effort**: Low, but may be unnecessary if master's fix is equivalent.
Need to verify: does `curr = min_size` produce identical traversal as
`curr += (run_size + 1)` + `min_size += (run_size + 1)`? If yes, this patch is
redundant. If no, both fixes address different aspects.

**Verdict**: Likely redundant — master already fixed the same issue differently.
Recommend re-testing on a corpus of NTFS images before applying.

---

## 2025-03-0059 — tss2: buffer offset restore on retry

**File**: `grub-core/lib/tss2/tpm2_cmd.c`
**Author**: Yann Diorcet | **Size**: +4 lines
**Function**: `tpm2_submit_command()`

**What it does**: Saves `out->offset` before the retry loop and restores it on each
`TPM_RC_RETRY`. Without this, the retry sends a command with the output buffer
offset already advanced by the previous failed attempt, corrupting the next response.

**Code review**:
- Clean save/restore pattern: `grub_size_t offset = out->offset;` before loop,
  `out->offset = offset;` on retry
- Commit message cites real hardware: "Intel Elkhart Lake chip" — production issue
- The retry loop runs up to 3 times; without offset restore, retry 2+ reads from
  wrong position in the output buffer
- No risk of regression — only affects the retry path which is currently broken

**Complexity**: Simple
**Risk**: None — strictly additive, only affects error recovery path
**Manual fix effort**: Very low — 4 lines in a clear location

---

## 2025-06-0011 — hostdisk: signed integer overflow guard

**File**: `grub-core/osdep/unix/hostdisk.c`
**Author**: Lidong Chen | **Size**: +6 lines
**Functions**: `grub_util_fd_read()`, `grub_util_fd_write()`

**What it does**: Adds `if (len > GRUB_SSIZE_MAX) return -1;` before the read/write
loops to prevent `size_t` → `ssize_t` truncation.

**Code review**:
- **Master already has this fix** using `SSIZE_MAX` instead of `GRUB_SSIZE_MAX`
  (master lines 104, 137)
- `GRUB_SSIZE_MAX` (defined in `types.h:125/144`) is the GRUB-portable equivalent
  of `SSIZE_MAX` — same value on the same platform
- The patch is functionally identical to what's already on master
- **This patch is redundant** — the fix landed via a different submission

**Complexity**: Trivial
**Risk**: N/A
**Manual fix effort**: N/A — already applied
**Verdict**: **SHOULD BE DROPPED** — master already has equivalent fix.
Missed during earlier inspection because the patch uses `GRUB_SSIZE_MAX`
while master uses `SSIZE_MAX`.

---

## 2025-01-0098 — xfs: fix iterate_dir return value

**File**: `grub-core/fs/xfs.c`
**Author**: Egor Ignatov | **Size**: +9/-2 lines
**Series**: [2025-01-0098](series/2025-01-0098) (patch 1 of 2)

**What it does**: Changes two error paths in `grub_xfs_iterate_dir()` to call
`grub_error()` and `return 0` instead of `return grub_error()`. The function's
return type is `int` (1=found, 0=continue), but `grub_error()` returns
`grub_err_t` — returning that as an int confuses the iterator framework.

**Code review**:
- Commit message references `ef7850c757` which introduced boundary checks
  but returned the error code directly (wrong for an iterator callback)
- Also changes error string `"not a correct XFS inode"` → `"invalid XFS inode"`
- **Already upstream**: master lines 889-891 have the fixed pattern
- BUT: this patch is kept because patch 2 (2025-01-0099) adds `grub_errno`
  propagation which is NOT upstream

**Complexity**: Simple
**Risk**: None (already upstream for this specific patch)
**Manual fix effort**: N/A — patch 1 is upstream; only patch 2 needs manual work

---

## 2025-01-0099 — xfs: propagate grub_errno after iterate_dir_call_hook

**File**: `grub-core/fs/xfs.c`
**Author**: Egor Ignatov | **Size**: +12/-2 lines
**Series**: [2025-01-0098](series/2025-01-0098) (patch 2 of 2)

**What it does**: Two related changes:
1. Removes `grub_print_error()` calls in `iterate_dir_call_hook()` — these
   printed errors to console and cleared `grub_errno`, hiding the error from callers
2. Adds `else if (grub_errno) return 0;` guards after every `iterate_dir_call_hook()`
   call — so malloc failures and inode read errors propagate up properly

**Code review**:
- Currently, if `grub_malloc` fails in `iterate_dir_call_hook`, `grub_print_error()`
  is called (which resets `grub_errno`), then the caller continues iterating as if
  nothing happened — potentially reading garbage
- The patch fixes 5 call sites: `.` entry, `..` entry, inline dir entries,
  block dir entries, and the general inline loop
- Pattern is consistent: `if (hook(...)) return 1; else if (grub_errno) return 0;`
- Also frees `dirblock` on the block-dir error path (correct cleanup)
- Master still has `grub_print_error()` at lines 818, 824, 836 — **NOT upstream**

**Complexity**: Medium — 5 call sites, must understand iterator return convention
**Risk**: Low — only affects error paths; normal operation unchanged
**Manual fix effort**: Medium — 5 insertions across the function, context may have shifted

---

## 2025-05-0033 — zfs: free_sahdrp memory leak

**File**: `grub-core/fs/zfs/zfs.c`
**Author**: Glenn Washburn | **Size**: +5 lines
**Series**: [2025-05-0032](series/2025-05-0032) (patch 2 of 2)

**What it does**: Tracks whether `sahdrp` was heap-allocated (via `zio_read`) vs
stack/inline (from `DN_BONUS`), and frees it if heap-allocated. Uses a `bool
free_sahdrp` flag set to `true` only when `zio_read` succeeds.

**Code review**:
- **Already upstream**: master lines 3052-3068 have identical `free_sahdrp` pattern
- This patch is in a KEEP series because its sibling (2025-05-0032, test disable)
  is not upstream — but this specific patch is redundant

**Complexity**: Simple
**Risk**: N/A (already upstream)
**Manual fix effort**: N/A

---

## 2025-05-0256 — affs: double-free in iterate_dir

**File**: `grub-core/fs/affs.c`
**Author**: cyber (volticks) | **Size**: +27/-18 lines

**What it does**: Fixes a double-free in `grub_affs_iterate_dir()`. The original code
allocates `node` (shared as `orig_node`) and passes it to `hook(".")`. If the hook
frees `node` (non-matching path) and returns 0, `node`/`orig_node` still point to
freed memory — later code frees it again via `orig_node`.

The fix allocates a separate `temp_node` for the `.` and `..` hook calls,
keeping `node`/`orig_node` untouched. This mirrors `grub_hfsplus_iterate_dir()`
which uses the same pattern.

**Code review**:
- Genuine security issue: double-free can lead to heap corruption
- Comes with a reproducer (affs filesystem image + grub script)
- The fix is sound: separate allocation for hook-consumed nodes
- Note: `temp_node` is allocated with `grub_zalloc` but only freed by the hook —
  if both hooks return 0 without consuming it, `temp_node` leaks. However,
  examining the hook framework: `grub_fshelp_find_file` always takes ownership
  of the node, so this is safe
- HTML email artifacts and binary reproducer in FAILED.patch — the code diff is
  clean but the file is messy

**Complexity**: Medium — requires understanding fshelp node ownership semantics
**Risk**: Low — same pattern as hfsplus
**Manual fix effort**: Medium — need to extract the clean diff from the HTML-encoded
FAILED.patch, ignore the binary reproducer data

---

## 2025-07-0034 — libgcrypt: coverity warnings

**Files**: 2 new patch files in `grub-core/lib/libgcrypt-patches/`
**Author**: Vladimir Serbinenko | **Size**: 2 patches (20+37 lines)
**Series**: [2025-07-0029](series/2025-07-0029) (patch 7 of 11)

**What it does**: Two libgcrypt build-time patches:
1. `03_mpiutil_alloc.patch`: NULL check after `xtrymalloc` in `_gcry_mpi_alloc_like()` —
   calls `_gcry_fatal_error` on failure instead of dereferencing NULL (CID# 369001)
2. `03_sexp_free.patch`: frees s-expression resources on error in `_gcry_sexp_vbuild()` —
   prevents resource leak on parse failure (CID# 369003)

**Code review**:
- Both are Coverity-found issues (CID numbers in commit message)
- The patch files are applied to libgcrypt sources during `autogen.sh` build step
- Master has these patch files: `03_mpiutil_alloc.patch` and `03_sexp_free.patch` exist
  on master — **already upstream**

**Complexity**: Simple (patch files, not direct code changes)
**Risk**: N/A (already upstream)
**Manual fix effort**: N/A

---

## 2025-07-0039 — libgcrypt: sexp.c memory leak

**File**: new patch `grub-core/lib/libgcrypt-patches/08_sexp_leak.patch`
**Author**: Vladimir Serbinenko | **Size**: 15 lines
**Series**: [2025-07-0029](series/2025-07-0029) (patch 11 of 11)

**What it does**: Adds `free(buffer)` before `return NULL` in `sexp.c` hex string
parser. When invalid hex digits are encountered, the function returns NULL but
leaks the already-allocated `buffer`.

**Code review**:
- Classic memory leak: allocate buffer, parse hex, find bad digit, return without free
- One-line fix inside an error path: `free(buffer);` before `return NULL;`
- **NOT upstream**: master `sexp.c` line ~2717 still returns NULL without freeing
- This is the reason the entire 11-patch libgcrypt series is KEEP

**Complexity**: Trivial
**Risk**: None
**Manual fix effort**: Very low — create the patch file, add to `conf/Makefile.extra-dist`

---

## 2025-09-0037 — lsefi: memory leaks + EFI pool helpers

**File**: `grub-core/commands/efi/lsefi.c`, `include/grub/efi/efi.h`
**Author**: Renaud Métrich | **Size**: +31 lines

**What it does**: Two fixes:
1. In `grub_cmd_lsefi()`: adds `grub_efi_free_pool(protocols)` after iterating
   protocol GUIDs, and `grub_free(handles)` at function exit
2. In `efi.h`: adds inline `grub_efi_allocate_pool()` and `grub_efi_free_pool()`
   wrappers around EFI boot services calls

**Code review**:
- The `handles` array from `grub_efi_locate_handle` was never freed — leaked on
  every `lsefi` command invocation
- The `protocols` array from `ProtocolsPerHandle` is EFI pool memory — must use
  `FreePool` (via `grub_efi_free_pool`), not `grub_free`
- The wrapper functions are `static inline __attribute__((__unused__))` — clean,
  no linkage issues
- Master has `grub_free(handles)` at line 128 but does NOT have
  `grub_efi_free_pool(protocols)` or the wrapper functions

**Complexity**: Medium — two different allocators (GRUB heap vs EFI pool)
**Risk**: Low
**Manual fix effort**: Medium — need to add the `efi.h` wrappers and the `lsefi.c` fixes.
The `efi.h` change adds ~26 lines and may conflict with other header changes.

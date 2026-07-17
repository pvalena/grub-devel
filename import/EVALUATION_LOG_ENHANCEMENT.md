# Evaluation Log: Enhancements

In-depth review of 11 enhancement patches kept for manual incorporation.

---

## 2025-03-0186 — pgp: factor out rsa_pad

**Files**: `grub-core/commands/pgp.c`, new `grub-core/lib/pkcs1_v15.c`, `include/grub/pkcs1_v15.h`,
`grub-core/Makefile.core.def`
**Author**: Daniel Axtens | **Size**: +100/-32 lines | **Standalone**

**What it does**: Extracts the RSA PKCS#1 v1.5 padding logic from `pgp.c` into a
standalone module `pkcs1_v15`. Creates `grub_crypto_rsa_pad()` as a reusable function
for appended signature verification.

**Code review**:
- Part of the appended-signatures infrastructure (v2 series, patch 5/21)
- The new module is registered in Makefile.core.def with gcry cflags
- Clean separation: pgp.c loses ~30 lines, pkcs1_v15.c gains ~100 lines
- Needed by the appended-signature verification code (not yet upstream)

**Complexity**: Medium — refactoring with new module registration
**Risk**: Low — extracts existing code, doesn't change behavior
**Manual fix effort**: Medium — new files + Makefile changes

---

## 2025-03-0226 — Remove qemu_mips port

**Files**: `configure.ac`, `Makefile.am`, `docs/grub.texi`, `gentpl.py`, many more (36 files)
**Author**: Vladimir Serbinenko | **Size**: +59/-387 lines | **Standalone**

**What it does**: Removes the `qemu_mips` platform target from the GRUB build system.
Deletes platform-specific conditionals, test configurations, and documentation references.

**Code review**:
- Large patch (36 files) but entirely deletion-focused
- Master still has qemu_mips at configure.ac lines 214-219, 282
- The MIPS QEMU port is unmaintained and unlikely to have users
- Removing dead platform code reduces maintenance burden

**Complexity**: Simple (deletions) but wide-reaching (36 files)
**Risk**: Low — only affects an unmaintained platform
**Manual fix effort**: Medium-High — 36 files, context may have shifted significantly

---

## 2025-04-0048 — startup: call → jmp for grub_main

**File**: `grub-core/kern/x86_64/efi/startup.S`
**Author**: khaliid caliy | **Size**: +1/-2 lines | **Standalone**

**What it does**: Replaces `call EXT_C(grub_main)` with `jmp EXT_C(grub_main)` in the
EFI startup code. Since `grub_main` never returns, `jmp` is more correct and slightly
more efficient (no return address pushed on stack).

**Code review**:
- Minimal, clean optimization
- The comment `/* Doesn't return. */` is also removed (the `jmp` makes it self-evident)
- No functional change — `grub_main` is `__attribute__((noreturn))`

**Complexity**: Trivial
**Risk**: None
**Manual fix effort**: Trivial

---

## 2025-04-0142 — Debug traces with timestamps

**Files**: `config.h.in`, `configure.ac`, `grub-core/kern/misc.c`
**Author**: Renaud Métrich | **Size**: +43/-5 lines | **Standalone**

**What it does**: Adds `--with-debug-timestamps` configure option that prepends absolute
and relative timestamps to `grub_dprintf` output. Useful for boot time profiling.

**Code review**:
- Conditional compilation via `DEBUG_WITH_TIMESTAMPS` define
- Timestamps use `grub_get_time_ms()` — existing GRUB API
- Shows both absolute ms and delta since last debug message
- Default: off (must be explicitly enabled at configure time)

**Complexity**: Medium — configure + runtime code changes
**Risk**: None — opt-in feature, disabled by default
**Manual fix effort**: Low-Medium

---

## 2025-05-0076 — chainloader: hex status in error messages

**File**: `grub-core/loader/efi/chainloader.c`
**Author**: khaalid | **Size**: +3/-9 lines
**Series**: [2025-05-0076](series/2025-05-0076) (patch 1 of 2)

**What it does**: Replaces `"unknown error"` with `"cannot start image 0x%lx"` and
merges the `GRUB_EFI_OUT_OF_RESOURCES` branch into a single error with hex status.

**Code review**:
- Simplifies error handling (fewer branches, more information)
- The hex status helps users and developers identify the EFI error
- Note: commit has conflict markers (`<<<<<<< HEAD`) — the FAILED.patch has the clean fix

**Complexity**: Simple
**Risk**: None
**Manual fix effort**: Low — but commit has conflict markers, use FAILED.patch only

---

## 2025-05-0077 — linux: hex status in error messages

**File**: `grub-core/loader/efi/linux.c`
**Author**: khaalid | **Size**: +3/-5 lines
**Series**: [2025-05-0076](series/2025-05-0076) (patch 2 of 2)

**What it does**: Same as sibling — replaces plain `"cannot load image"` with
`"cannot load image 0x%lx"` and `"start_image() returned..."` with
`"cannot start image 0x%lx"`.

**Code review**:
- Consistent with the chainloader patch
- HTML-encoded FAILED.patch (Re: email) but diff is clear

**Complexity**: Simple
**Risk**: None
**Manual fix effort**: Low

---

## 2025-05-0201 — Export variables to upper levels

**Files**: `grub-core/kern/env.c`, `grub-core/normal/context.c`, `include/grub/env.h`
**Author**: Jiří Wolker | **Size**: +75/-18 lines
**Series**: [2025-05-0201](series/2025-05-0201) (patch 1 of 2)

**What it does**: Adds `grub_env_set_export_mode()` with modes: `exported` (existing),
`global` (new — propagates to parent scopes), `local` (new — reverses export).
Converts `export` command to `extcmd` with `-u`/`-g` flags.

**Code review**:
- Extends the existing export mechanism with bidirectional scope control
- The `global` mode allows variables to bubble up through nested scopes
- Uses `GRUB_COMMAND_ACCEPT_DASH` and `GRUB_COMMAND_OPTIONS_AT_START`
- Changes `var->global` from boolean to enum — ABI change within the env subsystem
- Sibling patch 2025-05-0202 documents the new options

**Complexity**: Medium-High — env subsystem changes, new command flags
**Risk**: Medium — changes variable scoping behavior, potential for subtle bugs
**Manual fix effort**: Medium

---

## 2025-07-0042 — import_gcry: Fix pylint warnings

**File**: `util/import_gcry.py`
**Author**: Vladimir Serbinenko | **Size**: +623/-657 lines
**Series**: [2025-07-0029](series/2025-07-0029) (patch 10 of 8 remaining)

**What it does**: Comprehensive pylint cleanup of the libgcrypt import script.
Fixes indentation, variable naming, unused imports, and string formatting.

**Code review**:
- Large patch but entirely cosmetic — no logic changes
- Master still has 4 f-strings and various pylint issues
- Part of the libgcrypt v14 series (kept for the sexp.c leak fix)
- Makes the script more maintainable for future modifications

**Complexity**: Simple (cosmetic) but large (623+ lines)
**Risk**: Low — no logic changes, but review is needed to confirm parity
**Manual fix effort**: Medium-High — large diff, context may have shifted

---

## 2025-07-0050 — arm64/xen: Use LoadFile2 protocol for Xen boot

**File**: `grub-core/loader/arm64/xen_boot.c`
**Author**: Frediano Ziglio | **Size**: +178/-5 lines
**Series**: [2025-07-0047](series/2025-07-0047) (patch 2 of 3)

**What it does**: Adds LoadFile2 protocol support for loading Xen dom0 kernel
and initrd on arm64. Instead of loading files directly, registers a LoadFile2
handler that the Xen hypervisor can call back into.

**Code review**:
- RFC patch — experimental approach for Xen boot on arm64
- Uses the existing `grub_efi_load_file2` infrastructure from linux.c
- Adds `xen_grub_initrd_load_file2` callback
- Requires sibling patch 2025-07-0057 (`grub_list_append`) for module list management

**Complexity**: High — EFI protocol registration, callback-based loading
**Risk**: Medium — new boot path for Xen, needs thorough testing
**Manual fix effort**: High — 178 lines of new protocol code

---

## 2025-09-0238 — Hint missing zstd support for PvGrub2

**File**: `grub-core/loader/i386/xen_file.c`
**Author**: Nagy Elemér Károly | **Size**: +2/-1 lines | **Standalone**

**What it does**: Changes the error message `"not xen image"` to
`"not xen image (or image is zstd-compressed, which is not supported)"`.
Helps users who hit this error with zstd-compressed kernels.

**Code review**:
- Purely cosmetic — better error message, no logic change
- The zstd hint is accurate: PvGrub2 doesn't support zstd decompression
  for Xen images, and this is a common source of confusion

**Complexity**: Trivial
**Risk**: None
**Manual fix effort**: Trivial

---

## 2025-10-0189 — hashsum: Allow storing hash in variable

**Files**: `grub-core/commands/hashsum.c`, `docs/grub.texi`
**Author**: D.-E. Divernois | **Size**: +43/-14 lines | **Standalone**

**What it does**: Adds `--set` option to the hashsum commands (md5sum, sha256sum, etc.)
that stores the computed hash in an environment variable instead of printing it.
Enables scripted hash verification in grub.cfg.

**Code review**:
- Adds `grub_env_set()` call when `--set` is used
- Also adds documentation in grub.texi for the new option
- Useful for Secure Boot workflows that need hash comparison in scripts
- Clean implementation: option parsing via existing extcmd framework

**Complexity**: Simple
**Risk**: None
**Manual fix effort**: Low

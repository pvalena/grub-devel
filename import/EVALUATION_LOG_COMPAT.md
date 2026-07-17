# Evaluation Log: Compatibility

In-depth review of 9 compatibility patches kept for manual incorporation.

---

## 2025-05-0025 — ia64: Disable inline integer divide optimization

**File**: `configure.ac`, `grub-core/Makefile.core.def`
**Author**: Vladimir Serbinenko | **Size**: +5/-7 lines | **Standalone**

**What it does**: Adds `-mno-inline-int-divide` to the ia64 soft-float check
and removes `-minline-int-divide-max-throughput` from ia64_efi_cflags. The inline
integer division generates floating-point instructions, which GRUB cannot use.

**Code review**:
- Consistent with existing `-mno-inline-float-divide` and `-mno-inline-sqrt`
- The old flag `-minline-int-divide-max-throughput` explicitly enabled what the
  new flag disables — removing it is correct
- ia64 is a niche platform but still supported in GRUB

**Complexity**: Simple
**Risk**: None — ia64 only
**Manual fix effort**: Very low

---

## 2025-05-0032 — tests: Disable gfxterm_menu and cmdline_cat tests

**File**: `grub-core/Makefile.core.def`
**Author**: Glenn Washburn | **Size**: +5/-4 lines | **Standalone**

**What it does**: Comments out the `gfxterm_menu` and `cmdline_cat_test` module
definitions with an explanation that they fail due to unifont version
differences. Not removing the source files — just disabling the build.

**Code review**:
- Workaround, not a fix — the real issue is unifont version sensitivity
- Tests still exist in source, can be re-enabled
- Prevents spurious test failures from masking real issues
- The comment explains why and when to reinstate

**Complexity**: Trivial
**Risk**: None — disables tests only, no runtime impact
**Manual fix effort**: Trivial

---
## 2025-07-0038 — import_gcry: Make compatible with python 3.4

**File**: `util/import_gcry.py`
**Author**: Vladimir Serbinenko | **Size**: +6/-8 lines
**Series**: [2025-07-0029](series/2025-07-0029) (patch 9 of 10 remaining)

**What it does**: Replaces Python 3.5+ features with 3.4-compatible equivalents
in the libgcrypt import script. Primarily `os.scandir()` → `os.listdir()` and
similar compatibility changes.

**Code review**:
- Needed for distros still on Python 3.4 (RHEL 7, older SUSE)
- Simple function replacements, no logic changes
- Part of the libgcrypt v14 series (kept for the sexp.c leak fix)

**Complexity**: Simple
**Risk**: None
**Manual fix effort**: Very low

---

## 2025-08-0167 — bootstrap: git depth check for newer git

**File**: `bootstrap`
**Author**: Andrew Hamilton | **Size**: +3/-5 lines | **Standalone**

**What it does**: Changes `grep -- --depth` to `grep -E -- '--(\[no-\])?depth'`
when checking if git supports shallow clones. Newer git versions changed the
help text format for `--depth` (now shows `--[no-]depth`), breaking the old check.

**Code review**:
- Without this fix, bootstrap on newer git always uses full (non-shallow) clones
  of gnulib, which is much slower
- The regex `'--(\[no-\])?depth'` matches both old (`--depth`) and new
  (`--[no-]depth`) formats
- Applied to both `git clone -h` and `git fetch -h` checks

**Complexity**: Simple
**Risk**: None — only affects clone depth selection
**Manual fix effort**: Very low — 2 line changes

---
## 2026-01-0021 — configure: autoconf-archive error message

**File**: `configure.ac`
**Author**: Radoslav Kolev | **Size**: +3 lines | **Standalone** (clean apply)

**What it does**: Adds `m4_ifndef([AX_CHECK_LINK_FLAG], [m4_fatal(...)])` to
produce a clear error message when autoconf-archive is not installed, instead
of the confusing default autoconf error about undefined macros.

**Code review**:
- Clean apply (no FAILED.patch, no conflicts)
- Uses `m4_fatal` which stops `autoreconf` immediately with the message
- Complements the INSTALL documentation patches (2025-12-0072) which add
  autoconf-archive to the requirements list

**Complexity**: Trivial
**Risk**: None
**Manual fix effort**: Trivial — 3 lines at top of configure.ac

---

## 2026-01-0053 — AROS compilation fixes

**Files**: `Makefile.in` (and others)
**Author**: Kalamatee | **Size**: +45/-45 lines | **Standalone**

**What it does**: Adds `-lpthread` to various `_LDADD` lines in `Makefile.in` and
adjusts some includes for AROS (Amiga Research Operating System) compatibility.
The patch is from a mailing list discussion, not a formal submission.

**Code review**:
- AROS is a very niche platform (Amiga-compatible OS)
- The patch modifies generated `Makefile.in` rather than `Makefile.am` — this is
  incorrect for upstream; changes to generated files get overwritten by `automake`
- The email tone is a discussion/request for help, not a formal patch
- Would need significant rework for upstream: changes should target `.am` files

**Complexity**: Simple changes, wrong target files
**Risk**: Medium — modifying generated Makefile.in is fragile
**Manual fix effort**: High — needs rewrite to target Makefile.am instead
**Maturity**: Not upstream-ready — needs rework

---

## 2026-02-0101 — PKS: Exclude grub-emu on 32-bit PowerPC

**File**: `include/grub/powerpc/ieee1275/platform_keystore.h`
**Author**: Vladimir Serbinenko | **Size**: +2/-3 lines | **Standalone**

**What it does**: Adds `&& !(GRUB_MACHINE_EMU)` to the `#if defined(__powerpc__)`
guard in the PKS header. The Platform Keystore code uses ieee1275 firmware calls
that don't exist in the emulator.

**Code review**:
- Without this, building `grub-emu` on 32-bit PowerPC fails with undefined symbols
- Clean, minimal fix — one preprocessor condition change
- HTML-encoded FAILED.patch (Re: email) but the diff is clear

**Complexity**: Trivial
**Risk**: None
**Manual fix effort**: Very low

---

## 2026-03-0010 — ld.lld: Revert --image-base check

**File**: `acinclude.m4`, `configure.ac`
**Author**: Nicholas Vinson | **Size**: +4/-21 lines
**Series**: [2026-03-0010](series/2026-03-0010) (patch 1 of 5)

**What it does**: Reverts the `AX_CHECK_LINK_FLAG([-Wl,--image-base,0], ...)`
check that was added to detect linker support for `--image-base`. The check
fails with `ld.lld` version 21+ which changed its behavior.

**Code review**:
- Part of a 5-patch series for ld.lld 21+ compatibility
- The `--image-base` check was added to support both GNU ld and older lld, but
  lld 21 changed semantics making the check produce wrong results
- Revert is the correct approach — the subsequent patches in the series provide
  alternative methods

**Complexity**: Simple (revert)
**Risk**: Low — only affects i386-pc target with lld linker
**Manual fix effort**: Low — but must be applied with the rest of the series

---

## 2026-03-0012 — ld.lld: Drop -Ttext checks for i386-pc

**File**: `acinclude.m4`, `configure.ac`, `conf/Makefile.extra-dist`, `Makefile.core.def`
**Author**: Nicholas Vinson | **Size**: +59/-25 lines
**Series**: [2026-03-0010](series/2026-03-0010) (patch 2 of 5)

**What it does**: Removes `-Ttext` linker checks for i386-pc and replaces them
with `--defsym` approach. Uses a linker script (`.lds`) instead of `-Ttext`
to set the text segment base address, which works with both GNU ld and lld.

**Code review**:
- The most substantial patch in the ld.lld series
- Introduces `TARGET_IMG_LDSCRIPT` and `TARGET_IMG_LDFLAGS` variables
- The `.lds` approach is more portable than `-Ttext`
- Touches build system files — needs careful testing on all supported linkers

**Complexity**: Medium — build system changes across multiple files
**Risk**: Medium — affects all i386-pc builds
**Manual fix effort**: Medium — must be applied with the full series

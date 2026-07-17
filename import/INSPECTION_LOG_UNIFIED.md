# Patch Inspection — Unified Log

Record of every inspected branch with decision and evidence.
Pipeline documentation: [FINAL_REPORT.md](FINAL_REPORT.md).

---

## KEEP — Series

8 series. Series files in [`series/`](series/), overview in [`SERIES.md`](SERIES.md).

## Series: [2025-04-0266](series/2025-04-0266) (7 of 7, Brown/Philipson/Żygowski) — KEEP

**Topic**: AMD SKINIT Secure Launch: x86 definitions, PSP discovery, core SKINIT,
EFI support, TMR setup, multiboot2 support

| Branch | Commit content | Author | Verdict |
|--------|---------------|--------|---------|
| 2025-04-0270 | FAILED.patch only: x86 definitions for AMD SKINIT | Philipson | Not upstream |
| 2025-04-0266 | FAILED.patch only: PSP discovery code, `psp.c`, `psp.h` | Brown | Not upstream |
| 2025-04-0267 | FAILED.patch only: core PSP commands and capability | Brown | Not upstream |
| 2025-04-0268 | FAILED.patch only: TMR setup to protect RAM from DMA | Brown | Not upstream |
| 2025-04-0271 | FAILED.patch only: AMD SKINIT Secure Launch core | Philipson | Not upstream |
| 2025-04-0272 | FAILED.patch only: EFI AMD SKINIT support | Philipson | Not upstream |
| 2025-04-0273 | FAILED.patch only: multiboot2 SKINIT Secure Launch | Żygowski | Not upstream |

RFC PATCH v2, all 7 parts. Three co-authors.
All FAILED.patch only. No slaunch/PSP/SKINIT code on master. All target files
MISSING: `grub-core/loader/slaunch/`, `include/grub/i386/psp.h`,
`include/grub/i386/skinit.h`, `include/grub/slaunch.h`, `include/grub/slr_table.h`.
**Decision**: KEEP — new feature, not upstream.

## Series: test-disable-zfs (dissolved — patch 2 upstream, patch 1 standalone KEEP)

**Topic**: Disable gfxterm_menu/cmdline_cat tests + ZFS memory leak fix

| Branch | Commit content | Verdict |
|--------|---------------|---------|
| 2025-05-0032 | FAILED.patch only: comment out gfxterm_menu/cmdline_cat tests | **Not upstream** |
| 2025-05-0033 | FAILED.patch + code: ZFS `free_sahdrp` memory leak fix | Already upstream |

Mixed: ZFS `free_sahdrp` fix (2025-05-0033) IS on master (lines 3052-3068).
Test disable (2025-05-0032) is NOT on master — tests still enabled, patch was
not accepted (workaround for unifont issue). Independent patches grouped by
proximity; keeping as a unit for review.
**Decision**: KEEP — test disable not upstream.


## Series: [2025-05-0076](series/2025-05-0076) (2 patches, khaalid) — KEEP

**Topic**: Enhance error messages in chainloader/linux with hex status codes

| Branch | Commit content | Verdict |
|--------|---------------|---------|
| 2025-05-0076 | FAILED.patch + chainloader.c: add hex status to error messages | Not upstream |
| 2025-05-0077 | FAILED.patch + linux.c: add hex status to error messages | Not upstream |

Not upstream — master still has plain `"cannot load image"` without status code in
chainloader.c. linux.c has different wording (`"start_image() returned"` vs `"cannot start image"`).
**Decision**: KEEP.


## Series: [2025-05-0201](series/2025-05-0201) (2 patches, Jiří Wolker) — KEEP

**Topic**: Export/unexport env variables with `-u`/`-g` flags

| Branch | Commit content | Verdict |
|--------|---------------|---------|
| 2025-05-0201 | FAILED.patch only: add `grub_env_set_export_mode`, `-u`/`-g` flags | Not upstream |
| 2025-05-0202 | FAILED.patch only: docs for new export/unexport options | Not upstream |

Not upstream — no `unexport` command, no `grub_env_set_export_mode`, no `-g` flag on master.
**Decision**: KEEP.


## Series: [2025-07-0029](series/2025-07-0029) (10 of 15 patches, Vladimir Serbinenko) — KEEP

**Topic**: Import libgcrypt 1.11, b64dec, blake2, import script, coverity fixes, memory leak

| Branch | Commit content | Verdict |
|--------|---------------|---------|
| 2025-07-0033 | FAILED.patch + code: Import libgcrypt 1.11 (hundreds of files) | Already upstream |
| 2025-07-0029 | FAILED.patch + code: Import b64dec from gpg-error | Already upstream |
| 2025-07-0031 | FAILED.patch + code: Adjust import script | Already upstream |
| 2025-07-0032 | FAILED.patch + code: Add DSA and RSA SEXP tests | Already upstream |
| 2025-07-0034 | FAILED.patch + code: Fix coverity warnings | Already upstream |
| 2025-07-0035 | FAILED.patch + code: Remove unneeded gcrypt compilation flag | Already upstream |
| 2025-07-0037 | FAILED.patch + code: Ignore sign-compare warnings | Already upstream |
| 2025-07-0040 | FAILED.patch + code: Import blake family of hashes | Already upstream |
| 2025-07-0038 | FAILED.patch + code: import_gcry python 3.4 compat | Already upstream |
| 2025-07-0042 | FAILED.patch + code: Fix pylint warnings | Already upstream |
| 2025-07-0039 | FAILED.patch + code: Fix memory leak in sexp.c | **NOT upstream** |

Master has libgcrypt 1.11.0 — the import itself is upstream. However, patch 14
(2025-07-0039, memory leak fix in `sexp.c`) is NOT upstream: `free(buffer)` before
`return NULL` at "Invalid hex digits" path is missing on master line ~2719.
**Decision**: KEEP — memory leak fix not upstream.


## Series: [2025-07-0047](series/2025-07-0047) (3 of 5, Frediano Ziglio) — KEEP

**Topic**: kern/list: `grub_list_append` + arm64/xen LoadFile2 + xen kernel cmdline

| Branch | Commit content | Verdict |
|--------|---------------|---------|
| 2025-07-0057 | CLEAN_APPLY: kern/list: Add `grub_list_append` function | Not upstream |
| 2025-07-0050 | FAILED.patch only: arm64/xen: Use LoadFile2 protocol for Xen boot | Not upstream |
| 2025-07-0047 | FAILED.patch only: arm64/xen: Use kernel command line from cmdline | Not upstream |

RFC patches. No `grub_list_append` on master. Xen LoadFile2 not in xen loader.
**Decision**: KEEP.


## Series: [2025-08-0012](series/2025-08-0012) (2 patches, Vladimir Serbinenko) — KEEP

**Topic**: ZFS: rewrite endianness handling + datto encryption support

| Branch | Commit content | Verdict |
|--------|---------------|---------|
| 2025-08-0012 | FAILED.patch + 7 code files: rewrite ZFS endianness handling | Not upstream |
| 2025-08-0013 | FAILED.patch + 3 code files: add datto encryption support | Not upstream |

Not upstream — no `datto`, no `DSL_CRYPTO`, no `grub_cpu_to_zfs` on master.
**Decision**: KEEP.


## Series: [2025-10-0294](series/2025-10-0294) (6 of 12, Michael Chang) — grub-editenv v6 — KEEP

| Branch | Commit content | Verdict |
|--------|---------------|---------|
| 2025-10-0294 | FAILED.patch + code: fs_envblk open helper | Already upstream |
| 2025-10-0296 | FAILED.patch + code: fs_envblk write helper | Already upstream |
| 2025-10-0297 | FAILED.patch + code: wire set_variables to optional | Already upstream |
| 2025-10-0299 | FAILED.patch + code: wire unset_variables to optional | Already upstream |
| 2025-10-0304 | FAILED.patch + code: docs: Btrfs env block and special env vars | **NOT upstream** |
| 2025-10-0305 | FAILED.patch + code: btrfs: update doc link for bootloader support | Already upstream |

Code helpers (fs_envblk_open/write, set/unset/list wiring) on master. URL update
(btrfs.readthedocs.io) on master. BUT btrfs environment block documentation in
grub.texi (patch 11/12) is NOT on master.
**Decision**: KEEP — docs not upstream.


## Series: [2026-03-0010](series/2026-03-0010) (5 of 9, Nicholas Vinson / Daniel Kiper) — KEEP

| Branch | Commit content | Verdict |
|--------|---------------|---------|
| 2026-03-0010 | FAILED.patch + code: Revert `--image-base` check | Not upstream |
| 2026-03-0012 | FAILED.patch + code: Drop `-Ttext` checks for i386-pc | Not upstream |
| 2026-03-0014 | FAILED.patch only: Rename `i386-cygwin-img-ld.sc` to `.lds` | Not upstream |
| 2026-03-0015 | FAILED.patch only: Update `.lds` to use `--defsym` | Not upstream |
| 2026-03-0017 | FAILED.patch only: Re: cover letter for v4 series | Not upstream |

ld.lld compatibility: `--image-base` revert and `-Ttext` removal NOT on master.
configure.ac still has `--image-base` check (line 1502) and `-Ttext` fallback
(line 1504). `i386-cygwin-img.lds` exists but old `.sc` file removed.
**Decision**: KEEP — linker compatibility changes not upstream.


---

## KEEP — Standalone

34 entries. Full list: [`standalone.txt`](standalone.txt).

## 2025-01-0096 — KEEP

**Subject**: Re: term/ns8250: return in case of a null SPCR base addresses
**Author**: Leo Sandoval | **fp=1 code=0**
**Target**: `grub-core/term/ns8250.c`
**Change**: Add `if (addr == NULL) return NULL` in `grub_serial_ns8250_add_mmio`.
**Evidence**: not on master — no NULL check for `addr` in that function.


## 2025-03-0059 — KEEP

**Subject**: tss2: restore buffer offset on tpm2_submit_command retry
**Author**: Yann Diorcet | **fp=1 code=0**
**Target**: `grub-core/lib/tss2/tpm2_cmd.c`
**Change**: Save `out->offset` before retry loop, restore on each retry.
**Evidence**: master has the retry loop (lines 88-98) but no offset restore.


## 2025-03-0061 — KEEP

**Subject**: key_protector: Add systemd TPM2 Key Protector
**Author**: Diorcet Yann | **fp=1 code=0**
**Target**: 14 files, 5 MISSING on master
**Change**: New module: `systemd_tpm2_key_protector`, `tpm2srk`, `base64`.
**Evidence**: `systemd_tpm2_key_protector/`, `lib/tpm2srk.c`, `lib/base64.c`,
`include/grub/tpm2srk.h`, `include/grub/luks2.h` all MISSING on master.


## 2025-03-0186 — KEEP

**Subject**: pgp: factor out rsa_pad (appended-sig v2 part 5)
**Author**: Daniel Axtens
**Change**: New `pkcs1_v15` module factored out of pgp.c.
**Evidence**: `grub-core/lib/pkcs1_v15.c` and `include/grub/pkcs1_v15.h` MISSING on master.


## 2025-03-0226 — KEEP

**Subject**: Remove qemu_mips port
**Author**: Vladimir Serbinenko
**Change**: Remove all qemu_mips references from build system.
**Evidence**: master configure.ac still has `qemu_mips` at lines 214-219, 282.


## 2025-04-0048 — KEEP

**Subject**: kern/x86_64/efi/startup: `call` → `jmp` for grub_main
**Author**: khaliid caliy
**Evidence**: master startup.S line 34 still has `call`. Not upstream.


## 2025-04-0094 — KEEP

**Subject**: Use ET_DYN images and PHDRs for creating relocatable images
**Author**: Vladimir Serbinenko
**Change**: Switch EFI ldflags from `-Wl,-r` to `-shared`, remove `-R .rel.dyn`.
**Evidence**: master Makefile.common line 46 still has `-R .rel.dyn`. Not upstream.


## 2025-04-0196 — KEEP

**Subject**: Re: efi/mm: relax memory type request from allocate_pages
**Author**: Vladimir Serbinenko
**Change**: `GRUB_EFI_ALLOCATE_MAX_ADDRESS` → `GRUB_EFI_ALLOCATE_ANY_PAGES`.
**Evidence**: `ALLOCATE_ANY_PAGES` not found on master mm.c.


## 2025-04-0273 — KEEP

**Subject**: RFC: multiboot2: Support SKINIT Secure Launch
**Author**: Michał Żygowski | Part of SKINIT RFC series.
**Evidence**: `grub-core/loader/slaunch/skl.c` MISSING on master.


## 2025-05-0025 — KEEP

**Subject**: ia64: Disable optimizations using floating-point (v2)
**Author**: Vladimir Serbinenko | **Change**: Add `-mno-inline-int-divide`.
**Evidence**: not found on master configure.ac.


## 2025-05-0075 — KEEP

**Subject**: Re: testpci: initial module (v2)
**Author**: Vladimir Serbinenko
**Evidence**: `grub-core/commands/testpci.c` MISSING on master. New module.


## 2025-05-0209 — KEEP

**Subject**: Re: Exporting variables to upper levels
**Author**: Vladimir Serbinenko | Same feature as series 2025-05-0201.
**Evidence**: `grub_env_set_export_mode` not on master.


## 2025-05-0222 — KEEP

**Subject**: Re: Option to set title of submenus
**Author**: Vladimir Serbinenko | **Change**: Add `--menutitle` option.
**Evidence**: `menutitle` not found on master menuentry.c.


## 2025-05-0256 — KEEP

**Subject**: Regarding bug in affs filesystem parser (double-free fix)
**Author**: cyber | **Change**: Use `temp_node` to prevent double-free in iterate_dir.
**Evidence**: master affs.c lines 417-423 still have old code (no temp_node).


## 2025-06-0121, 2025-06-0143 — KEEP (2 branches)

**Subject**: Containerfile(s) for development
**Evidence**: `container/Containerfile*`, `container/README` MISSING on master.


## 2025-07-0004 — KEEP

**Subject**: efi/tpcm: Add UEFI interface for TPCM module (v3)
**Evidence**: TPCM files MISSING on master. Same feature as 2025-06-0188.


## 2025-08-0167 — KEEP

**Subject**: bootstrap: Ensure shallow GNULIB clone works on newer GIT
**Author**: Andrew Hamilton
**Change**: Add `grep -E -- '--(\[no-\])?depth'` check before using `--depth`.
**Evidence**: master bootstrap hardcodes `--depth 2` without checking (line 583).


## 2025-09-0195 — KEEP

**Subject**: efi/tpm: call get_active_pcr_banks only with TCG2 1.1+
**Author**: Luca Boccassi
**Evidence**: `tpm2_pcr_banks_reporting_present` not found on master.


## 2026-02-0101 — KEEP

**Subject**: Re: powerpc_ieee1275: Excluding the PKS for grub-emu on 32-bit
**Author**: Vladimir Serbinenko | **fp=1 code=0**
**Target**: `include/grub/powerpc/ieee1275/platform_keystore.h`
**Change**: Add `!(GRUB_MACHINE_EMU)` guard to PKS include.
**Evidence**: master platform_keystore.h has no emu exclude guard.


## 2026-03-0017 — KEEP

**Subject**: Re: Improve ld.lld-21+ compatibility when building (v4 0/9)
**Author**: Daniel Kiper | **fp=1 code=0**
**Target**: `configure.ac`
**Change**: Part of ld.lld compatibility series 2026-03-0010 (KEEP).
**Evidence**: master configure.ac still has `--image-base` check.


## 2025-04-0142 — KEEP

**Subject**: Prepend debug traces with absolute and relative timestamps
**Author**: Renaud Métrich | **fp=1 code=0**
**Target**: `configure.ac`, `grub-core/kern/misc.c`
**Change**: Add `--with-debug-timestamps` configure option.
**Evidence**: `DEBUG_WITH_TIMESTAMPS` not found on master.


## 2025-06-0117 — KEEP

**Subject**: gnulib: Add patch to allow GRUB w/GCC-15 compile (v2)
**Author**: Andrew Hamilton | **fp=1 code=2**
**Target**: `bootstrap.conf`, `grub-core/lib/gnulib-patches/gcc-15-compile-fix.patch`
**Evidence**: `gcc-15-compile-fix.patch` MISSING on master.


## 2025-09-0037 — KEEP

**Subject**: lsefi: fixed memory leaks (v2)
**Author**: Renaud Métrich | **fp=1 code=2**
**Target**: `grub-core/commands/efi/lsefi.c`, `include/grub/efi/efi.h`
**Change**: Add `grub_efi_free_pool(protocols)`, add `grub_efi_allocate_pool` wrapper.
**Evidence**: no `grub_efi_free_pool` calls in master lsefi.c.


## 2025-09-0238 — KEEP

**Subject**: Hint missing zstd support for PvGrub2 "not xen image"
**Author**: Nagy Elemér Károly | **fp=1 code=0**
**Target**: `grub-core/loader/i386/xen_file.c`
**Change**: Enhance error to mention possible zstd compression.
**Evidence**: master xen_file.c:92 still has plain `"not xen image"`.


## 2025-10-0189 — KEEP

**Subject**: commands/hashsum: Allow to store hash in variable
**Author**: D.-E. Divernois | **fp=1 code=0**
**Target**: `grub-core/commands/hashsum.c`, `docs/grub.texi`
**Change**: Add `--set` option to store hash in env variable.
**Evidence**: no `grub_env_set` in master hashsum.c.


## 2025-11-0027 — KEEP

**Subject**: util/grub.d/00_header.in: Disable loading all_video on EFI (v2)
**Author**: Andrew Hamilton | **fp=1 code=3**
**Change**: Same `GRUB_FORCE_EFI_ALL_VIDEO` feature as series 2025-11-0014.
**Evidence**: not on master (confirmed in series inspection).


## 2025-11-0238 — KEEP

**Subject**: tests: add functional tests for ECB mode using various ciphers
**Author**: Srish Srinivasan | **fp=1 code=4**
**Target**: `grub-core/tests/ecb_test.c` + build/doc files
**Evidence**: `ecb_test.c` MISSING on master.


## 2025-12-0072 — KEEP

**Subject**: INSTALL: Add new requirement for configure
**Author**: Andrew Hamilton | **fp=0 code=1** (clean apply)
**Change**: Add `Autoconf Archive macros (autoconf-archive)` to INSTALL.
**Evidence**: not found on master INSTALL.


## 2026-01-0019 — KEEP

**Subject**: [RFC] Feature proposal: EFI variable check to enter grub menu
**Author**: Mitchell Augustin | **fp=1 code=0**
**Target**: `grub-core/normal/menu.c`
**Change**: Check EFI variable to decide whether to show GRUB menu.
**Evidence**: no EFI variable menu check on master menu.c.


## 2026-01-0021 — KEEP

**Subject**: configure: print a more helpful error if autoconf-archive is not installed
**Author**: Radoslav Kolev | **fp=0 code=1** (clean apply)
**Change**: Better error message when autoconf-archive is missing.
**Evidence**: not on master (same feature as series 2025-12-0028).


## 2026-01-0053 — KEEP

**Subject**: Problems compiling 2.xx for AROS
**Author**: Kalamatee | **fp=1 code=0**
**Change**: Compilation fixes for AROS platform.
**Evidence**: AROS-specific code not on master.


## 2026-01-0079 — KEEP

**Subject**: commands/linux: verify kernel file size
**Author**: jinkangkang | **fp=1 code=0**
**Target**: multiple linux loaders including `grub-core/loader/i386/efi/linux.c`
**Change**: Add kernel file size verification.
**Evidence**: `grub-core/loader/i386/efi/linux.c` MISSING on master.


## 2025-01-0099 — KEEP

**Subject**: fs/xfs: Propagate incorrect inode error from grub_xfs_read_inode
**Author**: Egor Ignatov | **fp=1 code=0**
**Target**: `grub-core/fs/xfs.c`
**Change**: Remove `grub_print_error()` calls in `iterate_dir_call_hook()`, add
`else if (grub_errno) return 0` guards after every `iterate_dir_call_hook()` call.
**Evidence**: master still has `grub_print_error` at lines 818, 824, 836. Not upstream.
**Context**: Was patch 2 of xfs series 2025-01-0098. Patch 1 merged to master.


## 2025-05-0032 — KEEP

**Subject**: tests: Disable gfxterm_menu and cmdline_cat tests
**Author**: Glenn Washburn | **fp=1 code=0**
**Target**: `grub-core/Makefile.core.def`
**Change**: Comment out gfxterm_menu and cmdline_cat test modules (unifont workaround).
**Evidence**: master Makefile.core.def:2388 still has tests enabled. Not upstream.
**Context**: Was patch 1 of test/zfs series 2025-05-0032. Patch 2 (zfs leak) merged to master.


---

## DROP — Series

34 series. Confirmed: [`confirmed_series.txt`](confirmed_series.txt).
All dropped branches in [`drop_new.txt`](drop_new.txt).

## Series: 2025-01-0018 (2 patches, Glenn Washburn)

**Topic**: docs: Replace `@lbracechar{}` with `@{` + remove `--dumb` reference

| Branch | Commit content | Verdict |
|--------|---------------|---------|
| 2025-01-0018 | FAILED.patch only: `docs/grub-dev.texi` `@lbracechar{}` -> `@{` | Already upstream |
| 2025-01-0019 | FAILED.patch only: `docs/grub.texi` reword `--dumb` to `terminfo` | Already upstream |

**Evidence**: master lines 646-649 already use `@{...@}` syntax. Master line 2841-2843
already has the `terminfo` rewording. No `@lbracechar` or `--dumb` reference remains.


## Series: 2025-01-0033 (6 patches, Patrick Plenefisch)

**Topic**: LVM: rename `cache_lv` -> `ignored_feature_lv`, remove `cache_pool`,
add integrity/cachevol support, split validation loop, add debug messages

| Branch | Commit content | Verdict |
|--------|---------------|---------|
| 2025-01-0038 | FAILED.patch only (328L): rename `cache_lv` -> `ignored_feature_lv` | Already upstream |
| 2025-01-0037 | FAILED.patch only (66L): remove unused `cache_pool` field | Already upstream |
| 2025-01-0036 | FAILED.patch only (32L): split segment matching / validation loops | Already upstream |
| 2025-01-0035 | FAILED.patch only (103L): add `integrity` LV type handling | Already upstream |
| 2025-01-0034 | FAILED.patch only (51L): add `grub_util_info` debug messages | Already upstream |
| 2025-01-0033 | FAILED.patch only (21L): add `CACHE_USES_CACHEVOL` type | Already upstream |

**Evidence**: master `grub-core/disk/lvm.c` has `struct ignored_feature_lv` (line 37),
no `cache_pool` field, `CACHE_USES_CACHEVOL` match (line 851), `grub_util_info` messages
(lines 862, 1041), "Match LVs. Must be done after cache and integrity" comment (line 1047).
master `grub-core/disk/diskfilter.c` has the split validation loop (lines 982, 996).
All 6 commits are FAILED.patch-only (no code files changed in commit = auto-merge found
code already present).

## Series: xfs-iterate-dir (dissolved — patch 1 upstream, patch 2 standalone KEEP)

**Topic**: fs/xfs: Fix return values and error propagation in `grub_xfs_iterate_dir`

| Branch | Commit content | Verdict |
|--------|---------------|---------|
| 2025-01-0098 | FAILED.patch only: fix return value to `return 0` after `grub_error()` | Already upstream |
| 2025-01-0099 | FAILED.patch only: remove `grub_print_error`, add `grub_errno` propagation | **NOT upstream** |

**Evidence**: Patch 1's changes are on master (lines 889, 1012 use `grub_error` + `return 0`).
Patch 2's changes are NOT on master: `grub_print_error` still present at lines 818, 824, 836;
no `else if (grub_errno)` guards after `iterate_dir_call_hook` calls (lines 874, 877).
**Decision**: KEEP — patch 2 carries unmerged error propagation fixes.


## Series: 2025-03-0012 (4 of 6 patches, Glenn Washburn)

**Topic**: commands/ls: Return proper errors, merge print functions, add mtime/full-path display

| Branch | Commit content | Verdict |
|--------|---------------|---------|
| 2025-03-0012 | FAILED.patch + ls.c: proper GRUB_ERR_* returns | Already upstream |
| 2025-03-0014 | FAILED.patch + ls.c: merge print_files_long into print_file | Already upstream |
| 2025-03-0015 | FAILED.patch + ls.c: show modification time | Already upstream |
| 2025-03-0017 | FAILED.patch + ls.c: print full paths for file args | Already upstream |

**Evidence**: master `grub-core/commands/ls.c` has: single `print_file` function (no
`print_files_long`), `pathname` variable at line 102, `ctx->filename` check at line 108,
`print_dirhdr` field, `grub_datetime` mtime display at lines 158-171. Parts 4,6 were
already in the ALREADY_APPLIED set. All 4 remaining commits have both FAILED.patch and
code changes in ls.c — the conflict resolution produced partial merges but the full
intended change is now on master.


## Series: 2025-03-0189 (2 of 21 patches, Daniel Axtens) — appended-sig v2

**Topic**: dl: fake `grub_dl_set_persistent` for emu + crypto: move `grub_crypto_pk_*` to crypto.c

| Branch | Commit content | Verdict |
|--------|---------------|---------|
| 2025-03-0189 | FAILED.patch + dl.h: add emu-target `grub_dl_set_persistent` stub | Already upstream |
| 2025-03-0190 | FAILED.patch + pgp.c: move `grub_crypto_pk_{dsa,ecdsa,rsa}` to crypto.c | Already upstream |

**Evidence**: master `include/grub/dl.h` has both real (line 266) and emu-fake (line 251)
`grub_dl_set_persistent`. master `grub-core/lib/crypto.c` has `grub_crypto_pk_*` at
lines 175-177; `grub-core/commands/pgp.c` no longer declares them.


## Series: 2025-03-0192 (4 of 21 patches, Daniel Axtens) — appended-sig v2

**Topic**: ASN.1 description import, PKCS#7/X.509 parsers, docs, ibm,secure-boot lockdown

| Branch | Commit content | Verdict |
|--------|---------------|---------|
| 2025-03-0192 | FAILED.patch + asn1_tab.c files (**with conflict markers**) | Already upstream |
| 2025-03-0194 | FAILED.patch + pkcs7.c, x509.c, asn1util.c, appendedsig.h | Already upstream |
| 2025-03-0195 | FAILED.patch + grub.texi: appended sig docs | Already upstream |
| 2025-03-0197 | FAILED.patch only: ibm,secure-boot lockdown | Already upstream |

**Evidence**: master has all target files: `gnutls_asn1_tab.c` (148L), `pkix_asn1_tab.c`,
`pkcs7.c`, `x509.c`, `asn1util.c`, `appendedsig.h`. `ibm,secure-boot` check at
`kern/ieee1275/init.c:1031`. **Note**: 2025-03-0192's code files contain unresolved
git conflict markers (`<<<<<<< HEAD`) — the auto-merge committed broken state. The
FAILED.patch has the clean intended diff. Moot since the clean version landed via later
submissions (up to v18).


## Series: 2025-03-0198 (7 of 21 patches, Sudhakar Kuppusamy) — appended-sig v2

**Topic**: ieee1275 PKS support, DB/DBX reading, trusted/distrusted commands, ELF Note keys

| Branch | Commit content | Verdict |
|--------|---------------|---------|
| 2025-03-0198 | FAILED.patch only: ieee1275 Platform Keystore | Superseded by v18 |
| 2025-03-0199 | FAILED.patch only: read DB/DBX secure boot vars | Superseded by v18 |
| 2025-03-0200 | FAILED.patch only: trusted/distrusted list creation | Superseded by v18 |
| 2025-03-0201 | FAILED.patch only: kernel verification with db/dbx | Superseded by v18 |
| 2025-03-0203 | FAILED.patch only: use_static_keys flag | Superseded by v18 |
| 2025-03-0202 | FAILED.patch only: read default DB keys from ELF Note | Superseded by v18 |
| 2025-03-0205 | FAILED.patch only: appended-sig documentation | Superseded by v18 |

**Evidence**: Core features on master: `platform_keystore.c` (315L), `appendedsig.c`
with trust/distrust commands, ibm,secure-boot lockdown. Some v2-specific features
(`use_static_keys`, `read_secure_boot_variables`) not found on master or in v18
FAILED.patches — likely refactored/folded into different patches in v18 (which has 11
remaining parts covering the same scope: PKS, DB/DBX, key management, lockdown).
**Decision**: DROP — v2 superseded by v18 series (2025-10-0142), which is kept.
**Dropped branches**: 2025-03-0198, 2025-03-0199, 2025-03-0200, 2025-03-0201, 2025-03-0203, 2025-03-0202, 2025-03-0205


## Series: 2025-04-0016 (3 of 7, Vladimir Serbinenko) — libgcrypt v1 import

**Topic**: Import libgcrypt 1.10.3, adjust import script, disable keccak SSE

All FAILED.patch only. Superseded by v14 "Import libgcrypt 1.11" series (2025-07-0029,
11 patches remaining). v14 imports a newer version (1.11 vs 1.10.3).
**Decision**: DROP — superseded by v14.
**Dropped branches**: 2025-04-0016, 2025-04-0014, 2025-04-0015


## Series: 2025-04-0057 (9 of 13, Gary Lin) — tpm2_key_protector v5

**Topic**: dump PCRs, tpm2_dump_pcr command, NV index support, tests, docs

All have FAILED.patch + code changes. master has: `tpm2_dump_pcr` command in
`commands/tpm2_key_protector/module.c`, NV index in module + `grub-protect.c`
(line 66: `PROTECT_OPT_TPM2_NVINDEX`), NV tests in `tpm2_key_protector_test.in`
(line 240: `tpm2_seal_unseal_nv`), docs referencing tpm2_dump_pcr.
**Decision**: DROP — all features already upstream.
**Dropped branches**: 2025-04-0059, 2025-04-0057, 2025-04-0061, 2025-04-0063, 2025-04-0064, 2025-04-0065, 2025-04-0066, 2025-04-0070, 2025-04-0069


## Series: 2025-05-0113 (3 patches, Hamilton/Serbinenko)

**Topic**: NTFS regressions, fshelp NULL deref, NTFS access violations
All upstream. NTFS error strings on master: `"pu offset size incorrect"` (268),
`"edat offset is out of bounds"` (469/481), `"run offset out of range"` (722),
`"bitmap attribute loop"` (1161). fshelp `read_symlink != NULL` check at line 229.
**Decision**: DROP.
**Dropped branches**: 2025-05-0113, 2025-05-0118, 2025-05-0115


## Series: 2025-05-0151 (dissolved — both members upstream)

**Topic**: EFI memory leak fixes in lsefi.c, tpm.c, linux.c
All upstream. `grub_free(handles)` in lsefi.c:128, tpm.c:116/129.
`grub_free(mempath)` in linux.c:226/231.
**Decision**: DROP. Series dissolved — 2025-05-0151 moved to standalone (DROP),
2025-05-0153 moved to standalone (DROP).
**Dropped branches**: 2025-05-0151, 2025-05-0153


## Series: 2025-05-0166 (2 patches, Andrew Hamilton)

**Topic**: NTFS attribute validation + access violation fixes (v3)
Same NTFS fixes as 2025-05-0113, all on master.
**Decision**: DROP.
**Dropped branches**: 2025-05-0166, 2025-05-0167


## Series: 2025-06-0040 (2 patches, Alec Brown)

**Topic**: gnulib regcomp/regexec resource leak fixes
All upstream. Patch files exist on master: `fix-regcomp-resource-leak.patch` (110L),
`fix-regexec-resource-leak.patch` (11L). bootstrap.conf references them at lines 87-88.
**Decision**: DROP.
**Dropped branches**: 2025-06-0041, 2025-06-0040


## Series: 2025-06-0177 (4 of 6 patches, Frediano Ziglio)

**Topic**: loader/efi/linux LoadOptions: remove useless assignment, fix excessive size,
use sizeof, correct NUL termination
All upstream. master linux.c has `args_len` (201/242), separated `load_options_size` (253),
NUL terminator (252), `grub_utf8_to_utf16` with `args_len` (250).
**Decision**: DROP.
**Dropped branches**: 2025-06-0177, 2025-06-0178, 2025-06-0179, 2025-06-0182


## Series: 2025-07-0066 (3 of 5, Mate Kukri)

**Topic**: efi/sb: shim loader protocol support
All upstream. `GRUB_EFI_SHIM_IMAGE_LOADER_GUID` at sb.c:34, `shim_loader`
variable at sb.c:36, `last_verified_image_handle` at sb.c:39.
**Decision**: DROP.
**Dropped branches**: 2025-07-0068, 2025-07-0066, 2025-07-0069


## Series: 2025-07-0287 (2 of 7, Gary Lin)

**Topic**: Argon2: extract from libgcrypt + LUKS2 Argon2 support
Superseded by v5 series (2025-10-0235). master has `argon2.c` and
`LUKS2_KDF_TYPE_ARGON2I/ID` in luks2.c.
**Decision**: DROP — superseded by v5.
**Dropped branches**: 2025-07-0287, 2025-07-0291


## Series: 2025-08-0076 (3 of 3, Aaron Rainbolt)

**Topic**: Xen: rename MAX_GUEST_CMDLINE, add warning comment, add cmdline parsing (v5)
All upstream. `GRUB_XEN_MAX_GUEST_CMDLINE` at xen.h:831, `grub_parse_xen_cmdline`
at cmdline.c:118, called from init.c:585.
**Decision**: DROP.
**Dropped branches**: 2025-08-0076, 2025-08-0077, 2025-08-0079


## Series: 2025-08-0173 (2 patches, Andrew Hamilton)

**Topic**: INSTALL: document libtasn1 + BUGS: update bug tracker URL
All upstream. INSTALL has `libtasn1` reference. BUGS has savannah URL.
**Decision**: DROP.
**Dropped branches**: 2025-08-0173, 2025-08-0174


## Series: 2025-08-0182 (3 of 4, Andrew Hamilton)

**Topic**: docs: new libgcrypt modules, future section update, URL corrections
All upstream. grub.texi has blake2/aria module docs (7 hits), "2.x" text,
HTTPS URLs (3 hits for gnu.org/software/grub).
**Decision**: DROP.
**Dropped branches**: 2025-08-0184, 2025-08-0182, 2025-08-0185


## Series: 2025-08-0194 (7 of 21, Sudhakar Kuppusamy) — appended-sig v9

Superseded by v18 (2025-10-0142). All features on master or in v18 remaining.
**Decision**: DROP — superseded.
**Dropped branches**: 2025-08-0194, 2025-08-0196, 2025-08-0200, 2025-08-0198, 2025-08-0199, 2025-08-0203, 2025-08-0204


## Series: 2025-09-0005 (2 of 7, Gary Lin) — tss2 cap_pcr v3

Superseded by v4 (2025-10-0092). `grub_tcg2_cap_pcr` on master (efi/tcg2.c:206,
tpm2_cmd.c:572). `TPM_CC_PCR_Event` at tss2_types.h:346.
**Decision**: DROP — already upstream.
**Dropped branches**: 2025-09-0005, 2025-09-0006


## Series: 2025-09-0115 (2, Hector Cao) — WRONG MAILING LIST

QEMU patches (`hw/core/machine.c`, `target/i386/kvm/kvm.c`) sent to GRUB ML.
Not applicable to GRUB.
**Decision**: DROP — not a GRUB patch.
**Dropped branches**: 2025-09-0115, 2025-09-0116


## Series: 2025-10-0092 (3 of 7, Gary Lin) — tss2 PCR_Event v4

All upstream. `TPM2_PCR_Event` at tpm2_cmd.c:572, `grub_tcg2_cap_pcr` for
ieee1275 at tcg2.c:206, PCR capping in tpm2_key_protector module.c:1178,
`feature_tpm2_cap_pcrs` in normal/main.c:521.
**Decision**: DROP — already upstream.
**Dropped branches**: 2025-10-0092, 2025-10-0094, 2025-10-0097


## Series: 2025-10-0142 (11 of 20, Sudhakar Kuppusamy) — appended-sig v18

All upstream. `OBJ_TYPE_GPG_PUBKEY` (pgp.c:981), `appended-signature-size`
(mkimage.c:88), `pks.h` exists, `append_add_db_cert` commands (appendedsig.c:968),
ibm,secure-boot lockdown (init.c:1031), platform_keystore.c (315L).
**Decision**: DROP — all features already upstream.
**Dropped branches**: 2025-10-0142, 2025-10-0145, 2025-10-0148, 2025-10-0149, 2025-10-0150, 2025-10-0151, 2025-10-0152, 2025-10-0153, 2025-10-0156, 2025-10-0157, 2025-10-0158


## Series: 2025-10-0160 (3 of 20, Kuppusamy) — appended-sig v18 tests/docs

Same v18 series. Tests (`appended_signature_test.c`, 348L) and docs on master.
**Decision**: DROP — already upstream.
**Dropped branches**: 2025-10-0160, 2025-10-0162, 2025-10-0161


## Series: 2025-10-0235 (9 of 13, Gary Lin) — argon2/kdf v5

All upstream. `argon2.c` (52L), kdf patches (09-12), `argon2_test.c` (139L),
word copy optimization in `kern/misc.c` (line 83). `grub_crypto_argon` in 6 files.
**Decision**: DROP — already upstream.
**Dropped branches**: 2025-10-0238, 2025-10-0237, 2025-10-0242, 2025-10-0239, 2025-10-0235, 2025-10-0240, 2025-10-0245, 2025-10-0243, 2025-10-0247


## Series: 2025-10-0266 (3 of 12, Michael Chang) — btrfs envblk v5

All upstream. `GRUB_ENV_BTRFS_OFFSET` in fs.h:135 and btrfs.c:2358-2360.
`fs_envblk_open/write` in grub-editenv.c:133-134.
**Decision**: DROP — already upstream.
**Dropped branches**: 2025-10-0266, 2025-10-0271, 2025-10-0270


## Series: 2025-10-0329 (7 of 10, Gary Lin) — x86_64 sha256 hw accel v3

All upstream. `hwfeatures-gcry.c` (52L), `cpuid.h`, `x86_64/efi/hwfeatures-gcry.c`
(256L), libgcrypt patches 13-15 present.
**Decision**: DROP — already upstream.
**Dropped branches**: 2025-10-0329, 2025-10-0331, 2025-10-0332, 2025-10-0333, 2025-10-0335, 2025-10-0336, 2025-10-0337


## Series: 2025-11-0014 (dissolved — superseded by v2 standalone)

| Branch | Commit content | Verdict |
|--------|---------------|---------|
| 2025-11-0014 | FAILED.patch + code: add `GRUB_FORCE_EFI_ALLVIDEO` to grub-mkconfig | Superseded |
| 2025-11-0015 | FAILED.patch + code: docs for new `GRUB_FORCE_EFI_ALLVIDEO` variable | Superseded |

Superseded by v2 standalone `2025-11-0027` which is more complete (touches
`grub-mkconfig.in` + `00_header.in` + docs in a single patch).
**Decision**: DROP — superseded by v2.
**Dropped branches**: 2025-11-0014, 2025-11-0015


## Series: 2025-11-0097 (2 of 4, Glenn Washburn) — erofs test v3

All upstream. Root check removed from erofs_test.in. dump.erofs FSTIME fix at
grub-fs-tester.in:1512.
**Decision**: DROP.
**Dropped branches**: 2025-11-0099, 2025-11-0097


## Series: 2025-11-0104 (2 of 3, Andrew Hamilton) — ZFS ZSTD test split v6

All upstream. `zfs_zstd_test.in` (30L) exists. ext2 `-r` flag detection at
grub-fs-tester.in:890.
**Decision**: DROP.
**Dropped branches**: 2025-11-0104, 2025-11-0105


## Series: 2025-11-0120 (2 patches, Glenn Washburn) — cryptomount test

All upstream. `testcase_fail` changed to `testcase` for argon2 at
grub_cmd_cryptomount.in:182. `$builddir` variable used.
**Decision**: DROP.
**Dropped branches**: 2025-11-0121, 2025-11-0120


## Series: 2025-11-0142 (3 of 5, Glenn Washburn) — docs spelling/test section

All upstream. Spelling fix "across" (grub-dev.texi:931). Privileged user note
(grub-dev.texi:485). Tests chapter (grub-dev.texi:466-467).
**Decision**: DROP.
**Dropped branches**: 2025-11-0142, 2025-11-0143, 2025-11-0144


## Series: 2025-11-0204 (2 of 4, Glenn Washburn) — bootstrap linguas v4

All upstream. INSTALL step renumbered (no linguas.sh step). bootstrap.conf
linguas logic at lines 112-127.
**Decision**: DROP.
**Dropped branches**: 2025-11-0204, 2025-11-0205

## Series: autoconf-archive-install (dissolved — 0028 superseded by 0072, 0029 upstream)

| Branch | Commit content | Verdict |
|--------|---------------|---------|
| 2025-12-0028 | CLEAN_APPLY: INSTALL: Add Autoconf Archive note | **NOT upstream** |
| 2025-12-0029 | FAILED.patch + code: grub-fs-tester: Use CSMACINTOSH encoding | Already upstream |

CSMACINTOSH encoding fix (patch 2) is upstream (grub-fs-tester.in:746-748).
Autoconf Archive note in INSTALL (patch 1) is NOT upstream.
**Decision**: KEEP — autoconf-archive note not upstream.


## Series: 2026-02-0066 (3 of 6, Avnish Chouhan) — NVMeoFC v7

All upstream. `fcp-targets` method (ofdisk.c:279), `nvme-discovery-controllers`
(ofdisk.c:433), `add_multiple_nvme_bootdevices` (platform.c:191).
**Decision**: DROP.
**Dropped branches**: 2026-02-0066, 2026-02-0067, 2026-02-0068


---

## DROP — Standalone

159 entries. Confirmed: [`confirmed.txt`](confirmed.txt).
All in [`drop_new.txt`](drop_new.txt).

## 2025-01-0094 — DROP

**Subject**: term/nns8250-spcr: return if redirection is disabled
**Author**: Benjamin Herrenschmidt | **fp=1 code=1**
**Target**: `grub-core/term/ns8250-spcr.c`
**Change**: Add `if (spcr->base_addr.addr == 0) return NULL` check.
**Evidence**: master lines 80-81 have identical check.


## 2025-02-0002 — DROP

**Subject**: fs/xfs: add new superblock features (Linux 6.12/6.13)
**Author**: Darrick J. Wong | **fp=1 code=1**
**Target**: `grub-core/fs/xfs.c`
**Change**: Add `EXCHRANGE`, `PARENT`, `METADIR` incompat feature flags.
**Evidence**: master xfs.c lines 92-94 have all three defines.


## 2025-02-0105 — DROP

**Subject**: Re: fs: Disable many filesystems under lockdown
**Author**: Andrew Hamilton | **fp=1 code=0**
**Target**: 11 fs modules (affs, cbfs, jfs, minix, nilfs2, ntfs, reiserfs, romfs, sfs, udf, ufs)
**Change**: Add lockdown checks to filesystem modules.
**Evidence**: all 11 modules have 3 lockdown references each on master.


## 2025-02-0116 — DROP

**Subject**: fs/ext2: Rework out-of-bounds read for inline and external extents
**Author**: Michael Chang | **fp=1 code=1**
**Target**: `grub-core/fs/ext2.c`
**Change**: Add `max_inline_ext`/`max_external_ext` bounds checking.
**Evidence**: master ext2.c lines 500-528 have the bounds checking.


## 2025-02-0126 — DROP

**Subject**: util/grub.d/30_os-prober.in: Fix UUID boundaries, separators, deprecation
**Author**: Pascal Hambourg | **fp=1 code=1**
**Target**: `util/grub.d/30_os-prober.in`, `docs/grub.texi`
**Change**: Case-insensitive UUIDs, comma/semicolon separators, deprecated @/dev/* warning.
**Evidence**: master 30_os-prober.in lines 121-140 have all changes.


## 2025-02-0139 — DROP

**Subject**: util/grub.d/30_os-prober.in: Conditionally show chain entries by platform
**Author**: Pascal Hambourg | **fp=1 code=0**
**Target**: `util/grub.d/30_os-prober.in`
**Change**: Platform-specific conditionals (`grub_platform = pc/efi`).
**Evidence**: master 30_os-prober.in lines 168, 204.


## 2025-02-0195 — DROP

**Subject**: docs: Document Restricted Filesystems in Lockdown
**Author**: Andrew Hamilton | **fp=1 code=1**
**Target**: `docs/grub.texi`
**Change**: Add "not allowed in lockdown mode" notes to FS module docs.
**Evidence**: master grub.texi has 25 occurrences.


## 2025-03-0034 — DROP

**Subject**: tests/grub_cmd_cryptomount: Cleanup the cryptsetup script
**Author**: Glenn Washburn | **fp=1 code=1**
**Target**: `tests/grub_cmd_cryptomount.in`
**Change**: Add `GRUB_SHELL_DEFAULT_DEBUG`, cleanup `csscript`.
**Evidence**: master grub_cmd_cryptomount.in line 40, 187-198.


## 2025-03-0055 — DROP

**Subject**: bsd: Fix type passed for the kernel
**Author**: Vladimir Serbinenko | **fp=1 code=0**
**Target**: `grub-core/loader/i386/bsd.c`
**Change**: Use `FREEBSD_MODTYPE_KERNEL` instead of conditional 32/64.
**Evidence**: master line 1546 uses `FREEBSD_MODTYPE_KERNEL`.


## 2025-03-0058 — DROP

**Subject**: tests/util/grub-shell: Default qemuopts to envvar
**Author**: Glenn Washburn | **fp=1 code=0**
**Target**: `tests/util/grub-shell.in`
**Change**: `qemuopts=${GRUB_QEMU_OPTS}` instead of empty.
**Evidence**: master line 78 has `qemuopts=${GRUB_QEMU_OPTS}`.


## 2025-03-0065 — DROP

**Subject**: efi: Use shim's loader protocol for EFI image
**Author**: Mate Kukri | **fp=1 code=0**
**Target**: `kern/efi/sb.c`, `loader/efi/chainloader.c`, `loader/efi/linux.c`, headers
**Change**: Replace `shim_lock` with `shim_loader` protocol.
**Evidence**: master sb.c has `GRUB_EFI_SHIM_IMAGE_LOADER_GUID` (line 34),
`shim_loader` (line 36), `last_verified_image_handle` (line 39).
Also confirmed upstream during series inspection (2025-07-0066).


## 2025-03-0073 — DROP

**Subject**: fs/zfs: Fix a number of memory leaks
**Author**: Stuart Hayes | **Change**: Add grub_free for nvlist/zapbuf/features/dnbuf.
**Evidence**: master zfs.c has 28 free calls for these variables.


## 2025-03-0093 — DROP

**Subject**: powerpc: increase MIN RMA size for CAS negotiation (v4)
**Author**: Avnish Chouhan | **Change**: 512→768 MB, CAS reboot property check.
**Evidence**: master init.c lines 70-71 `RMO_ADDR_MAX 768 MB`.


## 2025-03-0124 — DROP

**Subject**: ieee1275/ofnet: Fix grub_malloc() removed after added safe
**Author**: Nicolas Frayer | **Change**: Re-add `ofdata->path = grub_malloc(sz)`.
**Evidence**: master ofnet.c line 467.


## 2025-03-0130 — DROP

**Subject**: fs/ntfs: Check at->attr_cur after calling next_attribute() (v2)
**Author**: Andrew Hamilton | **Evidence**: master ntfs.c line 417 (superseded by v3).


## 2025-03-0134 — DROP

**Subject**: fs/ntfs: Correct NULL Deref / Possible Infinite Loop (v3)
**Author**: Andrew Hamilton | **Evidence**: master ntfs.c line 417 `attr_cur >= at->mft->buf`.


## 2025-03-0204 — DROP

**Subject**: appendedsig: trusted and distrusted support with hash (v2 part 20)
**Author**: Sudhakar Kuppusamy
**Evidence**: master appendedsig.c line 57 `OPTION_BINARY_HASH`, line 138 `binary-hash`.


## 2025-03-0210 — DROP

**Subject**: loader/i386/linux: Fix resource leak
**Author**: Lidong Chen | **Change**: `return err` → `goto fail` after relocator alloc.
**Evidence**: master linux.c line 1145-1146 has `if (err) goto fail`.


## 2025-04-0009 — DROP

**Subject**: Re: fs/xfs: fix large extent counters incompat feature
**Author**: Vladimir Serbinenko | **Change**: Use `grub_xfs_get_inode_nextents()`.
**Evidence**: master xfs.c line 578 defines it, line 974 uses it.


## 2025-04-0031 — DROP

**Subject**: include/grub/i386/linux: Update linux_kernel_params
**Author**: Patrick Colp | **Change**: Rename `grub_e820_mmap` → `grub_boot_e820_entry`.
**Evidence**: master linux.h line 213 has `struct grub_boot_e820_entry`.


## 2025-04-0075 — DROP

**Subject**: Re: arm64: Limit memory allocations to 4GB boundary
**Author**: Vladimir Serbinenko
**Change**: `GRUB_EFI_MAX_USABLE_ADDRESS` 0xffffffffffff → 0xffffffff.
**Evidence**: master memory.h already has `0xffffffff`.


## 2025-04-0140 — DROP

**Subject**: Re: kern/efi/mm: try allocating in the lower 4GB first
**Author**: Vladimir Serbinenko
**Change**: Try `0xffffffff` first, fall back to `MAX_USABLE_ADDRESS`.
**Evidence**: master mm.c line 173 has `0xffffffff` allocation.


## 2025-04-0215 — DROP

**Subject**: Re: kern/efi/mm: try allocating in the lower 4GB first
**Author**: Vladimir Serbinenko | Same patch as 2025-04-0140.
**Evidence**: master mm.c line 173.


## 2025-04-0249 — DROP

**Subject**: Add Xen command line parsing (v1)
**Author**: Aaron Rainbolt | Superseded by v5 (2025-08-0076), confirmed upstream.


## 2025-04-0254 — DROP

**Subject**: loader/efi/chainloader: Enhance error message (v1)
**Author**: khaliid caliy
**Change**: Add `UNSUPPORTED`, `INVALID_PARAMETER`, hex status in error messages.
**Evidence**: none of these error strings on master chainloader.c.


## 2025-05-0037 — DROP

**Subject**: loader/efi/linux: Enhance linux command error messages (v2)
**Author**: khaliid caliy
**Evidence**: Enhanced error strings not on master linux.c.


## 2025-05-0046 — DROP

**Subject**: docs: Document available crypto disks checks (SECURITY PATCH 5/8)
**Author**: Maxim Suhanov
**Evidence**: master grub.texi lines 4756-4757, 6816, 7353-7354 have cryptocheck docs.


## 2025-05-0055, 2025-05-0056, 2025-05-0057, 2025-05-0058, 2025-05-0059 — DROP (5 branches)

**Subject**: SECURITY PATCH series parts 3,4,6,7,8: cryptocheck command, search
diskfilter, erase secrets, wipe passphrase, --quiet option
**Authors**: Vladimir Serbinenko (Re: to Maxim Suhanov originals)
**Evidence** (all on master):
- cryptocheck `--quiet`: diskfilter.c:1417-1423
- passphrase wipe: cryptodisk.c:1315, 1878
- erase secrets: cryptodisk.c:1889
- search diskfilter: search.c:58-68
- cryptocheck command: diskfilter.c:1382-1450


## 2025-05-0060 — DROP

**Subject**: Re: search: Introduce the --cryptodisk-only argument
**Evidence**: master search.c line 125 `SEARCH_FLAGS_CRYPTODISK_ONLY`.


## 2025-05-0062, 2025-05-0072 — DROP (2 branches)

**Subject**: commands/efi: dump all uefi runtime variables (lsefivar)
**Evidence**: master `grub-core/commands/efi/lsefivar.c` exists.


## 2025-05-0079 — DROP

**Subject**: loader/efi/linux: Fix memory leak
**Evidence**: `grub_free(mempath)` on master linux.c:226/231 (confirmed earlier).


## 2025-05-0083 — DROP

**Subject**: Re: grub-probe: detect DDF container similar to IMSM (v2)
**Evidence**: master getroot.c lines 122, 645 `grub_util_is_imsm_or_ddf`.


## 2025-05-0084, 2025-05-0132 — DROP (2 branches)

**Subject**: envblk: ignore empty new lines while parsing env files
**Evidence**: master envblk.c line 238 `*p != '#' && *p != '\n' && *p != '\r'` (superset).


## 2025-05-0110 — DROP

**Subject**: loader/efi/linux: Fix memory leak (v2)
**Evidence**: same fix as 2025-05-0079/0153, already upstream.


## 2025-05-0117 — DROP

**Subject**: Re: fs/fshelp: Avoid possible NULL pointer deference
**Evidence**: fshelp `read_symlink != NULL` at master line 229 (confirmed earlier).


## 2025-05-0139 — DROP

**Subject**: fs/ntfs: Correct regression with run list calculation (v2)
**Evidence**: master ntfs.c lines 86, 182-184 have `run_size` fix (different expression, same fix).


## 2025-05-0153 — DROP

**Subject**: loader/efi/linux: Fix memory leak (resubmission)
**Author**: khaalid cali | **fp=1 code=1**
**Target**: `grub-core/loader/efi/linux.c`
**Change**: Add `grub_free(mempath)` on error path and normal exit.
**Evidence**: master linux.c:226 `grub_free (mempath)` on error, line 231 on normal exit.
Originally in series 2025-05-0151; series dissolved, both members upstream.


## 2025-05-0180 — DROP

**Subject**: UEFI: Fix several memory leaks of UEFI handles
**Evidence**: Clean apply, `grub_memcpy` inline at master misc.h:107.


## 2025-06-0029 — DROP

**Subject**: tpm2_key_protector: Dump the PCR bank for key unsealing
**Evidence**: master module.c line 180 `tpm2_dump_bank`, lines 675/1061/1121.


## 2025-06-0045 — DROP

**Subject**: appendedsig: trusted and distrusted support
**Evidence**: Already confirmed upstream (same as 2025-03-0204).


## 2025-06-0081, 2025-06-0096 — DROP (2 branches)

**Subject**: lib/LzmaEnc: Validate 'len' before subtracting (v1 and v2)
**Evidence**: master LzmaEnc.c lines 1883-1885 have the validation.


## 2025-06-0099, 2025-06-0100 — DROP (2 branches)

**Subject**: grub-protect PCR digest fix + tpm2 SHA384 tests
Clean applies but branch tip = master tip (kern/misc memcpy). ALREADY_APPLIED.


## 2025-06-0133 — DROP

**Subject**: gnulib: Bring back the fix for resolving unused variable
**Evidence**: master bootstrap.conf line 90, patch file exists.


## 2025-06-0142 — DROP

**Subject**: tests: Correct netboot and file_filter test failure
**Evidence**: master grub-shell.in lines 718-719 have netdir cleanup.


## 2025-06-0149 — DROP

**Subject**: Re: tests: Correct netboot test failure
**Evidence**: Same fix as 2025-06-0142, already upstream.


## 2025-06-0163, 2025-06-0182 — DROP (2 branches)

**Subject**: loader/efi/linux v3 1/6 + v4 6/6
**Evidence**: Part of series 2025-06-0177, confirmed upstream.


## 2025-07-0027 — DROP

**Subject**: arm64/xen: Consider alignment calling (v2)
**Evidence**: `xen_boot_address_align` on master xen_boot.c line 93.


## 2025-07-0065 — DROP

**Subject**: efi: Provide wrappers for load_image, start_image (v5 1/5)
**Evidence**: `grub_efi_load_image` on master. Confirmed in shim loader series.


## 2025-07-0130 — DROP

**Subject**: Support environment block in btrfs reserved area
**Evidence**: Superseded by v5/v6 btrfs envblk series (upstream).


## 2025-07-0189 — DROP

**Subject**: RFC: Copy the x86_64 optimization files
**Evidence**: SHA-256 asm files already on master (upstream in series 2025-10-0329).


## 2025-07-0212 — DROP

**Subject**: conf: Add new libgcrypt and libtasn1 files to Makefile.extra-dist
**Evidence**: master Makefile.extra-dist has 17 libgcrypt-patches refs.


## 2025-07-0218 — DROP

**Subject**: bli: set LoaderTpm2ActivePcrBanks runtime variable (v2)
**Evidence**: master bli.c line 145 `LoaderTpm2ActivePcrBanks`.


## 2025-07-0292 — DROP

**Subject**: tests/util/grub-fs-tester: Use Argon2id for LUKS2 test
**Evidence**: master grub-fs-tester.in line 880 `argon2id`.


## 2025-08-0009 — DROP

**Subject**: Re: kern/misc: Implement grub_strtok() (v5)
**Evidence**: master misc.c lines 490-548, misc.h lines 128-129.


## 2025-08-0048 — DROP

**Subject**: relocator: Switch to own page table while moving chunks (v2)
**Evidence**: master relocator_common_c.c: `PAGE_PRESENT` (62),
`grub_cpu_relocator_preamble` (101), `preamble_size` (48).


## 2025-08-0051, 2025-08-0052, 2025-08-0054 — DROP (3 branches)

**Subject**: blsuki v6 (parts 2,4,5 of 5)
**Evidence**: master `blsuki.c` (1534 L).


## 2025-08-0093 — DROP

**Subject**: util/bash-completion.d: s/mkrescure/mkrescue/g
Clean apply = master tip commit. ALREADY_APPLIED.


## 2025-08-0115 — DROP

**Subject**: efi/console: treat scan_code 0x0102 (suspend) as enter
**Evidence**: master console.c lines 214-215.


## 2025-08-0146, 2025-08-0147, 2025-08-0153 — DROP (3 branches)

**Subject**: Re: crypto.h KDF, import_gcry.py Argon2, docs argon2
**Evidence**: all upstream — KDF at crypto.h:544-547, import_gcry.py:315, grub.texi:1714.


## 2025-08-0164 — DROP

**Subject**: Re: po: Update Translations to Build with Gettext 0.26
**Evidence**: po/*.sed files exist on master.


## 2025-08-0267 — DROP

**Subject**: datetime: Support dates outside of 1901..2038 range (v6)
**Evidence**: master datetime.c line 73 `grub_int64_t nix`.


## 2025-08-0277 — DROP

**Subject**: libgcrypt: Allow GRUB to Build With Clang
**Evidence**: master crypto.h lines 253-258 `#pragma GCC diagnostic ignored`.


## 2025-08-0280 — DROP

Clean apply = master tip. ALREADY_APPLIED.


## 2025-09-0012 — DROP

**Subject**: util/grub-editenv: add basic structures (v1)
**Evidence**: Superseded by v5/v6 btrfs envblk series (upstream).


## 2025-09-0020 — DROP

**Subject**: tcp: Fix TCP port number reused on reboot (v2)
**Evidence**: master tcp.c lines 557-578, time-based port derivation at 21550.


## 2025-09-0022 — DROP

**Subject**: libgcrypt/kdf: blake2b_512.hash_buffers() (v4)
**Evidence**: master patch file (63L). Superseded by v5.


## 2025-09-0036 — DROP

**Subject**: util/grub-image: fix riscv32 relocation offset
**Evidence**: master mkimagexx.c line 1396 `(grub_int64_t) sym_addr`.


## 2025-09-0065 — DROP

**Subject**: docs: Add Security Hardening Suggestions
**Evidence**: master grub.texi line 10757 "Security hardening".


## 2025-09-0073 — DROP

**Subject**: kern: perform NULL check in unregister paths
**Evidence**: master extcmd.c:142 `ext == NULL`, command.c:107 `cmd == NULL`.


## 2025-09-0082 — DROP

**Subject**: lib/hwfeatures-gcry: Enable SSE and AVX (v1)
**Evidence**: Superseded by v3 (2025-10-0329), confirmed upstream.


## 2025-09-0086, 2025-09-0119, 2025-09-0162 — DROP (3 branches)

Clean applies = master tip. ALREADY_APPLIED.


## 2025-09-0135 — DROP

**Subject**: docs: add Btrfs env block and special env vars (v2)
Superseded by v5/v6 btrfs envblk (upstream).


## 2025-09-0168 — DROP

**Subject**: loader/i386/linux: Transfer EDID information to kernel
**Evidence**: master linux.c lines 237-260 `grub_video_edid_info`.


## 2025-09-0175, 2025-09-0225 — DROP (2 branches)

Clean applies = master tip. ALREADY_APPLIED.


## 2025-09-0189 — DROP

**Subject**: tests: include verbosity on tests.in checks
**Evidence**: master tests have `set -ex` (e.g. btrfs_test.in:3).


## 2025-09-0237 — DROP

**Subject**: Re: Make grub_error() more verbose
**Evidence**: master err.h:92-97 has `grub_error` with `__FILE__`, `__FUNCTION__`, `__LINE__`.


## 2025-09-0244 — DROP

**Subject**: Re: Make grub_error() more verbose
**Author**: Leo Sandoval | **fp=1 code=0**
**Target**: `grub-core/kern/err.c`, `include/grub/err.h`
**Change**: Same grub_error file+line macro as 2025-09-0237.
**Evidence**: master err.h:92-97 has `grub_error` with `__FILE__`, `__FUNCTION__`, `__LINE__`.


## 2025-09-0250 — DROP

**Subject**: memtools: add lsmemregions command
**Author**: Leo Sandoval | **fp=1 code=2**
**Target**: `grub-core/commands/memtools.c`, `grub-core/kern/mm.c`, `include/grub/mm.h`
**Change**: Add `grub_cmd_lsmemregions` command.
**Evidence**: master memtools.c line 57 `grub_cmd_lsmemregions`, line 147 registered.


## 2025-09-0258 — DROP

**Subject**: tests: Extend pbkdf2_test to cover HMAC-SHA{256, 512} (v2)
**Author**: Gary Lin | **fp=0 code=3**
**Change**: Clean apply — branch tip = master tip (`kern/misc: Restore grub_memcpy()`).
**Evidence**: ALREADY_APPLIED pattern.


## 2025-10-0006 — DROP

**Subject**: hfsplus: Allow reading files created by Mac OS 9
**Author**: Dave Vasilevsky | **fp=1 code=1**
**Target**: `grub-core/fs/hfsplus.c`
**Change**: Handle `mode == 0` for pre-Mac OS X files.
**Evidence**: master hfsplus.c line 739 `if (mode == 0) /* Created by pre-Mac OS X. */`.


## 2025-10-0009 — DROP

**Subject**: util/grub-editenv: add fs_envblk open helper (v3)
**Author**: Michael Chang | **fp=1 code=0**
**Target**: `util/grub-editenv.c`
**Change**: Part of btrfs editenv feature.
**Evidence**: superseded by v5/v6 series (upstream). master grub-editenv.c:133 `fs_envblk_open`.


## 2025-10-0011 — DROP

**Subject**: util/grub-editenv: wire list_variables to optional (v3)
**Author**: Michael Chang | **fp=1 code=0**
**Target**: `util/grub-editenv.c`
**Change**: Part of btrfs editenv feature.
**Evidence**: superseded by v5/v6 series (upstream).


## 2025-10-0044 — DROP

**Subject**: loader/i386/linux: Transfer EDID information to kernel (v2)
**Author**: Thomas Zimmermann | **fp=1 code=1**
**Target**: `grub-core/loader/i386/linux.c`, `grub-core/video/video.c`, `include/grub/video.h`
**Change**: Pass EDID info to linux kernel params.
**Evidence**: master linux.c lines 237-260 `grub_video_edid_info`.


## 2025-10-0090 — DROP

**Subject**: tss2: Introduce grub_tcg2_cap_pcr() (v4)
**Author**: Gary Lin | **fp=0 code=3**
**Change**: Clean apply — branch tip = master tip.
**Evidence**: ALREADY_APPLIED pattern.


## 2025-10-0177 — DROP

**Subject**: util/grub-editenv: add basic structures and probe (v4)
**Author**: Michael Chang | **fp=1 code=1**
**Target**: `util/grub-editenv.c`
**Change**: Part of btrfs editenv feature.
**Evidence**: superseded by v5/v6 series (upstream).


## 2025-10-0194 — DROP

**Subject**: ieee1275: Use net config for boot location
**Author**: Michael Chang | **fp=1 code=1**
**Target**: `grub-core/kern/ieee1275/init.c`
**Change**: Use `grub_ieee1275_net_config` with `ret_device`/`ret_path` output params.
**Evidence**: master init.c lines 165-166 `ret_device`/`ret_path`, line 190 `net_config`.


## 2025-10-0228 — DROP

**Subject**: io: Implement zstdio decompression (v1)
**Author**: Logan Gunthorpe | **fp=1 code=1**
**Target**: `grub-core/io/zstdio.c` and build files
**Change**: New zstd decompression module.
**Evidence**: superseded by v3 (2025-10-0324). master `zstdio.c` exists (251L).


## 2025-10-0324 — DROP

**Subject**: io: Implement zstdio decompression (v3)
**Author**: Logan Gunthorpe | **fp=1 code=1**
**Target**: `grub-core/io/zstdio.c` and build files
**Change**: New zstd decompression module.
**Evidence**: master `zstdio.c` (251L) with copyright 2025 Free Software Foundation.


## 2025-10-0354 — DROP

**Subject**: Re: docs: add Btrfs env block and special env vars (v6)
**Author**: Leo Sandoval | **fp=1 code=0**
**Target**: `docs/grub.texi`
**Change**: Duplicate Re: of 2025-10-0304 which is in series 2025-10-0294 (KEEP).
**Evidence**: covered by the series.


## 2025-10-0357 — DROP

**Subject**: build: Add appended signatures header file to EXTRA_DIST
**Author**: Daniel Kiper | **fp=0 code=1**
**Target**: `conf/Makefile.extra-dist`
**Change**: Add `appendedsig.h` to EXTRA_DIST.
**Evidence**: master Makefile.extra-dist line 82 `appendedsig.h`.


## 2025-10-0365 — DROP

**Subject**: build: Include MAINTAINERS and SECURITY files in dist
**Author**: Gary Lin | **fp=0 code=3**
**Change**: Clean apply — branch tip = master tip (`kern/misc: Restore grub_memcpy()`).
**Evidence**: ALREADY_APPLIED (no patch commit, only master tip commit on branch).


## 2025-10-0380 — DROP

**Subject**: Fixing a memory leak in serial.c
**Author**: Gary Lin | **fp=0 code=3**
**Change**: Clean apply — branch tip = master tip.
**Evidence**: ALREADY_APPLIED.


## 2025-11-0032 — DROP

**Subject**: docs: Add Security Hardening Suggestions (v2)
**Author**: Gary Lin | **fp=0 code=3**
**Change**: Clean apply — branch tip = master tip.
**Evidence**: ALREADY_APPLIED.


## 2025-11-0046 — DROP

**Subject**: linguas: Ensure that scripts runs from the directory
**Author**: Gary Lin | **fp=0 code=3**
**Change**: Clean apply — branch tip = master tip.
**Evidence**: ALREADY_APPLIED.


## 2025-11-0058 — DROP

**Subject**: blsuki: Fix grub_errno leakage in blsuki_is_default_entry()
**Author**: Michael Chang | **fp=1 code=0**
**Target**: `grub-core/commands/blsuki.c`
**Change**: Clear `grub_errno` after `grub_strtol` fails with `GRUB_ERR_BAD_NUMBER`.
**Evidence**: master blsuki.c line 1396 `grub_errno = GRUB_ERR_NONE` (broader fix).


## 2025-11-0062 — DROP

**Subject**: ieee1275/openfw: add missing grub_strdup failure checks
**Author**: Gary Lin | **fp=0 code=3**
**Change**: Clean apply — branch tip = master tip.
**Evidence**: ALREADY_APPLIED.


## 2025-11-0112 — DROP

**Subject**: tests: Support Changed mkfs.ext2 Behavior for -r Flag (v7)
**Author**: Gary Lin | **fp=0 code=3**
**Change**: Clean apply — branch tip = master tip.
**Evidence**: ALREADY_APPLIED.


## 2025-11-0125 — DROP

**Subject**: fs/zfs: Avoid pointer downcasting in dnode_get()
**Author**: Gary Lin | **fp=0 code=3**
**Change**: Clean apply — branch tip = master tip.
**Evidence**: ALREADY_APPLIED.


## 2025-11-0155 — DROP

**Subject**: commands/test: Fix error in recursion depth (SECURITY PATCH)
**Author**: Gary Lin | **fp=0 code=3**
**Change**: Clean apply — branch tip = master tip.
**Evidence**: ALREADY_APPLIED.


## 2025-11-0173 — DROP

**Subject**: linux/ofpath: Add missing strdup failure checks (v1)
**Author**: Sudhakar Kuppusamy | **fp=1 code=1**
**Target**: `grub-core/osdep/linux/ofpath.c`
**Change**: Add `if (new == NULL) return NULL` after strdup.
**Evidence**: master ofpath.c line 1162 `if (new == NULL)`.


## 2025-11-0178 — DROP

**Subject**: Revert imprudent test changes (cover letter [PATCH 0/2])
**Author**: Glenn Washburn | **fp=1 code=0**
**Target**: no files (cover letter only, FAILED.patch is empty diff area)
**Evidence**: no actual code changes.


## 2025-11-0194 — DROP

**Subject**: blsuki: Fix grub_errno leakage (v4)
**Author**: Michael Chang | **fp=1 code=0**
**Target**: `grub-core/commands/blsuki.c`
**Change**: v4 of the errno leakage fix.
**Evidence**: master blsuki.c line 1396 `grub_errno = GRUB_ERR_NONE`.


## 2025-11-0195 — DROP

**Subject**: normal/cmdline: fix hist_lines state loss and grub calloc
**Author**: Avnish Chouhan | **fp=1 code=1**
**Target**: `grub-core/normal/cmdline.c`
**Change**: Restore `hist_lines` to `old_hist_lines` on calloc failure.
**Evidence**: master cmdline.c lines 44-55 `old_hist_lines` save/restore logic.


## 2025-11-0208 — DROP

**Subject**: tests: Fix nonnative tests labeled as native
**Author**: Glenn Washburn | **fp=1 code=0**
**Target**: `Makefile.util.def`
**Change**: Change `testcase = native` to `testcase = nonnative`.
**Evidence**: master Makefile.util.def lines 829-853 have `testcase = nonnative`.


## 2025-11-0226 — DROP

**Subject**: blsuki: error out if unexpected arguments are supplied (v2)
**Author**: Radoslav Kolev | **fp=1 code=1**
**Target**: `grub-core/commands/blsuki.c`
**Change**: Return error on unexpected argc.
**Evidence**: master blsuki.c lines 1496, 1508 `unexpected argument(s) found`.


## 2025-11-0245 — DROP

**Subject**: Re: efiemu/loadcore: Add grub_calloc failure check
**Author**: Vladimir Serbinenko | **fp=1 code=0**
**Target**: `grub-core/efiemu/loadcore.c`
**Change**: Check `grub_efiemu_elfsyms == NULL` after calloc.
**Evidence**: master loadcore.c lines 204-206 `if (grub_efiemu_elfsyms == NULL)`.


## 2025-12-0002 — DROP

**Subject**: disk/ieee1275: Add a fix for memory leaks in ofdisk
**Author**: Avnish Chouhan | **fp=1 code=1**
**Target**: `grub-core/disk/ieee1275/ofdisk.c`
**Change**: Add `grub_free(p->grub_devpath)` on error paths.
**Evidence**: master ofdisk.c lines 117, 125 `grub_free (p->grub_devpath)`.


## 2025-12-0024 — DROP

**Subject**: commands/bli: set UINT32_MAX in LoaderTpm2ActivePcrBanks
**Author**: Luca Boccassi | **fp=1 code=1**
**Target**: `grub-core/commands/efi/tpm.c`
**Change**: Use `grub_efi_int64_t tpm2_active_pcr_banks` instead of old approach.
**Evidence**: master tpm.c line 42 `static grub_efi_int64_t tpm2_active_pcr_banks = -1`.


## 2025-12-0037 — DROP

**Subject**: Re: commands/efi/lsefisystab: MEMORY_ATTRIBUTES_TABLE
**Author**: Vladimir Serbinenko | **fp=1 code=0**
**Target**: `grub-core/commands/efi/lsefisystab.c`, `include/grub/efi/api.h`
**Change**: Add MEMORY_ATTRIBUTES_TABLE GUID to system table listing.
**Evidence**: master lsefisystab.c line 50 `MEMORY ATTRIBUTES TABLE`.


## 2025-12-0051 — DROP

**Subject**: grub-mkimage: Add SBAT metadata check
**Author**: Sudhakar Kuppusamy | **fp=1 code=1**
**Target**: `util/mkimage.c`
**Change**: Validate SBAT metadata size and content.
**Evidence**: master mkimage.c line 931 `validate_sbat_line` function.


## 2025-12-0083 — DROP

**Subject**: grub-mkimage: Fix empty SBAT metadata file issue (v2)
**Author**: Sudhakar Kuppusamy | **fp=1 code=1**
**Target**: `util/mkimage.c`
**Change**: Add `SBAT_HEADER` define, validate minimum SBAT size.
**Evidence**: master mkimage.c lines 59-60 `SBAT_HEADER`, line 1147 size check.


## 2026-01-0005 — DROP

**Subject**: tests: add functional tests for ecb/cbc helpers (v4)
**Author**: Srish Srinivasan | **fp=1 code=1**
**Target**: `grub-core/tests/crypto_cipher_mode_test.c` and build/doc files
**Change**: New ECB/CBC cipher mode tests.
**Evidence**: master `crypto_cipher_mode_test.c` (197L).


## 2026-01-0018 — DROP

**Subject**: ieee1275: Add a check for invalid partition number (v4)
**Author**: Avnish Chouhan | **fp=1 code=1**
**Target**: `grub-core/kern/ieee1275/openfw.c`
**Change**: Use `grub_strtoul` with `endptr` for partition validation.
**Evidence**: master openfw.c lines 531-541 `endptr`, `partno > 65535`.


## 2026-01-0031 — DROP

**Subject**: mmap/mmap: Fix integer overflow in binary search
**Author**: Wanda Phinode | **fp=1 code=0**
**Target**: `grub-core/mmap/mmap.c`
**Change**: `(low + high) / 2` → `low + (high - low) / 2`.
**Evidence**: master mmap.c line 412 `cur = low + (high - low) / 2`.


## 2026-01-0076 — DROP

**Subject**: Re: Mandatory install device check for PowerPC (v4)
**Author**: Vladimir Serbinenko | **fp=1 code=0**
**Target**: `util/grub-install.c`
**Change**: Require install_device on PowerPC non-PowerMac.
**Evidence**: master grub-install.c line 1293 `install_device is required`.


## 2026-02-0012 — DROP

**Subject**: C23 fixes: fix strchr() and strrchr() handling (v2 8/8)
**Author**: Nicholas Vinson | **fp=1 code=1**
**Target**: `grub-core/osdep/linux/ofpath.c`, `util/probe.c`, `util/resolve.c`
**Change**: `char *ed = strstr(...)` → `const char *ed = strstr(...)`.
**Evidence**: master ofpath.c line 939 `const char *ed = strstr(...)`.


## 2026-02-0031 — DROP

**Subject**: Fix build with glibc 2.43 after new ISO C23 changes
**Author**: Radoslav Kolev | **fp=1 code=1**
**Target**: `grub-core/osdep/linux/ofpath.c`, `util/probe.c`, `util/resolve.c`
**Change**: Same C23 const fix (different approach).
**Evidence**: master ofpath.c line 939 already has const.


## 2026-02-0082 — DROP

**Subject**: grub-core/osdep/linux/ofpath.c: Update strstr() calls (v2 1/4)
**Author**: Nicholas Vinson | **fp=1 code=1**
**Target**: `grub-core/osdep/linux/ofpath.c`
**Change**: Same C23 const fix.
**Evidence**: master ofpath.c line 939 `const char *ed = strstr(...)`.


## 2026-02-0093 — DROP

**Subject**: Re: loader/efi/fdt: Ensure FDT blob is 8-byte aligned
**Author**: Vladimir Serbinenko | **fp=1 code=0**
**Target**: `grub-core/loader/efi/fdt.c`
**Change**: Use `grub_memalign(FDT_BLOB_ALIGNMENT, size)` instead of `grub_malloc`.
**Evidence**: master fdt.c line 41 `FDT_BLOB_ALIGNMENT 8`, line 149 `grub_memalign`.


## 2026-03-0020 — DROP

**Subject**: Re: SECURITY: Update security team members names/fingerprints
**Author**: Andrew Hamilton | **fp=1 code=0**
**Target**: `SECURITY`
**Change**: Update contact from Daniel Kiper to Marta Lewandowska.
**Evidence**: master SECURITY lines 52-53 Marta Lewandowska.


## 2026-03-0026 — DROP

**Subject**: Re: MAINTAINERS: update maintainers list (1/2)
**Author**: Andrew Hamilton | **fp=1 code=0**
**Target**: `MAINTAINERS`
**Change**: Add Leo Sandoval and Marta Lewandowska.
**Evidence**: master MAINTAINERS lines 5-6.


## 2026-03-0031 — DROP

**Subject**: Re: MAINTAINERS: update new GRUB git repository (2/2)
**Author**: Andrew Hamilton | **fp=1 code=0**
**Target**: `MAINTAINERS`
**Change**: Update git repository URL to freedesktop.
**Evidence**: master MAINTAINERS lines 17, 34-35 freedesktop URLs.


## 2025-03-0191 — DROP

**Subject**: grub-install: support embedding x509 certificates (appended-sig v2 part 7)
**Author**: Alastair D'Silva | **fp=1 code=3**
**Target**: `grub-core/commands/pgp.c`, `util/grub-mkimage.c`, headers
**Change**: Add `OBJ_TYPE_X509_PUBKEY`, `x509key` option.
**Evidence**: master mkimage.c:79 `x509key`, line 129 `x509keys`. Already upstream.


## 2025-03-0207 — DROP

**Subject**: configure: Add -mno-relax on riscv*
**Author**: Vladimir Serbinenko | **fp=1 code=0**
**Target**: `configure.ac`
**Change**: Add `-mno-relax` / `-Wa,-mno-relax` check for riscv targets.
**Evidence**: master configure.ac lines 919, 946, 1064 have `-mno-relax`.


## 2025-03-0214 — DROP

**Subject**: Re: fs/btrfs: Fix memory leaks
**Author**: Vladimir Serbinenko | **fp=1 code=0**
**Target**: `grub-core/fs/btrfs.c`
**Change**: Add `grub_free(desc.data)` on error path.
**Evidence**: master btrfs.c lines 1542, 2121 `grub_free (desc.data)`.


## 2025-03-0215 — DROP

**Subject**: Re: lib/reloacator: Fix memory leaks
**Author**: Vladimir Serbinenko | **fp=1 code=0**
**Target**: `grub-core/lib/relocator.c`
**Change**: Add `grub_free(ctx.chunk)` on error paths.
**Evidence**: master relocator.c lines 1443, 1461 `grub_free (ctx.chunk)`.


## 2025-04-0125 — DROP

**Subject**: b64dec: Adjust for compilation in GRUB environment (v11 part 3)
**Author**: Vladimir Serbinenko | **fp=1 code=1**
**Target**: `grub-core/lib/b64dec.c`
**Change**: Replace gpgrt headers with grub/crypto, add `_gpgrt_b64state` struct.
**Evidence**: master b64dec.c line 79 `_gpgrt_b64state`. Already upstream.


## 2025-04-0143 — DROP

**Subject**: Include function name on debug traces
**Author**: Leo Sandoval | **fp=1 code=1**
**Target**: `grub-core/kern/misc.c`, `include/grub/misc.h`
**Change**: Add `__FUNCTION__` to `grub_dprintf` macro.
**Evidence**: master misc.h:38 already has `__FUNCTION__`.


## 2025-04-0211 — DROP

**Subject**: date_unit_test: test dates outside of 32-bit unix range (v3)
**Author**: Andrew Hamilton | **fp=1 code=1**
**Target**: `tests/date_unit_test.c`
**Change**: Add test vectors for 1901 and 2038 edge cases.
**Evidence**: master date_unit_test.c lines 74-80 have 32-bit edge case tests.


## 2025-04-0242 — DROP

**Subject**: Testing for specific PCI devices
**Author**: Yair Yarom | **fp=1 code=0**
**Change**: Mailing list discussion/proposal, no actual code (empty FAILED.patch).
**Evidence**: 0 lines in FAILED.patch. Just an email with testpci concept.


## 2025-05-0064 — DROP

**Subject**: commands/efi: add command to dump all uefi runtime variables (v3)
**Author**: khaalid | **fp=1 code=0**
**Target**: `grub-core/commands/efi/lsefivar.c`
**Evidence**: master `lsefivar.c` (152L). Already upstream.


## 2025-05-0108 — DROP

**Subject**: commands/efi/lsefi: Fix memory leak (v2)
**Author**: khaalid | **fp=1 code=0**
**Target**: `grub-core/commands/efi/lsefi.c`
**Change**: Add `grub_free(handles)`.
**Evidence**: master lsefi.c:128 `grub_free (handles)`.


## 2025-06-0002 — DROP

**Subject**: fs/ntfs.c: Correct next_attribute validation
**Author**: Andrew Hamilton | **fp=1 code=1**
**Target**: `grub-core/fs/ntfs.c`
**Change**: Restructure `validate_attribute` call in `next_attribute`.
**Evidence**: master ntfs.c:238 already has `validate_attribute` check.


## 2025-06-0031 — DROP

**Subject**: tests/tpm2_key_protector_test: Add tests for SHA384 PCR
**Author**: Gary Lin | **fp=1 code=1**
**Evidence**: master tpm2_key_protector_test.in:139-141 has sha384 tests.


## 2025-06-0092 — DROP

**Subject**: build: Add new header files to dist
**Author**: Andrew Hamilton | **fp=1 code=1**
**Target**: `conf/Makefile.extra-dist`
**Change**: Add asn1_test.h, tpm2_key_protector headers to EXTRA_DIST.
**Evidence**: master Makefile.extra-dist:77-80 has all entries.


## 2025-06-0101 — DROP

**Subject**: tpm2_key_protector: Dump the PCR bank for key unsealing (v2)
**Author**: Gary Lin | **fp=1 code=1**
**Evidence**: master module.c:180 `tpm2_dump_bank`. Confirmed earlier.


## 2025-09-0087 — DROP

**Subject**: disk/cryptodisk: Add '--hw-accel' to enable hardware acceleration
**Evidence**: master cryptodisk.c:69 `hw-accel`.


## 2025-09-0230 — DROP

**Subject**: Include function name on debug and error print (v2 2/2)
**Evidence**: master err.h:97 `__FUNCTION__`. Already upstream.


## 2025-10-0159 — DROP

**Subject**: docs/grub: Document signing GRUB under UEFI (v18 18/20)
**Evidence**: master grub.texi:10651 "Signing GRUB for UEFI secure boot".


## 2025-10-0187 — DROP

**Subject**: menuentry: Fix for out of bound issue
**Author**: Sudhakar Kuppusamy | **fp=1 code=1**
**Evidence**: master menuentry.c:269-270 `grub_strlen(args[argc - 1])` check.


## 2025-10-0312 — DROP

**Subject**: docs: Document lsmemregions and memtools commands
**Author**: Andrew Hamilton | **fp=1 code=1**
**Evidence**: master grub.texi:4307/5465-5466 has memtools docs.


## 2025-10-0384 — DROP

**Subject**: Adding a grub_malloc failure check in mmap.c
**Author**: Avnish Chouhan | **fp=1 code=1**
**Evidence**: master mmap.c:245 `if (n == NULL)`.


## 2025-11-0055 — DROP

**Subject**: tests/erofs_test: Fix mkfs.erofs version test (v2)
**Author**: Glenn Washburn | **fp=1 code=1**
**Evidence**: master grub-fs-tester.in:606 uses `head -n 1 | (read _ V; echo $V)`.


## 2025-11-0123 — DROP

**Subject**: util/grub-mkrescue: Fix copy/paste issue referencing mdadm
**Author**: Glenn Washburn | **fp=1 code=1**
**Evidence**: master grub-mkrescue.c:342 uses `fout` (renamed from `mdadm`).


## 2025-11-0166 — DROP

**Subject**: Check linker for --image-base support (v2)
**Author**: Nicholas Vinson | **fp=1 code=2**
**Target**: `acinclude.m4`, `configure.ac`
**Evidence**: part of ld.lld compatibility series. Not upstream.


## 2025-05-0082 — DROP

**Subject**: Fwd: efi/tpcm: Add TPCM module support (v1)
**Evidence**: Superseded by v3 (2025-07-0004). Same feature, same files.


## 2025-06-0188 — DROP

**Subject**: efi/tpcm: Add UEFI interface for TPCM module (v2)
**Evidence**: Superseded by v3 (2025-07-0004). Same feature, same files.


## 2025-04-0029 — DROP

**Subject**: loader/efi: Enhance error messages in chainloader
**Evidence**: Superseded by Re: 2025-04-0054, then by v3 series 2025-05-0076.


## 2025-04-0054 — DROP

**Subject**: Re: loader/efi/chainloader: Enhance error messages (RESEND)
**Evidence**: Superseded by v3 series 2025-05-0076. Same topic, same file.


## 2025-04-0108 — DROP

**Subject**: Disable gfxterm_menu and cmdline_cat tests
**Evidence**: Superseded by 2025-05-0032 (same topic, later submission by Washburn).


## 2025-06-0011 — DROP

**Subject**: unix/hostdisk: Fix signed integer overflow
**Author**: Lidong Chen | **fp=1 code=1**
**Target**: `grub-core/osdep/unix/hostdisk.c`
**Change**: Add `if (len > GRUB_SSIZE_MAX) return -1` in fd_read/fd_write.
**Evidence**: master commit `86e8f2c4b` (same author, same CIDs 473850/473863) uses
`SSIZE_MAX` instead of `GRUB_SSIZE_MAX`. Functionally identical. Reviewed-by Kiper.
Originally classified KEEP because grep for `GRUB_SSIZE_MAX` found no match on master.


## 2025-05-0008 — DROP

**Subject**: ntfs: Fix attribute validation check
**Author**: Vladimir Serbinenko | **fp=1 code=1**
**Target**: `grub-core/fs/ntfs.c`
**Change**: `curr += min_size` → `curr = min_size` in `validate_attribute()` run list loop.
**Evidence**: master commit `0e1762c8a` (Andrew Hamilton) fixes the same bug differently:
introduces `run_size` variable, uses `curr += (run_size + 1)`. Reviewed-by Kiper.
Same underlying issue (quadratic `curr` growth), different fix approach.


## 2025-01-0098 — DROP (series context)

**Subject**: fs/xfs: Fix grub_xfs_iterate_dir return value in case of failure
**Author**: Egor Ignatov | **fp=1 code=0**
**Target**: `grub-core/fs/xfs.c`
**Change**: `return grub_error()` → `grub_error(); return 0` at 2 boundary check sites.
**Evidence**: master commit `f20988738` (same author, Reviewed-by Kiper). Exact same patch.
**Context**: Was patch 1 of 2 in xfs series. Patch 2 (2025-01-0099, error propagation)
is NOT upstream and remains as standalone KEEP. This patch is fully redundant.


## 2025-05-0033 — DROP (series context)

**Subject**: fs/zfs: Fix another memory leak in ZFS code
**Author**: Glenn Washburn | **fp=1 code=1**
**Target**: `grub-core/fs/zfs/zfs.c`
**Change**: Add `free_sahdrp` flag to track heap allocation, free on exit.
**Evidence**: master commit `34bd00ee2` (same author, Reviewed-by Kiper). Exact same patch.
**Context**: Was patch 2 of 2 in test-disable series. Patch 1 (2025-05-0032, test disable)
is NOT upstream and remains as standalone KEEP. This patch is fully redundant.


## 2025-07-0034 — DROP (series context)

**Subject**: libgcrypt: Fix coverity warnings
**Author**: Vladimir Serbinenko | **fp=1 code=2**
**Target**: 2 new patch files in `grub-core/lib/libgcrypt-patches/`
**Change**: NULL check in mpiutil + resource free in sexp error path. Coverity CID 369001/369003.
**Evidence**: master commit `e23704ad4` (same author, Reviewed-by Kiper). Exact same patches.
**Context**: Was patch 7 of 11 in libgcrypt v14 series. Patch 11 (2025-07-0039, sexp.c leak)
is NOT upstream and remains in the series. This patch is fully redundant.


## 2025-10-0305 — DROP

**Subject**: btrfs: update doc link for bootloader support
**Author**: Michael Chang | **fp=1 code=1**
**Target**: `grub-core/fs/btrfs.c`
**Change**: Update URL from btrfs.wiki.kernel.org to btrfs.readthedocs.io.
**Evidence**: master btrfs.c:2337-2338 has the readthedocs URL. Already upstream.
Removed from series 2025-10-0294 during evaluation.


## 2025-12-0028 — DROP

**Subject**: INSTALL: Add note that the GNU Autoconf Archive may be needed
**Author**: Glenn Washburn | **fp=0 code=1** (clean apply)
**Change**: Add `GNU Autoconf Archive (autoconf-archive on Debian)` to INSTALL.
**Evidence**: Superseded by 2025-12-0072 (Dec 21 vs Dec 12, same topic, slightly
different wording). Series dissolved, sibling 2025-12-0029 also upstream.


## 2025-12-0029 — DROP

**Subject**: tests/util/grub-fs-tester: Use CSMACINTOSH encoding
**Author**: Glenn Washburn | **fp=1 code=1**
**Change**: Replace `macroman` with `CSMACINTOSH` encoding in grub-fs-tester.
**Evidence**: master grub-fs-tester.in:746-748 has CSMACINTOSH. Already upstream.
Was in series 2025-12-0028, series dissolved.


## 2025-10-0304 — DROP

**Subject**: docs: add Btrfs env block and special env vars
**Author**: Michael Chang | **fp=1 code=1**
**Target**: `docs/grub.texi`
**Change**: Add Btrfs environment block documentation section.
**Evidence**: master grub.texi lines 3374, 4008-4021 have the exact content:
"Special environment block variables" section, "reserved area" and "copy-on-write"
explanation. Found during in-depth evaluation — earlier inspection missed it
because the check only looked for the section title, not the content.

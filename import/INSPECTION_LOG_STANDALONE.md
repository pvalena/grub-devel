# Standalone Patch Inspection Log

Code-level inspection of standalone (non-series) branches against `grub/master`.
Branches confirmed as already upstream are added to `drop_new.txt`.

## 2025-01-0094 — DROP

**Subject**: term/nns8250-spcr: return if redirection is disabled
**Author**: Benjamin Herrenschmidt | **fp=1 code=1**
**Target**: `grub-core/term/ns8250-spcr.c`
**Change**: Add `if (spcr->base_addr.addr == 0) return NULL` check.
**Evidence**: master lines 80-81 have identical check.

## 2025-01-0096 — KEEP

**Subject**: Re: term/ns8250: return in case of a null SPCR base addresses
**Author**: Leo Sandoval | **fp=1 code=0**
**Target**: `grub-core/term/ns8250.c`
**Change**: Add `if (addr == NULL) return NULL` in `grub_serial_ns8250_add_mmio`.
**Evidence**: not on master — no NULL check for `addr` in that function.

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

## 2025-03-0186 — KEEP

**Subject**: pgp: factor out rsa_pad (appended-sig v2 part 5)
**Author**: Daniel Axtens
**Change**: New `pkcs1_v15` module factored out of pgp.c.
**Evidence**: `grub-core/lib/pkcs1_v15.c` and `include/grub/pkcs1_v15.h` MISSING on master.

## 2025-03-0204 — DROP

**Subject**: appendedsig: trusted and distrusted support with hash (v2 part 20)
**Author**: Sudhakar Kuppusamy
**Evidence**: master appendedsig.c line 57 `OPTION_BINARY_HASH`, line 138 `binary-hash`.

## 2025-03-0210 — DROP

**Subject**: loader/i386/linux: Fix resource leak
**Author**: Lidong Chen | **Change**: `return err` → `goto fail` after relocator alloc.
**Evidence**: master linux.c line 1145-1146 has `if (err) goto fail`.

## 2025-03-0226 — KEEP

**Subject**: Remove qemu_mips port
**Author**: Vladimir Serbinenko
**Change**: Remove all qemu_mips references from build system.
**Evidence**: master configure.ac still has `qemu_mips` at lines 214-219, 282.

## 2025-04-0009 — DROP

**Subject**: Re: fs/xfs: fix large extent counters incompat feature
**Author**: Vladimir Serbinenko | **Change**: Use `grub_xfs_get_inode_nextents()`.
**Evidence**: master xfs.c line 578 defines it, line 974 uses it.

## 2025-04-0031 — DROP

**Subject**: include/grub/i386/linux: Update linux_kernel_params
**Author**: Patrick Colp | **Change**: Rename `grub_e820_mmap` → `grub_boot_e820_entry`.
**Evidence**: master linux.h line 213 has `struct grub_boot_e820_entry`.

## 2025-04-0048 — KEEP

**Subject**: kern/x86_64/efi/startup: `call` → `jmp` for grub_main
**Author**: khaliid caliy
**Evidence**: master startup.S line 34 still has `call`. Not upstream.

## 2025-04-0054 — KEEP

**Subject**: Re: loader/efi/chainloader: Enhance error messages
**Author**: khaliid caliy
**Change**: Add `GRUB_EFI_INVALID_PARAMETER`, `NOT_FOUND`, `UNSUPPORTED` error cases.
**Evidence**: none of these error strings on master chainloader.c.

## 2025-04-0075 — DROP

**Subject**: Re: arm64: Limit memory allocations to 4GB boundary
**Author**: Vladimir Serbinenko
**Change**: `GRUB_EFI_MAX_USABLE_ADDRESS` 0xffffffffffff → 0xffffffff.
**Evidence**: master memory.h already has `0xffffffff`.

## 2025-04-0094 — KEEP

**Subject**: Use ET_DYN images and PHDRs for creating relocatable images
**Author**: Vladimir Serbinenko
**Change**: Switch EFI ldflags from `-Wl,-r` to `-shared`, remove `-R .rel.dyn`.
**Evidence**: master Makefile.common line 46 still has `-R .rel.dyn`. Not upstream.

## 2025-04-0140 — DROP

**Subject**: Re: kern/efi/mm: try allocating in the lower 4GB first
**Author**: Vladimir Serbinenko
**Change**: Try `0xffffffff` first, fall back to `MAX_USABLE_ADDRESS`.
**Evidence**: master mm.c line 173 has `0xffffffff` allocation.

## 2025-04-0196 — KEEP

**Subject**: Re: efi/mm: relax memory type request from allocate_pages
**Author**: Vladimir Serbinenko
**Change**: `GRUB_EFI_ALLOCATE_MAX_ADDRESS` → `GRUB_EFI_ALLOCATE_ANY_PAGES`.
**Evidence**: `ALLOCATE_ANY_PAGES` not found on master mm.c.

## 2025-04-0215 — DROP

**Subject**: Re: kern/efi/mm: try allocating in the lower 4GB first
**Author**: Vladimir Serbinenko | Same patch as 2025-04-0140.
**Evidence**: master mm.c line 173.

## 2025-04-0249 — DROP

**Subject**: Add Xen command line parsing (v1)
**Author**: Aaron Rainbolt | Superseded by v5 (2025-08-0076), confirmed upstream.

## 2025-04-0254 — KEEP

**Subject**: loader/efi/chainloader: Enhance error message (v1)
**Author**: khaliid caliy
**Change**: Add `UNSUPPORTED`, `INVALID_PARAMETER`, hex status in error messages.
**Evidence**: none of these error strings on master chainloader.c.

## 2025-04-0273 — KEEP

**Subject**: RFC: multiboot2: Support SKINIT Secure Launch
**Author**: Michał Żygowski | Part of SKINIT RFC series.
**Evidence**: `grub-core/loader/slaunch/skl.c` MISSING on master.

## 2025-05-0008 — KEEP

**Subject**: ntfs: Fix attribute validation check
**Author**: Vladimir Serbinenko | **Change**: `curr += min_size` → `curr = min_size`.
**Evidence**: neither pattern found on master (code restructured, but fix not applied).

## 2025-05-0025 — KEEP

**Subject**: ia64: Disable optimizations using floating-point (v2)
**Author**: Vladimir Serbinenko | **Change**: Add `-mno-inline-int-divide`.
**Evidence**: not found on master configure.ac.

## 2025-05-0037 — KEEP

**Subject**: loader/efi/linux: Enhance linux command error messages (v2)
**Author**: khaliid caliy
**Evidence**: Enhanced error strings not on master linux.c.

## 2025-05-0046 — DROP

**Subject**: docs: Document available crypto disks checks (SECURITY PATCH 5/8)
**Author**: Maxim Suhanov
**Evidence**: master grub.texi lines 4756-4757, 6816, 7353-7354 have cryptocheck docs.

## 2025-05-0055 through 2025-05-0059 — DROP (5 branches)

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

## 2025-05-0075 — KEEP

**Subject**: Re: testpci: initial module (v2)
**Author**: Vladimir Serbinenko
**Evidence**: `grub-core/commands/testpci.c` MISSING on master. New module.

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

## 2025-05-0153 — DROP (already in drop_new.txt)

## 2025-05-0180 — DROP

**Subject**: UEFI: Fix several memory leaks of UEFI handles
**Evidence**: Clean apply, `grub_memcpy` inline at master misc.h:107.

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

## 2025-06-0121 — KEEP

**Subject**: Re: Create a Containerfile for development
**Evidence**: `container/Containerfile`, `container/README` MISSING on master.

## 2025-06-0133 — DROP

**Subject**: gnulib: Bring back the fix for resolving unused variable
**Evidence**: master bootstrap.conf line 90, patch file exists.

## 2025-06-0142 — DROP

**Subject**: tests: Correct netboot and file_filter test failure
**Evidence**: master grub-shell.in lines 718-719 have netdir cleanup.

## 2025-06-0121, 2025-06-0143 — KEEP (2 branches)

**Subject**: Containerfile(s) for development
**Evidence**: `container/Containerfile*`, `container/README` MISSING on master.

## 2025-06-0149 — DROP

**Subject**: Re: tests: Correct netboot test failure
**Evidence**: Same fix as 2025-06-0142, already upstream.

## 2025-06-0163, 2025-06-0182 — DROP (2 branches)

**Subject**: loader/efi/linux v3 1/6 + v4 6/6
**Evidence**: Part of series 2025-06-0177, confirmed upstream.

## 2025-06-0188 — KEEP

**Subject**: efi/tpcm: Add UEFI interface for TPCM module (v2)
**Author**: chench246
**Evidence**: `grub-core/commands/efi/tpcm.c`, `include/grub/efi/tpcm.h` MISSING on master.

## 2025-07-0004 — KEEP

**Subject**: efi/tpcm: Add UEFI interface for TPCM module (v3)
**Evidence**: TPCM files MISSING on master. Same feature as 2025-06-0188.

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

## 2025-08-0051, 0052, 0054 — DROP (3 branches)

**Subject**: blsuki v6 (parts 2,4,5 of 5)
**Evidence**: master `blsuki.c` (1534 L).

## 2025-08-0093 — DROP

**Subject**: util/bash-completion.d: s/mkrescure/mkrescue/g
Clean apply = master tip commit. ALREADY_APPLIED.

## 2025-08-0115 — DROP

**Subject**: efi/console: treat scan_code 0x0102 (suspend) as enter
**Evidence**: master console.c lines 214-215.

## 2025-08-0146, 0147, 0153 — DROP (3 branches)

**Subject**: Re: crypto.h KDF, import_gcry.py Argon2, docs argon2
**Evidence**: all upstream — KDF at crypto.h:544-547, import_gcry.py:315, grub.texi:1714.

## 2025-08-0164 — DROP

**Subject**: Re: po: Update Translations to Build with Gettext 0.26
**Evidence**: po/*.sed files exist on master.

## 2025-08-0167 — KEEP

**Subject**: bootstrap: Ensure shallow GNULIB clone works on newer GIT
**Author**: Andrew Hamilton
**Change**: Add `grep -E -- '--(\[no-\])?depth'` check before using `--depth`.
**Evidence**: master bootstrap hardcodes `--depth 2` without checking (line 583).

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

## 2025-09-0086, 0119, 0162 — DROP (3 branches)

Clean applies = master tip. ALREADY_APPLIED.

## 2025-09-0135 — DROP

**Subject**: docs: add Btrfs env block and special env vars (v2)
Superseded by v5/v6 btrfs envblk (upstream).

## 2025-09-0168 — DROP

**Subject**: loader/i386/linux: Transfer EDID information to kernel
**Evidence**: master linux.c lines 237-260 `grub_video_edid_info`.

## 2025-09-0175, 0225 — DROP (2 branches)

Clean applies = master tip. ALREADY_APPLIED.

## 2025-09-0189 — DROP

**Subject**: tests: include verbosity on tests.in checks
**Evidence**: master tests have `set -ex` (e.g. btrfs_test.in:3).

## 2025-09-0195 — KEEP

**Subject**: efi/tpm: call get_active_pcr_banks only with TCG2 1.1+
**Author**: Luca Boccassi
**Evidence**: `tpm2_pcr_banks_reporting_present` not found on master.

## 2025-09-0237 — DROP

**Subject**: Re: Make grub_error() more verbose
**Evidence**: master err.h:92-97 has `grub_error` with `__FILE__`, `__FUNCTION__`, `__LINE__`.

## Bulk DROPs (2025-09 through 2026-03)

| Branch | Subject | Evidence |
|--------|---------|----------|
| 2025-09-0244 | grub_error verbose (Re:) | Same as 0237, upstream |
| 2025-09-0250 | memtools: lsmemregions | master memtools.c:57 |
| 2025-09-0258 | pbkdf2 HMAC-SHA tests | Master tip (ALREADY_APPLIED) |
| 2025-10-0006 | hfsplus: Mac OS 9 files | master hfsplus.c:739 `mode == 0` |
| 2025-10-0009 | grub-editenv v3 | Superseded by v5/v6 |
| 2025-10-0011 | editenv list_variables v3 | Superseded by v5/v6 |
| 2025-10-0044 | EDID info to kernel v2 | master linux.c:237-260 |
| 2025-10-0090 | tss2 cap_pcr v4 | Master tip (ALREADY_APPLIED) |
| 2025-10-0177 | editenv basic structures v4 | Superseded by v5/v6 |
| 2025-10-0194 | ieee1275 net config for boot | master init.c:165-190 |
| 2025-10-0228 | zstdio decompression v1 | Superseded by v3 |
| 2025-10-0324 | zstdio decompression v3 | master zstdio.c (251L) |
| 2025-10-0354 | Re: btrfs env docs | Dup of 2025-10-0304 (in series) |
| 2025-10-0357 | appended sig EXTRA_DIST | master Makefile.extra-dist:82 |
| 2025-10-0365 | MAINTAINERS/SECURITY dist | Master tip |
| 2025-10-0380 | serial.c memory leak | Master tip |
| 2025-11-0032 | security hardening docs v2 | Master tip |
| 2025-11-0046 | linguas.sh directory fix | Master tip |
| 2025-11-0058 | blsuki errno leakage v1 | master blsuki.c:1396 |
| 2025-11-0062 | openfw strdup checks | Master tip |
| 2025-11-0112 | mkfs.ext2 -r flag v7 | Master tip |
| 2025-11-0125 | zfs pointer downcasting | Master tip |
| 2025-11-0155 | test: recursion depth fix | Master tip |
| 2025-11-0173 | ofpath strdup checks v1 | master ofpath.c:1162 |
| 2025-11-0178 | Revert test changes (cover) | Empty FAILED.patch |
| 2025-11-0194 | blsuki errno v4 | master blsuki.c:1396 |
| 2025-11-0195 | normal/cmdline hist_lines | master cmdline.c:44-55 |
| 2025-11-0208 | tests nonnative label fix | master Makefile.util.def:829+ |
| 2025-11-0226 | blsuki unexpected args v2 | master blsuki.c:1496/1508 |
| 2025-11-0245 | efiemu/loadcore calloc | master loadcore.c:204-206 |
| 2025-12-0002 | ofdisk memory leak | master ofdisk.c:117/125 |
| 2025-12-0024 | bli UINT32_MAX PCR banks | master tpm.c:42 |
| 2025-12-0037 | lsefisystab MEMORY_ATTRIBUTES | master lsefisystab.c:50 |
| 2025-12-0051 | grub-mkimage SBAT check | master mkimage.c:931+ |
| 2025-12-0083 | grub-mkimage SBAT fix v2 | master mkimage.c:59-60 |
| 2026-01-0005 | ECB/CBC tests v4 | master crypto_cipher_mode_test.c (197L) |
| 2026-01-0018 | ieee1275 partition check v4 | master openfw.c:531-541 |
| 2026-01-0031 | mmap integer overflow | master mmap.c:412 |
| 2026-01-0076 | PowerPC install device check v4 | master grub-install.c:1293 |
| 2026-02-0012 | C23 strchr/strrchr fix v2 | master ofpath.c:939 |
| 2026-02-0031 | glibc 2.43 C23 fix | Same C23 fix, upstream |
| 2026-02-0082 | ofpath strstr const v2 | master ofpath.c:939 |
| 2026-02-0093 | FDT blob 8-byte alignment | master fdt.c:41/149 |
| 2026-03-0020 | SECURITY team update | master SECURITY:52-53 |
| 2026-03-0026 | MAINTAINERS update | master MAINTAINERS:5-6 |
| 2026-03-0031 | MAINTAINERS git repo update | master MAINTAINERS:17/34-35 |

## Standalone KEEPs (58 branches)

These branches carry changes NOT found on current master. They should
remain as candidates for review and potential upstream submission.

## 2025-03-0073 — DROP

**Subject**: fs/zfs: Fix a number of memory leaks in ZFS code
**Author**: Stuart Hayes | **fp=1 code=1**
**Change**: Add `grub_free()` for nvlist, zapbuf, features, dnbuf, fsname, snapname.
**Evidence**: master zfs.c has 28 free calls for these variables.

## 2025-03-0093 — DROP

**Subject**: powerpc: increase MIN RMA size for CAS negotiation (v4)
**Author**: Avnish Chouhan | **fp=1 code=1**
**Change**: 512MB → 768MB RMA, add CAS reboot property check.
**Evidence**: master init.c lines 70-71 have `RMO_ADDR_MAX 768 MB`.

## 2025-03-0124 — DROP

**Subject**: ieee1275/ofnet: Fix grub_malloc() removed after added safe
**Author**: Nicolas Frayer | **fp=1 code=1**
**Change**: Re-add `ofdata->path = grub_malloc(sz)`.
**Evidence**: master ofnet.c line 467.

## 2025-03-0130 — DROP

**Subject**: fs/ntfs: Check at->attr_cur after calling next_attribute() (v2)
**Author**: Andrew Hamilton | **fp=1 code=1**
**Change**: Add `attr_cur != NULL` check in while loop.
**Evidence**: master ntfs.c line 417 has the bounds check (superseded by v3/0134).

## 2025-03-0134 — DROP

**Subject**: fs/ntfs: Correct NULL Deref / Possible Infinite Loop (v3)
**Author**: Andrew Hamilton | **fp=1 code=1**
**Change**: Add `attr_cur >= at->mft->buf` bounds check.
**Evidence**: master ntfs.c line 417 has `at->attr_cur >= at->mft->buf`.

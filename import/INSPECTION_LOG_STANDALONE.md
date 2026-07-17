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

## 2025-04-0254 — DROP

**Subject**: loader/efi/chainloader: Enhance error message (v1)
**Author**: khaliid caliy
**Change**: Add `UNSUPPORTED`, `INVALID_PARAMETER`, hex status in error messages.
**Evidence**: none of these error strings on master chainloader.c.

## 2025-04-0273 — KEEP

**Subject**: RFC: multiboot2: Support SKINIT Secure Launch
**Author**: Michał Żygowski | Part of SKINIT RFC series.
**Evidence**: `grub-core/loader/slaunch/skl.c` MISSING on master.

## 2025-05-0025 — KEEP

**Subject**: ia64: Disable optimizations using floating-point (v2)
**Author**: Vladimir Serbinenko | **Change**: Add `-mno-inline-int-divide`.
**Evidence**: not found on master configure.ac.

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

## 2025-05-0151 — DROP

**Subject**: commands/efi: Fix several memory leaks (cover letter)
**Author**: khaalid cali | **fp=1 code=1**
**Target**: `grub-core/commands/efi/lsefi.c`, `grub-core/commands/efi/tpm.c`
**Change**: Add `grub_free(handles)` on error/exit paths in lsefi.c and tpm.c.
**Evidence**: master lsefi.c:128 `grub_free (handles)`, tpm.c:116/129 `grub_free (handles)`.
Originally in series 2025-05-0151; series dissolved, both members upstream.

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

## 2025-09-0195 — KEEP

**Subject**: efi/tpm: call get_active_pcr_banks only with TCG2 1.1+
**Author**: Luca Boccassi
**Evidence**: `tpm2_pcr_banks_reporting_present` not found on master.

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

## 2025-04-0142 — KEEP

**Subject**: Prepend debug traces with absolute and relative timestamps
**Author**: Renaud Métrich | **fp=1 code=0**
**Target**: `configure.ac`, `grub-core/kern/misc.c`
**Change**: Add `--with-debug-timestamps` configure option.
**Evidence**: `DEBUG_WITH_TIMESTAMPS` not found on master.

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

## 2025-06-0031 — DROP

**Subject**: tests/tpm2_key_protector_test: Add tests for SHA384 PCR
**Evidence**: master tpm2_key_protector_test.in:139-141 has sha384.

## 2025-06-0092 — DROP

**Subject**: build: Add new header files to dist
**Evidence**: master Makefile.extra-dist:77-80 has all entries.

## 2025-06-0101 — DROP

**Subject**: tpm2_key_protector: Dump PCR bank for key unsealing (v2)
**Evidence**: master module.c:180 `tpm2_dump_bank`.

## 2025-09-0087 — DROP

**Subject**: disk/cryptodisk: Add '--hw-accel' to enable hardware acceleration
**Evidence**: master cryptodisk.c:69 `hw-accel`.

## 2025-09-0230 — DROP

**Subject**: Include function name on debug and error print (v2 2/2)
**Evidence**: master err.h:97 `__FUNCTION__`. Already upstream.

## 2025-09-0238 — KEEP

**Subject**: Hint missing zstd support for PvGrub2 "not xen image"
**Author**: Nagy Elemér Károly | **fp=1 code=0**
**Target**: `grub-core/loader/i386/xen_file.c`
**Change**: Enhance error to mention possible zstd compression.
**Evidence**: master xen_file.c:92 still has plain `"not xen image"`.

## 2025-10-0159 — DROP

**Subject**: docs/grub: Document signing GRUB under UEFI (v18 18/20)
**Evidence**: master grub.texi:10651 "Signing GRUB for UEFI secure boot".

## 2025-10-0187 — DROP

**Subject**: menuentry: Fix for out of bound issue
**Author**: Sudhakar Kuppusamy | **fp=1 code=1**
**Evidence**: master menuentry.c:269-270 `grub_strlen(args[argc - 1])` check.

## 2025-10-0189 — KEEP

**Subject**: commands/hashsum: Allow to store hash in variable
**Author**: D.-E. Divernois | **fp=1 code=0**
**Target**: `grub-core/commands/hashsum.c`, `docs/grub.texi`
**Change**: Add `--set` option to store hash in env variable.
**Evidence**: no `grub_env_set` in master hashsum.c.

## 2025-10-0312 — DROP

**Subject**: docs: Document lsmemregions and memtools commands
**Author**: Andrew Hamilton | **fp=1 code=1**
**Evidence**: master grub.texi:4307/5465-5466 has memtools docs.

## 2025-10-0384 — DROP

**Subject**: Adding a grub_malloc failure check in mmap.c
**Author**: Avnish Chouhan | **fp=1 code=1**
**Evidence**: master mmap.c:245 `if (n == NULL)`.

## 2025-11-0027 — KEEP

**Subject**: util/grub.d/00_header.in: Disable loading all_video on EFI (v2)
**Author**: Andrew Hamilton | **fp=1 code=3**
**Change**: Same `GRUB_FORCE_EFI_ALL_VIDEO` feature as series 2025-11-0014.
**Evidence**: not on master (confirmed in series inspection).

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

## 2025-04-0254 — DROP

**Subject**: loader/efi/chainloader: Enhance error message (v1)
**Evidence**: Superseded by v3 series 2025-05-0076. Same topic, same file.

## 2025-05-0037 — DROP

**Subject**: loader/efi/linux: Enhance linux command error messages (v2)
**Evidence**: Superseded by v3 (2025-05-0077 in series 2025-05-0076).

## 2025-11-0166 — DROP

**Subject**: Check linker for --image-base support (v2)
**Evidence**: Superseded by v4 series 2026-03-0010. Same topic, same files.

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

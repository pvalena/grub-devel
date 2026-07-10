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

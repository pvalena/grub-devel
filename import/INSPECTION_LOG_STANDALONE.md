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

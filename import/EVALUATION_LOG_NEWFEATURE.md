# Evaluation Log: New Features

In-depth review of 17 new feature patches kept for manual incorporation.

---

## 2025-03-0061 — systemd TPM2 Key Protector

**Files**: 14 files, 5 MISSING on master
**Author**: Diorcet Yann | **Size**: +1273/-318 lines | **Standalone**

**What it does**: Adds a new `systemd_tpm2_key_protector` module that retrieves
disk encryption keys from systemd-style TPM2 tokens in LUKS2 partition headers.
Also creates `tpm2srk` and `base64` support modules.

**Code review**:
- Large standalone patch creating a complete new key protector subsystem
- New files: `systemd_tpm2_key_protector/module.c`, `tpm2_luks2.c/.h`,
  `lib/tpm2srk.c`, `lib/base64.c`, `include/grub/tpm2srk.h`, `include/grub/luks2.h`
- Modifies existing: `tpm2_key_protector/module.c`, `tpm2_args.h`, `tpm2.h`,
  `disk/luks2.c`, `util/grub-protect.c`
- Designed to work alongside the existing `tpm2_key_protector` module

**Complexity**: High — new module, new crypto, new LUKS2 integration
**Risk**: Medium — touches existing TPM and LUKS code paths
**Manual fix effort**: High — 14 files, 1273 lines of new code

---

## 2025-04-0266 series — AMD SKINIT Secure Launch (7 patches)

**Files**: `grub-core/loader/slaunch/` (new directory), `include/grub/i386/` headers
**Authors**: Alec Brown, Ross Philipson, Michał Żygowski
**Series**: [2025-04-0266](series/2025-04-0266) (all 7 patches)
**Total size**: ~1400 lines new code

**What it does**: Implements AMD SKINIT Secure Launch support for GRUB:
- `2025-04-0270` (+14): x86 definitions for SKINIT
- `2025-04-0266` (+179): PSP discovery code (PCI device scanning)
- `2025-04-0267` (+283): Core PSP commands (capability query, response handling)
- `2025-04-0268` (+59): TMR (Trusted Memory Region) setup for DMA protection
- `2025-04-0271` (+665): SKINIT core — secure launch orchestration, SKL setup
- `2025-04-0272` (+197): EFI AMD SKINIT support — platform integration
- `2025-04-0273` (+16): Multiboot2 SKINIT Secure Launch support

**Code review**:
- RFC PATCH v2 — three co-authors from different organizations
- Complete new feature: slaunch directory with 6+ new source files
- Touches existing loaders: `multiboot_mbi2.c`, `i386/linux.c`
- All FAILED.patch only — no code files in commits (clean patches, all conflicted)
- AMD PSP interaction requires hardware for testing

**Complexity**: Very High — new security feature, hardware-specific, multi-file
**Risk**: High — secure boot chain, AMD-specific hardware, untested without hardware
**Manual fix effort**: Very High — entirely new directory, 7 interdependent patches

---

## 2025-06-0121, 2025-06-0143 — Containerfiles for development

**Files**: `container/Containerfile`, `container/Containerfile.debian`, `container/Containerfile.fedora`, `container/README`
**Author**: Andrew Hamilton (0121), Andrew Hamilton (0143, v2)
**Size**: +70/+138 lines | **Standalone** (2 patches)

**What it does**: Adds container definitions for GRUB development environments.
- `2025-06-0121`: Single Containerfile with required packages
- `2025-06-0143`: v2 with separate Containerfiles for Debian and Fedora

**Code review**:
- Both are standalone (not a series) — v2 (0143) is more complete
- New directory `container/` with README
- Build/dev tooling, not runtime code
- 0121 and 0143 overlap — may want to keep only v2

**Complexity**: Trivial (container configs)
**Risk**: None
**Manual fix effort**: Trivial
**Note**: Consider keeping only 2025-06-0143 (v2) and dropping 2025-06-0121 (v1)

---

## 2025-07-0004 — efi/tpcm: UEFI TPCM module (v3)

**Files**: `grub-core/commands/efi/tpcm.c` (new), `include/grub/efi/tpcm.h` (new), `include/grub/err.h`
**Author**: chench246 | **Size**: +229 lines | **Standalone**

**What it does**: Adds a new TPCM (Trusted Platform Control Module) command for
UEFI platforms. TPCM is a Chinese trusted computing standard, similar to TPM but
with different protocol and command set.

**Code review**:
- v3 of this feature (v1=2025-05-0082, v2=2025-06-0188, both dropped)
- Creates new module with EFI protocol interface
- Adds `GRUB_ERR_TPCM_ERROR` to the error enum
- Niche feature — TPCM hardware is primarily Chinese market

**Complexity**: Medium — new EFI protocol module
**Risk**: Low — new module, doesn't affect existing code
**Manual fix effort**: Medium — new files + err.h modification

---

## 2025-07-0047 series — kern/list append + Xen arm64 (3 patches)

**Files**: `include/grub/list.h`, `grub-core/loader/arm64/xen_boot.c`
**Author**: Frediano Ziglio
**Series**: [2025-07-0047](series/2025-07-0047) (all 3 patches)

**What it does**:
- `2025-07-0057` (+0, clean apply): Adds `grub_list_append()` function to list API
- `2025-07-0050` (+178): Use LoadFile2 protocol for Xen dom0 boot on arm64
- `2025-07-0047` (+25): Allow Xen kernel to use command line from first module

**Code review**:
- RFC patches — experimental approach
- `grub_list_append` is a generic utility needed by the Xen patches
- The LoadFile2 approach is the most complex part (protocol registration, callbacks)
- 0057 is a clean apply (no FAILED.patch) — this is notable

**Complexity**: High (LoadFile2 protocol)
**Risk**: Medium — new boot path
**Manual fix effort**: Medium-High

---

## 2025-08-0012 series — ZFS endianness rewrite + datto encryption (2 patches)

**Files**: `grub-core/fs/zfs/zfs.c` + 6 other ZFS files
**Author**: Vladimir Serbinenko
**Series**: [2025-08-0012](series/2025-08-0012) (both patches)
**Total size**: +1354/-532 lines

**What it does**:
- `2025-08-0012` (+558/-429): Rewrites ZFS endianness handling — replaces
  `grub_zfs_endian_t` scattered throughout with a cleaner macro-based approach.
  Removes `dnode_end_t` wrapper, uses direct endian conversion.
- `2025-08-0013` (+796/-103): Adds datto encryption support — new crypto key
  management for datto-encrypted ZFS datasets, HMAC verification, cipher setup.

**Code review**:
- Massive changes to the ZFS subsystem — 7 files, 1354 lines changed
- The endianness rewrite touches nearly every function in zfs.c
- Datto encryption adds `DSL_CRYPTO_*` defines, cipher key management,
  `com.datto:encryption` property parsing
- Both patches have FAILED.patch + 7 code files with conflict resolution artifacts
- Very high context-shift risk — ZFS code has been actively maintained

**Complexity**: Very High — ZFS internals, crypto, endianness
**Risk**: High — pervasive ZFS changes, encryption
**Manual fix effort**: Very High — 1354 lines across 7 files, extensive conflict resolution

---

## 2025-11-0238 — ECB mode cipher tests

**Files**: `grub-core/tests/ecb_test.c` (new), `grub-core/Makefile.core.def`, `docs/grub.texi`
**Author**: Srish Srinivasan | **Size**: +299 lines | **Standalone**

**What it does**: Adds functional tests for ECB (Electronic Codebook) cipher mode
using AES, Twofish, Serpent, and Camellia. Tests encrypt/decrypt with known test
vectors.

**Code review**:
- New test file `ecb_test.c` with test vectors from standards
- Registered in Makefile.core.def as a functional test module
- Documented in grub.texi
- Pure test code — no runtime impact

**Complexity**: Simple (test code)
**Risk**: None
**Manual fix effort**: Low — new file + build registration

---

## 2026-01-0079 — commands/linux: verify kernel file size

**Files**: `grub-core/loader/efi/linux.c`, `grub-core/loader/i386/efi/linux.c` (new),
`grub-core/loader/i386/linux.c`, `grub-core/loader/i386/pc/linux.c`
**Author**: jinkangkang | **Size**: +31/-7 lines | **Standalone**

**What it does**: Adds kernel file size verification before loading. Checks that
the file size is large enough to contain the kernel header, preventing crashes
from truncated or corrupt kernel images.

**Code review**:
- Touches 4 loader files across different platforms (EFI, i386/EFI, i386, i386/pc)
- `grub-core/loader/i386/efi/linux.c` is MISSING on master — new file
- Simple size checks: `if (size < sizeof(linux_kernel_header)) return error`
- Defensive programming — prevents potential buffer overreads

**Complexity**: Simple
**Risk**: Low
**Manual fix effort**: Low-Medium — 4 files but each change is small

# Evaluation Overview

46 KEEP branches evaluated. Per-branch data in [`evaluation/`](evaluation/).
In-depth code reviews with complexity, risk, and effort assessments:

| Category | Count | Evaluation log |
|----------|------:|----------------|
| Bug fix | 6 | [EVALUATION_LOG_BUGFIX.md](EVALUATION_LOG_BUGFIX.md) |
| New feature | 17 | [EVALUATION_LOG_NEWFEATURE.md](EVALUATION_LOG_NEWFEATURE.md) |
| Enhancement | 11 | [EVALUATION_LOG_ENHANCEMENT.md](EVALUATION_LOG_ENHANCEMENT.md) |
| Compatibility | 9 | [EVALUATION_LOG_COMPAT.md](EVALUATION_LOG_COMPAT.md) |
| RFC | 1 | [EVALUATION_LOG_RFC_DOCS.md](EVALUATION_LOG_RFC_DOCS.md) |
| Documentation | 2 | [EVALUATION_LOG_RFC_DOCS.md](EVALUATION_LOG_RFC_DOCS.md) |
| **Total** | **46** | |

---

## All patches

| Branch | Type | Size | Series | Summary |
|--------|------|------|--------|---------|
| [2025-01-0096](evaluation/2025-01-0096.txt) | Bug fix | +4 -2 lines | standalone | term/ns8250: return in case of a null SPCR base addresses |
| [2025-01-0099](evaluation/2025-01-0099.txt) | Bug fix | +13 -5 lines | 2025-01-0098 (2 members) | fs/xfs: Propagate incorrect inode error from grub_xfs_read_inode |
| [2025-03-0059](evaluation/2025-03-0059.txt) | Bug fix | +5 -3 lines | standalone | tss2: restore buffer offset on tpm2_submit_command retry |
| [2025-03-0061](evaluation/2025-03-0061.txt) | New feature | +1273 -318 lines | standalone | key_protector: Add systemd TPM2 Key Protector |
| [2025-03-0186](evaluation/2025-03-0186.txt) | Enhancement | +100 -32 lines | standalone | pgp: factor out rsa_pad |
| [2025-03-0226](evaluation/2025-03-0226.txt) | Enhancement | +59 -387 lines | standalone | Remove qemu_mips port |
| [2025-04-0048](evaluation/2025-04-0048.txt) | Enhancement | +2 -3 lines | standalone | kern/x86_64/efi/startup: Suggestion in the startup code |
| [2025-04-0142](evaluation/2025-04-0142.txt) | Enhancement | +43 -5 lines | standalone | Prepend debug traces with absolute and relative timestamps |
| [2025-04-0266](evaluation/2025-04-0266.txt) | New feature | +179 -5 lines | [2025-04-0266](series/2025-04-0266) | i386: Add PSP discovery code |
| [2025-04-0267](evaluation/2025-04-0267.txt) | New feature | +283 -6 lines | [2025-04-0266](series/2025-04-0266) | slaunch/psp: Add core PSP commands and get capability command |
| [2025-04-0268](evaluation/2025-04-0268.txt) | New feature | +59 -4 lines | [2025-04-0266](series/2025-04-0266) | slaunch/psp: Setup TMRs to protect RAM from DMA |
| [2025-04-0270](evaluation/2025-04-0270.txt) | New feature | +14 -8 lines | [2025-04-0266](series/2025-04-0266) | i386: Extra x86 definitions needed by AMD SKINIT Secure Launch |
| [2025-04-0271](evaluation/2025-04-0271.txt) | New feature | +665 -26 lines | [2025-04-0266](series/2025-04-0266) | slaunch/skinit: AMD SKINIT Secure Launch core implementation |
| [2025-04-0272](evaluation/2025-04-0272.txt) | New feature | +197 -33 lines | [2025-04-0266](series/2025-04-0266) | efi: Add AMD SKINIT Secure Launch support |
| [2025-04-0273](evaluation/2025-04-0273.txt) | New feature | +16 -6 lines | [2025-04-0266](series/2025-04-0266) | multiboot2: Support SKINIT Secure Launch |
| [2025-05-0025](evaluation/2025-05-0025.txt) | Compatibility | +5 -7 lines | standalone | ia64: Disable optimizations using floating-point arithmetics |
| [2025-05-0032](evaluation/2025-05-0032.txt) | Compatibility | +5 -4 lines | 2025-05-0032 (2 members) | tests: Disable gfxterm_menu and cmdline_cat tests |
| [2025-05-0076](evaluation/2025-05-0076.txt) | Enhancement | +3 -9 lines | [2025-05-0076](series/2025-05-0076) | loader/efi/chainloader: Enhance error message of chainloader command |
| [2025-05-0077](evaluation/2025-05-0077.txt) | Enhancement | +3 -5 lines | [2025-05-0076](series/2025-05-0076) | loader/efi/linux: Enhance error message of linux command |
| [2025-05-0201](evaluation/2025-05-0201.txt) | Enhancement | +75 -18 lines | [2025-05-0201](series/2025-05-0201) | Exporting variables to upper levels |
| [2025-05-0202](evaluation/2025-05-0202.txt) | Documentation | +10 -2 lines | [2025-05-0201](series/2025-05-0201) | Docs for the new options of the ‘export’ command |
| [2025-05-0256](evaluation/2025-05-0256.txt) | Bug fix | +27 -18 lines | standalone | Regarding bug in affs filesystem parser |
| [2025-06-0121](evaluation/2025-06-0121.txt) | New feature | +70 -3 lines | standalone | Create a Containerfile with required grub packages for development |
| [2025-06-0143](evaluation/2025-06-0143.txt) | New feature | +138 -3 lines | standalone | Create Containerfiles with required grub packages for development |
| [2025-07-0004](evaluation/2025-07-0004.txt) | New feature | +229 -6 lines | standalone | efi/tpcm: Add UEFI interface for TPCM module |
| [2025-07-0038](evaluation/2025-07-0038.txt) | Compatibility | +6 -8 lines | 2025-07-0029 (11 members) | import_gcry: Make compatible with python 3.4 |
| [2025-07-0039](evaluation/2025-07-0039.txt) | Bug fix | +16 -3 lines | 2025-07-0029 (11 members) | libgcrypt: Fix a memory leak |
| [2025-07-0042](evaluation/2025-07-0042.txt) | Enhancement | +623 -657 lines | 2025-07-0029 (11 members) | import_gcry: Fix pylint warnings |
| [2025-07-0047](evaluation/2025-07-0047.txt) | New feature | +25 -4 lines | [2025-07-0047](series/2025-07-0047) | arm64/xen: Allows to use kernel command line from first module |
| [2025-07-0050](evaluation/2025-07-0050.txt) | Enhancement | +178 -5 lines | [2025-07-0047](series/2025-07-0047) | arm64/xen: Use LoadFile2 protocol for Xen boot |
| [2025-07-0057](evaluation/2025-07-0057.txt) | New feature | +0 | [2025-07-0047](series/2025-07-0047) | kern/list: Add a grub_list_append function |
| [2025-08-0012](evaluation/2025-08-0012.txt) | New feature | +558 -429 lines | [2025-08-0012](series/2025-08-0012) | zfs: Rewrite endianness handling |
| [2025-08-0013](evaluation/2025-08-0013.txt) | New feature | +796 -103 lines | [2025-08-0012](series/2025-08-0012) | zfs: Support datto encryption |
| [2025-08-0167](evaluation/2025-08-0167.txt) | Compatibility | +3 -5 lines | standalone | bootstrap: Ensure shallow GNULIB clone Works on Newer GIT |
| [2025-09-0037](evaluation/2025-09-0037.txt) | Bug fix | +33 -4 lines | standalone | lsefi: fixed memory leaks |
| [2025-09-0238](evaluation/2025-09-0238.txt) | Enhancement | +2 -3 lines | standalone | Hint missing zstd support for PvGrub2 "not xen image" |
| [2025-10-0189](evaluation/2025-10-0189.txt) | Enhancement | +43 -14 lines | standalone | commands/hashsum: Allow to store hash in variable |
| [2025-11-0238](evaluation/2025-11-0238.txt) | New feature | +299 -6 lines | standalone | tests: add functional tests for ECB mode using various ciphers |
| [2025-12-0072](evaluation/2025-12-0072.txt) | Documentation | +0 | standalone | INSTALL: Add new requirement for configure |
| [2026-01-0019](evaluation/2026-01-0019.txt) | RFC | +20 -3 lines | standalone | Feature proposal: EFI variable check to enter grub menu |
| [2026-01-0021](evaluation/2026-01-0021.txt) | Compatibility | +0 | standalone | configure: print a more helpful error if autoconf-archive is not installed |
| [2026-01-0053](evaluation/2026-01-0053.txt) | Compatibility | +45 -45 lines | standalone | Problems compiling 2.xx for AROS. |
| [2026-01-0079](evaluation/2026-01-0079.txt) | New feature | +31 -7 lines | standalone | commands/linux: verify kernel file size |
| [2026-02-0101](evaluation/2026-02-0101.txt) | Compatibility | +2 -3 lines | standalone | powerpc_ieee1275: Excluding the PKS for grub-emu on 32-bit PowerPC |
| [2026-03-0010](evaluation/2026-03-0010.txt) | Compatibility | +4 -21 lines | [2026-03-0010](series/2026-03-0010) | Revert "configure: Check linker for --image-base support" |
| [2026-03-0012](evaluation/2026-03-0012.txt) | Compatibility | +59 -25 lines | [2026-03-0010](series/2026-03-0010) | configure: drop -Ttext checks for i386-pc |

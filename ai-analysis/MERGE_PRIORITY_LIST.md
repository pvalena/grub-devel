# GRUB Branch Merge Priority List

## IMMEDIATE PRIORITY (Critical Fixes)

| Branch | Subject | Reason |
|--------|---------|--------|
| 2025-01-0091 | grub-install: force journal draining | Prevents XFS corruption on power loss |
| 2025-12-0020 | efi/sb: Fix boot failure when shim validation is disabled | Critical boot failure fix |
| 2026-02-0009 | efi: Always close protocols after usage | Fixes firmware resource leaks |
| 2025-05-0018 | pe2elf: Set correct flag for relocation sections | Prevents crash |
| 2026-03-0008 | grub-core: Update kernel image generation | i386-pc build fix for ld.lld-21 |

## HIGH PRIORITY (Important Features & Platform Support)

### Secure Launch Series (Merge as complete set)
| Branch | Subject |
|--------|---------|
| 2025-04-0275 | mmap: Add grub_mmap_get_lowest() and grub_mmap_get_highest() |
| 2025-04-0276 | slaunch: Add Secure Launch Resource Table (SLRT) header file |
| 2025-04-0278 | i386: Add CRx, MMIO, MSR and extend CPUID definitions |
| 2025-04-0281 | slaunch: Add SLR table setup support module |
| 2025-04-0283 | i386/txt: Add Intel TXT definitions header file |
| 2025-04-0284 | slaunch/txt: Add Intel TXT ACM module support |
| 2025-04-0285 | slaunch/txt: Add Intel TXT core implementation |
| 2025-04-0286 | i386: extract grub_get_max_phy_addr_bits () |
| 2025-04-0287 | slaunch/txt: Add Intel TXT verification routines |
| 2025-04-0289 | i386/efi: Add DL stub as common DL event module |
| 2025-04-0294 | multiboot: Make GRUB_MULTIBOOT(make_mbi) return MBI's size |

### Modern Hardware Support
| Branch | Subject | Reason |
|--------|---------|--------|
| 2025-05-0103 | Add xHCI support | Required for modern USB controllers |
| 2025-11-0241 | efi: new 'connectefi' command | Fixes network boot chainloading issues |

### Platform-Specific Fixes
| Branch | Subject | Platform |
|--------|---------|----------|
| 2025-04-0139 | kern/efi/mm: try allocating in the lower 4GB first | ARM64 Snapdragon X Elite |
| 2025-05-0010 | loongarch64: Use got-based retrieval instead of la. | loongarch64 |
| 2025-05-0012 | Force mcmodel=large on x64 and riscv64 | x64/riscv64 |
| 2025-05-0014 | Use mcmodel=extreme on loongarch64 | loongarch64 |
| 2026-01-0064 | Mandatory install device check for PowerPC | PowerPC |
| 2026-02-0071 | ieee1275/powerpc: implements fibre channel discovery | PowerPC FC |
| 2026-02-0072 | ieee1275: implement FCP methods for WWPN and LUNs | PowerPC FC |
| 2026-02-0073 | ieee1275: change the logic of ieee1275_get_devargs() | PowerPC NVMeoFC |

## MEDIUM PRIORITY (Features & Enhancements)

### Security Features
| Branch | Subject | Reason |
|--------|---------|--------|
| 2026-01-0033 | password_argon2: Support Argon2 for user passwords | Modern password hashing |
| 2026-01-0034 | util: Introduce grub-mkpasswd-argon2 | Companion utility |
| 2026-01-0035 | docs: Document password_argon2 | Documentation |
| 2026-01-0039 | key_protector: Add MFA key protector | Multi-factor auth for LUKS |
| 2026-01-0040 | docs: Add documentation for MFA key protector | Documentation |
| 2026-01-0041 | tests: Add mfa_key_protector_test | Testing |

### Boot Loader Spec Compliance
| Branch | Subject |
|--------|---------|
| 2025-12-0030 | blsuki: scan XBOOTLDR partition for BLS/UKIs if it exists |
| 2025-12-0032 | blsuki: search default location on XBOOTLDR partition |

### User Experience
| Branch | Subject |
|--------|---------|
| 2026-02-0024 | normal/menu_entry: Add support for jump/delete word shortcuts |
| 2026-02-0025 | normal/cmdline: Add support for jump/delete word shortcuts |
| 2025-05-0220 | Customization of GRUB menu title |
| 2025-05-0221 | Option to set title of submenus |
| 2025-05-0225 | Documentation for the --menutitle option |
| 2025-12-0027 | icon offset |

### Bug Fixes
| Branch | Subject |
|--------|---------|
| 2025-01-0065 | term/ns8250: return in case of a null SPCR base addresses |
| 2025-01-0100 | fs/xfs: Handle root inode read failure |
| 2025-02-0185 | i386: Check for cpuid family when flush cache |
| 2025-03-0211 | loader/xnu: Fix memory leak |
| 2025-05-0152 | disk/efi/efidisk: Fix memory leak |
| 2025-12-0012 | normal/menu_entry: Add grub_calloc failure check |
| 2026-02-0010 | zfs: fix root dataset detection on encrypted pools |
| 2026-02-0086 | loader/efi/fdt: Ensure FDT blob is 8-byte aligned |
| 2026-03-0003 | appendedsig: Exclude PKS support for grub-emu |

### Performance Optimizations
| Branch | Subject |
|--------|---------|
| 2025-07-0190 | libgcrypt-grub: implement _gcry_get_hw_features() |
| 2025-07-0191 | Build blake2 and sha256 with x86_64 optimization |
| 2025-07-0192 | libgcrypt-grub: fix a typo in blake2.c |
| 2025-07-0193 | libgcrypt-grub: fix missing-prototypes error |
| 2025-09-0165 | getroot: Skip mount points in grub_find_device |
| 2025-04-0149 | i386: Reduce the time of set VESA mode |

## LOWER PRIORITY (Nice to Have)

### Build System & Tooling
| Branch | Subject |
|--------|---------|
| 2025-03-0206 | Add convenience TARGET_CROSS |
| 2025-03-0223 | build: include missing header files in source tarball |
| 2025-04-0012 | libgcrypt: Fix coverity warnings |
| 2025-06-0010 | grub-core/genmoddep.awk: Replace asorti |

### Cygwin/Windows Support Series
| Branch | Subject |
|--------|---------|
| 2025-05-0016 | Fix error when cross-compiling for windows |
| 2025-05-0017 | compiler-rt: Add pei386_runtime_relocator stub |
| 2025-05-0019 | hostdisk: Fix cygwin compilation |
| 2025-05-0020 | Add cygwin path to unifont |
| 2025-05-0021 | Strip extra sections generated on cygwin |
| 2025-05-0022 | mkrescue: Fix compilation under cygwin |
| 2025-05-0023 | Discard .buildid and .reloc in cygwin script |
| 2025-05-0024 | render-label: Supports canonical paths |

### Testing & Development
| Branch | Subject |
|--------|---------|
| 2025-06-0033 | Skip tests if required tools are not available |
| 2025-09-0190 | tests: remove -w param from mkfs.hfsplus |
| 2025-09-0193 | Define a Containerfile for development |

### Documentation & Administrative
| Branch | Subject |
|--------|---------|
| 2026-03-0019 | SECURITY: Update security team members |
| 2026-03-0023 | MAINTAINERS: update maintainers list |
| 2026-03-0024 | MAINTAINERS: update new GRUB git repository |
| 2026-01-0073 | grub.texi: remove old notice about unsupported Argon2 |

### Diagnostic Tools
| Branch | Subject |
|--------|---------|
| 2025-04-0214 | Command lspaging to show paging table |
| 2025-05-0074 | testpci: initial module |
| 2025-07-0196 | commands/efi: Add a command to dump all UEFI runtime variables |
| 2026-02-0008 | efi: Add wrappers to close device path |

### Minor Enhancements
| Branch | Subject |
|--------|---------|
| 2025-03-0102 | luks2: Add token parsing support |
| 2025-03-0103 | base64: Add new module |
| 2025-03-0105 | tpm2_key_protector/grub_protect: code factorization |
| 2025-03-0106 | tss2: Add some types and marshalling functions |
| 2025-05-0159 | kern/vercmp: Add functionality to compare kernel versions |
| 2025-07-0062 | kern/list: Add a grub_list_length function |
| 2025-07-0063 | arm64/xen: Allows to use xen_hypervisor on x86_64-efi |
| 2026-06-0183 | kern/efi: Add centralized UEFI error printer |

## NEEDS CAREFUL REVIEW

| Branch | Subject | Concern |
|--------|---------|---------|
| 2025-05-0011 | Use ET_DYN instead of ET_REL modules | Major architectural change |
| 2026-02-0020 | efi: Drop support for UGA Draw and Console Control | May break very old systems |

## SKIP (Do Not Merge)

| Branch | Subject | Reason |
|--------|---------|--------|
| 2025-05-0124 | include/efi/efi: Add the prototype | Incomplete - only prototype |

## SUPERSEDED (Skip - Better Version Exists)

| Branch | Superseded By | Reason |
|--------|---------------|--------|
| 2025-04-0073 | 2025-04-0139 | Better ARM64 memory allocation approach |
| 2025-04-0092 | 2025-05-0010 | Better loongarch64 solution |
| 2025-04-0198 | 2025-04-0236/0237 | More complete EFI memory fix |
| 2025-06-0162 | 2025-09-0193 | Improved Containerfile approach |
| 2026-02-0096 | 2026-03-0003 | Better PKS exclusion |
| 2026-01-0054 | 2026-02-0020 | UGA removal makes this obsolete |

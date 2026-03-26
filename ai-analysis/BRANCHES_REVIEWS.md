# GRUB MRs - Review Results by Issue Severity

Complete analysis of all 63 MRs grouped by issue type discovered during code review.

**Total MRs reviewed**: 63
**Critical issues**: 7
**Minor issues**: 2
**No issues**: 53
**Complex/needs testing**: 1

---

## Critical Issues (7 MRs)

Issues that could cause system instability, data corruption, or security vulnerabilities.

| MR | Title | Issue Found |
|----|-------|-------------|
| [!20](https://gitlab.freedesktop.org/gnu-grub/grub/-/merge_requests/20) | grub-install: force journal draining | Unchecked unfreeze error - filesystem could remain frozen |
| [!23](https://gitlab.freedesktop.org/gnu-grub/grub/-/merge_requests/23) | Expose luks2_iterate_keyslot | Missing enum value causes compilation failure |
| [!25](https://gitlab.freedesktop.org/gnu-grub/grub/-/merge_requests/25) | xnu: Fix memory leak | Compilation error in fix |
| [!32](https://gitlab.freedesktop.org/gnu-grub/grub/-/merge_requests/32) | Relax memory allocation type | Conflicts with MR !29 |
| [!35](https://gitlab.freedesktop.org/gnu-grub/grub/-/merge_requests/35) | x86_64-efi: Ensure memory mapping | Wrong page table pointer |
| [!47](https://gitlab.freedesktop.org/gnu-grub/grub/-/merge_requests/47) | Option to set title of submenus | Double increment in loop |
| [!68](https://gitlab.freedesktop.org/gnu-grub/grub/-/merge_requests/68) | Add XBOOTLDR partition support | Double-free bug |
| [!69](https://gitlab.freedesktop.org/gnu-grub/grub/-/merge_requests/69) | Add MFA key protector | Double-free bug |

---

## Minor Issues (2 MRs)

Non-critical issues that should be addressed but don't cause immediate failure.

| MR | Title | Issue Found |
|----|-------|-------------|
| [!33](https://gitlab.freedesktop.org/gnu-grub/grub/-/merge_requests/33) | Command lspaging | Printf format string mismatch |
| [!49](https://gitlab.freedesktop.org/gnu-grub/grub/-/merge_requests/49) | Replace asorti with portable alternative | File descriptor leak |

---

## Complex/Needs Hardware Testing (1 MR)

Code that is too complex or platform-specific for thorough static analysis.

| MR | Title | Notes |
|----|-------|-------|
| [!78](https://gitlab.freedesktop.org/gnu-grub/grub/-/merge_requests/78) | Add NVMe over Fibre Channel support | Complex PowerPC/IEEE1275/NVMeoFC code requiring specialized hardware for testing |

---

## No Issues Found (53 MRs)

Clean code with no issues detected during review.

| MR | Title |
|----|-------|
| [!19](https://gitlab.freedesktop.org/gnu-grub/grub/-/merge_requests/19) | ns8250: return on null SPCR base addresses |
| [!21](https://gitlab.freedesktop.org/gnu-grub/grub/-/merge_requests/21) | xfs: Handle root inode read failure |
| [!22](https://gitlab.freedesktop.org/gnu-grub/grub/-/merge_requests/22) | Optimize VESA mode setting for Zhaoxin/Glenfly |
| [!24](https://gitlab.freedesktop.org/gnu-grub/grub/-/merge_requests/24) | Add convenience TARGET_CROSS |
| [!26](https://gitlab.freedesktop.org/gnu-grub/grub/-/merge_requests/26) | Include missing headers in source tarball |
| [!27](https://gitlab.freedesktop.org/gnu-grub/grub/-/merge_requests/27) | Add support for qemu emulation of malta board |
| [!28](https://gitlab.freedesktop.org/gnu-grub/grub/-/merge_requests/28) | arm64: Limit memory to 4GB boundary |
| [!29](https://gitlab.freedesktop.org/gnu-grub/grub/-/merge_requests/29) | Try allocating below 4GB first |
| [!30](https://gitlab.freedesktop.org/gnu-grub/grub/-/merge_requests/30) | Implement __aeabi_uldivmod |
| [!31](https://gitlab.freedesktop.org/gnu-grub/grub/-/merge_requests/31) | Enable (u)divdi3 and (u)moddi3 for mips |
| [!34](https://gitlab.freedesktop.org/gnu-grub/grub/-/merge_requests/34) | Use GRUB_MM_ADD_REGION_IN_RANGE on RISC-V |
| [!36](https://gitlab.freedesktop.org/gnu-grub/grub/-/merge_requests/36) | Ask for >4GB memory if needed |
| [!37](https://gitlab.freedesktop.org/gnu-grub/grub/-/merge_requests/37) | Secure Launch support |
| [!38](https://gitlab.freedesktop.org/gnu-grub/grub/-/merge_requests/38) | Use ET_DYN images and PHDRs |
| [!39](https://gitlab.freedesktop.org/gnu-grub/grub/-/merge_requests/39) | Cygwin/Windows build fixes |
| [!40](https://gitlab.freedesktop.org/gnu-grub/grub/-/merge_requests/40) | ia64: Fix left shift overflow |
| [!41](https://gitlab.freedesktop.org/gnu-grub/grub/-/merge_requests/41) | testpci: initial module |
| [!42](https://gitlab.freedesktop.org/gnu-grub/grub/-/merge_requests/42) | Add xHCI support |
| [!43](https://gitlab.freedesktop.org/gnu-grub/grub/-/merge_requests/43) | Complete UEFI status codes |
| [!44](https://gitlab.freedesktop.org/gnu-grub/grub/-/merge_requests/44) | Fix memory leak in efidisk |
| [!45](https://gitlab.freedesktop.org/gnu-grub/grub/-/merge_requests/45) | Add kernel version comparison |
| [!46](https://gitlab.freedesktop.org/gnu-grub/grub/-/merge_requests/46) | Customization of GRUB menu title |
| [!48](https://gitlab.freedesktop.org/gnu-grub/grub/-/merge_requests/48) | Documentation for --menutitle option |
| [!50](https://gitlab.freedesktop.org/gnu-grub/grub/-/merge_requests/50) | Add development Containerfiles |
| [!51](https://gitlab.freedesktop.org/gnu-grub/grub/-/merge_requests/51) | Add centralized UEFI error printer |
| [!52](https://gitlab.freedesktop.org/gnu-grub/grub/-/merge_requests/52) | Add TPCM module support |
| [!53](https://gitlab.freedesktop.org/gnu-grub/grub/-/merge_requests/53) | Multiple fixes |
| [!54](https://gitlab.freedesktop.org/gnu-grub/grub/-/merge_requests/54) | Enable xen_boot for x86_64-efi |
| [!55](https://gitlab.freedesktop.org/gnu-grub/grub/-/merge_requests/55) | Implement _gcry_get_hw_features() |
| [!56](https://gitlab.freedesktop.org/gnu-grub/grub/-/merge_requests/56) | Build blake2/sha256 with x86_64 optimizations |
| [!57](https://gitlab.freedesktop.org/gnu-grub/grub/-/merge_requests/57) | Fix blake2.c typo |
| [!58](https://gitlab.freedesktop.org/gnu-grub/grub/-/merge_requests/58) | Fix missing-prototypes in sha256-intel-shaext.c |
| [!59](https://gitlab.freedesktop.org/gnu-grub/grub/-/merge_requests/59) | Add lsefivar command to dump UEFI variables |
| [!60](https://gitlab.freedesktop.org/gnu-grub/grub/-/merge_requests/60) | Fix command line parsing |
| [!61](https://gitlab.freedesktop.org/gnu-grub/grub/-/merge_requests/61) | Skip mount points in grub_find_device |
| [!62](https://gitlab.freedesktop.org/gnu-grub/grub/-/merge_requests/62) | Remove -w param from mkfs.hfsplus |
| [!63](https://gitlab.freedesktop.org/gnu-grub/grub/-/merge_requests/63) | Add Containerfile for distro images |
| [!64](https://gitlab.freedesktop.org/gnu-grub/grub/-/merge_requests/64) | Disable video_bochs/cirrus for EFI x86 |
| [!65](https://gitlab.freedesktop.org/gnu-grub/grub/-/merge_requests/65) | Add 'connectefi' command |
| [!66](https://gitlab.freedesktop.org/gnu-grub/grub/-/merge_requests/66) | Add grub_calloc failure check |
| [!67](https://gitlab.freedesktop.org/gnu-grub/grub/-/merge_requests/67) | Add icon_offset property |
| [!70](https://gitlab.freedesktop.org/gnu-grub/grub/-/merge_requests/70) | Re-encode versioninfo.rc.in to UTF-8 |
| [!71](https://gitlab.freedesktop.org/gnu-grub/grub/-/merge_requests/71) | Mandatory install device check for PowerPC |
| [!72](https://gitlab.freedesktop.org/gnu-grub/grub/-/merge_requests/72) | Remove outdated Argon2 notice |
| [!73](https://gitlab.freedesktop.org/gnu-grub/grub/-/merge_requests/73) | Always close EFI protocols after usage |
| [!74](https://gitlab.freedesktop.org/gnu-grub/grub/-/merge_requests/74) | Fix ZFS root dataset detection on encrypted pools |
| [!75](https://gitlab.freedesktop.org/gnu-grub/grub/-/merge_requests/75) | Drop UGA Draw and Console Control protocols |
| [!76](https://gitlab.freedesktop.org/gnu-grub/grub/-/merge_requests/76) | Add jump/delete word shortcuts |
| [!77](https://gitlab.freedesktop.org/gnu-grub/grub/-/merge_requests/77) | Add jump/delete word shortcuts to cmdline |
| [!79](https://gitlab.freedesktop.org/gnu-grub/grub/-/merge_requests/79) | Ensure FDT blob 8-byte alignment |
| [!80](https://gitlab.freedesktop.org/gnu-grub/grub/-/merge_requests/80) | Exclude PKS for grub-emu on 32-bit PowerPC |
| [!81](https://gitlab.freedesktop.org/gnu-grub/grub/-/merge_requests/81) | Exclude PKS support for grub-emu |

---

## Summary Statistics

- **Pass rate**: 84.1% (53/63 MRs with no issues)
- **Critical issue rate**: 11.1% (7/63 MRs)
- **Minor issue rate**: 3.2% (2/63 MRs)
- **Needs hardware testing**: 1.6% (1/63 MRs)

Most common critical issues:
1. Memory management bugs (double-free) - 2 MRs
2. Compilation errors - 2 MRs
3. Logic errors - 3 MRs

All reviews are stored in `reviews/` directory with detailed analysis for each MR.

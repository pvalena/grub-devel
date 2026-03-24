# GRUB Branches by Author - Brief Overview

Complete listing of all active branches organized by author with brief descriptions.

**Total MRs**: 63 | **Total authors**: 39

---

## Vladimir Serbinenko
*phcoder at gmail dot com*

**MRs**: 8

- **[!24](https://gitlab.freedesktop.org/gnu-grub/grub/-/merge_requests/24)**: Add convenience TARGET_CROSS
- **[!27](https://gitlab.freedesktop.org/gnu-grub/grub/-/merge_requests/27)**: Add support for qemu emulation of malta board
- **[!30](https://gitlab.freedesktop.org/gnu-grub/grub/-/merge_requests/30)**: Implement __aeabi_uldivmod
- **[!31](https://gitlab.freedesktop.org/gnu-grub/grub/-/merge_requests/31)**: Enable (u)divdi3 and (u)moddi3 for mips
- **[!33](https://gitlab.freedesktop.org/gnu-grub/grub/-/merge_requests/33)**: Command lspaging to show paging table
- **[!35](https://gitlab.freedesktop.org/gnu-grub/grub/-/merge_requests/35)**: x86_64-efi: Ensure that memory is mapped when allocating
- **[!38](https://gitlab.freedesktop.org/gnu-grub/grub/-/merge_requests/38)**: Use ET_DYN images and PHDRs for creating relocatable images (5 commits)
- **[!39](https://gitlab.freedesktop.org/gnu-grub/grub/-/merge_requests/39)**: render-label: Supports canonical paths not starting with / (9 commits)

## Gary Lin
*glin at suse dot com*

**MRs**: 5

- **[!55](https://gitlab.freedesktop.org/gnu-grub/grub/-/merge_requests/55)**: libgcrypt-grub: implement _gcry_get_hw_features()
- **[!56](https://gitlab.freedesktop.org/gnu-grub/grub/-/merge_requests/56)**: Build blake2 and sha256 with x86_64 optimization assembly code
- **[!57](https://gitlab.freedesktop.org/gnu-grub/grub/-/merge_requests/57)**: libgcrypt-grub: fix a typo in blake2.c
- **[!58](https://gitlab.freedesktop.org/gnu-grub/grub/-/merge_requests/58)**: libgcrypt-grub: fix missing-prototypes error in sha256-intel-shaext.c
- **[!69](https://gitlab.freedesktop.org/gnu-grub/grub/-/merge_requests/69)**: tests: Add mfa_key_protector_test (3 commits)

## Leo Sandoval
*lsandova at redhat dot com*

**MRs**: 4

- **[!19](https://gitlab.freedesktop.org/gnu-grub/grub/-/merge_requests/19)**: term/ns8250: return in case of a null SPCR base addresses
- **[!50](https://gitlab.freedesktop.org/gnu-grub/grub/-/merge_requests/50)**: Create a Containerfiles with required grub packages for development
- **[!62](https://gitlab.freedesktop.org/gnu-grub/grub/-/merge_requests/62)**: tests: remove -w param from mkfs.hfsplus
- **[!63](https://gitlab.freedesktop.org/gnu-grub/grub/-/merge_requests/63)**: Define a Containerfile and instructions to build distro images

## Mate Kukri
*mate dot kukri at canonical dot com*

**MRs**: 3

- **[!75](https://gitlab.freedesktop.org/gnu-grub/grub/-/merge_requests/75)**: efi: Drop support for UGA Draw and Console Control protocols
- **[!76](https://gitlab.freedesktop.org/gnu-grub/grub/-/merge_requests/76)**: normal/menu_entry: Add support for jump/delete word shortcuts
- **[!77](https://gitlab.freedesktop.org/gnu-grub/grub/-/merge_requests/77)**: normal/cmdline: Add support for jump/delete word shortcuts

## Michael Chang
*mchang at suse dot com*

**MRs**: 2

- **[!20](https://gitlab.freedesktop.org/gnu-grub/grub/-/merge_requests/20)**: grub-install: force journal draining to ensure data integrity
- **[!61](https://gitlab.freedesktop.org/gnu-grub/grub/-/merge_requests/61)**: getroot: Skip mount points in grub_find_device

## Tobias Heider
*tobias dot heider at canonical dot com*

**MRs**: 2

- **[!28](https://gitlab.freedesktop.org/gnu-grub/grub/-/merge_requests/28)**: arm64: Limit memory allocations to 4GB boundary
- **[!29](https://gitlab.freedesktop.org/gnu-grub/grub/-/merge_requests/29)**: kern/efi/mm: try allocating in the lower 4GB first

## Paymon MARANDI
*paymon at encs dot concordia dot ca*

**MRs**: 2

- **[!32](https://gitlab.freedesktop.org/gnu-grub/grub/-/merge_requests/32)**: efi/mm: relax memory type request we're asking for from allocate_pages()
- **[!36](https://gitlab.freedesktop.org/gnu-grub/grub/-/merge_requests/36)**: kern/efi/mm: ask for more that 4GB if we need it

## Jiří Wolker
*projects at jwo dot cz*

**MRs**: 2

- **[!46](https://gitlab.freedesktop.org/gnu-grub/grub/-/merge_requests/46)**: Customization of GRUB menu title
- **[!47](https://gitlab.freedesktop.org/gnu-grub/grub/-/merge_requests/47)**: Option to set title of submenus

## Khalid Ali
*khaliidcaliy at gmail dot com*

**MRs**: 2

- **[!51](https://gitlab.freedesktop.org/gnu-grub/grub/-/merge_requests/51)**: kern/efi: Add centralized UEFI error printer
- **[!73](https://gitlab.freedesktop.org/gnu-grub/grub/-/merge_requests/73)**: efi: Always close protocols after usage (2 commits)

## Frediano Ziglio
*frediano dot ziglio at cloud dot com*

**MRs**: 2

- **[!53](https://gitlab.freedesktop.org/gnu-grub/grub/-/merge_requests/53)**: kern/list: Add a grub_list_length function
- **[!54](https://gitlab.freedesktop.org/gnu-grub/grub/-/merge_requests/54)**: arm64/xen: Allows to use xen_hypervisor and xen_module on x86_64-efi

## Avnish Chouhan
*avnish at linux dot ibm dot com*

**MRs**: 2

- **[!71](https://gitlab.freedesktop.org/gnu-grub/grub/-/merge_requests/71)**: Mandatory install device check for PowerPC
- **[!78](https://gitlab.freedesktop.org/gnu-grub/grub/-/merge_requests/78)**: ieee1275: add support for NVMeoFC (6 commits)

## Sudhakar Kuppusamy
*sudhakar at linux dot ibm dot com*

**MRs**: 2

- **[!80](https://gitlab.freedesktop.org/gnu-grub/grub/-/merge_requests/80)**: powerpc_ieee1275: Excluding the PKS for grub-emu on 32-bit PowerPC
- **[!81](https://gitlab.freedesktop.org/gnu-grub/grub/-/merge_requests/81)**: appendedsig: Exclude PKS support for grub-emu

## Egor Ignatov
*egori at altlinux dot org*

**MRs**: 1

- **[!21](https://gitlab.freedesktop.org/gnu-grub/grub/-/merge_requests/21)**: fs/xfs: Handle root inode read failure in grub_xfs_mount

## Tony W Wang-oc
*TonyWWang-oc at zhaoxin dot com*

**MRs**: 1

- **[!22](https://gitlab.freedesktop.org/gnu-grub/grub/-/merge_requests/22)**: i386: Reduce the time of set VESA mode by clearing FB directly for Zhaoxin/Glenfly card (2 commits)

## Yann Diorcet
*diorcet dot yann at gmail dot com*

**MRs**: 1

- **[!23](https://gitlab.freedesktop.org/gnu-grub/grub/-/merge_requests/23)**: luks: Expose new luks2_iterate_keyslot (7 commits)

## Lidong Chen
*lidong dot chen at oracle dot com*

**MRs**: 1

- **[!25](https://gitlab.freedesktop.org/gnu-grub/grub/-/merge_requests/25)**: loader/xnu: Fix memory leak

## Mike Gilbert
*floppym at gentoo dot org*

**MRs**: 1

- **[!26](https://gitlab.freedesktop.org/gnu-grub/grub/-/merge_requests/26)**: build: include missing header files in source tarball

## Adriano Cordova
*adrianox at gmail dot com*

**MRs**: 1

- **[!34](https://gitlab.freedesktop.org/gnu-grub/grub/-/merge_requests/34)**: kern/efi/mm.c: use GRUB_MM_ADD_REGION_IN_RANGE on risc-v (2 commits)

## Sergii Dmytruk
*sergii dot dmytruk at 3mdeb dot com*

**MRs**: 1

- **[!37](https://gitlab.freedesktop.org/gnu-grub/grub/-/merge_requests/37)**: efi/chainloader: support Secure Launch (20 commits)

## Collin Funk
*collin dot funk1 at gmail dot com*

**MRs**: 1

- **[!40](https://gitlab.freedesktop.org/gnu-grub/grub/-/merge_requests/40)**: ia64: Fix left shift overflow.

## Yair Yarom
*irush at cs dot huji dot ac dot il*

**MRs**: 1

- **[!41](https://gitlab.freedesktop.org/gnu-grub/grub/-/merge_requests/41)**: testpci: initial module

## Waldemar Brodkorb
*wbx at openadk dot org*

**MRs**: 1

- **[!42](https://gitlab.freedesktop.org/gnu-grub/grub/-/merge_requests/42)**: Add xHCI support

## khaalid
*khaliidcaliy at gmail dot com*

**MRs**: 1

- **[!43](https://gitlab.freedesktop.org/gnu-grub/grub/-/merge_requests/43)**: include/efi/api: Complete UEFI status codes

## khaalid cali
*khaliidcaliy at gmail dot com*

**MRs**: 1

- **[!44](https://gitlab.freedesktop.org/gnu-grub/grub/-/merge_requests/44)**: disk/efi/efidisk: Fix memory leak

## Alec Brown
*alec dot r dot brown at oracle dot com*

**MRs**: 1

- **[!45](https://gitlab.freedesktop.org/gnu-grub/grub/-/merge_requests/45)**: kern/vercmp: Add functionality to compare kernel versions

## Jiří ‘bindiff’ Wolker
*jwo at jwo dot cz*

**MRs**: 1

- **[!48](https://gitlab.freedesktop.org/gnu-grub/grub/-/merge_requests/48)**: Documentation for the --menutitle option

## Ismael Luceno
*iluceno at suse dot de*

**MRs**: 1

- **[!49](https://gitlab.freedesktop.org/gnu-grub/grub/-/merge_requests/49)**: grub-core/genmoddep.awk: Replace asorti with portable alternative

## chench246
*chench246 at gmail dot com*

**MRs**: 1

- **[!52](https://gitlab.freedesktop.org/gnu-grub/grub/-/merge_requests/52)**: efi/tpcm: Add complete support of TPCM module

## Khalid Ali
*khaliidcaly at gmail dot com*

**MRs**: 1

- **[!59](https://gitlab.freedesktop.org/gnu-grub/grub/-/merge_requests/59)**: commands/efi: Add a command to dump all UEFI runtime variables

## Shreenidhi Shedi
*yesshedi at gmail dot com*

**MRs**: 1

- **[!60](https://gitlab.freedesktop.org/gnu-grub/grub/-/merge_requests/60)**: cmdline: fix command line parsing in grub

## Andrew Hamilton
*adhamilt at gmail dot com*

**MRs**: 1

- **[!64](https://gitlab.freedesktop.org/gnu-grub/grub/-/merge_requests/64)**: build: Disable building video_bochs/cirrus for EFI x86

## Renaud Métrich
*rmetrich at redhat dot com*

**MRs**: 1

- **[!65](https://gitlab.freedesktop.org/gnu-grub/grub/-/merge_requests/65)**: efi: new 'connectefi' command

## Sridhar Markonda
*sridharm at linux dot ibm dot com*

**MRs**: 1

- **[!66](https://gitlab.freedesktop.org/gnu-grub/grub/-/merge_requests/66)**: normal/menu_entry: Add grub_calloc failure check

## Daniel Murcia
*danielmr97 at gmail dot com*

**MRs**: 1

- **[!67](https://gitlab.freedesktop.org/gnu-grub/grub/-/merge_requests/67)**: icon offset

## Radoslav Kolev
*radoslav dot kolev at suse dot com*

**MRs**: 1

- **[!68](https://gitlab.freedesktop.org/gnu-grub/grub/-/merge_requests/68)**: blsuki: search default location on XBOOTLDR partition, even if entries found on ESP (2 commits)

## Glenn Washburn
*development at efficientek dot com*

**MRs**: 1

- **[!70](https://gitlab.freedesktop.org/gnu-grub/grub/-/merge_requests/70)**: libgcrypt: Re-encode versioninfo.rc.in to UTF8 from latin-1

## Martin Castillo
*castilma at uni-bremen dot de*

**MRs**: 1

- **[!72](https://gitlab.freedesktop.org/gnu-grub/grub/-/merge_requests/72)**: grub.texi: remove old notice about unsupported Argon2

## Christian Schoenebeck
*linux_oss at crudebyte dot com*

**MRs**: 1

- **[!74](https://gitlab.freedesktop.org/gnu-grub/grub/-/merge_requests/74)**: zfs: fix root dataset detection on encrypted pools

## Mikhail Lappo
*miklelappo at gmail dot com*

**MRs**: 1

- **[!79](https://gitlab.freedesktop.org/gnu-grub/grub/-/merge_requests/79)**: loader/efi/fdt: Ensure FDT blob is 8-byte aligned

---

## Legend

- **!XX** - GitLab Merge Request number
- Number in parentheses indicates multiple commits in the MR
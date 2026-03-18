# GRUB Branches by Author - Brief Overview

Complete listing of all 111 branches organized by author with brief descriptions.

**Total branches**: 111 | **Total authors**: 43

---

## Vladimir Serbinenko
*phcoder at gmail dot com*

**Branches**: 21

- **[2025-03-0206](https://gitlab.freedesktop.org/pvalena/grub/-/tree/2025-03-0206)** ✅: Add convenience TARGET_CROSS
- **[2025-03-0225](https://gitlab.freedesktop.org/pvalena/grub/-/tree/2025-03-0225)** ✅: Add support for qemu emulation of malta board
- **[2025-04-0012](https://gitlab.freedesktop.org/pvalena/grub/-/tree/2025-04-0012)** ✅: libgcrypt: Fix coverity warnings
- **[2025-04-0092](https://gitlab.freedesktop.org/pvalena/grub/-/tree/2025-04-0092)** ⚠️: loongarch64: Use la.pcrel instead of la.
- **[2025-04-0167](https://gitlab.freedesktop.org/pvalena/grub/-/tree/2025-04-0167)** ✅: Implement __aeabi_uldivmod
- **[2025-04-0168](https://gitlab.freedesktop.org/pvalena/grub/-/tree/2025-04-0168)** ✅: Enable (u)divdi3 and (u)moddi3 for mips
- **[2025-04-0214](https://gitlab.freedesktop.org/pvalena/grub/-/tree/2025-04-0214)** ✅: Command lspaging to show paging table
- **[2025-04-0236](https://gitlab.freedesktop.org/pvalena/grub/-/tree/2025-04-0236)** ✅: x86_64-efi: Ensure that memory is mapped when allocating
- **[2025-05-0010](https://gitlab.freedesktop.org/pvalena/grub/-/tree/2025-05-0010)** ✅: loongarch64: Use got-based retrieval instead of la.
- **[2025-05-0011](https://gitlab.freedesktop.org/pvalena/grub/-/tree/2025-05-0011)** ⚠️: Use ET_DYN instead of ET_REL modules
- **[2025-05-0012](https://gitlab.freedesktop.org/pvalena/grub/-/tree/2025-05-0012)** ✅: Force mcmodel=large on x64 and riscv64
- **[2025-05-0014](https://gitlab.freedesktop.org/pvalena/grub/-/tree/2025-05-0014)** ✅: Use mcmodel=extreme on loongarch64
- **[2025-05-0016](https://gitlab.freedesktop.org/pvalena/grub/-/tree/2025-05-0016)** ✅: Fix error when cross-compiling for windows from unix-like OS
- **[2025-05-0017](https://gitlab.freedesktop.org/pvalena/grub/-/tree/2025-05-0017)** ✅: compiler-rt: Add pei386_runtime_relocator stub
- **[2025-05-0018](https://gitlab.freedesktop.org/pvalena/grub/-/tree/2025-05-0018)** ✅: pe2elf: Set correct flag for relocation sections
- **[2025-05-0019](https://gitlab.freedesktop.org/pvalena/grub/-/tree/2025-05-0019)** ✅: hostdisk: Fix cygwin compilation
- **[2025-05-0020](https://gitlab.freedesktop.org/pvalena/grub/-/tree/2025-05-0020)** ✅: Add cygwin path to unifont
- **[2025-05-0021](https://gitlab.freedesktop.org/pvalena/grub/-/tree/2025-05-0021)** ✅: Strip extra sections generated on cygwin when creating binary images
- **[2025-05-0022](https://gitlab.freedesktop.org/pvalena/grub/-/tree/2025-05-0022)** ✅: mkrescue: Fix compilation under cygwin.
- **[2025-05-0023](https://gitlab.freedesktop.org/pvalena/grub/-/tree/2025-05-0023)** ✅: Discard .buildid and .reloc in cygwin script
- **[2025-05-0024](https://gitlab.freedesktop.org/pvalena/grub/-/tree/2025-05-0024)** ✅: render-label: Supports canonical paths not starting with /

## Gary Lin
*glin at suse dot com*

**Branches**: 10

- **[2025-07-0190](https://gitlab.freedesktop.org/pvalena/grub/-/tree/2025-07-0190)** ✅: libgcrypt-grub: implement _gcry_get_hw_features()
- **[2025-07-0191](https://gitlab.freedesktop.org/pvalena/grub/-/tree/2025-07-0191)** ✅: Build blake2 and sha256 with x86_64 optimization assembly code
- **[2025-07-0192](https://gitlab.freedesktop.org/pvalena/grub/-/tree/2025-07-0192)** ✅: libgcrypt-grub: fix a typo in blake2.c
- **[2025-07-0193](https://gitlab.freedesktop.org/pvalena/grub/-/tree/2025-07-0193)** ✅: libgcrypt-grub: fix missing-prototypes error in sha256-intel-shaext.c
- **[2026-01-0033](https://gitlab.freedesktop.org/pvalena/grub/-/tree/2026-01-0033)** ✅: password_argon2: Support Argon2 for user passwords
- **[2026-01-0034](https://gitlab.freedesktop.org/pvalena/grub/-/tree/2026-01-0034)** ✅: util: Introduce grub-mkpasswd-argon2
- **[2026-01-0035](https://gitlab.freedesktop.org/pvalena/grub/-/tree/2026-01-0035)** ✅: docs: Document password_argon2 and grub-mkpasswd-argon2
- **[2026-01-0039](https://gitlab.freedesktop.org/pvalena/grub/-/tree/2026-01-0039)** ✅: key_protector: Add MFA key protector
- **[2026-01-0040](https://gitlab.freedesktop.org/pvalena/grub/-/tree/2026-01-0040)** ✅: docs: Add documentation for MFA key protector
- **[2026-01-0041](https://gitlab.freedesktop.org/pvalena/grub/-/tree/2026-01-0041)** ✅: tests: Add mfa_key_protector_test

## Leo Sandoval
*lsandova at redhat dot com*

**Branches**: 8

- **[2025-01-0065](https://gitlab.freedesktop.org/pvalena/grub/-/tree/2025-01-0065)** ✅: term/ns8250: return in case of a null SPCR base addresses
- **[2025-06-0033](https://gitlab.freedesktop.org/pvalena/grub/-/tree/2025-06-0033)** ✅: Skip tests if required tools are not available
- **[2025-06-0162](https://gitlab.freedesktop.org/pvalena/grub/-/tree/2025-06-0162)** ⚠️: Create a Containerfiles with required grub packages for development
- **[2025-09-0190](https://gitlab.freedesktop.org/pvalena/grub/-/tree/2025-09-0190)** ✅: tests: remove -w param from mkfs.hfsplus
- **[2025-09-0193](https://gitlab.freedesktop.org/pvalena/grub/-/tree/2025-09-0193)** ✅: Define a Containerfile and instructions to build distro images
- **[2026-03-0019](https://gitlab.freedesktop.org/pvalena/grub/-/tree/2026-03-0019)** ✅: SECURITY: Update security team members names/fingerprints
- **[2026-03-0023](https://gitlab.freedesktop.org/pvalena/grub/-/tree/2026-03-0023)** ✅: MAINTAINERS: update maintainers list
- **[2026-03-0024](https://gitlab.freedesktop.org/pvalena/grub/-/tree/2026-03-0024)** ✅: MAINTAINERS: update new GRUB git repository and mailing list

## Ross Philipson
*ross dot philipson at oracle dot com*

**Branches**: 8

- **[2025-04-0276](https://gitlab.freedesktop.org/pvalena/grub/-/tree/2025-04-0276)** ✅: slaunch: Add Secure Launch Resource Table (SLRT) header file
- **[2025-04-0278](https://gitlab.freedesktop.org/pvalena/grub/-/tree/2025-04-0278)** ✅: i386: Add CRx, MMIO, MSR and extend CPUID definitions
- **[2025-04-0281](https://gitlab.freedesktop.org/pvalena/grub/-/tree/2025-04-0281)** ✅: slaunch: Add SLR table setup support module
- **[2025-04-0283](https://gitlab.freedesktop.org/pvalena/grub/-/tree/2025-04-0283)** ✅: i386/txt: Add Intel TXT definitions header file
- **[2025-04-0284](https://gitlab.freedesktop.org/pvalena/grub/-/tree/2025-04-0284)** ✅: slaunch/txt: Add Intel TXT ACM module support
- **[2025-04-0285](https://gitlab.freedesktop.org/pvalena/grub/-/tree/2025-04-0285)** ✅: slaunch/txt: Add Intel TXT core implementation
- **[2025-04-0287](https://gitlab.freedesktop.org/pvalena/grub/-/tree/2025-04-0287)** ✅: slaunch/txt: Add Intel TXT verification routines
- **[2025-04-0289](https://gitlab.freedesktop.org/pvalena/grub/-/tree/2025-04-0289)** ✅: i386/efi: Add DL stub as common DL event module

## Yann Diorcet
*diorcet dot yann at gmail dot com*

**Branches**: 4

- **[2025-03-0102](https://gitlab.freedesktop.org/pvalena/grub/-/tree/2025-03-0102)** ✅: luks2: Add token parsing support
- **[2025-03-0103](https://gitlab.freedesktop.org/pvalena/grub/-/tree/2025-03-0103)** ✅: base64: Add new module allowing multiple modules to use base64 functions
- **[2025-03-0105](https://gitlab.freedesktop.org/pvalena/grub/-/tree/2025-03-0105)** ✅: tpm2_key_protector/grub_protect: code factorization for srk functions
- **[2025-03-0106](https://gitlab.freedesktop.org/pvalena/grub/-/tree/2025-03-0106)** ✅: tss2: Add some types and mashalling/unmarshalling functions for IESYS

## Avnish Chouhan
*avnish at linux dot ibm dot com*

**Branches**: 4

- **[2026-01-0064](https://gitlab.freedesktop.org/pvalena/grub/-/tree/2026-01-0064)** ✅: Mandatory install device check for PowerPC
- **[2026-02-0071](https://gitlab.freedesktop.org/pvalena/grub/-/tree/2026-02-0071)** ✅: ieee1275/powerpc: implements fibre channel discovery for ofpathname
- **[2026-02-0072](https://gitlab.freedesktop.org/pvalena/grub/-/tree/2026-02-0072)** ✅: ieee1275: implement FCP methods for WWPN and LUNs
- **[2026-02-0073](https://gitlab.freedesktop.org/pvalena/grub/-/tree/2026-02-0073)** ✅: ieee1275: change the logic of ieee1275_get_devargs()

## Nicholas Vinson
*nvinson234 at gmail dot com*

**Branches**: 4

- **[2026-03-0007](https://gitlab.freedesktop.org/pvalena/grub/-/tree/2026-03-0007)** ✅: i386/pc/int.h: move GRUB_MACHINE_PCBIOS ifdef
- **[2026-03-0008](https://gitlab.freedesktop.org/pvalena/grub/-/tree/2026-03-0008)** ✅: grub-core: Update kernel image generation
- **[2026-03-0009](https://gitlab.freedesktop.org/pvalena/grub/-/tree/2026-03-0009)** ✅: Revert "configure: Print a more helpful error if autoconf-archive is not installed"
- **[2026-03-0011](https://gitlab.freedesktop.org/pvalena/grub/-/tree/2026-03-0011)** ✅: Revert "INSTALL: Add note that the GNU Autoconf Archive may be needed"

## Michael Chang
*mchang at suse dot com*

**Branches**: 3

- **[2025-01-0091](https://gitlab.freedesktop.org/pvalena/grub/-/tree/2025-01-0091)** ✅: grub-install: force journal draining to ensure data integrity
- **[2025-09-0165](https://gitlab.freedesktop.org/pvalena/grub/-/tree/2025-09-0165)** ✅: getroot: Skip mount points in grub_find_device
- **[2026-01-0054](https://gitlab.freedesktop.org/pvalena/grub/-/tree/2026-01-0054)** ⚠️: 00_header: Omit loading efi_uga on non-x86 EFI platforms

## Khalid Ali
*khaliidcaliy at gmail dot com*

**Branches**: 3

- **[2025-06-0183](https://gitlab.freedesktop.org/pvalena/grub/-/tree/2025-06-0183)** ✅: kern/efi: Add centralized UEFI error printer
- **[2026-02-0008](https://gitlab.freedesktop.org/pvalena/grub/-/tree/2026-02-0008)** ✅: efi: Add wrappers to close device path and loaded image
- **[2026-02-0009](https://gitlab.freedesktop.org/pvalena/grub/-/tree/2026-02-0009)** ✅: efi: Always close protocols after usage

## Mate Kukri
*mate dot kukri at canonical dot com*

**Branches**: 3

- **[2026-02-0020](https://gitlab.freedesktop.org/pvalena/grub/-/tree/2026-02-0020)** ⚠️: efi: Drop support for UGA Draw and Console Control protocols
- **[2026-02-0024](https://gitlab.freedesktop.org/pvalena/grub/-/tree/2026-02-0024)** ✅: normal/menu_entry: Add support for jump/delete word shortcuts
- **[2026-02-0025](https://gitlab.freedesktop.org/pvalena/grub/-/tree/2026-02-0025)** ✅: normal/cmdline: Add support for jump/delete word shortcuts

## Tony W Wang-oc
*TonyWWang-oc at zhaoxin dot com*

**Branches**: 2

- **[2025-02-0185](https://gitlab.freedesktop.org/pvalena/grub/-/tree/2025-02-0185)** ✅: i386: Check for cpuid family when flush cache only on VIA CPUs
- **[2025-04-0149](https://gitlab.freedesktop.org/pvalena/grub/-/tree/2025-04-0149)** ✅: i386: Reduce the time of set VESA mode by clearing FB directly for Zhaoxin/Glenfly card

## Tobias Heider
*tobias dot heider at canonical dot com*

**Branches**: 2

- **[2025-04-0073](https://gitlab.freedesktop.org/pvalena/grub/-/tree/2025-04-0073)** ⚠️: arm64: Limit memory allocations to 4GB boundary
- **[2025-04-0139](https://gitlab.freedesktop.org/pvalena/grub/-/tree/2025-04-0139)** ✅: kern/efi/mm: try allocating in the lower 4GB first

## Paymon MARANDI
*paymon at encs dot concordia dot ca*

**Branches**: 2

- **[2025-04-0198](https://gitlab.freedesktop.org/pvalena/grub/-/tree/2025-04-0198)** ⚠️: efi/mm: relax memory type request we're asking for from allocate_pages()
- **[2025-04-0237](https://gitlab.freedesktop.org/pvalena/grub/-/tree/2025-04-0237)** ✅: kern/efi/mm: ask for more that 4GB if we need it

## Adriano Cordova
*adrianox at gmail dot com*

**Branches**: 2

- **[2025-04-0223](https://gitlab.freedesktop.org/pvalena/grub/-/tree/2025-04-0223)** ✅: kern/efi/mm.c: Add optional range check
- **[2025-04-0224](https://gitlab.freedesktop.org/pvalena/grub/-/tree/2025-04-0224)** ✅: kern/efi/mm.c: use GRUB_MM_ADD_REGION_IN_RANGE on risc-v

## Sergii Dmytruk
*sergii dot dmytruk at 3mdeb dot com*

**Branches**: 2

- **[2025-04-0286](https://gitlab.freedesktop.org/pvalena/grub/-/tree/2025-04-0286)** ✅: i386: extract grub_get_max_phy_addr_bits ()
- **[2025-04-0294](https://gitlab.freedesktop.org/pvalena/grub/-/tree/2025-04-0294)** ✅: multiboot: Make GRUB_MULTIBOOT(make_mbi) return MBI's size

## khaalid
*khaliidcaliy at gmail dot com*

**Branches**: 2

- **[2025-05-0123](https://gitlab.freedesktop.org/pvalena/grub/-/tree/2025-05-0123)** ✅: include/efi/api: Complete UEFI status codes
- **[2025-05-0124](https://gitlab.freedesktop.org/pvalena/grub/-/tree/2025-05-0124)** ❌: include/efi/efi: Add the prototype

## Jiří Wolker
*projects at jwo dot cz*

**Branches**: 2

- **[2025-05-0220](https://gitlab.freedesktop.org/pvalena/grub/-/tree/2025-05-0220)** ✅: Customization of GRUB menu title
- **[2025-05-0221](https://gitlab.freedesktop.org/pvalena/grub/-/tree/2025-05-0221)** ✅: Option to set title of submenus

## Frediano Ziglio
*frediano dot ziglio at cloud dot com*

**Branches**: 2

- **[2025-07-0062](https://gitlab.freedesktop.org/pvalena/grub/-/tree/2025-07-0062)** ✅: kern/list: Add a grub_list_length function
- **[2025-07-0063](https://gitlab.freedesktop.org/pvalena/grub/-/tree/2025-07-0063)** ✅: arm64/xen: Allows to use xen_hypervisor and xen_module on x86_64-efi

## Radoslav Kolev
*radoslav dot kolev at suse dot com*

**Branches**: 2

- **[2025-12-0030](https://gitlab.freedesktop.org/pvalena/grub/-/tree/2025-12-0030)** ✅: blsuki: scan XBOOTLDR partition for BLS/UKIs if it exists
- **[2025-12-0032](https://gitlab.freedesktop.org/pvalena/grub/-/tree/2025-12-0032)** ✅: blsuki: search default location on XBOOTLDR partition, even if entries found on ESP

## Sudhakar Kuppusamy
*sudhakar at linux dot ibm dot com*

**Branches**: 2

- **[2026-02-0096](https://gitlab.freedesktop.org/pvalena/grub/-/tree/2026-02-0096)** ⚠️: powerpc_ieee1275: Excluding the PKS for grub-emu on 32-bit PowerPC
- **[2026-03-0003](https://gitlab.freedesktop.org/pvalena/grub/-/tree/2026-03-0003)** ✅: appendedsig: Exclude PKS support for grub-emu

## Egor Ignatov
*egori at altlinux dot org*

**Branches**: 1

- **[2025-01-0100](https://gitlab.freedesktop.org/pvalena/grub/-/tree/2025-01-0100)** ✅: fs/xfs: Handle root inode read failure in grub_xfs_mount

## Lidong Chen
*lidong dot chen at oracle dot com*

**Branches**: 1

- **[2025-03-0211](https://gitlab.freedesktop.org/pvalena/grub/-/tree/2025-03-0211)** ✅: loader/xnu: Fix memory leak

## Mike Gilbert
*floppym at gentoo dot org*

**Branches**: 1

- **[2025-03-0223](https://gitlab.freedesktop.org/pvalena/grub/-/tree/2025-03-0223)** ✅: build: include missing header files in source tarball

## Daniel Kiper
*daniel dot kiper at oracle dot com*

**Branches**: 1

- **[2025-04-0275](https://gitlab.freedesktop.org/pvalena/grub/-/tree/2025-04-0275)** ✅: mmap: Add grub_mmap_get_lowest() and grub_mmap_get_highest()

## Collin Funk
*collin dot funk1 at gmail dot com*

**Branches**: 1

- **[2025-05-0028](https://gitlab.freedesktop.org/pvalena/grub/-/tree/2025-05-0028)** ✅: ia64: Fix left shift overflow.

## Yair Yarom
*irush at cs dot huji dot ac dot il*

**Branches**: 1

- **[2025-05-0074](https://gitlab.freedesktop.org/pvalena/grub/-/tree/2025-05-0074)** ✅: testpci: initial module

## Waldemar Brodkorb
*wbx at openadk dot org*

**Branches**: 1

- **[2025-05-0103](https://gitlab.freedesktop.org/pvalena/grub/-/tree/2025-05-0103)** ✅: Add xHCI support

## khaalid cali
*khaliidcaliy at gmail dot com*

**Branches**: 1

- **[2025-05-0152](https://gitlab.freedesktop.org/pvalena/grub/-/tree/2025-05-0152)** ✅: disk/efi/efidisk: Fix memory leak

## Alec Brown
*alec dot r dot brown at oracle dot com*

**Branches**: 1

- **[2025-05-0159](https://gitlab.freedesktop.org/pvalena/grub/-/tree/2025-05-0159)** ✅: kern/vercmp: Add functionality to compare kernel versions

## Jiří 'bindiff' Wolker
*jwo at jwo dot cz*

**Branches**: 1

- **[2025-05-0225](https://gitlab.freedesktop.org/pvalena/grub/-/tree/2025-05-0225)** ✅: Documentation for the --menutitle option

## Ismael Luceno
*iluceno at suse dot de*

**Branches**: 1

- **[2025-06-0010](https://gitlab.freedesktop.org/pvalena/grub/-/tree/2025-06-0010)** ✅: grub-core/genmoddep.awk: Replace asorti with portable alternative

## chench246
*chench246 at gmail dot com*

**Branches**: 1

- **[2025-07-0005](https://gitlab.freedesktop.org/pvalena/grub/-/tree/2025-07-0005)** ✅: efi/tpcm: Add complete support of TPCM module

## Khalid Ali
*khaliidcaly at gmail dot com*

**Branches**: 1

- **[2025-07-0196](https://gitlab.freedesktop.org/pvalena/grub/-/tree/2025-07-0196)** ✅: commands/efi: Add a command to dump all UEFI runtime variables

## Shreenidhi Shedi
*yesshedi at gmail dot com*

**Branches**: 1

- **[2025-07-0295](https://gitlab.freedesktop.org/pvalena/grub/-/tree/2025-07-0295)** ✅: cmdline: fix command line parsing in grub

## Andrew Hamilton
*adhamilt at gmail dot com*

**Branches**: 1

- **[2025-09-0265](https://gitlab.freedesktop.org/pvalena/grub/-/tree/2025-09-0265)** ✅: build: Disable building video_bochs/cirrus for EFI x86

## Renaud Métrich
*rmetrich at redhat dot com*

**Branches**: 1

- **[2025-11-0241](https://gitlab.freedesktop.org/pvalena/grub/-/tree/2025-11-0241)** ✅: efi: new 'connectefi' command

## Sridhar Markonda
*sridharm at linux dot ibm dot com*

**Branches**: 1

- **[2025-12-0012](https://gitlab.freedesktop.org/pvalena/grub/-/tree/2025-12-0012)** ✅: normal/menu_entry: Add grub_calloc failure check

## Michael Chang via Grub-devel
*grub-devel at gnu dot org*

**Branches**: 1

- **[2025-12-0020](https://gitlab.freedesktop.org/pvalena/grub/-/tree/2025-12-0020)** ✅: efi/sb: Fix boot failure when shim validation is disabled

## Daniel Murcia
*danielmr97 at gmail dot com*

**Branches**: 1

- **[2025-12-0027](https://gitlab.freedesktop.org/pvalena/grub/-/tree/2025-12-0027)** ✅: icon offset

## Glenn Washburn
*development at efficientek dot com*

**Branches**: 1

- **[2026-01-0052](https://gitlab.freedesktop.org/pvalena/grub/-/tree/2026-01-0052)** ✅: libgcrypt: Re-encode versioninfo.rc.in to UTF8 from latin-1

## Martin Castillo
*castilma at uni-bremen dot de*

**Branches**: 1

- **[2026-01-0073](https://gitlab.freedesktop.org/pvalena/grub/-/tree/2026-01-0073)** ✅: grub.texi: remove old notice about unsupported Argon2

## Christian Schoenebeck
*linux_oss at crudebyte dot com*

**Branches**: 1

- **[2026-02-0010](https://gitlab.freedesktop.org/pvalena/grub/-/tree/2026-02-0010)** ✅: zfs: fix root dataset detection on encrypted pools

## Mikhail Lappo
*miklelappo at gmail dot com*

**Branches**: 1

- **[2026-02-0086](https://gitlab.freedesktop.org/pvalena/grub/-/tree/2026-02-0086)** ✅: loader/efi/fdt: Ensure FDT blob is 8-byte aligned

---

## Legend

- ✅ **MERGE**: Ready to merge
- ⚠️ **REVIEW**: Needs careful review before merge
- ❌ **SKIP**: Should not be merged

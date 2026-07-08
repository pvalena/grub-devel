# Patch Series Overview

50 series, 187 patches total.

| Series | Patches | Author | Topic |
|--------|--------:|--------|-------|
| [2025-01-0018](series/2025-01-0018) | 2 | Glenn Washburn | docs: Replace @lbracechar{} and @rbracechar{} with @{ and @} |
| [2025-01-0033](series/2025-01-0033) | 6 | Patrick Plenefisch | disk/lvm: Make cache_lv more generic as ignored_feature_lv |
| [2025-01-0098](series/2025-01-0098) | 2 | Egor Ignatov | fs/xfs: Fix grub_xfs_iterate_dir return value in case of failure |
| [2025-03-0012](series/2025-03-0012) | 4 | Glenn Washburn | commands/ls: Return proper GRUB_ERR_* for functions returning ... |
| [2025-03-0189](series/2025-03-0189) | 2 | Daniel Axtens | dl: provide a fake grub_dl_set_persistent for the emu target |
| [2025-03-0192](series/2025-03-0192) | 5 | Daniel Axtens | appended signatures: import GNUTLS's ASN.1 description files |
| [2025-03-0198](series/2025-03-0198) | 8 | Sudhakar Kuppusamy | ieee1275: Platform Keystore (PKS) Support |
| [2025-04-0011](series/2025-04-0011) | 5 | Vladimir Serbinenko | Import libgcrypt 1.10.3 |
| [2025-04-0057](series/2025-04-0057) | 9 | Gary Lin | tpm2_key_protector: dump PCRs on policy fail |
| [2025-04-0146](series/2025-04-0146) | 3 | Alec Brown | blsuki: Add blscfg command to parse Boot Loader Specification ... |
| [2025-04-0266](series/2025-04-0266) | 3 | Alec Brown | i386: Add PSP discovery code |
| [2025-04-0270](series/2025-04-0270) | 3 | Ross Philipson | i386: Extra x86 definitions needed by AMD SKINIT Secure Launch |
| [2025-05-0032](series/2025-05-0032) | 2 | Glenn Washburn | tests: Disable gfxterm_menu and cmdline_cat tests |
| [2025-05-0044](series/2025-05-0044) | 2 | Maxim Suhanov | commands/search: Introduce the --cryptodisk-only argument |
| [2025-05-0076](series/2025-05-0076) | 2 | khaalid | loader/efi/chainloader: Enhance error message of chainloader c... |
| [2025-05-0113](series/2025-05-0113) | 4 | Andrew Hamilton | fs/ntfs: Correct some NTFS regressions |
| [2025-05-0151](series/2025-05-0151) | 2 | khaalid cali | commands/efi: Fix sevral memory leaks |
| [2025-05-0166](series/2025-05-0166) | 2 | Andrew Hamilton | fs/ntfs: Correct attribute vs attribute list validation |
| [2025-05-0201](series/2025-05-0201) | 2 | Jiří 'bindiff' Wolker | Exporting variables to upper levels |
| [2025-06-0040](series/2025-06-0040) | 2 | Alec Brown | gnulib/regcomp: Fix resource leak |
| [2025-06-0177](series/2025-06-0177) | 4 | Frediano Ziglio | loader/efi/linux: Remove useless assignment |
| [2025-07-0029](series/2025-07-0029) | 11 | Vladimir Serbinenko | Import libgcrypt 1.11 |
| [2025-07-0047](series/2025-07-0047) | 3 | Frediano Ziglio | kern/list: Add a grub_list_append function |
| [2025-07-0066](series/2025-07-0066) | 3 | Mate Kukri | efi/sb: Add support for the shim loader protocol |
| [2025-07-0287](series/2025-07-0287) | 4 | Gary Lin | argon2: Extract Argon2 code from libgcrypt |
| [2025-08-0012](series/2025-08-0012) | 2 | Vladimir Serbinenko | zfs: Rewrite endianness handling |
| [2025-08-0076](series/2025-08-0076) | 3 | Aaron Rainbolt | include/xen: Rename MAX_GUEST_CMDLINE to GRUB_XEN_MAX_GUEST_CM... |
| [2025-08-0173](series/2025-08-0173) | 2 | Andrew Hamilton | INSTALL: Document Libtasn1 Needed for grub-protect |
| [2025-08-0182](series/2025-08-0182) | 3 | Andrew Hamilton | docs: Document New libgrypt Modules |
| [2025-08-0194](series/2025-08-0194) | 10 | Sudhakar Kuppusamy | appended signatures: Parse PKCS#7 signedData |
| [2025-09-0005](series/2025-09-0005) | 2 | Gary Lin | tss2: Introduce grub_tcg2_cap_pcr() |
| [2025-09-0078](series/2025-09-0078) | 2 | Gary Lin | Tweak autoconf/automake files to detect x86_64 features |
| [2025-09-0115](series/2025-09-0115) | 2 | Hector Cao | target/i386: add compatibility property for arch_capabilities |
| [2025-09-0127](series/2025-09-0127) | 2 | Michael Chang | util/grub-editenv: add basic structures and probe call for ext... |
| [2025-10-0092](series/2025-10-0092) | 3 | Gary Lin | tss2: Add TPM2_PCR_Event command |
| [2025-10-0142](series/2025-10-0142) | 11 | Sudhakar Kuppusamy | powerpc-ieee1275: Add support for signing GRUB with an appende... |
| [2025-10-0160](series/2025-10-0160) | 3 | Sudhakar Kuppusamy | appended signatures: Verification tests |
| [2025-10-0235](series/2025-10-0235) | 9 | Gary Lin | libgcrypt/kdf: Implement hash_buffers() for BLAKE2b-512 |
| [2025-10-0266](series/2025-10-0266) | 3 | Michael Chang | btrfs: add environment block to reserved header area |
| [2025-10-0294](series/2025-10-0294) | 6 | Michael Chang | util/grub-editenv: add fs_envblk open helper |
| [2025-10-0329](series/2025-10-0329) | 7 | Gary Lin | Tweak autoconf/automake files to detect x86_64 features |
| [2025-11-0014](series/2025-11-0014) | 2 | Andrew Hamilton | util/grub-mkconfig: Add new environment variable |
| [2025-11-0097](series/2025-11-0097) | 2 | Glenn Washburn | tests/erofs_test: Remove root check |
| [2025-11-0104](series/2025-11-0104) | 2 | Andrew Hamilton | tests: Split ZFS ZSTD Test Into New File |
| [2025-11-0120](series/2025-11-0120) | 2 | Glenn Washburn | tests/grub_cmd_cryptomount: Expect test success, now that GRUB... |
| [2025-11-0142](series/2025-11-0142) | 3 | Glenn Washburn | docs: Fix spelling, grammatical and usage issues with new Port... |
| [2025-11-0204](series/2025-11-0204) | 2 | Glenn Washburn | bootstrap: Run linguas.sh in bootstrap epilogue |
| [2025-12-0028](series/2025-12-0028) | 2 | Glenn Washburn | INSTALL: Add note that the GNU Autoconf Archive may be needed |
| [2026-02-0066](series/2026-02-0066) | 3 | Avnish Chouhan | ieee1275: add support for NVMeoFC |
| [2026-03-0010](series/2026-03-0010) | 4 | Nicholas Vinson | Revert "configure: Check linker for --image-base support" |

# Patch Inspection Log

Code-level inspection of remaining branches against current `grub/master`.
Branches confirmed as already upstream are added to `drop_new.txt`.

## Series: 2025-01-0018 (2 patches, Glenn Washburn)

**Topic**: docs: Replace `@lbracechar{}` with `@{` + remove `--dumb` reference

| Branch | Commit content | Verdict |
|--------|---------------|---------|
| 2025-01-0018 | FAILED.patch only: `docs/grub-dev.texi` `@lbracechar{}` -> `@{` | Already upstream |
| 2025-01-0019 | FAILED.patch only: `docs/grub.texi` reword `--dumb` to `terminfo` | Already upstream |

**Evidence**: master lines 646-649 already use `@{...@}` syntax. Master line 2841-2843
already has the `terminfo` rewording. No `@lbracechar` or `--dumb` reference remains.

## Series: 2025-01-0033 (6 patches, Patrick Plenefisch)

**Topic**: LVM: rename `cache_lv` -> `ignored_feature_lv`, remove `cache_pool`,
add integrity/cachevol support, split validation loop, add debug messages

| Branch | Commit content | Verdict |
|--------|---------------|---------|
| 2025-01-0038 | FAILED.patch only (328L): rename `cache_lv` -> `ignored_feature_lv` | Already upstream |
| 2025-01-0037 | FAILED.patch only (66L): remove unused `cache_pool` field | Already upstream |
| 2025-01-0036 | FAILED.patch only (32L): split segment matching / validation loops | Already upstream |
| 2025-01-0035 | FAILED.patch only (103L): add `integrity` LV type handling | Already upstream |
| 2025-01-0034 | FAILED.patch only (51L): add `grub_util_info` debug messages | Already upstream |
| 2025-01-0033 | FAILED.patch only (21L): add `CACHE_USES_CACHEVOL` type | Already upstream |

**Evidence**: master `grub-core/disk/lvm.c` has `struct ignored_feature_lv` (line 37),
no `cache_pool` field, `CACHE_USES_CACHEVOL` match (line 851), `grub_util_info` messages
(lines 862, 1041), "Match LVs. Must be done after cache and integrity" comment (line 1047).
master `grub-core/disk/diskfilter.c` has the split validation loop (lines 982, 996).
All 6 commits are FAILED.patch-only (no code files changed in commit = auto-merge found
code already present).

## Series: 2025-01-0098 (dissolved — patch 1 upstream, patch 2 standalone KEEP)

**Topic**: fs/xfs: Fix return values and error propagation in `grub_xfs_iterate_dir`

| Branch | Commit content | Verdict |
|--------|---------------|---------|
| 2025-01-0098 | FAILED.patch only: fix return value to `return 0` after `grub_error()` | Already upstream |
| 2025-01-0099 | FAILED.patch only: remove `grub_print_error`, add `grub_errno` propagation | **NOT upstream** |

**Evidence**: Patch 1's changes are on master (lines 889, 1012 use `grub_error` + `return 0`).
Patch 2's changes are NOT on master: `grub_print_error` still present at lines 818, 824, 836;
no `else if (grub_errno)` guards after `iterate_dir_call_hook` calls (lines 874, 877).
**Decision**: KEEP — patch 2 carries unmerged error propagation fixes.

## Series: 2025-03-0012 (4 of 6 patches, Glenn Washburn)

**Topic**: commands/ls: Return proper errors, merge print functions, add mtime/full-path display

| Branch | Commit content | Verdict |
|--------|---------------|---------|
| 2025-03-0012 | FAILED.patch + ls.c: proper GRUB_ERR_* returns | Already upstream |
| 2025-03-0014 | FAILED.patch + ls.c: merge print_files_long into print_file | Already upstream |
| 2025-03-0015 | FAILED.patch + ls.c: show modification time | Already upstream |
| 2025-03-0017 | FAILED.patch + ls.c: print full paths for file args | Already upstream |

**Evidence**: master `grub-core/commands/ls.c` has: single `print_file` function (no
`print_files_long`), `pathname` variable at line 102, `ctx->filename` check at line 108,
`print_dirhdr` field, `grub_datetime` mtime display at lines 158-171. Parts 4,6 were
already in the ALREADY_APPLIED set. All 4 remaining commits have both FAILED.patch and
code changes in ls.c — the conflict resolution produced partial merges but the full
intended change is now on master.

## Series: 2025-03-0189 (2 of 21 patches, Daniel Axtens) — appended-sig v2

**Topic**: dl: fake `grub_dl_set_persistent` for emu + crypto: move `grub_crypto_pk_*` to crypto.c

| Branch | Commit content | Verdict |
|--------|---------------|---------|
| 2025-03-0189 | FAILED.patch + dl.h: add emu-target `grub_dl_set_persistent` stub | Already upstream |
| 2025-03-0190 | FAILED.patch + pgp.c: move `grub_crypto_pk_{dsa,ecdsa,rsa}` to crypto.c | Already upstream |

**Evidence**: master `include/grub/dl.h` has both real (line 266) and emu-fake (line 251)
`grub_dl_set_persistent`. master `grub-core/lib/crypto.c` has `grub_crypto_pk_*` at
lines 175-177; `grub-core/commands/pgp.c` no longer declares them.

## Series: 2025-03-0192 (4 of 21 patches, Daniel Axtens) — appended-sig v2

**Topic**: ASN.1 description import, PKCS#7/X.509 parsers, docs, ibm,secure-boot lockdown

| Branch | Commit content | Verdict |
|--------|---------------|---------|
| 2025-03-0192 | FAILED.patch + asn1_tab.c files (**with conflict markers**) | Already upstream |
| 2025-03-0194 | FAILED.patch + pkcs7.c, x509.c, asn1util.c, appendedsig.h | Already upstream |
| 2025-03-0195 | FAILED.patch + grub.texi: appended sig docs | Already upstream |
| 2025-03-0197 | FAILED.patch only: ibm,secure-boot lockdown | Already upstream |

**Evidence**: master has all target files: `gnutls_asn1_tab.c` (148L), `pkix_asn1_tab.c`,
`pkcs7.c`, `x509.c`, `asn1util.c`, `appendedsig.h`. `ibm,secure-boot` check at
`kern/ieee1275/init.c:1031`. **Note**: 2025-03-0192's code files contain unresolved
git conflict markers (`<<<<<<< HEAD`) — the auto-merge committed broken state. The
FAILED.patch has the clean intended diff. Moot since the clean version landed via later
submissions (up to v18).

## Series: 2025-03-0198 (7 of 21 patches, Sudhakar Kuppusamy) — appended-sig v2

**Topic**: ieee1275 PKS support, DB/DBX reading, trusted/distrusted commands, ELF Note keys

| Branch | Commit content | Verdict |
|--------|---------------|---------|
| 2025-03-0198 | FAILED.patch only: ieee1275 Platform Keystore | Superseded by v18 |
| 2025-03-0199 | FAILED.patch only: read DB/DBX secure boot vars | Superseded by v18 |
| 2025-03-0200 | FAILED.patch only: trusted/distrusted list creation | Superseded by v18 |
| 2025-03-0201 | FAILED.patch only: kernel verification with db/dbx | Superseded by v18 |
| 2025-03-0203 | FAILED.patch only: use_static_keys flag | Superseded by v18 |
| 2025-03-0202 | FAILED.patch only: read default DB keys from ELF Note | Superseded by v18 |
| 2025-03-0205 | FAILED.patch only: appended-sig documentation | Superseded by v18 |

**Evidence**: Core features on master: `platform_keystore.c` (315L), `appendedsig.c`
with trust/distrust commands, ibm,secure-boot lockdown. Some v2-specific features
(`use_static_keys`, `read_secure_boot_variables`) not found on master or in v18
FAILED.patches — likely refactored/folded into different patches in v18 (which has 11
remaining parts covering the same scope: PKS, DB/DBX, key management, lockdown).
**Decision**: DROP — v2 superseded by v18 series (2025-10-0142), which is kept.
**Dropped branches**: 2025-03-0198, 2025-03-0199, 2025-03-0200, 2025-03-0201, 2025-03-0203, 2025-03-0202, 2025-03-0205

## Series: 2025-04-0016 (3 of 7, Vladimir Serbinenko) — libgcrypt v1 import

**Topic**: Import libgcrypt 1.10.3, adjust import script, disable keccak SSE

All FAILED.patch only. Superseded by v14 "Import libgcrypt 1.11" series (2025-07-0029,
11 patches remaining). v14 imports a newer version (1.11 vs 1.10.3).
**Decision**: DROP — superseded by v14.
**Dropped branches**: 2025-04-0016, 2025-04-0014, 2025-04-0015

## Series: 2025-04-0057 (9 of 13, Gary Lin) — tpm2_key_protector v5

**Topic**: dump PCRs, tpm2_dump_pcr command, NV index support, tests, docs

All have FAILED.patch + code changes. master has: `tpm2_dump_pcr` command in
`commands/tpm2_key_protector/module.c`, NV index in module + `grub-protect.c`
(line 66: `PROTECT_OPT_TPM2_NVINDEX`), NV tests in `tpm2_key_protector_test.in`
(line 240: `tpm2_seal_unseal_nv`), docs referencing tpm2_dump_pcr.
**Decision**: DROP — all features already upstream.
**Dropped branches**: 2025-04-0059, 2025-04-0057, 2025-04-0061, 2025-04-0063, 2025-04-0064, 2025-04-0065, 2025-04-0066, 2025-04-0070, 2025-04-0069

## Series: 2025-04-0266 (7 of 7, Brown/Philipson/Żygowski) — KEEP

**Topic**: AMD SKINIT Secure Launch: x86 definitions, PSP discovery, core SKINIT,
EFI support, TMR setup, multiboot2 support

| Branch | Commit content | Author | Verdict |
|--------|---------------|--------|---------|
| 2025-04-0270 | FAILED.patch only: x86 definitions for AMD SKINIT | Philipson | Not upstream |
| 2025-04-0266 | FAILED.patch only: PSP discovery code, `psp.c`, `psp.h` | Brown | Not upstream |
| 2025-04-0267 | FAILED.patch only: core PSP commands and capability | Brown | Not upstream |
| 2025-04-0268 | FAILED.patch only: TMR setup to protect RAM from DMA | Brown | Not upstream |
| 2025-04-0271 | FAILED.patch only: AMD SKINIT Secure Launch core | Philipson | Not upstream |
| 2025-04-0272 | FAILED.patch only: EFI AMD SKINIT support | Philipson | Not upstream |
| 2025-04-0273 | FAILED.patch only: multiboot2 SKINIT Secure Launch | Żygowski | Not upstream |

RFC PATCH v2, all 7 parts. Three co-authors.
All FAILED.patch only. No slaunch/PSP/SKINIT code on master. All target files
MISSING: `grub-core/loader/slaunch/`, `include/grub/i386/psp.h`,
`include/grub/i386/skinit.h`, `include/grub/slaunch.h`, `include/grub/slr_table.h`.
**Decision**: KEEP — new feature, not upstream.

## Series: 2025-05-0032 (dissolved — patch 2 upstream, patch 1 standalone KEEP)

**Topic**: Disable gfxterm_menu/cmdline_cat tests + ZFS memory leak fix

| Branch | Commit content | Verdict |
|--------|---------------|---------|
| 2025-05-0032 | FAILED.patch only: comment out gfxterm_menu/cmdline_cat tests | **Not upstream** |
| 2025-05-0033 | FAILED.patch + code: ZFS `free_sahdrp` memory leak fix | Already upstream |

Mixed: ZFS `free_sahdrp` fix (2025-05-0033) IS on master (lines 3052-3068).
Test disable (2025-05-0032) is NOT on master — tests still enabled, patch was
not accepted (workaround for unifont issue). Independent patches grouped by
proximity; keeping as a unit for review.
**Decision**: KEEP — test disable not upstream.

## Series: 2025-01-0098 (dissolved — patch 1 upstream, patch 2 standalone KEEP) (noted earlier)

## Series: 2025-05-0076 (2 patches, khaalid) — KEEP

**Topic**: Enhance error messages in chainloader/linux with hex status codes

| Branch | Commit content | Verdict |
|--------|---------------|---------|
| 2025-05-0076 | FAILED.patch + chainloader.c: add hex status to error messages | Not upstream |
| 2025-05-0077 | FAILED.patch + linux.c: add hex status to error messages | Not upstream |

Not upstream — master still has plain `"cannot load image"` without status code in
chainloader.c. linux.c has different wording (`"start_image() returned"` vs `"cannot start image"`).
**Decision**: KEEP.

## Series: 2025-05-0113 (3 patches, Hamilton/Serbinenko)

**Topic**: NTFS regressions, fshelp NULL deref, NTFS access violations
All upstream. NTFS error strings on master: `"pu offset size incorrect"` (268),
`"edat offset is out of bounds"` (469/481), `"run offset out of range"` (722),
`"bitmap attribute loop"` (1161). fshelp `read_symlink != NULL` check at line 229.
**Decision**: DROP.
**Dropped branches**: 2025-05-0113, 2025-05-0118, 2025-05-0115

## Series: 2025-05-0151 (dissolved — both members upstream)

**Topic**: EFI memory leak fixes in lsefi.c, tpm.c, linux.c
All upstream. `grub_free(handles)` in lsefi.c:128, tpm.c:116/129.
`grub_free(mempath)` in linux.c:226/231.
**Decision**: DROP. Series dissolved — 2025-05-0151 moved to standalone (DROP),
2025-05-0153 moved to standalone (DROP).
**Dropped branches**: 2025-05-0151, 2025-05-0153

## Series: 2025-05-0166 (2 patches, Andrew Hamilton)

**Topic**: NTFS attribute validation + access violation fixes (v3)
Same NTFS fixes as 2025-05-0113, all on master.
**Decision**: DROP.
**Dropped branches**: 2025-05-0166, 2025-05-0167

## Series: 2025-05-0201 (2 patches, Jiří Wolker) — KEEP

**Topic**: Export/unexport env variables with `-u`/`-g` flags

| Branch | Commit content | Verdict |
|--------|---------------|---------|
| 2025-05-0201 | FAILED.patch only: add `grub_env_set_export_mode`, `-u`/`-g` flags | Not upstream |
| 2025-05-0202 | FAILED.patch only: docs for new export/unexport options | Not upstream |

Not upstream — no `unexport` command, no `grub_env_set_export_mode`, no `-g` flag on master.
**Decision**: KEEP.

## Series: 2025-06-0040 (2 patches, Alec Brown)

**Topic**: gnulib regcomp/regexec resource leak fixes
All upstream. Patch files exist on master: `fix-regcomp-resource-leak.patch` (110L),
`fix-regexec-resource-leak.patch` (11L). bootstrap.conf references them at lines 87-88.
**Decision**: DROP.
**Dropped branches**: 2025-06-0041, 2025-06-0040

## Series: 2025-06-0177 (4 of 6 patches, Frediano Ziglio)

**Topic**: loader/efi/linux LoadOptions: remove useless assignment, fix excessive size,
use sizeof, correct NUL termination
All upstream. master linux.c has `args_len` (201/242), separated `load_options_size` (253),
NUL terminator (252), `grub_utf8_to_utf16` with `args_len` (250).
**Decision**: DROP.
**Dropped branches**: 2025-06-0177, 2025-06-0178, 2025-06-0179, 2025-06-0182

## Series: 2025-07-0029 (10 of 15 patches, Vladimir Serbinenko) — KEEP

**Topic**: Import libgcrypt 1.11, b64dec, blake2, import script, coverity fixes, memory leak

| Branch | Commit content | Verdict |
|--------|---------------|---------|
| 2025-07-0033 | FAILED.patch + code: Import libgcrypt 1.11 (hundreds of files) | Already upstream |
| 2025-07-0029 | FAILED.patch + code: Import b64dec from gpg-error | Already upstream |
| 2025-07-0031 | FAILED.patch + code: Adjust import script | Already upstream |
| 2025-07-0032 | FAILED.patch + code: Add DSA and RSA SEXP tests | Already upstream |
| 2025-07-0034 | FAILED.patch + code: Fix coverity warnings | Already upstream |
| 2025-07-0035 | FAILED.patch + code: Remove unneeded gcrypt compilation flag | Already upstream |
| 2025-07-0037 | FAILED.patch + code: Ignore sign-compare warnings | Already upstream |
| 2025-07-0040 | FAILED.patch + code: Import blake family of hashes | Already upstream |
| 2025-07-0038 | FAILED.patch + code: import_gcry python 3.4 compat | Already upstream |
| 2025-07-0042 | FAILED.patch + code: Fix pylint warnings | Already upstream |
| 2025-07-0039 | FAILED.patch + code: Fix memory leak in sexp.c | **NOT upstream** |

Master has libgcrypt 1.11.0 — the import itself is upstream. However, patch 14
(2025-07-0039, memory leak fix in `sexp.c`) is NOT upstream: `free(buffer)` before
`return NULL` at "Invalid hex digits" path is missing on master line ~2719.
**Decision**: KEEP — memory leak fix not upstream.

## Series: 2025-07-0047 (3 of 5, Frediano Ziglio) — KEEP

**Topic**: kern/list: `grub_list_append` + arm64/xen LoadFile2 + xen kernel cmdline

| Branch | Commit content | Verdict |
|--------|---------------|---------|
| 2025-07-0057 | CLEAN_APPLY: kern/list: Add `grub_list_append` function | Not upstream |
| 2025-07-0050 | FAILED.patch only: arm64/xen: Use LoadFile2 protocol for Xen boot | Not upstream |
| 2025-07-0047 | FAILED.patch only: arm64/xen: Use kernel command line from cmdline | Not upstream |

RFC patches. No `grub_list_append` on master. Xen LoadFile2 not in xen loader.
**Decision**: KEEP.

## Series: 2025-07-0066 (3 of 5, Mate Kukri)

**Topic**: efi/sb: shim loader protocol support
All upstream. `GRUB_EFI_SHIM_IMAGE_LOADER_GUID` at sb.c:34, `shim_loader`
variable at sb.c:36, `last_verified_image_handle` at sb.c:39.
**Decision**: DROP.
**Dropped branches**: 2025-07-0068, 2025-07-0066, 2025-07-0069

## Series: 2025-07-0287 (2 of 7, Gary Lin)

**Topic**: Argon2: extract from libgcrypt + LUKS2 Argon2 support
Superseded by v5 series (2025-10-0235). master has `argon2.c` and
`LUKS2_KDF_TYPE_ARGON2I/ID` in luks2.c.
**Decision**: DROP — superseded by v5.
**Dropped branches**: 2025-07-0287, 2025-07-0291

## Series: 2025-08-0012 (2 patches, Vladimir Serbinenko) — KEEP

**Topic**: ZFS: rewrite endianness handling + datto encryption support

| Branch | Commit content | Verdict |
|--------|---------------|---------|
| 2025-08-0012 | FAILED.patch + 7 code files: rewrite ZFS endianness handling | Not upstream |
| 2025-08-0013 | FAILED.patch + 3 code files: add datto encryption support | Not upstream |

Not upstream — no `datto`, no `DSL_CRYPTO`, no `grub_cpu_to_zfs` on master.
**Decision**: KEEP.

## Series: 2025-08-0076 (3 of 3, Aaron Rainbolt)

**Topic**: Xen: rename MAX_GUEST_CMDLINE, add warning comment, add cmdline parsing (v5)
All upstream. `GRUB_XEN_MAX_GUEST_CMDLINE` at xen.h:831, `grub_parse_xen_cmdline`
at cmdline.c:118, called from init.c:585.
**Decision**: DROP.
**Dropped branches**: 2025-08-0076, 2025-08-0077, 2025-08-0079

## Series: 2025-08-0173 (2 patches, Andrew Hamilton)

**Topic**: INSTALL: document libtasn1 + BUGS: update bug tracker URL
All upstream. INSTALL has `libtasn1` reference. BUGS has savannah URL.
**Decision**: DROP.
**Dropped branches**: 2025-08-0173, 2025-08-0174

## Series: 2025-08-0182 (3 of 4, Andrew Hamilton)

**Topic**: docs: new libgcrypt modules, future section update, URL corrections
All upstream. grub.texi has blake2/aria module docs (7 hits), "2.x" text,
HTTPS URLs (3 hits for gnu.org/software/grub).
**Decision**: DROP.
**Dropped branches**: 2025-08-0184, 2025-08-0182, 2025-08-0185

## Series: 2025-08-0194 (7 of 21, Sudhakar Kuppusamy) — appended-sig v9

Superseded by v18 (2025-10-0142). All features on master or in v18 remaining.
**Decision**: DROP — superseded.
**Dropped branches**: 2025-08-0194, 2025-08-0196, 2025-08-0200, 2025-08-0198, 2025-08-0199, 2025-08-0203, 2025-08-0204

## Series: 2025-09-0005 (2 of 7, Gary Lin) — tss2 cap_pcr v3

Superseded by v4 (2025-10-0092). `grub_tcg2_cap_pcr` on master (efi/tcg2.c:206,
tpm2_cmd.c:572). `TPM_CC_PCR_Event` at tss2_types.h:346.
**Decision**: DROP — already upstream.
**Dropped branches**: 2025-09-0005, 2025-09-0006

## Series: 2025-09-0115 (2, Hector Cao) — WRONG MAILING LIST

QEMU patches (`hw/core/machine.c`, `target/i386/kvm/kvm.c`) sent to GRUB ML.
Not applicable to GRUB.
**Decision**: DROP — not a GRUB patch.
**Dropped branches**: 2025-09-0115, 2025-09-0116

## Series: 2025-10-0092 (3 of 7, Gary Lin) — tss2 PCR_Event v4

All upstream. `TPM2_PCR_Event` at tpm2_cmd.c:572, `grub_tcg2_cap_pcr` for
ieee1275 at tcg2.c:206, PCR capping in tpm2_key_protector module.c:1178,
`feature_tpm2_cap_pcrs` in normal/main.c:521.
**Decision**: DROP — already upstream.
**Dropped branches**: 2025-10-0092, 2025-10-0094, 2025-10-0097

## Series: 2025-10-0142 (11 of 20, Sudhakar Kuppusamy) — appended-sig v18

All upstream. `OBJ_TYPE_GPG_PUBKEY` (pgp.c:981), `appended-signature-size`
(mkimage.c:88), `pks.h` exists, `append_add_db_cert` commands (appendedsig.c:968),
ibm,secure-boot lockdown (init.c:1031), platform_keystore.c (315L).
**Decision**: DROP — all features already upstream.
**Dropped branches**: 2025-10-0142, 2025-10-0145, 2025-10-0148, 2025-10-0149, 2025-10-0150, 2025-10-0151, 2025-10-0152, 2025-10-0153, 2025-10-0156, 2025-10-0157, 2025-10-0158

## Series: 2025-10-0160 (3 of 20, Kuppusamy) — appended-sig v18 tests/docs

Same v18 series. Tests (`appended_signature_test.c`, 348L) and docs on master.
**Decision**: DROP — already upstream.
**Dropped branches**: 2025-10-0160, 2025-10-0162, 2025-10-0161

## Series: 2025-10-0235 (9 of 13, Gary Lin) — argon2/kdf v5

All upstream. `argon2.c` (52L), kdf patches (09-12), `argon2_test.c` (139L),
word copy optimization in `kern/misc.c` (line 83). `grub_crypto_argon` in 6 files.
**Decision**: DROP — already upstream.
**Dropped branches**: 2025-10-0238, 2025-10-0237, 2025-10-0242, 2025-10-0239, 2025-10-0235, 2025-10-0240, 2025-10-0245, 2025-10-0243, 2025-10-0247

## Series: 2025-10-0266 (3 of 12, Michael Chang) — btrfs envblk v5

All upstream. `GRUB_ENV_BTRFS_OFFSET` in fs.h:135 and btrfs.c:2358-2360.
`fs_envblk_open/write` in grub-editenv.c:133-134.
**Decision**: DROP — already upstream.
**Dropped branches**: 2025-10-0266, 2025-10-0271, 2025-10-0270

## Series: 2025-10-0294 (6 of 12, Michael Chang) — grub-editenv v6 — KEEP

| Branch | Commit content | Verdict |
|--------|---------------|---------|
| 2025-10-0294 | FAILED.patch + code: fs_envblk open helper | Already upstream |
| 2025-10-0296 | FAILED.patch + code: fs_envblk write helper | Already upstream |
| 2025-10-0297 | FAILED.patch + code: wire set_variables to optional | Already upstream |
| 2025-10-0299 | FAILED.patch + code: wire unset_variables to optional | Already upstream |
| 2025-10-0304 | FAILED.patch + code: docs: Btrfs env block and special env vars | **NOT upstream** |
| 2025-10-0305 | FAILED.patch + code: btrfs: update doc link for bootloader support | Already upstream |

Code helpers (fs_envblk_open/write, set/unset/list wiring) on master. URL update
(btrfs.readthedocs.io) on master. BUT btrfs environment block documentation in
grub.texi (patch 11/12) is NOT on master.
**Decision**: KEEP — docs not upstream.

## Series: 2025-10-0329 (7 of 10, Gary Lin) — x86_64 sha256 hw accel v3

All upstream. `hwfeatures-gcry.c` (52L), `cpuid.h`, `x86_64/efi/hwfeatures-gcry.c`
(256L), libgcrypt patches 13-15 present.
**Decision**: DROP — already upstream.
**Dropped branches**: 2025-10-0329, 2025-10-0331, 2025-10-0332, 2025-10-0333, 2025-10-0335, 2025-10-0336, 2025-10-0337

## Series: 2025-11-0014 (dissolved — superseded by v2 standalone)

| Branch | Commit content | Verdict |
|--------|---------------|---------|
| 2025-11-0014 | FAILED.patch + code: add `GRUB_FORCE_EFI_ALLVIDEO` to grub-mkconfig | Superseded |
| 2025-11-0015 | FAILED.patch + code: docs for new `GRUB_FORCE_EFI_ALLVIDEO` variable | Superseded |

Superseded by v2 standalone `2025-11-0027` which is more complete (touches
`grub-mkconfig.in` + `00_header.in` + docs in a single patch).
**Decision**: DROP — superseded by v2.
**Dropped branches**: 2025-11-0014, 2025-11-0015

## Series: 2025-11-0097 (2 of 4, Glenn Washburn) — erofs test v3

All upstream. Root check removed from erofs_test.in. dump.erofs FSTIME fix at
grub-fs-tester.in:1512.
**Decision**: DROP.
**Dropped branches**: 2025-11-0099, 2025-11-0097

## Series: 2025-11-0104 (2 of 3, Andrew Hamilton) — ZFS ZSTD test split v6

All upstream. `zfs_zstd_test.in` (30L) exists. ext2 `-r` flag detection at
grub-fs-tester.in:890.
**Decision**: DROP.
**Dropped branches**: 2025-11-0104, 2025-11-0105

## Series: 2025-11-0120 (2 patches, Glenn Washburn) — cryptomount test

All upstream. `testcase_fail` changed to `testcase` for argon2 at
grub_cmd_cryptomount.in:182. `$builddir` variable used.
**Decision**: DROP.
**Dropped branches**: 2025-11-0121, 2025-11-0120

## Series: 2025-11-0142 (3 of 5, Glenn Washburn) — docs spelling/test section

All upstream. Spelling fix "across" (grub-dev.texi:931). Privileged user note
(grub-dev.texi:485). Tests chapter (grub-dev.texi:466-467).
**Decision**: DROP.
**Dropped branches**: 2025-11-0142, 2025-11-0143, 2025-11-0144

## Series: 2025-11-0204 (2 of 4, Glenn Washburn) — bootstrap linguas v4

All upstream. INSTALL step renumbered (no linguas.sh step). bootstrap.conf
linguas logic at lines 112-127.
**Decision**: DROP.
**Dropped branches**: 2025-11-0204, 2025-11-0205

## Series: 2025-12-0028 (2, Glenn Washburn) — KEEP

| Branch | Commit content | Verdict |
|--------|---------------|---------|
| 2025-12-0028 | CLEAN_APPLY: INSTALL: Add Autoconf Archive note | **NOT upstream** |
| 2025-12-0029 | FAILED.patch + code: grub-fs-tester: Use CSMACINTOSH encoding | Already upstream |

CSMACINTOSH encoding fix (patch 2) is upstream (grub-fs-tester.in:746-748).
Autoconf Archive note in INSTALL (patch 1) is NOT upstream.
**Decision**: KEEP — autoconf-archive note not upstream.

## Series: 2026-02-0066 (3 of 6, Avnish Chouhan) — NVMeoFC v7

All upstream. `fcp-targets` method (ofdisk.c:279), `nvme-discovery-controllers`
(ofdisk.c:433), `add_multiple_nvme_bootdevices` (platform.c:191).
**Decision**: DROP.
**Dropped branches**: 2026-02-0066, 2026-02-0067, 2026-02-0068

## Series: 2026-03-0010 (5 of 9, Nicholas Vinson / Daniel Kiper) — KEEP

| Branch | Commit content | Verdict |
|--------|---------------|---------|
| 2026-03-0010 | FAILED.patch + code: Revert `--image-base` check | Not upstream |
| 2026-03-0012 | FAILED.patch + code: Drop `-Ttext` checks for i386-pc | Not upstream |
| 2026-03-0014 | FAILED.patch only: Rename `i386-cygwin-img-ld.sc` to `.lds` | Not upstream |
| 2026-03-0015 | FAILED.patch only: Update `.lds` to use `--defsym` | Not upstream |
| 2026-03-0017 | FAILED.patch only: Re: cover letter for v4 series | Not upstream |

ld.lld compatibility: `--image-base` revert and `-Ttext` removal NOT on master.
configure.ac still has `--image-base` check (line 1502) and `-Ttext` fallback
(line 1504). `i386-cygwin-img.lds` exists but old `.sc` file removed.
**Decision**: KEEP — linker compatibility changes not upstream.


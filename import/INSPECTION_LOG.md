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

## Series: 2025-01-0098 (2 patches, Egor Ignatov) — KEEP

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

## Series: 2025-04-0016 (3 of 7, Vladimir Serbinenko) — libgcrypt v1 import

**Topic**: Import libgcrypt 1.10.3, adjust import script, disable keccak SSE

All FAILED.patch only. Superseded by v14 "Import libgcrypt 1.11" series (2025-07-0029,
11 patches remaining). v14 imports a newer version (1.11 vs 1.10.3).
**Decision**: DROP — superseded by v14.

## Series: 2025-04-0057 (9 of 13, Gary Lin) — tpm2_key_protector v5

**Topic**: dump PCRs, tpm2_dump_pcr command, NV index support, tests, docs

All have FAILED.patch + code changes. master has: `tpm2_dump_pcr` command in
`commands/tpm2_key_protector/module.c`, NV index in module + `grub-protect.c`
(line 66: `PROTECT_OPT_TPM2_NVINDEX`), NV tests in `tpm2_key_protector_test.in`
(line 240: `tpm2_seal_unseal_nv`), docs referencing tpm2_dump_pcr.
**Decision**: DROP — all features already upstream.

## Series: 2025-04-0266 + 2025-04-0270 (6 of 7, Brown/Philipson) — KEEP

**Topic**: AMD SKINIT Secure Launch: PSP discovery, x86 definitions, core SKINIT,
EFI support, TMR setup

RFC PATCH v2, all FAILED.patch only. No slaunch/PSP/SKINIT code on master.
**Decision**: KEEP — new feature, not upstream.

## Series: 2025-05-0032 (2 patches, Glenn Washburn) — KEEP

**Topic**: Disable gfxterm_menu/cmdline_cat tests + ZFS memory leak fix

Mixed: ZFS `free_sahdrp` fix (2025-05-0033) IS on master (lines 3052-3068).
Test disable (2025-05-0032) is NOT on master — tests still enabled, patch was
not accepted (workaround for unifont issue). Independent patches grouped by
proximity; keeping as a unit for review.
**Decision**: KEEP — test disable not upstream.

## Series: 2025-01-0098 (2 patches, Egor Ignatov) — KEEP (noted earlier)

## Series: 2025-05-0076 (2 patches, khaalid) — KEEP

**Topic**: Enhance error messages in chainloader/linux with hex status codes
Not upstream — master still has plain `"cannot load image"` without status code in
chainloader.c. linux.c has different wording (`"start_image() returned"` vs `"cannot start image"`).

## Series: 2025-05-0113 (3 patches, Hamilton/Serbinenko)

**Topic**: NTFS regressions, fshelp NULL deref, NTFS access violations
All upstream. NTFS error strings on master: `"pu offset size incorrect"` (268),
`"edat offset is out of bounds"` (469/481), `"run offset out of range"` (722),
`"bitmap attribute loop"` (1161). fshelp `read_symlink != NULL` check at line 229.
**Decision**: DROP.

## Series: 2025-05-0151 (2 patches, khaalid cali)

**Topic**: EFI memory leak fixes in lsefi.c, tpm.c, linux.c
All upstream. `grub_free(handles)` in lsefi.c:128, tpm.c:116/129.
`grub_free(mempath)` in linux.c:226/231.
**Decision**: DROP.

## Series: 2025-05-0166 (2 patches, Andrew Hamilton)

**Topic**: NTFS attribute validation + access violation fixes (v3)
Same NTFS fixes as 2025-05-0113, all on master.
**Decision**: DROP.

## Series: 2025-05-0201 (2 patches, Jiří Wolker) — KEEP

**Topic**: Export/unexport env variables with `-u`/`-g` flags
Not upstream — no `unexport` command, no `grub_env_set_export_mode`, no `-g` flag on master.

## Series: 2025-06-0040 (2 patches, Alec Brown)

**Topic**: gnulib regcomp/regexec resource leak fixes
All upstream. Patch files exist on master: `fix-regcomp-resource-leak.patch` (110L),
`fix-regexec-resource-leak.patch` (11L). bootstrap.conf references them at lines 87-88.
**Decision**: DROP.

## Series: 2025-06-0177 (4 of 6 patches, Frediano Ziglio)

**Topic**: loader/efi/linux LoadOptions: remove useless assignment, fix excessive size,
use sizeof, correct NUL termination
All upstream. master linux.c has `args_len` (201/242), separated `load_options_size` (253),
NUL terminator (252), `grub_utf8_to_utf16` with `args_len` (250).
**Decision**: DROP.

## Series: 2025-07-0029 (11 of 15 patches, Vladimir Serbinenko) — KEEP

**Topic**: Import libgcrypt 1.11, b64dec, blake2, import script, coverity fixes, memory leak
Master has libgcrypt 1.11.0 — the import itself is upstream. However, patch 14
(2025-07-0039, memory leak fix in `sexp.c`) is NOT upstream: `free(buffer)` before
`return NULL` at "Invalid hex digits" path is missing on master line ~2719.
**Decision**: KEEP — memory leak fix not upstream.

## Series: 2025-07-0047 (3 of 5, Frediano Ziglio) — KEEP

**Topic**: kern/list: `grub_list_append` + arm64/xen LoadFile2 + xen kernel cmdline
RFC patches. No `grub_list_append` on master. Xen LoadFile2 not in xen loader.

## Series: 2025-07-0066 (3 of 5, Mate Kukri)

**Topic**: efi/sb: shim loader protocol support
All upstream. `GRUB_EFI_SHIM_IMAGE_LOADER_GUID` at sb.c:34, `shim_loader`
variable at sb.c:36, `last_verified_image_handle` at sb.c:39.
**Decision**: DROP.

## Series: 2025-07-0287 (2 of 7, Gary Lin)

**Topic**: Argon2: extract from libgcrypt + LUKS2 Argon2 support
Superseded by v5 series (2025-10-0235). master has `argon2.c` and
`LUKS2_KDF_TYPE_ARGON2I/ID` in luks2.c.
**Decision**: DROP — superseded by v5.

## Series: 2025-08-0012 (2 patches, Vladimir Serbinenko) — KEEP

**Topic**: ZFS: rewrite endianness handling + datto encryption support
Not upstream — no `datto`, no `DSL_CRYPTO`, no `grub_cpu_to_zfs` on master.

## Series: 2025-08-0076 (3 of 3, Aaron Rainbolt)

**Topic**: Xen: rename MAX_GUEST_CMDLINE, add warning comment, add cmdline parsing (v5)
All upstream. `GRUB_XEN_MAX_GUEST_CMDLINE` at xen.h:831, `grub_parse_xen_cmdline`
at cmdline.c:118, called from init.c:585.
**Decision**: DROP.

## Series: 2025-08-0173 (2 patches, Andrew Hamilton)

**Topic**: INSTALL: document libtasn1 + BUGS: update bug tracker URL
All upstream. INSTALL has `libtasn1` reference. BUGS has savannah URL.
**Decision**: DROP.

## Series: 2025-08-0182 (3 of 4, Andrew Hamilton)

**Topic**: docs: new libgcrypt modules, future section update, URL corrections
All upstream. grub.texi has blake2/aria module docs (7 hits), "2.x" text,
HTTPS URLs (3 hits for gnu.org/software/grub).
**Decision**: DROP.

## Series: 2025-08-0194 (7 of 21, Sudhakar Kuppusamy) — appended-sig v9

Superseded by v18 (2025-10-0142). All features on master or in v18 remaining.
**Decision**: DROP — superseded.

## Series: 2025-09-0005 (2 of 7, Gary Lin) — tss2 cap_pcr v3

Superseded by v4 (2025-10-0092). `grub_tcg2_cap_pcr` on master (efi/tcg2.c:206,
tpm2_cmd.c:572). `TPM_CC_PCR_Event` at tss2_types.h:346.
**Decision**: DROP — already upstream.

## Series: 2025-09-0115 (2, Hector Cao) — WRONG MAILING LIST

QEMU patches (`hw/core/machine.c`, `target/i386/kvm/kvm.c`) sent to GRUB ML.
Not applicable to GRUB.
**Decision**: DROP — not a GRUB patch.

## Series: 2025-10-0092 (3 of 7, Gary Lin) — tss2 PCR_Event v4

All upstream. `TPM2_PCR_Event` at tpm2_cmd.c:572, `grub_tcg2_cap_pcr` for
ieee1275 at tcg2.c:206, PCR capping in tpm2_key_protector module.c:1178,
`feature_tpm2_cap_pcrs` in normal/main.c:521.
**Decision**: DROP — already upstream.

## Series: 2025-10-0142 (11 of 20, Sudhakar Kuppusamy) — appended-sig v18

All upstream. `OBJ_TYPE_GPG_PUBKEY` (pgp.c:981), `appended-signature-size`
(mkimage.c:88), `pks.h` exists, `append_add_db_cert` commands (appendedsig.c:968),
ibm,secure-boot lockdown (init.c:1031), platform_keystore.c (315L).
**Decision**: DROP — all features already upstream.

# Failed Patches Analysis Report (v3)
**Generated**: 2026-07-09
**Source**: `import/failed.txt` (1302 branches)

---

## Summary

| Category | Count | % |
|----------|------:|--:|
| Total branches | 1302 | 100% |
| DROP: Already in master | 320 | 24% |
| DROP: Date fix | 2 | 0% |
| DROP: Older version | 546 | 41% |
| DROP: Re: dup | 13 | 0% |
| DROP: Reply only | 36 | 2% |
| DROP: Resend | 38 | 2% |
| **Total dropped** | **955** | **73%** |
| **REMAINING** | **347** | **26%** |

### Verification method

All decisions verified against actual commit data (`git show BRANCH`):
author name, date, commit subject. Cross-version groups checked for
date consistency. Resends detected by matching commit subject + author.
Re: entries with uncovered topics recovered to remaining.

### Manual review flags

5 "resend" pairs have different authors (original vs Re: response):

| Dropped | Kept | Note |
|---------|------|------|
| 2025-05-0045 (Suhanov) | 2025-05-0058 (Serbinenko) | Re: may be correction |
| 2025-05-0050 (Suhanov) | 2025-05-0059 (Serbinenko) | Re: may be correction |
| 2025-09-0231 (P. Jones) | 2025-09-0237 (Serbinenko) | Re: may be correction |
| 2025-03-0188 (Axtens) | 2025-08-0206 (Kuppusamy) | Authorship changed at v9 |
| 2025-03-0196 (Axtens) | 2025-08-0205 (Kuppusamy) | Authorship changed at v9 |

### Date-conflict corrections

| Topic | Original decision | Correction |
|-------|-------------------|------------|
| lsefi: fixed memory leaks | Kept v6 (2025-03) | Keep 2025-09-0037 (Sept) |
| loader/efi/linux: fix memory leak | Kept v2 (May 16) | Keep 2025-05-0153 (May 20) |

---

## All Branches — Decision Log

### 2025-01 (50 branches: 12 remain, 38 drop)

| Branch | Subject | Decision | Reason | Superseded by |
|--------|---------|----------|--------|---------------|
| 2025-01-0013 | [PATCH v2] acpi: Use options enum to index command options | DROP | Older version | 2025-03-0008 |
| 2025-01-0018 | [PATCH] docs: Replace @lbracechar{} and @rbracechar{} wit... | KEEP | | |
| 2025-01-0019 | [PATCH] docs: Do not reference non-existent "--dumb" option | KEEP | | |
| 2025-01-0021 | [PATCH v3 1/6] commands/ls: Return proper GRUB_ERR_* for ... | DROP | Older version | 2025-03-0012 |
| 2025-01-0022 | [PATCH v3 2/6] commands/ls: Merge print_files_long and pr... | DROP | Older version | 2025-03-0014 |
| 2025-01-0023 | [PATCH v3 3/6] commands/ls: Show modification time for fi... | DROP | Older version | 2025-03-0015 |
| 2025-01-0024 | [PATCH v3 4/6] commands/ls: Output path for single file a... | DROP | Already in master | 2025-03-0016 |
| 2025-01-0025 | [PATCH v3 5/6] commands/ls: Print full paths for file args | DROP | Older version | 2025-03-0017 |
| 2025-01-0026 | [PATCH v3 6/6] commands/ls: Add directory header for dir ... | DROP | Older version | 2025-03-0012 |
| 2025-01-0033 | [PATCH 6/6 v13] lvm: Add support for cachevol lv | KEEP | | |
| 2025-01-0034 | [PATCH 5/6 v13] lvm: add informational messages in error ... | KEEP | | |
| 2025-01-0035 | [PATCH 4/6 v13] lvm: Add support for integrity lv | KEEP | | |
| 2025-01-0036 | [PATCH 3/6 v13] lvm: Match all lvm segments before valida... | KEEP | | |
| 2025-01-0037 | [PATCH 2/6 v13] disk/lvm: Remove unused cache_pool | KEEP | | |
| 2025-01-0038 | [PATCH 1/6 v13] disk/lvm: Make cache_lv more generic as | KEEP | | |
| 2025-01-0041 | [PATCH] commands/file: Fix null dereference in the knetbs... | DROP | Already in master |  |
| 2025-01-0045 | [PATCH v4 1/6] commands/ls: Return proper GRUB_ERR_* for ... | DROP | Older version | 2025-03-0012 |
| 2025-01-0046 | [PATCH v4 3/6] commands/ls: Show modification time for fi... | DROP | Older version | 2025-03-0015 |
| 2025-01-0047 | [PATCH v4 2/6] commands/ls: Merge print_files_long and pr... | DROP | Older version | 2025-03-0014 |
| 2025-01-0048 | [PATCH v4 4/6] commands/ls: Output path for single file a... | DROP | Already in master | 2025-03-0016 |
| 2025-01-0049 | [PATCH v4 5/6] commands/ls: Print full paths for file args | DROP | Older version | 2025-03-0017 |
| 2025-01-0050 | [PATCH v4 6/6] commands/ls: Add directory header for dir ... | DROP | Older version | 2025-03-0012 |
| 2025-01-0053 | [PATCH v2 01/10] tpm2_key_protector: dump PCRs on policy ... | DROP | Older version | 2025-04-0059 |
| 2025-01-0055 | [PATCH v2 02/10] tpm2_key_protector: Add 'tpm2_dump_pcr' ... | DROP | Older version | 2025-04-0057 |
| 2025-01-0056 | [PATCH v2 03/10] docs: Document tpm2_dump_pcr | DROP | Older version | 2025-04-0059 |
| 2025-01-0057 | [PATCH v2 04/10] tss2: Fix the missing authCommand | DROP | Already in master | 2025-03-0138 |
| 2025-01-0058 | [PATCH v2 05/10] tss2: Add TPM 2.0 NV index commands | DROP | Older version | 2025-04-0061 |
| 2025-01-0059 | [PATCH v2 06/10] tpm2_key_protector: Unseal key from a bu... | DROP | Older version | 2025-04-0059 |
| 2025-01-0060 | [PATCH v2 07/10] tpm2_key_protector: Support NV index han... | DROP | Older version | 2025-04-0063 |
| 2025-01-0061 | [PATCH v2 08/10] util/grub-protect: Support NV index mode | DROP | Older version | 2025-04-0064 |
| 2025-01-0062 | [PATCH v2 09/10] tests/tpm2_key_protector_test: Amend the... | DROP | Older version | 2025-04-0059 |
| 2025-01-0063 | [PATCH v2 10/10] docs: Update NV index mode of TPM2 key p... | DROP | Older version | 2025-04-0059 |
| 2025-01-0074 | [PATCH] gitignore: Ignore generated files from libtasn | DROP | Already in master |  |
| 2025-01-0076 | [PATCH v3 01/10] tpm2_key_protector: dump PCRs on policy ... | DROP | Older version | 2025-04-0059 |
| 2025-01-0077 | [PATCH v3 02/10] tpm2_key_protector: Add 'tpm2_dump_pcr' ... | DROP | Older version | 2025-04-0057 |
| 2025-01-0078 | [PATCH v3 03/10] docs: Document tpm2_dump_pcr | DROP | Older version | 2025-04-0059 |
| 2025-01-0079 | [PATCH v3 04/10] tss2: Fix the missing authCommand | DROP | Already in master | 2025-03-0138 |
| 2025-01-0080 | [PATCH v3 05/10] tss2: Add TPM 2.0 NV index commands | DROP | Older version | 2025-04-0061 |
| 2025-01-0081 | [PATCH v3 06/10] tpm2_key_protector: Unseal key from a bu... | DROP | Already in master | 2025-03-0138 |
| 2025-01-0082 | [PATCH v3 07/10] tpm2_key_protector: Support NV index han... | DROP | Older version | 2025-04-0063 |
| 2025-01-0083 | [PATCH v3 08/10] util/grub-protect: Support NV index mode | DROP | Older version | 2025-04-0064 |
| 2025-01-0084 | [PATCH v3 09/10] tests/tpm2_key_protector_test: Amend the... | DROP | Older version | 2025-04-0059 |
| 2025-01-0085 | [PATCH v3 10/10] docs: Update NV index mode of TPM2 key p... | DROP | Older version | 2025-04-0059 |
| 2025-01-0088 | [PATCH] powerpc: increase MIN RMA size for CAS negotiation | DROP | Older version | 2025-03-0093 |
| 2025-01-0089 | [PATCH 1/1] gdb: typo hueristic | DROP | Already in master |  |
| 2025-01-0094 | [PATCH] term/nns8250-spcr: return if redirection is disabled | KEEP | | |
| 2025-01-0095 | [PATCH] disk/ahci.c: remove conditional operator for endtime | DROP | Already in master |  |
| 2025-01-0096 | Re: [PATCH] term/ns8250: return in case of a null SPCR ba... | KEEP | | |
| 2025-01-0098 | [PATCH 2/3] fs/xfs: Fix grub_xfs_iterate_dir return value... | KEEP | | |
| 2025-01-0099 | [PATCH 3/3] fs/xfs: Propagate incorrect inode error from | KEEP | | |

### 2025-02 (13 branches: 6 remain, 7 drop)

| Branch | Subject | Decision | Reason | Superseded by |
|--------|---------|----------|--------|---------------|
| 2025-02-0002 | [PATCH] fs/xfs: add new superblock features added in Linu... | KEEP | | |
| 2025-02-0020 | [PATCH 2/3] blsuki: Check for mounted /boot in emu | DROP | Older version | 2025-08-0052 |
| 2025-02-0021 | [PATCH 3/3] blsuki: Add uki command to load Unified Kerne... | DROP | Older version | 2025-08-0051 |
| 2025-02-0022 | [PATCH 1/3] blsuki: Add blscfg command to parse Boot Loader | DROP | Older version | 2025-08-0054 |
| 2025-02-0102 | Re: [SECURITY PATCH 49/73] fs: Disable many filesystems u... | DROP | Re: dup | 2025-02-0105 |
| 2025-02-0105 | Re: [SECURITY PATCH 49/73] fs: Disable many filesystems u... | KEEP | | |
| 2025-02-0116 | [PATCH] fs/ext2: Rework out-of-bounds read for inline and... | KEEP | | |
| 2025-02-0126 | [PATCH v2 RESEND] util/grub.d/30_os-prober.in: Fix | KEEP | | |
| 2025-02-0139 | [PATCH v2 RESEND] util/grub.d/30_os-prober.in: Conditiona... | KEEP | | |
| 2025-02-0180 | [PATCH] fs/ntfs: Check at->attr_cur after calling next_at... | DROP | Older version | 2025-03-0130 |
| 2025-02-0195 | [PATCH 1/2] docs: Document Restricted Filesystems in Lock... | KEEP | | |
| 2025-02-0196 | [PATCH 2/2] docs: Capture Additional Commands Restricted ... | DROP | Already in master |  |
| 2025-02-0197 | Re: [PATCH] fs/ntfs: Check at->attr_cur after calling nex... | DROP | Reply only |  |

### 2025-03 (90 branches: 39 remain, 51 drop)

| Branch | Subject | Decision | Reason | Superseded by |
|--------|---------|----------|--------|---------------|
| 2025-03-0002 | [PATCH v5 1/6] commands/ls: Return proper GRUB_ERR_* for ... | DROP | Older version | 2025-03-0012 |
| 2025-03-0003 | [PATCH v5 3/6] commands/ls: Show modification time for fi... | DROP | Older version | 2025-03-0015 |
| 2025-03-0004 | [PATCH v5 4/6] commands/ls: Output path for single file a... | DROP | Already in master | 2025-03-0016 |
| 2025-03-0005 | [PATCH v5 2/6] commands/ls: Merge print_files_long and pr... | DROP | Older version | 2025-03-0014 |
| 2025-03-0006 | [PATCH v5 5/6] commands/ls: Print full paths for file args | DROP | Older version | 2025-03-0017 |
| 2025-03-0007 | [PATCH v5 6/6] commands/ls: Add directory header for dir ... | DROP | Already in master | 2025-03-0016 |
| 2025-03-0008 | [PATCH v3] acpi: Use options enum to index command options | DROP | Already in master |  |
| 2025-03-0012 | [PATCH v6 1/6] commands/ls: Return proper GRUB_ERR_* for ... | KEEP | | |
| 2025-03-0014 | [PATCH v6 2/6] commands/ls: Merge print_files_long and pr... | KEEP | | |
| 2025-03-0015 | [PATCH v6 3/6] commands/ls: Show modification time for fi... | KEEP | | |
| 2025-03-0016 | [PATCH v6 4/6] commands/ls: Output path for single file a... | DROP | Already in master |  |
| 2025-03-0017 | [PATCH v6 5/6] commands/ls: Print full paths for file args | KEEP | | |
| 2025-03-0018 | [PATCH v6 6/6] commands/ls: Add directory header for dir ... | DROP | Already in master |  |
| 2025-03-0023 | [PATCH 1/1] lib: Fix clang Build - Remove Duplicate Typed... | DROP | Already in master |  |
| 2025-03-0026 | [PATCH] kern: Unbreak support for nested partitions | DROP | Already in master |  |
| 2025-03-0027 | [PATCH] bsd: Fix type passed for the kernel | DROP | Older version | 2025-03-0055 |
| 2025-03-0029 | [PATCH v2 1/6] tests/util/grub-shell-luks-tester: Add mis... | DROP | Already in master |  |
| 2025-03-0031 | [PATCH v2 2/6] tests: Cleanup generated files on expected... | DROP | Already in master |  |
| 2025-03-0032 | [PATCH v2 6/6] tests/util/grub-shell: Remove the work dir... | DROP | Already in master |  |
| 2025-03-0033 | [PATCH v2 4/6] tests/grub_cmd_cryptomount: Default TMPDIR... | DROP | Already in master |  |
| 2025-03-0034 | [PATCH v2 3/6] tests/grub_cmd_cryptomount: Cleanup the cr... | KEEP | | |
| 2025-03-0035 | [PATCH v2 5/6] tests/grub_cmd_cryptomount: Remove temporary | DROP | Already in master |  |
| 2025-03-0039 | [PATCH v2] powerpc: increase MIN RMA size for CAS negotia... | DROP | Older version | 2025-03-0093 |
| 2025-03-0055 | [PATCH v2] bsd: Fix type passed for the kernel | KEEP | | |
| 2025-03-0057 | [PATCH] tests/util/grub-shell-luks-tester: Find cryptodis... | DROP | Already in master |  |
| 2025-03-0058 | [PATCH] tests/util/grub-shell: Default qemuopts to envvar | KEEP | | |
| 2025-03-0059 | [PATCH] tss2: restore buffer offset on tpm2_submit_comman... | KEEP | | |
| 2025-03-0061 | [PATCH] key_protector: Add systemd TPM2 Key Protector | KEEP | | |
| 2025-03-0065 | [PATCH v2 2/2] efi: Use shim's loader protocol for EFI image | KEEP | | |
| 2025-03-0066 | [PATCH v2 1/2] efi: Provide wrappers for load_image, star... | DROP | Older version | 2025-07-0065 |
| 2025-03-0073 | [PATCH] fs/zfs: Fix a number of memory leaks in ZFS code | KEEP | | |
| 2025-03-0074 | Re: [PATCH] fs/zfs: Fix a number of memory leaks in ZFS code | DROP | Reply only |  |
| 2025-03-0080 | [PATCH v3] powerpc: increase MIN RMA size for CAS negotia... | DROP | Older version | 2025-03-0093 |
| 2025-03-0093 | [PATCH v4] powerpc: increase MIN RMA size for CAS negotia... | KEEP | | |
| 2025-03-0122 | [PATCH v6 1/2] lsefi: fixed memory leaks | DROP | Date fix | 2025-09-0037 |
| 2025-03-0124 | [PATCH] ieee1275/ofnet: Fix grub_malloc() removed after a... | KEEP | | |
| 2025-03-0130 | [PATCH v2] fs/ntfs: Check at->attr_cur after calling next... | KEEP | | |
| 2025-03-0131 | Re: [PATCH v2] fs/ntfs: Check at->attr_cur after calling | DROP | Reply only |  |
| 2025-03-0132 | [PATCH] include/grub/i386/linux: Update linux_kernel_para... | DROP | Resend | 2025-04-0031 |
| 2025-03-0133 | Re: [PATCH v2] fs/ntfs: Check at->attr_cur after calling | DROP | Reply only |  |
| 2025-03-0134 | [PATCH v3] fs/ntfs: Correct NULL Deref / Possible Infinit... | KEEP | | |
| 2025-03-0136 | [PATCH v4 01/12] tpm2_key_protector: dump PCRs on policy ... | DROP | Older version | 2025-04-0059 |
| 2025-03-0137 | [PATCH v4 02/12] tpm2_key_protector: Add 'tpm2_dump_pcr' ... | DROP | Older version | 2025-04-0057 |
| 2025-03-0138 | [PATCH v4 03/12] tss2: Fix the missing authCommand | DROP | Already in master |  |
| 2025-03-0139 | [PATCH v4 04/12] tss2: Add TPM 2.0 NV index commands | DROP | Older version | 2025-04-0061 |
| 2025-03-0140 | [PATCH v4 05/12] tpm2_key_protector: Unseal key from a bu... | DROP | Already in master |  |
| 2025-03-0141 | [PATCH v4 06/12] tpm2_key_protector: Support NV index han... | DROP | Older version | 2025-04-0063 |
| 2025-03-0142 | [PATCH v4 07/12] util/grub-protect: Support NV index mode | DROP | Older version | 2025-04-0064 |
| 2025-03-0143 | [PATCH v4 08/12] tests/tpm2_key_protector_test: Simplify ... | DROP | Older version | 2025-04-0065 |
| 2025-03-0144 | [PATCH v4 09/12] tests/tpm2_key_protector_test: Reset 're... | DROP | Older version | 2025-04-0066 |
| 2025-03-0145 | [PATCH v4 10/12] tests/tpm2_key_protector_test: Add more ... | DROP | Older version | 2025-04-0070 |
| 2025-03-0146 | [PATCH v4 11/12] docs: Update NV index mode of TPM2 key p... | DROP | Already in master |  |
| 2025-03-0147 | [PATCH v4 12/12] INSTALL: Document the packages needed fo... | DROP | Already in master |  |
| 2025-03-0151 | Re: [PATCH v3] fs/ntfs: Correct NULL Deref / Possible Inf... | DROP | Reply only |  |
| 2025-03-0164 | Re: [PATCH v4 09/12] tests/tpm2_key_protector_test: Reset... | DROP | Reply only |  |
| 2025-03-0167 | [PATCH v2 2/3] blsuki: Check for mounted /boot in emu | DROP | Older version | 2025-08-0052 |
| 2025-03-0169 | [PATCH v2 3/3] blsuki: Add uki command to load Unified Ke... | DROP | Older version | 2025-08-0051 |
| 2025-03-0170 | [PATCH v2 1/3] blsuki: Add blscfg command to parse Boot L... | DROP | Older version | 2025-08-0054 |
| 2025-03-0172 | Re: [PATCH v2 2/3] blsuki: Check for mounted /boot in emu | DROP | Older version | 2025-08-0052 |
| 2025-03-0185 | [PATCH v2 02/21] docs/grub: Document signing grub under UEFI | DROP | Resend | 2025-08-0207 |
| 2025-03-0186 | [PATCH v2 05/21] pgp: factor out rsa_pad | KEEP | | |
| 2025-03-0187 | [PATCH v2 01/21] powerpc-ieee1275: Add support for signin... | KEEP | | |
| 2025-03-0188 | [PATCH v2 03/21] docs/grub: Document signing grub with an... | DROP | Resend | 2025-08-0206 |
| 2025-03-0189 | [PATCH v2 04/21] dl: provide a fake grub_dl_set_persisten... | KEEP | | |
| 2025-03-0190 | [PATCH v2 06/21] crypto: move storage for grub_crypto_pk_... | KEEP | | |
| 2025-03-0191 | [PATCH v2 07/21] grub-install: support embedding x509 cer... | KEEP | | |
| 2025-03-0192 | [PATCH v2 08/21] appended signatures: import GNUTLS's ASN.1 | KEEP | | |
| 2025-03-0193 | [PATCH v2 10/21] appended signatures: support verifying a... | KEEP | | |
| 2025-03-0194 | [PATCH v2 09/21] appended signatures: parse PKCS#7 signed... | KEEP | | |
| 2025-03-0195 | [PATCH v2 12/21] appended signatures: documentation | KEEP | | |
| 2025-03-0196 | [PATCH v2 11/21] appended signatures: verification tests | DROP | Resend | 2025-08-0205 |
| 2025-03-0197 | [PATCH v2 13/21] ieee1275: enter lockdown based on /ibm,s... | KEEP | | |
| 2025-03-0198 | [PATCH v2 14/21] ieee1275: Platform Keystore (PKS) Support | KEEP | | |
| 2025-03-0199 | [PATCH v2 15/21] ieee1275: Read the DB and DBX secure boo... | KEEP | | |
| 2025-03-0200 | [PATCH v2 16/21] appendedsig: The creation of trusted and... | KEEP | | |
| 2025-03-0201 | [PATCH v2 17/21] appendedsig: While verifying the kernel, | KEEP | | |
| 2025-03-0202 | [PATCH v2 19/21] appendedsig: Reads the default DB keys f... | KEEP | | |
| 2025-03-0203 | [PATCH v2 18/21] powerpc_ieee1275: set use_static_keys flag | KEEP | | |
| 2025-03-0204 | [PATCH v2 20/21] appendedsig: The grub command's trusted and | KEEP | | |
| 2025-03-0205 | [PATCH v2 21/21] appendedsig: documentation | KEEP | | |
| 2025-03-0207 | [PATCH] configure: Add -mno-relax on riscv* | KEEP | | |
| 2025-03-0208 | [PATCH 2/5] lib/reloacator: Fix memory leaks | DROP | Already in master |  |
| 2025-03-0209 | [PATCH 1/5] disk/ldm: Fix memory leaks | DROP | Already in master |  |
| 2025-03-0210 | [PATCH 3/5] loader/i386/linux: Fix resource leak | KEEP | | |
| 2025-03-0213 | [PATCH 4/5] fs/btrfs: Fix memory leaks | DROP | Already in master |  |
| 2025-03-0214 | Re: [PATCH 4/5] fs/btrfs: Fix memory leaks | KEEP | | |
| 2025-03-0215 | Re: [PATCH 2/5] lib/reloacator: Fix memory leaks | KEEP | | |
| 2025-03-0216 | Re: [PATCH 5/5] loader/xnu: Fix memory leak | KEEP | | |
| 2025-03-0224 | [PATCH 1/2] build: remove extra_deps.lst from EXTRA_DIST | DROP | Already in master |  |
| 2025-03-0226 | [PATCH 2/2] Remove qemu_mips port | KEEP | | |

### 2025-04 (139 branches: 44 remain, 95 drop)

| Branch | Subject | Decision | Reason | Superseded by |
|--------|---------|----------|--------|---------------|
| 2025-04-0003 | [PATCH v3 2/5] efi/sb: Add support for the shim loader pr... | DROP | Older version | 2025-07-0068 |
| 2025-04-0004 | [PATCH v3 3/5] efi/sb: Add API for retrieving shim loader... | DROP | Older version | 2025-07-0066 |
| 2025-04-0005 | [PATCH v3 4/5] loader/efi/chainloader: Use shim loader im... | DROP | Already in master | 2025-06-0136 |
| 2025-04-0006 | [PATCH v3 1/5] efi: Provide wrappers for load_image, star... | DROP | Older version | 2025-07-0065 |
| 2025-04-0007 | [PATCH v3 5/5] loader/efi/linux: Use shim loader image ha... | DROP | Older version | 2025-07-0069 |
| 2025-04-0009 | Re: [PATCH GRUB] fs/xfs: fix large extent counters incomp... | KEEP | | |
| 2025-04-0011 | [PATCH 7/7] Remove now unneeded gcrypt compilation flag | KEEP | | |
| 2025-04-0013 | [PATCH 4/7] Add DSA and RSA SEXP tests | KEEP | | |
| 2025-04-0014 | [PATCH 3/7] Adjust import script, | KEEP | | |
| 2025-04-0015 | [PATCH 5/7] keccak: Disable acceleration with SSE asm | KEEP | | |
| 2025-04-0016 | [PATCH 1/7] Import libgcrypt 1.10.3 | KEEP | | |
| 2025-04-0017 | [PATCH 2/7] Import b64dec from gpg-error | DROP | Older version | 2025-07-0029 |
| 2025-04-0029 | Subject: [PATCH] loader/efi: Enhance error messages in ch... | KEEP | | |
| 2025-04-0031 | [PATCH v2 1/1] include/grub/i386/linux: Update linux_kern... | KEEP | | |
| 2025-04-0032 | [RESEND PATCH 1/1] loader/efi/chainloader: Enhance error ... | KEEP | | |
| 2025-04-0039 | [PATCH v8 2/9] Import b64dec from gpg-error | DROP | Older version | 2025-07-0029 |
| 2025-04-0040 | [PATCH v8 3/9] b64dec: Adjust for compilation in GRUB env... | DROP | Older version | 2025-07-0029 |
| 2025-04-0041 | [PATCH v8 5/9] Add DSA and RSA SEXP tests | DROP | Older version | 2025-07-0032 |
| 2025-04-0042 | [PATCH v8 1/9] Import libgcrypt 1.11 | DROP | Older version | 2025-07-0033 |
| 2025-04-0043 | [PATCH v8 4/9] Adjust import script, | DROP | Older version | 2025-07-0031 |
| 2025-04-0044 | [PATCH v8 6/9] keccak: Disable acceleration with SSE asm | DROP | Older version | 2025-07-0029 |
| 2025-04-0045 | [PATCH v8 7/9] libgcrypt: Fix coverity warnings | DROP | Older version | 2025-07-0034 |
| 2025-04-0046 | [PATCH v8 8/9] Remove now unneeded gcrypt compilation flag | DROP | Older version | 2025-07-0035 |
| 2025-04-0048 | [PATCH] kern/x86_64/efi/startup: Suggestion in the startu... | KEEP | | |
| 2025-04-0049 | Re: [PATCH] kern/x86_64/efi/startup: Suggestion in the st... | DROP | Reply only |  |
| 2025-04-0050 | Re: [RESEND PATCH 1/1] loader/efi/chainloader: Enhance er... | DROP | Reply only |  |
| 2025-04-0052 | [DRAFT PATCH 1/1] Add Xen command line parsing | DROP | Older version | 2025-04-0249 |
| 2025-04-0054 | Re: [RESEND PATCH 1/1] loader/efi/chainloader: Enhance er... | KEEP | | |
| 2025-04-0055 | [PATCH] datetime: Specify license in emu module | DROP | Already in master |  |
| 2025-04-0057 | [PATCH v5 02/13] tpm2_key_protector: Add 'tpm2_dump_pcr' ... | KEEP | | |
| 2025-04-0059 | [PATCH v5 01/13] tpm2_key_protector: dump PCRs on policy ... | KEEP | | |
| 2025-04-0060 | [PATCH v5 03/13] tss2: Fix the missing authCommand | DROP | Already in master |  |
| 2025-04-0061 | [PATCH v5 04/13] tss2: Add TPM 2.0 NV index commands | KEEP | | |
| 2025-04-0062 | [PATCH v5 05/13] tpm2_key_protector: Unseal key from a bu... | DROP | Already in master |  |
| 2025-04-0063 | [PATCH v5 06/13] tpm2_key_protector: Support NV index han... | KEEP | | |
| 2025-04-0064 | [PATCH v5 07/13] util/grub-protect: Support NV index mode | KEEP | | |
| 2025-04-0065 | [PATCH v5 08/13] tests/tpm2_key_protector_test: Simplify ... | KEEP | | |
| 2025-04-0066 | [PATCH v5 09/13] tests/tpm2_key_protector_test: Reset 're... | KEEP | | |
| 2025-04-0067 | [PATCH v5 11/13] docs: Update NV index mode of TPM2 key p... | DROP | Already in master |  |
| 2025-04-0068 | [PATCH v5 12/13] INSTALL: Document the packages needed fo... | DROP | Already in master |  |
| 2025-04-0069 | [PATCH v5 13/13] docs: Document the long options of | KEEP | | |
| 2025-04-0070 | [PATCH v5 10/13] tests/tpm2_key_protector_test: Add more ... | KEEP | | |
| 2025-04-0074 | [PATCH] ia64: Reset grub_errno on failure to allocate | DROP | Already in master |  |
| 2025-04-0075 | Re: [PATCH] arm64: Limit memory allocations to 4GB boundary | KEEP | | |
| 2025-04-0079 | [PATCH v9 02/11] Import b64dec from gpg-error | DROP | Older version | 2025-07-0029 |
| 2025-04-0080 | [PATCH v9 04/11] Adjust import script, | DROP | Older version | 2025-07-0031 |
| 2025-04-0081 | [PATCH v9 03/11] b64dec: Adjust for compilation in GRUB e... | DROP | Older version | 2025-07-0029 |
| 2025-04-0082 | [PATCH v9 08/11] Remove now unneeded gcrypt compilation flag | DROP | Older version | 2025-07-0035 |
| 2025-04-0083 | [PATCH v9 05/11] Add DSA and RSA SEXP tests | DROP | Older version | 2025-07-0032 |
| 2025-04-0084 | [PATCH v9 01/11] Import libgcrypt 1.11 | DROP | Older version | 2025-07-0033 |
| 2025-04-0085 | [PATCH v9 07/11] libgcrypt: Fix coverity warnings | DROP | Older version | 2025-07-0034 |
| 2025-04-0086 | [PATCH v9 11/11] libgcrypt: Import blake family of hashes | DROP | Older version | 2025-07-0040 |
| 2025-04-0087 | [PATCH v9 06/11] keccak: Disable acceleration with SSE asm | DROP | Older version | 2025-07-0029 |
| 2025-04-0089 | [PATCH v9 10/11] gcry: Ignore sign-compare warnings | DROP | Older version | 2025-07-0037 |
| 2025-04-0094 | [PATCH 3/3] Use ET_DYN images and PHDRs for creating relo... | KEEP | | |
| 2025-04-0096 | [PATCH v10 02/12] Import b64dec from gpg-error | DROP | Older version | 2025-07-0029 |
| 2025-04-0098 | [PATCH v10 04/12] Adjust import script, | DROP | Older version | 2025-07-0031 |
| 2025-04-0099 | [PATCH v10 12/12] libgcrypt: Import blake family of hashes | DROP | Older version | 2025-07-0040 |
| 2025-04-0100 | [PATCH v10 06/12] keccak: Disable acceleration with SSE asm | DROP | Already in master | 2025-07-0030 |
| 2025-04-0102 | [PATCH v10 08/12] Remove now unneeded gcrypt compilation ... | DROP | Older version | 2025-07-0035 |
| 2025-04-0103 | [PATCH v10 11/12] gcry: Ignore sign-compare warnings | DROP | Older version | 2025-07-0037 |
| 2025-04-0104 | [PATCH v10 07/12] libgcrypt: Fix coverity warnings | DROP | Older version | 2025-07-0034 |
| 2025-04-0105 | [PATCH v10 05/12] Add DSA and RSA SEXP tests | DROP | Older version | 2025-07-0032 |
| 2025-04-0106 | [PATCH v10 01/12] Import libgcrypt 1.11 | DROP | Older version | 2025-07-0033 |
| 2025-04-0107 | [PATCH v10 03/12] b64dec: Adjust for compilation in GRUB ... | DROP | Older version | 2025-07-0029 |
| 2025-04-0108 | [PATCH] Disable gfxterm_menu and cmdline_cat tests | KEEP | | |
| 2025-04-0115 | [PATCH] util/grub-install: Include raid5rec module for RA... | DROP | Already in master |  |
| 2025-04-0116 | [PATCH] ia64: Disable optimizations using floating-point ... | KEEP | | |
| 2025-04-0125 | [PATCH v11 03/14] b64dec: Adjust for compilation in GRUB ... | KEEP | | |
| 2025-04-0126 | [PATCH v11 02/14] Import b64dec from gpg-error | DROP | Older version | 2025-07-0029 |
| 2025-04-0127 | [PATCH v11 05/14] Add DSA and RSA SEXP tests | DROP | Older version | 2025-07-0032 |
| 2025-04-0128 | [PATCH v11 07/14] libgcrypt: Fix coverity warnings | DROP | Older version | 2025-07-0034 |
| 2025-04-0130 | [PATCH v11 13/14] import_gcry: Make compatible with pytho... | DROP | Resend | 2025-07-0038 |
| 2025-04-0131 | [PATCH v11 06/14] keccak: Disable acceleration with SSE asm | DROP | Already in master |  |
| 2025-04-0132 | [PATCH v11 04/14] Adjust import script, | DROP | Older version | 2025-07-0031 |
| 2025-04-0134 | [PATCH v11 01/14] Import libgcrypt 1.11 | DROP | Older version | 2025-07-0033 |
| 2025-04-0135 | [PATCH v11 08/14] Remove now unneeded gcrypt compilation ... | DROP | Older version | 2025-07-0035 |
| 2025-04-0136 | [PATCH v11 11/14] gcry: Ignore sign-compare warnings | DROP | Resend | 2025-07-0037 |
| 2025-04-0137 | [PATCH v11 12/14] libgcrypt: Import blake family of hashes | DROP | Resend | 2025-07-0040 |
| 2025-04-0138 | [PATCH v11 14/14] import_gcry: Fix pylint warnings | DROP | Resend | 2025-07-0042 |
| 2025-04-0140 | Re: [PATCH] kern/efi/mm: try allocating in the lower 4GB ... | DROP | Re: dup | 2025-04-0215 |
| 2025-04-0142 | [PATCH 2/2] Prepend debug traces with absolute and relati... | KEEP | | |
| 2025-04-0143 | [PATCH 1/2] Include function name on debug traces | KEEP | | |
| 2025-04-0146 | [PATCH v3 1/3] blsuki: Add blscfg command to parse Boot L... | KEEP | | |
| 2025-04-0147 | [PATCH v3 2/3] blsuki: Check for mounted /boot in emu | KEEP | | |
| 2025-04-0148 | [PATCH v3 3/3] blsuki: Add uki command to load Unified Ke... | KEEP | | |
| 2025-04-0151 | Re: [PATCH v1] grub-probe: detect DDF container similar t... | DROP | Re: dup | 2025-05-0083 |
| 2025-04-0152 | Re: [PATCH v1] grub-probe: detect DDF container similar t... | DROP | Re: dup | 2025-05-0083 |
| 2025-04-0153 | Re: [PATCH v1] grub-probe: detect DDF container similar t... | DROP | Re: dup | 2025-05-0083 |
| 2025-04-0157 | [PATCH v11 02/14] Import b64dec from gpg-error | DROP | Older version | 2025-07-0029 |
| 2025-04-0158 | [PATCH v11 03/14] b64dec: Adjust for compilation in GRUB ... | DROP | Older version | 2025-07-0029 |
| 2025-04-0159 | [PATCH v11 05/14] Add DSA and RSA SEXP tests | DROP | Older version | 2025-07-0032 |
| 2025-04-0160 | [PATCH v11 07/14] libgcrypt: Fix coverity warnings | DROP | Older version | 2025-07-0034 |
| 2025-04-0161 | [PATCH v11 06/14] keccak: Disable acceleration with SSE asm | DROP | Already in master | 2025-07-0030 |
| 2025-04-0162 | [PATCH v11 11/14] gcry: Ignore sign-compare warnings | DROP | Older version | 2025-07-0037 |
| 2025-04-0163 | [PATCH v11 14/14] import_gcry: Fix pylint warnings | DROP | Older version | 2025-07-0042 |
| 2025-04-0164 | [PATCH v11 01/14] Import libgcrypt 1.11 | DROP | Older version | 2025-07-0033 |
| 2025-04-0165 | [PATCH v11 08/14] Remove now unneeded gcrypt compilation ... | DROP | Older version | 2025-07-0035 |
| 2025-04-0166 | [PATCH v11 04/14] Adjust import script, | DROP | Older version | 2025-07-0031 |
| 2025-04-0169 | [PATCH v11 12/14] libgcrypt: Import blake family of hashes | DROP | Older version | 2025-07-0040 |
| 2025-04-0170 | [PATCH v11 13/14] import_gcry: Make compatible with pytho... | DROP | Older version | 2025-07-0038 |
| 2025-04-0179 | Re: [PATCH 1/2] Include function name on debug traces | DROP | Reply only |  |
| 2025-04-0181 | [PATCH v12 02/13] Import b64dec from gpg-error | DROP | Older version | 2025-07-0029 |
| 2025-04-0182 | [PATCH v12 03/13] b64dec: Adjust for compilation in GRUB ... | DROP | Older version | 2025-07-0029 |
| 2025-04-0183 | [PATCH v12 11/13] import_gcry: Make compatible with pytho... | DROP | Older version | 2025-07-0038 |
| 2025-04-0184 | [PATCH v12 13/13] libgcrypt: Don't use 64-bit division on... | DROP | Older version | 2025-07-0029 |
| 2025-04-0185 | [PATCH v12 06/13] keccak: Disable acceleration with SSE asm | DROP | Already in master | 2025-07-0030 |
| 2025-04-0186 | [PATCH v12 01/13] Import libgcrypt 1.11 | DROP | Older version | 2025-07-0033 |
| 2025-04-0187 | [PATCH v12 05/13] Add DSA and RSA SEXP tests | DROP | Older version | 2025-07-0032 |
| 2025-04-0188 | [PATCH v12 12/13] import_gcry: Fix pylint warnings | DROP | Older version | 2025-07-0042 |
| 2025-04-0189 | [PATCH v12 10/13] libgcrypt: Import blake family of hashes | DROP | Older version | 2025-07-0040 |
| 2025-04-0190 | [PATCH v12 08/13] Remove now unneeded gcrypt compilation ... | DROP | Older version | 2025-07-0035 |
| 2025-04-0191 | [PATCH v12 07/13] libgcrypt: Fix coverity warnings | DROP | Older version | 2025-07-0034 |
| 2025-04-0192 | [PATCH v12 09/13] gcry: Ignore sign-compare warnings | DROP | Older version | 2025-07-0037 |
| 2025-04-0193 | [PATCH v12 04/13] Adjust import script, | DROP | Older version | 2025-07-0031 |
| 2025-04-0196 | Re: [PATCH] efi/mm: relax memory type request we're askin... | KEEP | | |
| 2025-04-0211 | [PATCH v3 2/2] date_unit_test: test dates outside of 32-b... | KEEP | | |
| 2025-04-0212 | [PATCH v3 1/2] datetime: Support dates outside of 1901..2... | DROP | Older version | 2025-08-0267 |
| 2025-04-0215 | Re: [PATCH] kern/efi/mm: try allocating in the lower 4GB ... | KEEP | | |
| 2025-04-0238 | Re: [PATCH 1/2] x86_64-efi: Ensure that memory is mapped ... | KEEP | | |
| 2025-04-0239 | Re: [PATCH 2/2] kern/efi/mm: ask for more that 4GB if we ... | KEEP | | |
| 2025-04-0240 | Re: [PATCH 1/2] Include function name on debug traces | DROP | Reply only |  |
| 2025-04-0242 | Testing for specific PCI devices | KEEP | | |
| 2025-04-0244 | Re: [PATCH 1/2] Include function name on debug traces | DROP | Reply only |  |
| 2025-04-0245 | Re: [PATCH 1/2] Include function name on debug traces | DROP | Reply only |  |
| 2025-04-0249 | [PATCH 1/1] Add Xen command line parsing | KEEP | | |
| 2025-04-0250 | [PATCH v2] grub-probe: detect DDF container similar to IMSM | DROP | Already in master |  |
| 2025-04-0254 | [PATCH 0/1] loader/efi/chainloader: Enhance error message of | DROP | Older version | 2025-05-0076 |
| 2025-04-0256 | [PATCH 1/1] loader/efi/linux: Enhance linux command error... | DROP | Older version | 2025-05-0037 |
| 2025-04-0259 | [PATCH v2 1/1] loader/efi/linux: Enhance linux command er... | DROP | Older version | 2025-05-0037 |
| 2025-04-0264 | [PATCH v5 4/5] ieee1275: add support for NVMeoFC | DROP | Older version | 2026-02-0066 |
| 2025-04-0265 | [PATCH v5 5/5] ieee1275: ofpath enable NVMeoF logical dev... | DROP | Older version | 2026-02-0067 |
| 2025-04-0266 | [RFC PATCH v2 2/7] i386: Add PSP discovery code | KEEP | | |
| 2025-04-0267 | [RFC PATCH v2 3/7] slaunch/psp: Add core PSP commands and... | KEEP | | |
| 2025-04-0268 | [RFC PATCH v2 4/7] slaunch/psp: Setup TMRs to protect RAM... | KEEP | | |
| 2025-04-0270 | [RFC PATCH v2 1/7] i386: Extra x86 definitions needed by ... | KEEP | | |
| 2025-04-0271 | [RFC PATCH v2 5/7] slaunch/skinit: AMD SKINIT Secure Laun... | KEEP | | |
| 2025-04-0272 | [RFC PATCH v2 6/7] efi: Add AMD SKINIT Secure Launch support | KEEP | | |
| 2025-04-0273 | [RFC PATCH v2 7/7] multiboot2: Support SKINIT Secure Launch | KEEP | | |

### 2025-05 (87 branches: 35 remain, 52 drop)

| Branch | Subject | Decision | Reason | Superseded by |
|--------|---------|----------|--------|---------------|
| 2025-05-0008 | [PATCH] ntfs: Fix attribute validation check | KEEP | | |
| 2025-05-0025 | [PATCH v2] ia64: Disable optimizations using floating-point | KEEP | | |
| 2025-05-0032 | [PATCH] tests: Disable gfxterm_menu and cmdline_cat tests | KEEP | | |
| 2025-05-0033 | [PATCH] fs/zfs: Fix another memory leak in ZFS code | KEEP | | |
| 2025-05-0036 | [PATCH v2 0/1] loader/efi/chainloader: Enhance error mess... | DROP | Older version | 2025-05-0076 |
| 2025-05-0037 | [PATCH v2 1/1] loader/efi/linux: Enhance linux command er... | KEEP | | |
| 2025-05-0040 | Re: [PATCH] testpci: initial module | DROP | Re: dup | 2025-05-0075 |
| 2025-05-0041 | [SECURITY PATCH 1/8] kern/rescue_reader: Block the rescue... | DROP | Already in master |  |
| 2025-05-0042 | Re: [PATCH v2 0/1] loader/efi/chainloader: Enhance error ... | DROP | Reply only |  |
| 2025-05-0044 | [SECURITY PATCH 2/8] commands/search: Introduce the --cry... | KEEP | | |
| 2025-05-0045 | [SECURITY PATCH 4/8] commands/search: Add the diskfilter ... | DROP | Resend | 2025-05-0058 |
| 2025-05-0046 | [SECURITY PATCH 5/8] docs: Document available crypto disk... | KEEP | | |
| 2025-05-0047 | [SECURITY PATCH 7/8] disk/cryptodisk: Wipe the passphrase... | DROP | Already in master |  |
| 2025-05-0048 | [SECURITY PATCH 6/8] disk/cryptodisk: Add the "erase secr... | DROP | Already in master |  |
| 2025-05-0049 | [SECURITY PATCH 1/8] kern/rescue_reader: Block the rescue... | DROP | Already in master |  |
| 2025-05-0050 | [SECURITY PATCH 3/8] disk/diskfilter: Introduce the "cryp... | DROP | Resend | 2025-05-0059 |
| 2025-05-0051 | [SECURITY PATCH 8/8] cryptocheck: Add --quiet option | DROP | Already in master |  |
| 2025-05-0055 | Re: [SECURITY PATCH 8/8] cryptocheck: Add --quiet option | KEEP | | |
| 2025-05-0056 | Re: [SECURITY PATCH 7/8] disk/cryptodisk: Wipe the passph... | KEEP | | |
| 2025-05-0057 | Re: [SECURITY PATCH 6/8] disk/cryptodisk: Add the "erase ... | KEEP | | |
| 2025-05-0058 | Re: [SECURITY PATCH 4/8] commands/search: Add the diskfil... | KEEP | | |
| 2025-05-0059 | Re: [SECURITY PATCH 3/8] disk/diskfilter: Introduce the "... | KEEP | | |
| 2025-05-0060 | Re: [SECURITY PATCH 2/8] commands/search: Introduce the | KEEP | | |
| 2025-05-0061 | Re: [RFC PATCH] commands/efi: add a command to dump all U... | DROP | Reply only |  |
| 2025-05-0062 | [PATCH v2] commands/efi: add a command to dump all uefi r... | KEEP | | |
| 2025-05-0064 | [PATCH v3] commands/efi: add command to dump all uefi run... | KEEP | | |
| 2025-05-0072 | Re: [PATCH v5] commands/efi: dump all uefi runtime variables | KEEP | | |
| 2025-05-0075 | Re: [PATCH v2] testpci: initial module | KEEP | | |
| 2025-05-0076 | [PATCH v3 0/1] loader/efi/chainloader: Enhance error mess... | KEEP | | |
| 2025-05-0077 | [PATCH v3 1/1] loader/efi/linux: Enhance error message of... | KEEP | | |
| 2025-05-0078 | [PATCH 0/2] commands/efi/lsefi: Fix memory leak | DROP | Older version | 2025-05-0108 |
| 2025-05-0079 | [PATCH 1/2] loader/efi/linux: Fix memory leak | DROP | Older version | 2025-05-0153 |
| 2025-05-0082 | Fwd: [PATCH] efi/tpcm: Add TPCM module support | KEEP | | |
| 2025-05-0083 | Re: [PATCH v2] grub-probe: detect DDF container similar t... | KEEP | | |
| 2025-05-0084 | [PATCH 1/2] envblk: ignore empty new lines while parsing ... | DROP | Older version | 2025-05-0135 |
| 2025-05-0108 | [PATCH v2 0/3] commands/efi/lsefi: Fix memory leak | KEEP | | |
| 2025-05-0110 | [PATCH v2 2/3] loader/efi/linux: Fix memory leak | DROP | Date fix | 2025-05-0153 |
| 2025-05-0111 | [RESEND PATCH 3/3] commands/efi/tmp: Fix memory leak | DROP | Already in master |  |
| 2025-05-0113 | [PATCH 1/3] fs/ntfs: Correct some NTFS regressions | KEEP | | |
| 2025-05-0114 | [PATCH 2/3] fs/fshelp: Avoid possible NULL pointer deference | KEEP | | |
| 2025-05-0115 | [PATCH 3/3] fs/ntfs: Correct possible access violations a... | KEEP | | |
| 2025-05-0117 | Re: [PATCH 2/3] fs/fshelp: Avoid possible NULL pointer de... | DROP | Older version | 2025-05-0118 |
| 2025-05-0118 | Re: [PATCH 2/3] fs/fshelp: Avoid possible NULL pointer de... | KEEP | | |
| 2025-05-0119 | [PATCH v1 1/2] envblk: ignore empty new lines while parsi... | DROP | Older version | 2025-05-0135 |
| 2025-05-0125 | [PATCH v2] ieee1275: support added for multiple nvme boot... | DROP | Resend | 2026-02-0068 |
| 2025-05-0129 | Re: [PATCH 2/3] fs/fshelp: Avoid possible NULL pointer de... | DROP | Reply only |  |
| 2025-05-0132 | Re: [PATCH v1 1/2] envblk: ignore empty new lines while p... | KEEP | | |
| 2025-05-0135 | [PATCH v2 1/2] envblk: ignore empty new lines while parsi... | DROP | Already in master |  |
| 2025-05-0139 | [PATCH v2 1/4] fs/ntfs: Correct regression with run list ... | DROP | Older version | 2025-05-0165 |
| 2025-05-0140 | [PATCH v2 2/4] fs/ntfs: Correct attribute vs attribute li... | DROP | Older version | 2025-05-0166 |
| 2025-05-0141 | [PATCH v2 3/4] fs/fshelp: Avoid possible NULL pointer def... | DROP | Already in master | 2025-05-0165 |
| 2025-05-0142 | [PATCH v2 4/4] fs/ntfs: Correct possible access violation... | DROP | Older version | 2025-05-0165 |
| 2025-05-0143 | Re: [PATCH v2 1/4] fs/ntfs: Correct regression with run list | DROP | Older version | 2025-05-0165 |
| 2025-05-0151 | [PATCH 0/2] commands/efi: Fix sevral memory leaks | KEEP | | |
| 2025-05-0153 | [PATCH 2/2 ] loader/efi/linux: Fix memory leak | KEEP | | |
| 2025-05-0160 | [PATCH v4 3/4] blsuki: Check for mounted /boot in emu | DROP | Older version | 2025-08-0052 |
| 2025-05-0161 | [PATCH v4 4/4] blsuki: Add uki command to load Unified Ke... | DROP | Older version | 2025-08-0051 |
| 2025-05-0162 | [PATCH v4 2/4] blsuki: Add blscfg command to parse Boot L... | DROP | Older version | 2025-08-0054 |
| 2025-05-0165 | [PATCH v3 1/5] fs/ntfs: Correct regression with run list ... | DROP | Already in master |  |
| 2025-05-0166 | [PATCH v3 2/5] fs/ntfs: Correct attribute vs attribute li... | KEEP | | |
| 2025-05-0167 | [PATCH v3 3/5] fs/ntfs: Correct possible access violations | KEEP | | |
| 2025-05-0168 | [PATCH v3 4/5] fs/ntfs: Correct possible infinite loops /... | DROP | Already in master |  |
| 2025-05-0169 | [PATCH v3 5/5] fs/fshelp: Avoid possible NULL pointer def... | DROP | Already in master |  |
| 2025-05-0180 | [PATCH] UEFI: Fix several memory leaks of UEFI handles | DROP | Already in master |  |
| 2025-05-0186 | [PATCH v13 02/13] Import b64dec from gpg-error | DROP | Older version | 2025-07-0029 |
| 2025-05-0187 | [PATCH v13 03/13] b64dec: Add harness for compilation in ... | DROP | Already in master | 2025-07-0030 |
| 2025-05-0188 | [PATCH v13 05/13] Add DSA and RSA SEXP tests | DROP | Older version | 2025-07-0032 |
| 2025-05-0189 | [PATCH v13 04/13] Adjust import script, | DROP | Older version | 2025-07-0031 |
| 2025-05-0190 | [PATCH v13 09/13] gcry: Ignore sign-compare warnings | DROP | Older version | 2025-07-0037 |
| 2025-05-0191 | [PATCH v13 01/13] Import libgcrypt 1.11 | DROP | Older version | 2025-07-0033 |
| 2025-05-0192 | [PATCH v13 08/13] Remove now unneeded gcrypt compilation ... | DROP | Older version | 2025-07-0035 |
| 2025-05-0193 | [PATCH v13 10/13] libgcrypt: Import blake family of hashes | DROP | Older version | 2025-07-0040 |
| 2025-05-0194 | [PATCH v13 12/13] import_gcry: Fix pylint warnings | DROP | Older version | 2025-07-0042 |
| 2025-05-0195 | [PATCH v13 07/13] libgcrypt: Fix coverity warnings | DROP | Older version | 2025-07-0034 |
| 2025-05-0196 | [PATCH v13 06/13] keccak: Disable acceleration with SSE asm | DROP | Already in master | 2025-07-0030 |
| 2025-05-0197 | [PATCH v13 11/13] import_gcry: Make compatible with pytho... | DROP | Older version | 2025-07-0038 |
| 2025-05-0198 | [PATCH v13 13/13] libgcrypt: Don't use 64-bit division on... | DROP | Already in master | 2025-07-0030 |
| 2025-05-0201 | [PATCH 1/2] Exporting variables to upper levels | KEEP | | |
| 2025-05-0202 | =?UTF-8?Q?=5BPATCH_2/2=5D_Docs_for_the_new_options_of_the... | KEEP | | |
| 2025-05-0209 | Re: [PATCH 1/2] Exporting variables to upper levels | DROP | Reply only |  |
| 2025-05-0212 | [PATCH] luks2: Add attempting to decrypt message to align... | DROP | Already in master |  |
| 2025-05-0222 | Re: [PATCH v2 2/3] Option to set title of submenus | KEEP | | |
| 2025-05-0248 | [RESEND PATCH] UEFI: Fix several memory leaks of UEFI han... | DROP | Already in master |  |
| 2025-05-0256 | Regarding bug in affs filesystem parser | KEEP | | |
| 2025-05-0258 | [PATCH v2 1/1] kern/xen: Add Xen command line parsing | DROP | Older version | 2025-07-0224 |
| 2025-05-0262 | [PATCH 1/2] gnulib: Add patch to allow GRUB w/GCC-15 compile | DROP | Older version | 2025-06-0117 |
| 2025-05-0263 | [PATCH 2/2] util/grub-protect: Correct uninit 'err' Variable | DROP | Already in master | 2025-06-0118 |

### 2025-06 (52 branches: 18 remain, 34 drop)

| Branch | Subject | Decision | Reason | Superseded by |
|--------|---------|----------|--------|---------------|
| 2025-06-0002 | [PATCH 1/1] fs/ntfs.c: Correct next_attribute validation | KEEP | | |
| 2025-06-0011 | [PATCH] unix/hostdisk: Fix signed integer overflow | KEEP | | |
| 2025-06-0013 | [PATCH v3 1/1] kern/xen: Add Xen command line parsing | DROP | Older version | 2025-07-0224 |
| 2025-06-0029 | [PATCH 2/3] tpm2_key_protector: Dump the PCR bank for key... | DROP | Older version | 2025-06-0101 |
| 2025-06-0030 | [PATCH 1/3] grub-protect: Fix the hash algorithm of PCR d... | DROP | Already in master |  |
| 2025-06-0031 | [PATCH 3/3] tests/tpm2_key_protector_test: Add tests for ... | KEEP | | |
| 2025-06-0037 | Re: [PATCH] Create a Containerfile with required grub pac... | DROP | Re: dup | 2025-06-0121 |
| 2025-06-0038 | [PATCH v1] lsefi: fixed memory leaks | DROP | Older version | 2025-09-0037 |
| 2025-06-0040 | [PATCH 2/2] gnulib/regexec: Fix resource leak | KEEP | | |
| 2025-06-0041 | [PATCH 1/2] gnulib/regcomp: Fix resource leak | KEEP | | |
| 2025-06-0045 | [PATCH 1/2] appendedsig: The grub command's trusted and d... | KEEP | | |
| 2025-06-0081 | [PATCH] lib/LzmaEnc: Validate 'len' before subtracting | DROP | Older version | 2025-06-0096 |
| 2025-06-0091 | [PATCH 1/2] build: remove extra_deps.lst from EXTRA_DIST | DROP | Already in master |  |
| 2025-06-0092 | [PATCH 2/2] build: Add new header files to dist to allow ... | KEEP | | |
| 2025-06-0096 | [PATCH v2] lib/LzmaEnc: Validate 'len' before subtracting | KEEP | | |
| 2025-06-0099 | [PATCH v2 1/3] grub-protect: Fix the hash algorithm of PC... | DROP | Already in master |  |
| 2025-06-0100 | [PATCH v2 3/3] tests/tpm2_key_protector_test: Add tests f... | DROP | Already in master |  |
| 2025-06-0101 | [PATCH v2 2/3] tpm2_key_protector: Dump the PCR bank for ... | KEEP | | |
| 2025-06-0111 | Re: [PATCH] Create a Containerfile with required grub pac... | DROP | Re: dup | 2025-06-0121 |
| 2025-06-0114 | Re: [PATCH] Create a Containerfile with required grub pac... | DROP | Re: dup | 2025-06-0121 |
| 2025-06-0117 | [PATCH v2 1/2] gnulib: Add patch to allow GRUB w/GCC-15 c... | KEEP | | |
| 2025-06-0118 | [PATCH v2 2/2] util/grub-protect: Correct uninit 'err' Va... | DROP | Already in master |  |
| 2025-06-0121 | Re: [PATCH] Create a Containerfile with required grub pac... | KEEP | | |
| 2025-06-0123 | Re: [PATCH] Create a Containerfile with required grub pac... | DROP | Re: dup | 2025-06-0121 |
| 2025-06-0125 | [PATCH] loader/efi/linux.c: unload previous linux before ... | DROP | Already in master |  |
| 2025-06-0133 | [PATCH 1/2] gnulib: Bring back the fix for resolving unus... | KEEP | | |
| 2025-06-0134 | [PATCH] normal/charset: Fix underflow and overflow in loo... | DROP | Already in master |  |
| 2025-06-0135 | [PATCH v4 2/5] efi/sb: Add support for the shim loader pr... | DROP | Older version | 2025-07-0068 |
| 2025-06-0136 | [PATCH v4 4/5] loader/efi/chainloader: Use shim loader im... | DROP | Already in master |  |
| 2025-06-0137 | [PATCH v4 1/5] efi: Provide wrappers for load_image, star... | DROP | Older version | 2025-07-0065 |
| 2025-06-0138 | [PATCH v4 3/5] efi/sb: Add API for retrieving shim loader... | DROP | Older version | 2025-07-0066 |
| 2025-06-0139 | [PATCH v4 5/5] loader/efi/linux: Use shim loader image ha... | DROP | Older version | 2025-07-0069 |
| 2025-06-0142 | [PATCH 1/1] tests: Correct netboot and file_filter test f... | KEEP | | |
| 2025-06-0143 | Re: [PATCH v2] Create Containerfiles with required grub p... | KEEP | | |
| 2025-06-0144 | [PATCH] loader/efi/linux: Correctly terminate LoadOptions... | DROP | Older version | 2025-06-0182 |
| 2025-06-0149 | Re: [PATCH 1/1] tests: Correct netboot and file_filter te... | DROP | Reply only |  |
| 2025-06-0151 | [PATCH] Revert "lzma: Make sure we don't dereference past... | DROP | Already in master |  |
| 2025-06-0154 | [PATCH] loader/i386/pc/linux: Fix resource leak | DROP | Already in master |  |
| 2025-06-0157 | [PATCH v2] loader/efi/linux: Correctly terminate LoadOpti... | DROP | Resend | 2025-06-0182 |
| 2025-06-0163 | [PATCH v3 1/6] loader/efi/linux: Remove useless assignment | DROP | Older version | 2025-06-0177 |
| 2025-06-0164 | [PATCH v3 3/6] loader/efi/linux: Do not pass excessive si... | DROP | Older version | 2025-06-0178 |
| 2025-06-0165 | [PATCH v3 5/6] loader/efi/linux: Use sizeof instead of co... | DROP | Older version | 2025-06-0179 |
| 2025-06-0166 | [PATCH v3 6/6] loader/efi/linux: Correctly terminate Load... | DROP | Older version | 2025-06-0182 |
| 2025-06-0167 | [PATCH v3 2/6] include/grub/charset.h: Update documentation | DROP | Already in master | 2025-06-0180 |
| 2025-06-0168 | [PATCH v3 4/6] loader/efi/linux: Use proper type for "len... | DROP | Older version | 2025-06-0177 |
| 2025-06-0177 | [PATCH v4 1/6] loader/efi/linux: Remove useless assignment | KEEP | | |
| 2025-06-0178 | [PATCH v4 3/6] loader/efi/linux: Do not pass excessive si... | KEEP | | |
| 2025-06-0179 | [PATCH v4 5/6] loader/efi/linux: Use sizeof instead of co... | KEEP | | |
| 2025-06-0180 | [PATCH v4 4/6] loader/efi/linux: Use proper type for "len... | DROP | Already in master |  |
| 2025-06-0181 | [PATCH v4 2/6] include/grub/charset.h: Update documentation | DROP | Already in master |  |
| 2025-06-0182 | [PATCH v4 6/6] loader/efi/linux: Correctly terminate Load... | KEEP | | |
| 2025-06-0188 | [PATCH v2 1/2] efi/tpcm: Add UEFI interface for TPCM module | DROP | Older version | 2025-07-0004 |

### 2025-07 (168 branches: 29 remain, 139 drop)

| Branch | Subject | Decision | Reason | Superseded by |
|--------|---------|----------|--------|---------------|
| 2025-07-0002 | Re: [PATCH v3 17/25] ieee1275: Platform Keystore (PKS) Su... | DROP | Reply only |  |
| 2025-07-0004 | [PATCH v3 1/2] efi/tpcm: Add UEFI interface for TPCM module | KEEP | | |
| 2025-07-0008 | [PATCH] dl: fix grub_dl_is_persistent() for EMU | DROP | Already in master |  |
| 2025-07-0013 | [PATCH] arm64/xen: Delete correctly all modules loaded by... | DROP | Already in master |  |
| 2025-07-0015 | [PATCH] arm64/xen: Use bool instead of int | DROP | Already in master |  |
| 2025-07-0016 | [PATCH] arm64/xen: Consider alignment calling | DROP | Already in master | 2025-07-0027 |
| 2025-07-0025 | [PATCH v14 01/15] Import libgcrypt 1.11 | DROP | Older version | 2025-07-0033 |
| 2025-07-0027 | [PATCH v2] arm64/xen: Consider alignment calling | KEEP | | |
| 2025-07-0029 | [PATCH v14 02/15] Import b64dec from gpg-error | KEEP | | |
| 2025-07-0030 | [PATCH v14 03/15] b64dec: Add harness for compilation in ... | DROP | Already in master |  |
| 2025-07-0031 | [PATCH v14 04/15] Adjust import script, | KEEP | | |
| 2025-07-0032 | [PATCH v14 05/15] Add DSA and RSA SEXP tests | KEEP | | |
| 2025-07-0033 | [PATCH v14 01/15] Import libgcrypt 1.11 | KEEP | | |
| 2025-07-0034 | [PATCH v14 07/15] libgcrypt: Fix coverity warnings | KEEP | | |
| 2025-07-0035 | [PATCH v14 08/15] Remove now unneeded gcrypt compilation ... | KEEP | | |
| 2025-07-0036 | [PATCH v14 06/15] keccak: Disable acceleration with SSE asm | DROP | Already in master |  |
| 2025-07-0037 | [PATCH v14 09/15] gcry: Ignore sign-compare warnings | KEEP | | |
| 2025-07-0038 | [PATCH v14 11/15] import_gcry: Make compatible with pytho... | KEEP | | |
| 2025-07-0039 | [PATCH v14 14/15] libgcrypt: Fix a memory leak | KEEP | | |
| 2025-07-0040 | [PATCH v14 10/15] libgcrypt: Import blake family of hashes | KEEP | | |
| 2025-07-0041 | [PATCH v14 13/15] libgcrypt: Don't use 64-bit division on... | DROP | Already in master |  |
| 2025-07-0042 | [PATCH v14 12/15] import_gcry: Fix pylint warnings | KEEP | | |
| 2025-07-0043 | [PATCH v14 15/15] Write how to import new libgcrypt | DROP | Already in master |  |
| 2025-07-0047 | [RFC PATCH 5/5] arm64/xen: Allows to use kernel command l... | KEEP | | |
| 2025-07-0049 | [PATCH 1/7] tss2: Add TPM2_PCR_Event command | DROP | Older version | 2025-10-0092 |
| 2025-07-0050 | [RFC PATCH 4/5] arm64/xen: Use LoadFile2 protocol for Xen... | KEEP | | |
| 2025-07-0051 | [PATCH 3/7] tss2: Implement grub_tcg2_cap_pcr() for EFI | DROP | Older version | 2025-09-0006 |
| 2025-07-0056 | [PATCH 6/7] tpm2_key_protector: Support PCR capping | DROP | Older version | 2025-10-0097 |
| 2025-07-0057 | [RFC PATCH 2/5] kern/list: Add a grub_list_append function | KEEP | | |
| 2025-07-0059 | [PATCH 2/7] tss2: Introduce grub_tcg2_cap_pcr() | DROP | Older version | 2025-10-0090 |
| 2025-07-0060 | [PATCH 7/7] tests/tpm2_key_protector_test: Add a test for... | DROP | Already in master | 2025-10-0090 |
| 2025-07-0064 | [PATCH 5/7] tss2: Implement grub_tcg2_cap_pcr() for EMU | DROP | Older version | 2025-10-0090 |
| 2025-07-0065 | [PATCH v5 1/5] efi: Provide wrappers for load_image, star... | KEEP | | |
| 2025-07-0066 | [PATCH v5 3/5] efi/sb: Add API for retrieving shim loader... | KEEP | | |
| 2025-07-0067 | [PATCH v5 4/5] loader/efi/chainloader: Use shim loader im... | DROP | Already in master |  |
| 2025-07-0068 | [PATCH v5 2/5] efi/sb: Add support for the shim loader pr... | KEEP | | |
| 2025-07-0069 | [PATCH v5 5/5] loader/efi/linux: Use shim loader image ha... | KEEP | | |
| 2025-07-0070 | [PATCH 4/7] tss2: Implement grub_tcg2_cap_pcr() for ieee1275 | DROP | Older version | 2025-10-0094 |
| 2025-07-0079 | [PATCH v4 01/23] powerpc-ieee1275: Add support for signin... | DROP | Older version | 2025-10-0142 |
| 2025-07-0081 | [PATCH v4 02/23] docs/grub: Document signing GRUB under UEFI | DROP | Older version | 2025-10-0159 |
| 2025-07-0082 | [PATCH v4 04/23] pgp: Factor out rsa_pad | DROP | Older version | 2025-10-0142 |
| 2025-07-0083 | [PATCH v4 05/23] crypto: Move storage for grub_crypto_pk_... | DROP | Older version | 2025-10-0142 |
| 2025-07-0084 | [PATCH v4 07/23] grub-install: Support embedding x509 cer... | DROP | Older version | 2025-10-0142 |
| 2025-07-0085 | [PATCH v4 08/23] appended signatures: Import GNUTLS's ASN.1 | DROP | Already in master | 2025-10-0143 |
| 2025-07-0086 | [PATCH v4 03/23] docs/grub: Document signing GRUB with an... | DROP | Older version | 2025-10-0162 |
| 2025-07-0087 | [PATCH v4 10/23] appended signatures: Parse PKCS#7 signed... | DROP | Older version | 2025-10-0142 |
| 2025-07-0088 | [PATCH v4 09/23] appended signatures: Parse ASN1 node | DROP | Older version | 2025-10-0148 |
| 2025-07-0089 | [PATCH v4 11/23] appended signatures: Parse X.509 certifi... | DROP | Older version | 2025-10-0142 |
| 2025-07-0090 | [PATCH v4 06/23] pgp: Rename OBJ_TYPE_PUBKEY to OBJ_TYPE_... | DROP | Older version | 2025-10-0145 |
| 2025-07-0091 | [PATCH v4 19/23] powerpc_ieee1275: Introduce use_static_k... | DROP | Older version | 2025-10-0142 |
| 2025-07-0092 | [PATCH v4 12/23] appended signatures: Support verifying a... | DROP | Older version | 2025-10-0151 |
| 2025-07-0093 | [PATCH v4 13/23] appended signatures: Verification tests | DROP | Older version | 2025-10-0160 |
| 2025-07-0094 | [PATCH v4 15/23] ieee1275: Enter lockdown based on /ibm,s... | DROP | Older version | 2025-10-0142 |
| 2025-07-0095 | [PATCH v4 14/23] appended signatures: Documentation | DROP | Older version | 2025-10-0142 |
| 2025-07-0096 | [PATCH v4 18/23] appendedsig: verify the kernel using db ... | DROP | Older version | 2025-10-0142 |
| 2025-07-0097 | [PATCH v4 21/23] appendedsig: Introduce GRUB commands to ... | DROP | Older version | 2025-10-0142 |
| 2025-07-0098 | [PATCH v4 17/23] appendedsig: create db and dbx lists | DROP | Older version | 2025-10-0142 |
| 2025-07-0099 | [PATCH v4 20/23] appendedsig: Read default DB keys from t... | DROP | Older version | 2025-10-0142 |
| 2025-07-0100 | [PATCH v4 23/23] appendedsig test: Replace the certificat... | DROP | Older version | 2025-10-0142 |
| 2025-07-0101 | [PATCH v4 16/23] ieee1275: Read the DB and DBX secure boo... | DROP | Older version | 2025-10-0142 |
| 2025-07-0102 | [PATCH v4 22/23] appendedsig: Documentation | DROP | Older version | 2025-10-0142 |
| 2025-07-0114 | [PATCH] loader/efi/linux: Return correct size from LoadFile | DROP | Older version | 2025-07-0174 |
| 2025-07-0126 | [RESEND PATCH] UEFI: Fix several memory leaks of UEFI han... | DROP | Already in master |  |
| 2025-07-0129 | [PATCH] tcp: Fix TCP port number reused on reboot | DROP | Older version | 2025-09-0020 |
| 2025-07-0130 | [PATCH] Support environment block in btrfs reserved area | KEEP | | |
| 2025-07-0132 | [PATCH v2] loader/efi/linux: Return correct size from Loa... | DROP | Older version | 2025-07-0174 |
| 2025-07-0134 | [PATCH v2] tcp: Fix TCP port number reused on reboot | DROP | Resend | 2025-09-0020 |
| 2025-07-0136 | [PATCH v3] loader/efi/linux: Return correct size from Loa... | DROP | Older version | 2025-07-0174 |
| 2025-07-0139 | [PATCH v5 01/21] powerpc-ieee1275: Add support for signin... | DROP | Older version | 2025-10-0142 |
| 2025-07-0140 | [PATCH v5 02/21] docs/grub: Document signing GRUB under UEFI | DROP | Older version | 2025-10-0159 |
| 2025-07-0141 | [PATCH v5 03/21] docs/grub: Document signing GRUB with an... | DROP | Older version | 2025-10-0162 |
| 2025-07-0142 | [PATCH v5 04/21] crypto: Move storage for grub_crypto_pk_... | DROP | Already in master | 2025-10-0143 |
| 2025-07-0143 | [PATCH v5 09/21] appended signatures: Parse PKCS#7 signed... | DROP | Older version | 2025-10-0142 |
| 2025-07-0144 | [PATCH v5 08/21] appended signatures: Parse ASN1 node | DROP | Older version | 2025-10-0148 |
| 2025-07-0145 | [PATCH v5 10/21] appended signatures: Parse X.509 certifi... | DROP | Older version | 2025-10-0142 |
| 2025-07-0146 | [PATCH v5 15/21] ieee1275: Read the DB and DBX secure boo... | DROP | Older version | 2025-10-0142 |
| 2025-07-0147 | [PATCH v5 14/21] ieee1275: Enter lockdown based on /ibm,s... | DROP | Older version | 2025-10-0142 |
| 2025-07-0148 | [PATCH v5 13/21] appended signatures: Documentation | DROP | Older version | 2025-10-0142 |
| 2025-07-0149 | [PATCH v5 05/21] pgp: Rename OBJ_TYPE_PUBKEY to OBJ_TYPE_... | DROP | Older version | 2025-10-0145 |
| 2025-07-0150 | [PATCH v5 07/21] appended signatures: Import GNUTLS's ASN.1 | DROP | Already in master | 2025-10-0143 |
| 2025-07-0151 | [PATCH v5 06/21] grub-install: Support embedding x509 cer... | DROP | Already in master | 2025-10-0143 |
| 2025-07-0152 | [PATCH v5 12/21] appended signatures: Verification tests | DROP | Older version | 2025-10-0160 |
| 2025-07-0153 | [PATCH v5 18/21] powerpc_ieee1275: Introduce use_static_k... | DROP | Older version | 2025-10-0142 |
| 2025-07-0154 | [PATCH v5 17/21] appendedsig: Verify the kernel using db ... | DROP | Older version | 2025-10-0142 |
| 2025-07-0155 | [PATCH v5 19/21] appendedsig: Read default DB keys from t... | DROP | Older version | 2025-10-0142 |
| 2025-07-0156 | [PATCH v5 20/21] appendedsig: Introduce GRUB commands to ... | DROP | Older version | 2025-10-0142 |
| 2025-07-0157 | [PATCH v5 21/21] appendedsig: Documentation | DROP | Older version | 2025-10-0142 |
| 2025-07-0158 | [PATCH v5 11/21] appended signatures: Support verifying a... | DROP | Older version | 2025-10-0151 |
| 2025-07-0159 | [PATCH v5 16/21] appendedsig: Create db and dbx lists | DROP | Older version | 2025-10-0142 |
| 2025-07-0161 | [PATCH v2 1/7] tss2: Add TPM2_PCR_Event command | DROP | Older version | 2025-10-0092 |
| 2025-07-0162 | [PATCH v2 2/7] tss2: Introduce grub_tcg2_cap_pcr() | DROP | Older version | 2025-09-0005 |
| 2025-07-0163 | [PATCH v2 3/7] tss2: Implement grub_tcg2_cap_pcr() for EFI | DROP | Older version | 2025-09-0006 |
| 2025-07-0164 | [PATCH v2 4/7] tss2: Implement grub_tcg2_cap_pcr() for ie... | DROP | Older version | 2025-10-0094 |
| 2025-07-0165 | [PATCH v2 5/7] tss2: Implement grub_tcg2_cap_pcr() for EMU | DROP | Already in master | 2025-09-0007 |
| 2025-07-0166 | [PATCH v2 6/7] tpm2_key_protector: Support PCR capping | DROP | Older version | 2025-10-0097 |
| 2025-07-0167 | [PATCH v2 7/7] tests/tpm2_key_protector_test: Add a test ... | DROP | Already in master | 2025-09-0007 |
| 2025-07-0174 | [PATCH v4] loader/efi/linux: Return correct size from Loa... | DROP | Already in master |  |
| 2025-07-0182 | Re: [PATCH v5 13/21] appended signatures: Documentation | DROP | Reply only |  |
| 2025-07-0188 | [RFC PATCH 1/6] tweak autoconf/automake files to detect x... | DROP | Older version | 2025-10-0329 |
| 2025-07-0189 | [RFC PATCH 2/6] Copy the x86_64 optimization files | KEEP | | |
| 2025-07-0194 | [PATCH] bli: set LoaderTpm2ActivePcrBanks runtime variable | DROP | Older version | 2025-07-0218 |
| 2025-07-0195 | [PATCH] bli: set LoaderTpm2ActivePcrBanks runtime variable | DROP | Older version | 2025-07-0218 |
| 2025-07-0197 | Re: [PATCH] Support environment block in btrfs reserved area | DROP | Reply only |  |
| 2025-07-0201 | [PATCH] arm64/xen: Set correctly bootargs property for mo... | DROP | Already in master |  |
| 2025-07-0203 | [RESEND PATCH v3 1/1] kern/xen: Add Xen command line parsing | DROP | Older version | 2025-07-0224 |
| 2025-07-0204 | [PATCH] zfs: fix LINUX_ROOT_DEVICE when grub-probe fails | DROP | Already in master |  |
| 2025-07-0206 | [PATCH] conf: Add util/import_gcrypt_inth.sed to EXTRA_DISTS | DROP | Already in master |  |
| 2025-07-0207 | [PATCH v2 1/2] conf: Add new libgcrypt and libtasn1 relat... | DROP | Older version | 2025-07-0212 |
| 2025-07-0208 | [PATCH v2 2/2] configure.ac: Generate tar-ustar tarball i... | DROP | Already in master |  |
| 2025-07-0212 | [PATCH v2 1/2] conf: Add new libgcrypt and libtasn1 relat... | KEEP | | |
| 2025-07-0213 | [PATCH v2 2/2] configure.ac: Generate tar-ustar tarball i... | DROP | Already in master |  |
| 2025-07-0218 | [PATCH v2] bli: set LoaderTpm2ActivePcrBanks runtime vari... | KEEP | | |
| 2025-07-0224 | [RESEND PATCH v3 1/1] kern/xen: Add Xen command line parsing | KEEP | | |
| 2025-07-0226 | [PATCH v5 4/5] blsuki: Check for mounted /boot in emu | DROP | Older version | 2025-08-0052 |
| 2025-07-0227 | [PATCH v5 3/5] util/misc.c: Change offset type for | DROP | Already in master |  |
| 2025-07-0228 | [PATCH v5 2/5] blsuki: Add blscfg command to parse Boot L... | DROP | Older version | 2025-08-0054 |
| 2025-07-0230 | [PATCH v5 5/5] blsuki: Add uki command to load Unified Ke... | DROP | Older version | 2025-08-0051 |
| 2025-07-0231 | [PATCH v5 1/5] kern/misc: Implement grub_strtok() | DROP | Already in master |  |
| 2025-07-0234 | [PATCH v6 01/20] powerpc-ieee1275: Add support for signin... | DROP | Older version | 2025-10-0142 |
| 2025-07-0235 | [PATCH v6 02/20] crypto: Move storage for grub_crypto_pk_... | DROP | Already in master | 2025-10-0143 |
| 2025-07-0236 | [PATCH v6 03/20] pgp: Rename OBJ_TYPE_PUBKEY to OBJ_TYPE_... | DROP | Older version | 2025-10-0145 |
| 2025-07-0237 | [PATCH v6 04/20] grub-install: Support embedding x509 cer... | DROP | Already in master | 2025-10-0143 |
| 2025-07-0238 | [PATCH v6 05/20] appended signatures: Import GNUTLS's ASN.1 | DROP | Already in master | 2025-10-0143 |
| 2025-07-0239 | [PATCH v6 07/20] appended signatures: Parse PKCS#7 signed... | DROP | Older version | 2025-10-0142 |
| 2025-07-0240 | [PATCH v6 13/20] appended signatures: Using db and dbx li... | DROP | Older version | 2025-10-0142 |
| 2025-07-0241 | [PATCH v6 12/20] appended signatures: Create db and dbx l... | DROP | Older version | 2025-10-0156 |
| 2025-07-0242 | [PATCH v6 14/20] powerpc_ieee1275: Introduce use_static_k... | DROP | Older version | 2025-10-0142 |
| 2025-07-0243 | [PATCH v6 19/20] docs/grub: Document signing GRUB with an... | DROP | Older version | 2025-10-0162 |
| 2025-07-0244 | [PATCH v6 06/20] appended signatures: Parse ASN1 node | DROP | Older version | 2025-10-0148 |
| 2025-07-0245 | [PATCH v6 09/20] powerpc_ieee1275: Enter lockdown based o... | DROP | Older version | 2025-10-0150 |
| 2025-07-0246 | [PATCH v6 10/20] appended signatures: Support verifying a... | DROP | Older version | 2025-10-0151 |
| 2025-07-0247 | [PATCH v6 11/20] powerpc_ieee1275: Read the db and dbx se... | DROP | Older version | 2025-10-0152 |
| 2025-07-0248 | [PATCH v6 15/20] appended signatures: Read default db key... | DROP | Older version | 2025-10-0142 |
| 2025-07-0249 | [PATCH v6 16/20] appended signatures: Introduce GRUB comm... | DROP | Older version | 2025-10-0142 |
| 2025-07-0250 | [PATCH v6 18/20] docs/grub: Document signing GRUB under UEFI | DROP | Older version | 2025-10-0159 |
| 2025-07-0251 | [PATCH v6 20/20] docs/grub: Document appended signature | DROP | Older version | 2025-10-0161 |
| 2025-07-0252 | [PATCH v6 08/20] appended signatures: Parse X.509 certifi... | DROP | Older version | 2025-10-0142 |
| 2025-07-0253 | [PATCH v6 17/20] appended signatures: Verification tests | DROP | Older version | 2025-10-0160 |
| 2025-07-0255 | [PATCH v6 01/20] powerpc-ieee1275: Add support for signin... | DROP | Older version | 2025-10-0142 |
| 2025-07-0257 | [PATCH v6 02/20] crypto: Move storage for grub_crypto_pk_... | DROP | Already in master | 2025-10-0143 |
| 2025-07-0258 | [PATCH v6 03/20] pgp: Rename OBJ_TYPE_PUBKEY to OBJ_TYPE_... | DROP | Older version | 2025-10-0145 |
| 2025-07-0259 | [PATCH v6 04/20] grub-install: Support embedding x509 cer... | DROP | Already in master | 2025-10-0143 |
| 2025-07-0260 | [PATCH v6 06/20] appended signatures: Parse ASN1 node | DROP | Older version | 2025-10-0148 |
| 2025-07-0261 | [PATCH v6 08/20] appended signatures: Parse X.509 certifi... | DROP | Older version | 2025-10-0142 |
| 2025-07-0262 | [PATCH v6 07/20] appended signatures: Parse PKCS#7 signed... | DROP | Older version | 2025-10-0142 |
| 2025-07-0263 | [PATCH v6 09/20] powerpc_ieee1275: Enter lockdown based o... | DROP | Older version | 2025-10-0150 |
| 2025-07-0264 | [PATCH v6 18/20] docs/grub: Document signing GRUB under UEFI | DROP | Older version | 2025-10-0159 |
| 2025-07-0265 | [PATCH v6 05/20] appended signatures: Import GNUTLS's ASN.1 | DROP | Already in master | 2025-10-0143 |
| 2025-07-0266 | [PATCH v6 10/20] appended signatures: Support verifying a... | DROP | Older version | 2025-10-0151 |
| 2025-07-0267 | [PATCH v6 11/20] powerpc_ieee1275: Read the db and dbx se... | DROP | Older version | 2025-10-0152 |
| 2025-07-0268 | [PATCH v6 14/20] powerpc_ieee1275: Introduce use_static_k... | DROP | Older version | 2025-10-0142 |
| 2025-07-0269 | [PATCH v6 16/20] appended signatures: Introduce GRUB comm... | DROP | Older version | 2025-10-0142 |
| 2025-07-0270 | [PATCH v6 17/20] appended signatures: Verification tests | DROP | Older version | 2025-10-0160 |
| 2025-07-0271 | [PATCH v6 12/20] appended signatures: Create db and dbx l... | DROP | Older version | 2025-10-0156 |
| 2025-07-0272 | [PATCH v6 13/20] appended signatures: Using db and dbx li... | DROP | Older version | 2025-10-0142 |
| 2025-07-0273 | [PATCH v6 15/20] appended signatures: Read default db key... | DROP | Older version | 2025-10-0142 |
| 2025-07-0274 | [PATCH v6 20/20] docs/grub: Document appended signature | DROP | Older version | 2025-10-0161 |
| 2025-07-0275 | [PATCH v6 19/20] docs/grub: Document signing GRUB with an... | DROP | Older version | 2025-10-0162 |
| 2025-07-0281 | [PATCH v6 4/6] ieee1275: add support for NVMeoFC | DROP | Older version | 2026-02-0066 |
| 2025-07-0282 | [PATCH v6 5/6] ieee1275: ofpath enable NVMeoF logical dev... | DROP | Older version | 2026-02-0067 |
| 2025-07-0283 | [PATCH v6 6/6] ieee1275: support added for multiple nvme ... | DROP | Older version | 2026-02-0068 |
| 2025-07-0287 | [PATCH 1/7] argon2: Extract Argon2 code from libgcrypt | KEEP | | |
| 2025-07-0288 | [PATCH 7/7] docs: Document argon2 and argon2_test | DROP | Already in master |  |
| 2025-07-0289 | [PATCH 3/7] Import Argon2 tests from libgcrypt | DROP | Resend | 2025-10-0240 |
| 2025-07-0290 | [PATCH 4/7] Integrate Argon2 tests into functional_test | DROP | Resend | 2025-10-0245 |
| 2025-07-0291 | [PATCH 5/7] disk/luks2: Add Argon2 support | KEEP | | |
| 2025-07-0292 | [PATCH 6/7] tests/util/grub-fs-tester: Use Argon2id for L... | KEEP | | |
| 2025-07-0293 | [PATCH 2/7] argon2: Introduce grub_crypto_argon2() | KEEP | | |

### 2025-08 (138 branches: 35 remain, 103 drop)

| Branch | Subject | Decision | Reason | Superseded by |
|--------|---------|----------|--------|---------------|
| 2025-08-0009 | Re: [PATCH v5 1/5] kern/misc: Implement grub_strtok() | KEEP | | |
| 2025-08-0012 | [PATCH 1/2] zfs: Rewrite endianness handling | KEEP | | |
| 2025-08-0013 | [PATCH 2/2] zfs: Support datto encryption | KEEP | | |
| 2025-08-0023 | [PATCH v4 1/2] include/xen: Rename MAX_GUEST_CMDLINE to | DROP | Older version | 2025-08-0076 |
| 2025-08-0024 | [PATCH v4 2/2] kern/xen: Add Xen command line parsing | DROP | Older version | 2025-08-0079 |
| 2025-08-0027 | [PATCH v2 1/9] util/import_gcry: Import kdf.c for Argon2 | DROP | Older version | 2025-10-0234 |
| 2025-08-0028 | [PATCH v2 2/9] crypto: Update crypto.h for libgcrypt KDF ... | DROP | Already in master | 2025-10-0234 |
| 2025-08-0029 | [PATCH v2 6/9] Integrate Argon2 tests into functional_test | DROP | Older version | 2025-10-0245 |
| 2025-08-0030 | [PATCH v2 3/9] kdf: Resovle the build errors | DROP | Older version | 2025-10-0234 |
| 2025-08-0031 | [PATCH v2 9/9] docs: Document argon2 and argon2_test | DROP | Already in master | 2025-10-0234 |
| 2025-08-0032 | [PATCH v2 5/9] Import Argon2 tests from libgcrypt | DROP | Older version | 2025-10-0240 |
| 2025-08-0033 | [PATCH v2 7/9] disk/luks2: Add Argon2 support | DROP | Older version | 2025-10-0234 |
| 2025-08-0034 | [PATCH v2 8/9] tests/util/grub-fs-tester: Use Argon2id fo... | DROP | Older version | 2025-10-0243 |
| 2025-08-0035 | [PATCH v2 4/9] argon2: Introduce grub_crypto_argon2() | DROP | Already in master | 2025-10-0234 |
| 2025-08-0048 | [PATCH v2] relocator: Switch to own page table while movi... | KEEP | | |
| 2025-08-0050 | [PATCH v6 3/5] util/misc.c: Change offset type for | DROP | Already in master |  |
| 2025-08-0051 | [PATCH v6 5/5] blsuki: Add uki command to load Unified Ke... | KEEP | | |
| 2025-08-0052 | [PATCH v6 4/5] blsuki: Check for mounted /boot in emu | KEEP | | |
| 2025-08-0053 | [PATCH v6 1/5] kern/misc: Implement grub_strtok() | DROP | Already in master |  |
| 2025-08-0054 | [PATCH v6 2/5] blsuki: Add blscfg command to parse Boot L... | KEEP | | |
| 2025-08-0063 | Re: [PATCH v4 1/2] include/xen: Rename MAX_GUEST_CMDLINE to | DROP | Reply only |  |
| 2025-08-0076 | [PATCH v5 1/3] include/xen: Rename MAX_GUEST_CMDLINE to | KEEP | | |
| 2025-08-0077 | [PATCH v5 2/3] include/xen: Add warning comment for cmd_line | KEEP | | |
| 2025-08-0079 | [PATCH v5 3/3] kern/xen: Add Xen command line parsing | KEEP | | |
| 2025-08-0082 | [PATCH 2/2] lib/pbkdf2: Optimize PBKDF2 by reusing HMAC h... | DROP | Already in master |  |
| 2025-08-0083 | [PATCH 1/2] lib/crypto: Introduce new HMAC functions to r... | DROP | Already in master |  |
| 2025-08-0093 | [PATCH] util/bash-completion.d/Makefile.am: s/mkrescure/m... | DROP | Already in master |  |
| 2025-08-0095 | [PATCH v7 01/20] powerpc-ieee1275: Add support for signin... | DROP | Older version | 2025-10-0142 |
| 2025-08-0096 | [PATCH v7 02/20] crypto: Move storage for grub_crypto_pk_... | DROP | Already in master | 2025-10-0143 |
| 2025-08-0097 | [PATCH v7 03/20] pgp: Rename OBJ_TYPE_PUBKEY to OBJ_TYPE_... | DROP | Older version | 2025-10-0145 |
| 2025-08-0098 | [PATCH v7 04/20] grub-install: Support embedding x509 cer... | DROP | Already in master | 2025-10-0143 |
| 2025-08-0099 | [PATCH v7 05/20] appended signatures: Import GNUTLS's ASN.1 | DROP | Already in master | 2025-10-0143 |
| 2025-08-0100 | [PATCH v7 06/20] appended signatures: Parse ASN1 node | DROP | Older version | 2025-10-0148 |
| 2025-08-0101 | [PATCH v7 07/20] appended signatures: Parse PKCS#7 signed... | DROP | Older version | 2025-10-0142 |
| 2025-08-0102 | [PATCH v7 08/20] appended signatures: Parse X.509 certifi... | DROP | Older version | 2025-10-0142 |
| 2025-08-0103 | [PATCH v7 09/20] powerpc_ieee1275: Enter lockdown based o... | DROP | Older version | 2025-10-0150 |
| 2025-08-0104 | [PATCH v7 10/20] appended signatures: Support verifying a... | DROP | Older version | 2025-10-0151 |
| 2025-08-0105 | [PATCH v7 11/20] powerpc_ieee1275: Read the db and dbx se... | DROP | Older version | 2025-10-0152 |
| 2025-08-0106 | [PATCH v7 13/20] appended signatures: Using db and dbx li... | DROP | Older version | 2025-10-0142 |
| 2025-08-0107 | [PATCH v7 12/20] appended signatures: Create db and dbx l... | DROP | Older version | 2025-10-0156 |
| 2025-08-0108 | [PATCH v7 14/20] powerpc_ieee1275: Introduce use_static_k... | DROP | Older version | 2025-10-0142 |
| 2025-08-0109 | [PATCH v7 15/20] appended signatures: Read default db key... | DROP | Older version | 2025-10-0142 |
| 2025-08-0110 | [PATCH v7 16/20] appended signatures: Introduce GRUB comm... | DROP | Older version | 2025-10-0142 |
| 2025-08-0111 | [PATCH v7 18/20] docs/grub: Document signing GRUB under UEFI | DROP | Older version | 2025-10-0159 |
| 2025-08-0112 | [PATCH v7 17/20] appended signatures: Verification tests | DROP | Older version | 2025-10-0160 |
| 2025-08-0113 | [PATCH v7 19/20] docs/grub: Document signing GRUB with an... | DROP | Older version | 2025-10-0162 |
| 2025-08-0114 | [PATCH v7 20/20] docs/grub: Document appended signature | DROP | Older version | 2025-10-0161 |
| 2025-08-0115 | [PATCH] efi/console: treat scan_code 0x0102 (suspend) as ... | KEEP | | |
| 2025-08-0122 | [PATCH v8 01/20] powerpc-ieee1275: Add support for signin... | DROP | Older version | 2025-10-0142 |
| 2025-08-0123 | [PATCH v8 03/20] pgp: Rename OBJ_TYPE_PUBKEY to OBJ_TYPE_... | DROP | Older version | 2025-10-0145 |
| 2025-08-0124 | [PATCH v8 02/20] crypto: Move storage for grub_crypto_pk_... | DROP | Already in master | 2025-10-0143 |
| 2025-08-0125 | [PATCH v8 04/20] grub-install: Support embedding x509 cer... | DROP | Already in master | 2025-10-0143 |
| 2025-08-0126 | [PATCH v8 06/20] appended signatures: Parse ASN1 node | DROP | Older version | 2025-10-0148 |
| 2025-08-0127 | [PATCH v8 05/20] appended signatures: Import GNUTLS's ASN.1 | DROP | Already in master | 2025-10-0143 |
| 2025-08-0128 | [PATCH v8 07/20] appended signatures: Parse PKCS#7 signed... | DROP | Older version | 2025-10-0142 |
| 2025-08-0129 | [PATCH v8 08/20] appended signatures: Parse X.509 certifi... | DROP | Older version | 2025-10-0142 |
| 2025-08-0130 | [PATCH v8 09/20] powerpc_ieee1275: Enter lockdown based o... | DROP | Older version | 2025-10-0150 |
| 2025-08-0131 | [PATCH v8 10/20] appended signatures: Support verifying a... | DROP | Older version | 2025-10-0151 |
| 2025-08-0132 | [PATCH v8 11/20] powerpc_ieee1275: Read the db and dbx se... | DROP | Older version | 2025-10-0152 |
| 2025-08-0133 | [PATCH v8 13/20] appended signatures: Using db and dbx li... | DROP | Older version | 2025-10-0142 |
| 2025-08-0134 | [PATCH v8 12/20] appended signatures: Create db and dbx l... | DROP | Older version | 2025-10-0156 |
| 2025-08-0135 | [PATCH v8 14/20] powerpc_ieee1275: Introduce use_static_k... | DROP | Older version | 2025-10-0142 |
| 2025-08-0136 | [PATCH v8 15/20] appended signatures: Read default db key... | DROP | Older version | 2025-10-0142 |
| 2025-08-0137 | [PATCH v8 16/20] appended signatures: Introduce GRUB comm... | DROP | Older version | 2025-10-0142 |
| 2025-08-0138 | [PATCH v8 17/20] appended signatures: Verification tests | DROP | Older version | 2025-10-0160 |
| 2025-08-0139 | [PATCH v8 18/20] docs/grub: Document signing GRUB under UEFI | DROP | Older version | 2025-10-0159 |
| 2025-08-0140 | [PATCH v8 20/20] docs/grub: Document appended signature | DROP | Older version | 2025-10-0161 |
| 2025-08-0141 | [PATCH v8 19/20] docs/grub: Document signing GRUB with an... | DROP | Older version | 2025-10-0162 |
| 2025-08-0146 | Re: [PATCH v2 2/9] crypto: Update crypto.h for libgcrypt ... | KEEP | | |
| 2025-08-0147 | Re: [PATCH v2 1/9] util/import_gcry: Import kdf.c for Argon2 | KEEP | | |
| 2025-08-0148 | Re: [PATCH v2 4/9] argon2: Introduce grub_crypto_argon2() | DROP | Reply only |  |
| 2025-08-0149 | Re: [PATCH v2 5/9] Import Argon2 tests from libgcrypt | DROP | Reply only |  |
| 2025-08-0150 | Re: [PATCH v2 6/9] Integrate Argon2 tests into functional... | DROP | Reply only |  |
| 2025-08-0151 | Re: [PATCH v2 7/9] disk/luks2: Add Argon2 support | DROP | Reply only |  |
| 2025-08-0152 | Re: [PATCH v2 8/9] tests/util/grub-fs-tester: Use Argon2i... | DROP | Reply only |  |
| 2025-08-0153 | Re: [PATCH v2 9/9] docs: Document argon2 and argon2_test | KEEP | | |
| 2025-08-0162 | [PATCH 1/1] po: Update Translations to Build with Gettext... | DROP | Already in master |  |
| 2025-08-0164 | Re: [PATCH 1/1] po: Update Translations to Build with Get... | KEEP | | |
| 2025-08-0167 | [PATCH 1/1] bootstrap: Ensure shallow GNULIB clone Works ... | KEEP | | |
| 2025-08-0173 | [PATCH 1/2] INSTALL: Document Libtasn1 Needed for grub-pr... | KEEP | | |
| 2025-08-0174 | [PATCH 2/2] BUGS: Update to Point to Bug Tracking System | KEEP | | |
| 2025-08-0176 | [PATCH v2 1/1] bootstrap: Ensure shallow GNULIB clone Wor... | DROP | Already in master |  |
| 2025-08-0178 | [PATCH 1/3] tests: Split ZFS ZSTD Test Into New File | DROP | Older version | 2025-11-0104 |
| 2025-08-0179 | [PATCH 2/3] tests: Avoid Test Failure in erofs for label ... | DROP | Already in master | 2025-11-0106 |
| 2025-08-0180 | [PATCH 3/3] tests: Support Changed mkfs.ext2 Behavior for... | DROP | Older version | 2025-11-0105 |
| 2025-08-0182 | [PATCH 3/4] docs: Update Future Section to Reflect Curren... | KEEP | | |
| 2025-08-0183 | [PATCH 1/4] docs: Clarify Section Heading and Fix Wording | DROP | Already in master |  |
| 2025-08-0184 | [PATCH 2/4] docs: Document New libgrypt Modules | KEEP | | |
| 2025-08-0185 | [PATCH 4/4] docs: Correct Some URLs | KEEP | | |
| 2025-08-0186 | Re: [PATCH 1/3] tests: Split ZFS ZSTD Test Into New File | DROP | Reply only |  |
| 2025-08-0188 | [PATCH v9 02/21] crypto: Move storage for grub_crypto_pk_... | DROP | Already in master |  |
| 2025-08-0189 | [PATCH v9 01/21] powerpc-ieee1275: Add support for signin... | DROP | Older version | 2025-10-0142 |
| 2025-08-0190 | [PATCH v9 03/21] pgp: Rename OBJ_TYPE_PUBKEY to OBJ_TYPE_... | DROP | Older version | 2025-10-0145 |
| 2025-08-0191 | [PATCH v9 04/21] grub-install: Support embedding x509 cer... | DROP | Already in master |  |
| 2025-08-0192 | [PATCH v9 05/21] appended signatures: Import GNUTLS's ASN.1 | DROP | Already in master |  |
| 2025-08-0193 | [PATCH v9 06/21] appended signatures: Parse ASN1 node | DROP | Older version | 2025-10-0148 |
| 2025-08-0194 | [PATCH v9 07/21] appended signatures: Parse PKCS#7 signed... | KEEP | | |
| 2025-08-0195 | [PATCH v9 09/21] powerpc_ieee1275: Enter lockdown based o... | DROP | Older version | 2025-10-0150 |
| 2025-08-0196 | [PATCH v9 08/21] appended signatures: Parse X.509 certifi... | KEEP | | |
| 2025-08-0197 | [PATCH v9 10/21] appended signatures: Support verifying a... | DROP | Older version | 2025-10-0151 |
| 2025-08-0198 | [PATCH v9 14/21] appended signatures: Using db and dbx li... | KEEP | | |
| 2025-08-0199 | [PATCH v9 15/21] powerpc_ieee1275: Introduce use_static_k... | KEEP | | |
| 2025-08-0200 | [PATCH v9 11/21] appended signatures: Introducting GRUB c... | KEEP | | |
| 2025-08-0201 | [PATCH v9 12/21] powerpc_ieee1275: Read the db and dbx se... | KEEP | | |
| 2025-08-0202 | [PATCH v9 13/21] appended signatures: Create db and dbx l... | DROP | Older version | 2025-10-0156 |
| 2025-08-0203 | [PATCH v9 16/21] appended signatures: Read default db key... | KEEP | | |
| 2025-08-0204 | [PATCH v9 17/21] appended signatures: Introduce GRUB comm... | KEEP | | |
| 2025-08-0205 | [PATCH v9 18/21] appended signatures: Verification tests | KEEP | | |
| 2025-08-0206 | [PATCH v9 20/21] docs/grub: Document signing GRUB with an... | KEEP | | |
| 2025-08-0207 | [PATCH v9 19/21] docs/grub: Document signing GRUB under UEFI | KEEP | | |
| 2025-08-0208 | [PATCH v9 21/21] docs/grub: Document appended signature | KEEP | | |
| 2025-08-0209 | Re: [PATCH 1/3] tests: Split ZFS ZSTD Test Into New File | DROP | Reply only |  |
| 2025-08-0223 | [PATCH v2 2/3] tests: Avoid Test Failure in erofs for lab... | DROP | Already in master | 2025-11-0029 |
| 2025-08-0224 | [PATCH v2 1/3] tests: Split ZFS ZSTD Test Into New File | DROP | Older version | 2025-11-0104 |
| 2025-08-0225 | [PATCH v2 3/3] tests: Support Changed mkfs.ext2 Behavior ... | DROP | Older version | 2025-11-0105 |
| 2025-08-0226 | [PATCH v3 01/12] util/import_gcry: Import kdf.c for Argon2 | DROP | Already in master | 2025-10-0234 |
| 2025-08-0228 | [PATCH v3 04/12] libgcrypt/kdf: Get rid of gpg_err_code_f... | DROP | Older version | 2025-10-0237 |
| 2025-08-0229 | [PATCH v3 05/12] libgcrypt/kdf: Remove unsupported KDFs | DROP | Older version | 2025-10-0242 |
| 2025-08-0230 | [PATCH v3 03/12] libgcrypt/kdf: Implement blake2b_512.has... | DROP | Older version | 2025-10-0234 |
| 2025-08-0231 | [PATCH v3 09/12] Integrate Argon2 tests into functional_test | DROP | Older version | 2025-10-0245 |
| 2025-08-0232 | [PATCH v3 02/12] crypto: Update crypto.h for libgcrypt KD... | DROP | Already in master | 2025-10-0234 |
| 2025-08-0233 | [PATCH v3 12/12] docs: Document argon2 and argon2_test | DROP | Already in master | 2025-10-0234 |
| 2025-08-0234 | [PATCH v3 06/12] libgcrypt/kdf: Fix 64-bit modulus on 32-... | DROP | Older version | 2025-10-0239 |
| 2025-08-0235 | [PATCH v3 07/12] argon2: Introduce grub_crypto_argon2() | DROP | Older version | 2025-10-0235 |
| 2025-08-0236 | [PATCH v3 11/12] tests/util/grub-fs-tester: Use Argon2id ... | DROP | Older version | 2025-10-0243 |
| 2025-08-0237 | [PATCH v3 08/12] Import Argon2 tests from libgcrypt | DROP | Older version | 2025-10-0240 |
| 2025-08-0238 | [PATCH v3 10/12] disk/luks2: Add Argon2 support | DROP | Already in master | 2025-10-0234 |
| 2025-08-0239 | [PATCH v4 1/2] datetime: Support dates outside of 1901..2... | DROP | Older version | 2025-08-0267 |
| 2025-08-0240 | [PATCH v4 2/2] date_unit_test: test dates outside of 32-b... | DROP | Older version | 2025-08-0267 |
| 2025-08-0251 | [PATCH v3 1/3] tests: Split ZFS ZSTD Test Into New File | DROP | Older version | 2025-11-0104 |
| 2025-08-0252 | [PATCH v3 2/3] tests: Avoid Test Failure in erofs for lab... | DROP | Already in master | 2025-11-0106 |
| 2025-08-0253 | [PATCH v3 3/3] tests: Support Changed mkfs.ext2 Behavior ... | DROP | Older version | 2025-11-0105 |
| 2025-08-0255 | [PATCH v5 1/2] datetime: Support dates outside of 1901..2... | DROP | Older version | 2025-08-0267 |
| 2025-08-0256 | [PATCH v5 2/2] date_unit_test: test dates outside of 32-b... | DROP | Older version | 2025-08-0267 |
| 2025-08-0267 | [PATCH v6 1/2] datetime: Support dates outside of 1901..2... | KEEP | | |
| 2025-08-0268 | [PATCH v6 2/2] date_unit_test: test dates outside of 32-b... | DROP | Already in master |  |
| 2025-08-0277 | [PATCH] libgcrypt: Allow GRUB to Build With Clang | KEEP | | |
| 2025-08-0280 | [PATCH] tests: Add test ISO files to Dist Package | DROP | Already in master |  |

### 2025-09 (160 branches: 18 remain, 142 drop)

| Branch | Subject | Decision | Reason | Superseded by |
|--------|---------|----------|--------|---------------|
| 2025-09-0004 | [PATCH v3 1/7] tss2: Add TPM2_PCR_Event command | DROP | Older version | 2025-10-0092 |
| 2025-09-0005 | [PATCH v3 2/7] tss2: Introduce grub_tcg2_cap_pcr() | KEEP | | |
| 2025-09-0006 | [PATCH v3 3/7] tss2: Implement grub_tcg2_cap_pcr() for EFI | KEEP | | |
| 2025-09-0007 | [PATCH v3 5/7] tss2: Implement grub_tcg2_cap_pcr() for EMU | DROP | Already in master |  |
| 2025-09-0008 | [PATCH v3 4/7] tss2: Implement grub_tcg2_cap_pcr() for ie... | DROP | Older version | 2025-10-0094 |
| 2025-09-0009 | [PATCH v3 6/7] tpm2_key_protector: Support PCR capping | DROP | Older version | 2025-10-0097 |
| 2025-09-0010 | [PATCH v3 7/7] tests/tpm2_key_protector_test: Add a test ... | DROP | Already in master |  |
| 2025-09-0012 | [PATCH 1/8] util/grub-editenv: add basic structures and p... | DROP | Older version | 2025-09-0127 |
| 2025-09-0013 | [PATCH 3/8] util/grub-editenv: add fs_envblk write helper | DROP | Older version | 2025-10-0296 |
| 2025-09-0014 | [PATCH 6/8] util/grub-editenv: wire list_variables to opt... | DROP | Older version | 2025-10-0271 |
| 2025-09-0015 | [PATCH 2/8] util/grub-editenv: add fs_envblk open helper | DROP | Older version | 2025-10-0294 |
| 2025-09-0016 | [PATCH 8/8] 00_header.in: wire grub.cfg to use env_block ... | DROP | Already in master | 2025-09-0136 |
| 2025-09-0017 | [PATCH 4/8] util/grub-editenv: wire set_variables to opti... | DROP | Older version | 2025-10-0297 |
| 2025-09-0018 | [PATCH 5/8] util/grub-editenv: wire unset_variables to op... | DROP | Older version | 2025-10-0299 |
| 2025-09-0019 | [PATCH 7/8] btrfs: add environment block to reserved head... | DROP | Older version | 2025-10-0266 |
| 2025-09-0020 | [PATCH v2] tcp: Fix TCP port number reused on reboot | KEEP | | |
| 2025-09-0022 | [PATCH v4 03/13] libgcrypt/kdf: Implement blake2b_512.has... | KEEP | | |
| 2025-09-0023 | [PATCH v4 02/13] crypto: Update crypto.h for libgcrypt KD... | DROP | Already in master |  |
| 2025-09-0024 | [PATCH v4 04/13] libgcrypt/kdf: Get rid of gpg_err_code_f... | DROP | Older version | 2025-10-0237 |
| 2025-09-0025 | [PATCH v4 01/13] util/import_gcry: Import kdf.c for Argon2 | DROP | Already in master |  |
| 2025-09-0026 | [PATCH v4 05/13] libgcrypt/kdf: Remove unsupported KDFs | DROP | Older version | 2025-10-0242 |
| 2025-09-0027 | [PATCH v4 06/13] libgcrypt/kdf: Fix 64-bit modulus on 32-... | DROP | Older version | 2025-10-0239 |
| 2025-09-0028 | [PATCH v4 07/13] argon2: Introduce grub_crypto_argon2() | DROP | Older version | 2025-10-0235 |
| 2025-09-0029 | [PATCH v4 08/13] Import Argon2 tests from libgcrypt | DROP | Resend | 2025-10-0240 |
| 2025-09-0030 | [PATCH v4 09/13] Integrate Argon2 tests into functional_test | DROP | Resend | 2025-10-0245 |
| 2025-09-0031 | [PATCH v4 10/13] disk/luks2: Add Argon2 support | DROP | Already in master |  |
| 2025-09-0032 | [PATCH v4 11/13] tests/util/grub-fs-tester: Use Argon2id ... | DROP | Older version | 2025-10-0243 |
| 2025-09-0033 | [PATCH v4 12/13] docs: Document argon2 and argon2_test | DROP | Already in master |  |
| 2025-09-0034 | [PATCH v4 13/13] kern/misc: Implement faster grub_memcpy(... | DROP | Older version | 2025-10-0247 |
| 2025-09-0036 | [PATCH] util/grub-image: fix riscv32 relocation offset | KEEP | | |
| 2025-09-0037 | [PATCH v2] lsefi: fixed memory leaks | KEEP | | |
| 2025-09-0038 | [PATCH] b64dec: use grub_size_t for function definition | DROP | Already in master |  |
| 2025-09-0065 | [PATCH] docs: Add Security Hardening Suggestions | DROP | Older version | 2025-11-0032 |
| 2025-09-0073 | [PATCH] kern: perform NULL check in unregister paths (com... | KEEP | | |
| 2025-09-0076 | [PATCH v2] kern: perform NULL check in unregister paths | DROP | Already in master |  |
| 2025-09-0078 | [PATCH 01/10] Tweak autoconf/automake files to detect x86... | KEEP | | |
| 2025-09-0079 | [PATCH 02/10] lib/hwfeatures-gcry: Introduce functions to... | DROP | Older version | 2025-10-0331 |
| 2025-09-0080 | [PATCH 04/10] libgcrypt: Copy sha256 x86_64 assembly files | DROP | Older version | 2025-10-0333 |
| 2025-09-0081 | [PATCH 05/10] libgcrypt: Copy sha512 x86_64 assembly files | DROP | Already in master |  |
| 2025-09-0082 | [PATCH 03/10] lib/hwfeatures-gcry: Enable SSE and AVX for... | DROP | Older version | 2025-10-0332 |
| 2025-09-0083 | [PATCH 06/10] libgcrypt: Implement _gcry_get_hw_features() | DROP | Older version | 2025-10-0335 |
| 2025-09-0084 | [PATCH 07/10] libgcrypt: Declare the sha256 shaext function | DROP | Older version | 2025-10-0336 |
| 2025-09-0085 | [PATCH 08/10] libgcrypt: Add hardware acceleration for gc... | DROP | Older version | 2025-10-0337 |
| 2025-09-0086 | [PATCH 09/10] libgcrypt: Add hardware acceleration for gc... | DROP | Already in master |  |
| 2025-09-0087 | [PATCH 10/10] disk/cryptodisk: Add '--hw-accel' to enable... | KEEP | | |
| 2025-09-0091 | [PATCH v10 01/22] powerpc-ieee1275: Add support for signi... | DROP | Older version | 2025-10-0142 |
| 2025-09-0092 | [PATCH v10 02/22] crypto: Move storage for grub_crypto_pk... | DROP | Already in master | 2025-10-0143 |
| 2025-09-0093 | [PATCH v10 03/22] pgp: Rename OBJ_TYPE_PUBKEY to OBJ_TYPE... | DROP | Older version | 2025-10-0145 |
| 2025-09-0094 | [PATCH v10 04/22] grub-install: Support embedding x509 ce... | DROP | Already in master | 2025-10-0143 |
| 2025-09-0095 | [PATCH v10 05/22] appended signatures: Import GNUTLS's ASN.1 | DROP | Already in master | 2025-10-0143 |
| 2025-09-0096 | [PATCH v10 06/22] appended signatures: Parse ASN1 node | DROP | Older version | 2025-10-0148 |
| 2025-09-0097 | [PATCH v10 07/22] appended signatures: Parse PKCS#7 signe... | DROP | Older version | 2025-10-0149 |
| 2025-09-0098 | [PATCH v10 11/22] powerpc_ieee1275: Read the db and dbx s... | DROP | Older version | 2025-10-0152 |
| 2025-09-0099 | [PATCH v10 10/22] appended signatures: Support verifying ... | DROP | Older version | 2025-10-0143 |
| 2025-09-0100 | [PATCH v10 12/22] appended signatures: Introducing key ma... | DROP | Older version | 2025-10-0153 |
| 2025-09-0101 | [PATCH v10 20/22] docs/grub: Document signing GRUB under ... | DROP | Older version | 2025-10-0159 |
| 2025-09-0102 | [PATCH v10 09/22] powerpc_ieee1275: Enter lockdown based ... | DROP | Older version | 2025-10-0150 |
| 2025-09-0103 | [PATCH v10 14/22] appended signatures: Using db and dbx l... | DROP | Older version | 2025-10-0142 |
| 2025-09-0104 | [PATCH v10 15/22] appended signatures: GRUB commands to m... | DROP | Older version | 2025-10-0157 |
| 2025-09-0105 | [PATCH v10 17/22] appended signatures: Read default db ke... | DROP | Older version | 2025-10-0142 |
| 2025-09-0106 | [PATCH v10 21/22] docs/grub: Document signing GRUB with a... | DROP | Older version | 2025-10-0162 |
| 2025-09-0107 | [PATCH v10 08/22] appended signatures: Parse X.509 certif... | DROP | Older version | 2025-10-0142 |
| 2025-09-0108 | [PATCH v10 13/22] appended signatures: Create db and dbx ... | DROP | Older version | 2025-10-0156 |
| 2025-09-0109 | [PATCH v10 16/22] powerpc_ieee1275: Introduce use_static_... | DROP | Older version | 2025-10-0142 |
| 2025-09-0110 | [PATCH v10 18/22] appended signatures: GRUB commands to m... | DROP | Older version | 2025-10-0158 |
| 2025-09-0111 | [PATCH v10 19/22] appended signatures: Verification tests | DROP | Older version | 2025-10-0160 |
| 2025-09-0112 | [PATCH v10 22/22] docs/grub: Document appended signature | DROP | Older version | 2025-10-0161 |
| 2025-09-0115 | [RFC PATCH 1/2] target/i386: add compatibility property for | KEEP | | |
| 2025-09-0116 | [RFC PATCH 2/2] target/i386: add compatibility property f... | KEEP | | |
| 2025-09-0119 | [PATCH] tests: Extend pbkdf2_test to cover HMAC-SHA{256, ... | DROP | Already in master | 2025-09-0258 |
| 2025-09-0127 | [PATCH v2 1/9] util/grub-editenv: add basic structures an... | KEEP | | |
| 2025-09-0129 | [PATCH v2 2/9] util/grub-editenv: add fs_envblk open helper | DROP | Resend | 2025-10-0294 |
| 2025-09-0130 | [PATCH v2 3/9] util/grub-editenv: add fs_envblk write helper | DROP | Resend | 2025-10-0296 |
| 2025-09-0131 | [PATCH v2 4/9] util/grub-editenv: wire set_variables to o... | DROP | Resend | 2025-10-0297 |
| 2025-09-0132 | [PATCH v2 5/9] util/grub-editenv: wire unset_variables to... | DROP | Resend | 2025-10-0299 |
| 2025-09-0133 | [PATCH v2 7/9] btrfs: add environment block to reserved h... | DROP | Resend | 2025-10-0266 |
| 2025-09-0134 | [PATCH v2 6/9] util/grub-editenv: wire list_variables to ... | DROP | Resend | 2025-10-0271 |
| 2025-09-0135 | [PATCH v2 9/9] docs: add Btrfs env block and special env ... | KEEP | | |
| 2025-09-0136 | [PATCH v2 8/9] 00_header.in: wire grub.cfg to use env_blo... | DROP | Already in master |  |
| 2025-09-0138 | [PATCH v11 02/22] crypto: Move storage for grub_crypto_pk... | DROP | Already in master | 2025-10-0120 |
| 2025-09-0139 | [PATCH v11 01/22] powerpc-ieee1275: Add support for signi... | DROP | Older version | 2025-10-0142 |
| 2025-09-0140 | [PATCH v11 03/22] pgp: Rename OBJ_TYPE_PUBKEY to OBJ_TYPE... | DROP | Older version | 2025-10-0145 |
| 2025-09-0142 | [PATCH v11 05/22] appended signatures: Import GNUTLS's ASN.1 | DROP | Already in master | 2025-10-0120 |
| 2025-09-0143 | [PATCH v11 04/22] grub-install: Support embedding x509 ce... | DROP | Already in master | 2025-10-0120 |
| 2025-09-0144 | [PATCH v11 06/22] appended signatures: Parse ASN1 node | DROP | Older version | 2025-10-0148 |
| 2025-09-0145 | [PATCH v11 08/22] appended signatures: Parse X.509 certif... | DROP | Older version | 2025-10-0120 |
| 2025-09-0146 | [PATCH v11 09/22] powerpc_ieee1275: Enter lockdown based ... | DROP | Older version | 2025-10-0150 |
| 2025-09-0147 | [PATCH v11 07/22] appended signatures: Parse PKCS#7 signe... | DROP | Older version | 2025-10-0149 |
| 2025-09-0148 | [PATCH v11 10/22] appended signatures: Support verifying ... | DROP | Older version | 2025-10-0120 |
| 2025-09-0149 | [PATCH v11 11/22] powerpc_ieee1275: Read the db and dbx s... | DROP | Older version | 2025-10-0152 |
| 2025-09-0150 | [PATCH v11 12/22] appended signatures: Introducing key ma... | DROP | Older version | 2025-10-0153 |
| 2025-09-0151 | [PATCH v11 13/22] appended signatures: Create db and dbx ... | DROP | Older version | 2025-10-0156 |
| 2025-09-0152 | [PATCH v11 14/22] appended signatures: Using db and dbx l... | DROP | Older version | 2025-10-0120 |
| 2025-09-0153 | [PATCH v11 15/22] appended signatures: GRUB commands to m... | DROP | Older version | 2025-10-0157 |
| 2025-09-0154 | [PATCH v11 16/22] powerpc_ieee1275: Introduce use_static_... | DROP | Older version | 2025-10-0120 |
| 2025-09-0155 | [PATCH v11 17/22] appended signatures: Read default db ke... | DROP | Older version | 2025-10-0120 |
| 2025-09-0156 | [PATCH v11 19/22] appended signatures: Verification tests | DROP | Older version | 2025-10-0160 |
| 2025-09-0157 | [PATCH v11 20/22] docs/grub: Document signing GRUB under ... | DROP | Older version | 2025-10-0159 |
| 2025-09-0158 | [PATCH v11 18/22] appended signatures: GRUB commands to m... | DROP | Older version | 2025-10-0158 |
| 2025-09-0159 | [PATCH v11 22/22] docs/grub: Document appended signature | DROP | Older version | 2025-10-0161 |
| 2025-09-0160 | [PATCH v11 21/22] docs/grub: Document signing GRUB with a... | DROP | Older version | 2025-10-0162 |
| 2025-09-0162 | [PATCH] docs/grub.texi: Fix build warnings in libgcrypt a... | DROP | Already in master |  |
| 2025-09-0168 | [PATCH] loader/i386/linux: Transfer EDID information to k... | DROP | Older version | 2025-10-0044 |
| 2025-09-0175 | [PATCH v1] docs/grub.texi: Fix build warnings in libgcryp... | DROP | Already in master |  |
| 2025-09-0189 | [PATCH 2/3] tests: include verbosity on tests.in checks | KEEP | | |
| 2025-09-0195 | [PATCH] efi/tpm: call get_active_pcr_banks() only with TC... | KEEP | | |
| 2025-09-0197 | [PATCH v3] command/extcmd: perform explicit NULL check in... | DROP | Already in master |  |
| 2025-09-0199 | [PATCH v12 01/22] powerpc-ieee1275: Add support for signi... | DROP | Older version | 2025-10-0142 |
| 2025-09-0200 | [PATCH v12 03/22] pgp: Rename OBJ_TYPE_PUBKEY to OBJ_TYPE... | DROP | Older version | 2025-10-0145 |
| 2025-09-0201 | [PATCH v12 04/22] grub-install: Support embedding x509 ce... | DROP | Already in master | 2025-10-0143 |
| 2025-09-0202 | [PATCH v12 05/22] appended signatures: Import GNUTLS's ASN.1 | DROP | Already in master | 2025-10-0143 |
| 2025-09-0203 | [PATCH v12 06/22] appended signatures: Parse ASN1 node | DROP | Older version | 2025-10-0148 |
| 2025-09-0204 | [PATCH v12 02/22] crypto: Move storage for grub_crypto_pk... | DROP | Already in master | 2025-10-0143 |
| 2025-09-0205 | [PATCH v12 08/22] appended signatures: Parse X.509 certif... | DROP | Older version | 2025-10-0142 |
| 2025-09-0206 | [PATCH v12 07/22] appended signatures: Parse PKCS#7 signe... | DROP | Older version | 2025-10-0149 |
| 2025-09-0207 | [PATCH v12 10/22] appended signatures: Support verifying ... | DROP | Older version | 2025-10-0143 |
| 2025-09-0208 | [PATCH v12 12/22] appended signatures: Introducing key ma... | DROP | Older version | 2025-10-0153 |
| 2025-09-0209 | [PATCH v12 09/22] powerpc_ieee1275: Enter lockdown based ... | DROP | Older version | 2025-10-0150 |
| 2025-09-0210 | [PATCH v12 11/22] powerpc_ieee1275: Read the db and dbx s... | DROP | Older version | 2025-10-0152 |
| 2025-09-0211 | [PATCH v12 13/22] appended signatures: Create db and dbx ... | DROP | Older version | 2025-10-0156 |
| 2025-09-0212 | [PATCH v12 14/22] appended signatures: Using db and dbx l... | DROP | Older version | 2025-10-0142 |
| 2025-09-0213 | [PATCH v12 17/22] appended signatures: Read default db ke... | DROP | Older version | 2025-10-0142 |
| 2025-09-0214 | [PATCH v12 15/22] appended signatures: GRUB commands to m... | DROP | Older version | 2025-10-0157 |
| 2025-09-0215 | [PATCH v12 16/22] powerpc_ieee1275: Introduce use_static_... | DROP | Older version | 2025-10-0142 |
| 2025-09-0216 | [PATCH v12 18/22] appended signatures: GRUB commands to m... | DROP | Older version | 2025-10-0158 |
| 2025-09-0217 | [PATCH v12 19/22] appended signatures: Verification tests | DROP | Older version | 2025-10-0160 |
| 2025-09-0218 | [PATCH v12 20/22] docs/grub: Document signing GRUB under ... | DROP | Older version | 2025-10-0159 |
| 2025-09-0219 | [PATCH v12 21/22] docs/grub: Document signing GRUB with a... | DROP | Older version | 2025-10-0162 |
| 2025-09-0220 | [PATCH v12 22/22] docs/grub: Document appended signature | DROP | Older version | 2025-10-0161 |
| 2025-09-0225 | [PATCH 3/4] tests/file_filter: Add zstd test file | DROP | Already in master | 2025-10-0323 |
| 2025-09-0226 | [PATCH 4/4] tests/file_filter: Add zstd tests | DROP | Already in master | 2025-10-0323 |
| 2025-09-0227 | [PATCH 2/4] tests/file_filter: Regenerate gpg keys | DROP | Already in master | 2025-10-0323 |
| 2025-09-0229 | [PATCH 1/4] io: Implement zstdio decompression | DROP | Older version | 2025-10-0324 |
| 2025-09-0230 | [PATCH v2 2/2] Include function name on debug and error p... | KEEP | | |
| 2025-09-0231 | [PATCH v2 1/2] Make grub_error() more verbose | DROP | Resend | 2025-09-0237 |
| 2025-09-0237 | Re: [PATCH v2 1/2] Make grub_error() more verbose | KEEP | | |
| 2025-09-0238 | [PATCH v1 1/1] Hint missing zstd support for PvGrub2 "not... | KEEP | | |
| 2025-09-0244 | Re: [PATCH v2 1/2] Make grub_error() more verbose | DROP | Reply only |  |
| 2025-09-0250 | [PATCH] memtools: add lsmemregions command | DROP | Older version | 2025-10-0328 |
| 2025-09-0258 | [PATCH v2] tests: Extend pbkdf2_test to cover HMAC-SHA{25... | DROP | Already in master |  |
| 2025-09-0268 | [PATCH v13 02/20] crypto: Move storage for grub_crypto_pk... | DROP | Already in master | 2025-10-0120 |
| 2025-09-0269 | [PATCH v13 06/20] appended signatures: Parse ASN1 node | DROP | Older version | 2025-10-0148 |
| 2025-09-0270 | [PATCH v13 07/20] appended signatures: Parse PKCS#7 signe... | DROP | Older version | 2025-10-0149 |
| 2025-09-0271 | [PATCH v13 04/20] grub-install: Support embedding x509 ce... | DROP | Already in master | 2025-10-0120 |
| 2025-09-0272 | [PATCH v13 01/20] powerpc-ieee1275: Add support for signi... | DROP | Older version | 2025-10-0142 |
| 2025-09-0274 | [PATCH v13 03/20] pgp: Rename OBJ_TYPE_PUBKEY to OBJ_TYPE... | DROP | Older version | 2025-10-0145 |
| 2025-09-0275 | [PATCH v13 05/20] appended signatures: Import GNUTLS's ASN.1 | DROP | Already in master | 2025-10-0120 |
| 2025-09-0276 | [PATCH v13 08/20] appended signatures: Parse X.509 certif... | DROP | Already in master | 2025-10-0120 |
| 2025-09-0277 | [PATCH v13 09/20] powerpc_ieee1275: Enter lockdown based ... | DROP | Older version | 2025-10-0150 |
| 2025-09-0278 | [PATCH v13 10/20] appended signatures: Support verifying ... | DROP | Older version | 2025-10-0120 |
| 2025-09-0279 | [PATCH v13 11/20] powerpc_ieee1275: Read the db and dbx s... | DROP | Older version | 2025-10-0152 |
| 2025-09-0280 | [PATCH v13 13/20] appended signatures: Create db and dbx ... | DROP | Older version | 2025-10-0156 |
| 2025-09-0281 | [PATCH v13 15/20] appended signatures: GRUB commands to m... | DROP | Older version | 2025-10-0157 |
| 2025-09-0282 | [PATCH v13 12/20] appended signatures: Introducing key ma... | DROP | Older version | 2025-10-0120 |
| 2025-09-0283 | [PATCH v13 14/20] appended signatures: Using db and dbx l... | DROP | Already in master | 2025-10-0120 |
| 2025-09-0284 | [PATCH v13 16/20] appended signatures: GRUB commands to m... | DROP | Older version | 2025-10-0158 |
| 2025-09-0285 | [PATCH v13 17/20] appended signatures: Verification tests | DROP | Older version | 2025-10-0160 |
| 2025-09-0286 | [PATCH v13 18/20] docs/grub: Document signing GRUB under ... | DROP | Older version | 2025-10-0159 |
| 2025-09-0287 | [PATCH v13 19/20] docs/grub: Document signing GRUB with a... | DROP | Older version | 2025-10-0162 |
| 2025-09-0288 | [PATCH v13 20/20] docs/grub: Document appended signature | DROP | Older version | 2025-10-0161 |

### 2025-10 (221 branches: 53 remain, 168 drop)

| Branch | Subject | Decision | Reason | Superseded by |
|--------|---------|----------|--------|---------------|
| 2025-10-0006 | [PATCH] hfsplus: Allow reading files created by Mac OS 9 | KEEP | | |
| 2025-10-0009 | [PATCH v3 2/9] util/grub-editenv: add fs_envblk open helper | DROP | Older version | 2025-10-0294 |
| 2025-10-0011 | [PATCH v3 6/9] util/grub-editenv: wire list_variables to ... | DROP | Older version | 2025-10-0294 |
| 2025-10-0012 | [PATCH v3 7/9] btrfs: add environment block to reserved h... | DROP | Older version | 2025-10-0294 |
| 2025-10-0013 | [PATCH v3 8/9] 00_header.in: wire grub.cfg to use env_blo... | DROP | Already in master | 2025-10-0295 |
| 2025-10-0014 | [PATCH v3 1/9] util/grub-editenv: add basic structures an... | DROP | Older version | 2025-10-0294 |
| 2025-10-0015 | [PATCH v3 5/9] util/grub-editenv: wire unset_variables to... | DROP | Older version | 2025-10-0299 |
| 2025-10-0016 | [PATCH v3 3/9] util/grub-editenv: add fs_envblk write helper | DROP | Older version | 2025-10-0296 |
| 2025-10-0017 | [PATCH v3 4/9] util/grub-editenv: wire set_variables to o... | DROP | Older version | 2025-10-0297 |
| 2025-10-0018 | [PATCH v3 9/9] docs: add Btrfs env block and special env ... | DROP | Older version | 2025-10-0304 |
| 2025-10-0023 | [PATCH v14 02/20] crypto: Move storage for grub_crypto_pk... | DROP | Already in master | 2025-10-0120 |
| 2025-10-0025 | [PATCH v14 01/20] powerpc-ieee1275: Add support for signi... | DROP | Older version | 2025-10-0142 |
| 2025-10-0026 | [PATCH v14 04/20] grub-install: Support embedding x509 ce... | DROP | Already in master | 2025-10-0120 |
| 2025-10-0027 | [PATCH v14 03/20] pgp: Rename OBJ_TYPE_PUBKEY to OBJ_TYPE... | DROP | Older version | 2025-10-0145 |
| 2025-10-0028 | [PATCH v14 07/20] appended signatures: Parse PKCS#7 signe... | DROP | Older version | 2025-10-0149 |
| 2025-10-0029 | [PATCH v14 05/20] appended signatures: Import GNUTLS's ASN.1 | DROP | Already in master | 2025-10-0120 |
| 2025-10-0030 | [PATCH v14 06/20] appended signatures: Parse ASN1 node | DROP | Older version | 2025-10-0148 |
| 2025-10-0031 | [PATCH v14 08/20] appended signatures: Parse X.509 certif... | DROP | Already in master | 2025-10-0120 |
| 2025-10-0032 | [PATCH v14 09/20] powerpc_ieee1275: Enter lockdown based ... | DROP | Older version | 2025-10-0150 |
| 2025-10-0033 | [PATCH v14 11/20] powerpc_ieee1275: Read the db and dbx s... | DROP | Older version | 2025-10-0152 |
| 2025-10-0034 | [PATCH v14 10/20] appended signatures: Support verifying ... | DROP | Older version | 2025-10-0151 |
| 2025-10-0035 | [PATCH v14 12/20] appended signatures: Introducing key ma... | DROP | Older version | 2025-10-0153 |
| 2025-10-0036 | [PATCH v14 13/20] appended signatures: Create db and dbx ... | DROP | Older version | 2025-10-0156 |
| 2025-10-0037 | [PATCH v14 14/20] appended signatures: Using db and dbx l... | DROP | Already in master | 2025-10-0120 |
| 2025-10-0038 | [PATCH v14 15/20] appended signatures: GRUB commands to m... | DROP | Older version | 2025-10-0157 |
| 2025-10-0039 | [PATCH v14 16/20] appended signatures: GRUB commands to m... | DROP | Older version | 2025-10-0158 |
| 2025-10-0040 | [PATCH v14 18/20] docs/grub: Document signing GRUB under ... | DROP | Older version | 2025-10-0159 |
| 2025-10-0041 | [PATCH v14 17/20] appended signatures: Verification tests | DROP | Older version | 2025-10-0160 |
| 2025-10-0042 | [PATCH v14 19/20] docs/grub: Document signing GRUB with a... | DROP | Older version | 2025-10-0162 |
| 2025-10-0043 | [PATCH v14 20/20] docs/grub: Document appended signature | DROP | Older version | 2025-10-0161 |
| 2025-10-0044 | [PATCH v2] loader/i386/linux: Transfer EDID information t... | KEEP | | |
| 2025-10-0065 | [PATCH v15 02/20] crypto: Move storage for grub_crypto_pk... | DROP | Already in master | 2025-10-0120 |
| 2025-10-0066 | [PATCH v15 01/20] powerpc-ieee1275: Add support for signi... | DROP | Older version | 2025-10-0142 |
| 2025-10-0067 | [PATCH v15 04/20] grub-install: Support embedding x509 ce... | DROP | Already in master | 2025-10-0120 |
| 2025-10-0068 | [PATCH v15 03/20] pgp: Rename OBJ_TYPE_PUBKEY to OBJ_TYPE... | DROP | Older version | 2025-10-0145 |
| 2025-10-0069 | [PATCH v15 05/20] appended signatures: Import GNUTLS's ASN.1 | DROP | Already in master | 2025-10-0120 |
| 2025-10-0070 | [PATCH v15 06/20] appended signatures: Parse ASN1 node | DROP | Older version | 2025-10-0148 |
| 2025-10-0071 | [PATCH v15 07/20] appended signatures: Parse PKCS#7 signe... | DROP | Older version | 2025-10-0149 |
| 2025-10-0072 | [PATCH v15 09/20] powerpc_ieee1275: Enter lockdown based ... | DROP | Older version | 2025-10-0150 |
| 2025-10-0073 | [PATCH v15 08/20] appended signatures: Parse X.509 certif... | DROP | Already in master | 2025-10-0120 |
| 2025-10-0074 | [PATCH v15 11/20] powerpc_ieee1275: Read the db and dbx s... | DROP | Older version | 2025-10-0152 |
| 2025-10-0075 | [PATCH v15 10/20] appended signatures: Support verifying ... | DROP | Older version | 2025-10-0151 |
| 2025-10-0076 | [PATCH v15 12/20] appended signatures: Introducing key ma... | DROP | Older version | 2025-10-0153 |
| 2025-10-0077 | [PATCH v15 13/20] appended signatures: Create db and dbx ... | DROP | Older version | 2025-10-0156 |
| 2025-10-0078 | [PATCH v15 14/20] appended signatures: Using db and dbx l... | DROP | Already in master | 2025-10-0120 |
| 2025-10-0079 | [PATCH v15 15/20] appended signatures: GRUB commands to m... | DROP | Older version | 2025-10-0157 |
| 2025-10-0080 | [PATCH v15 16/20] appended signatures: GRUB commands to m... | DROP | Older version | 2025-10-0158 |
| 2025-10-0081 | [PATCH v15 18/20] docs/grub: Document signing GRUB under ... | DROP | Older version | 2025-10-0159 |
| 2025-10-0082 | [PATCH v15 19/20] docs/grub: Document signing GRUB with a... | DROP | Older version | 2025-10-0162 |
| 2025-10-0083 | [PATCH v15 17/20] appended signatures: Verification tests | DROP | Older version | 2025-10-0160 |
| 2025-10-0084 | [PATCH v15 20/20] docs/grub: Document appended signature | DROP | Older version | 2025-10-0161 |
| 2025-10-0090 | [PATCH v4 2/7] tss2: Introduce grub_tcg2_cap_pcr() | DROP | Already in master |  |
| 2025-10-0092 | [PATCH v4 1/7] tss2: Add TPM2_PCR_Event command | KEEP | | |
| 2025-10-0093 | [PATCH v4 3/7] tss2: Implement grub_tcg2_cap_pcr() for EFI | DROP | Already in master |  |
| 2025-10-0094 | [PATCH v4 4/7] tss2: Implement grub_tcg2_cap_pcr() for ie... | KEEP | | |
| 2025-10-0095 | [PATCH v4 5/7] tss2: Implement grub_tcg2_cap_pcr() for EMU | DROP | Already in master |  |
| 2025-10-0096 | [PATCH v4 7/7] tests/tpm2_key_protector_test: Add a test ... | DROP | Already in master |  |
| 2025-10-0097 | [PATCH v4 6/7] tpm2_key_protector: Support PCR capping | KEEP | | |
| 2025-10-0099 | [PATCH v16 02/20] crypto: Move storage for grub_crypto_pk... | DROP | Already in master | 2025-10-0120 |
| 2025-10-0100 | [PATCH v16 01/20] powerpc-ieee1275: Add support for signi... | DROP | Older version | 2025-10-0142 |
| 2025-10-0101 | [PATCH v16 03/20] pgp: Rename OBJ_TYPE_PUBKEY to OBJ_TYPE... | DROP | Older version | 2025-10-0145 |
| 2025-10-0102 | [PATCH v16 04/20] grub-install: Support embedding x509 ce... | DROP | Already in master | 2025-10-0120 |
| 2025-10-0103 | [PATCH v16 05/20] appended signatures: Import GNUTLS's ASN.1 | DROP | Already in master | 2025-10-0120 |
| 2025-10-0104 | [PATCH v16 07/20] appended signatures: Parse PKCS#7 signe... | DROP | Older version | 2025-10-0149 |
| 2025-10-0105 | [PATCH v16 06/20] appended signatures: Parse ASN1 node | DROP | Older version | 2025-10-0148 |
| 2025-10-0106 | [PATCH v16 08/20] appended signatures: Parse X.509 certif... | DROP | Already in master | 2025-10-0120 |
| 2025-10-0107 | [PATCH v16 10/20] appended signatures: Support verifying ... | DROP | Older version | 2025-10-0151 |
| 2025-10-0108 | [PATCH v16 11/20] powerpc_ieee1275: Read the db and dbx s... | DROP | Older version | 2025-10-0152 |
| 2025-10-0109 | [PATCH v16 09/20] powerpc_ieee1275: Enter lockdown based ... | DROP | Older version | 2025-10-0150 |
| 2025-10-0110 | [PATCH v16 14/20] appended signatures: Using db and dbx l... | DROP | Already in master | 2025-10-0120 |
| 2025-10-0111 | [PATCH v16 15/20] appended signatures: GRUB commands to m... | DROP | Older version | 2025-10-0157 |
| 2025-10-0112 | [PATCH v16 13/20] appended signatures: Create db and dbx ... | DROP | Older version | 2025-10-0156 |
| 2025-10-0113 | [PATCH v16 12/20] appended signatures: Introducing key ma... | DROP | Older version | 2025-10-0153 |
| 2025-10-0114 | [PATCH v16 16/20] appended signatures: GRUB commands to m... | DROP | Older version | 2025-10-0158 |
| 2025-10-0115 | [PATCH v16 18/20] docs/grub: Document signing GRUB under ... | DROP | Older version | 2025-10-0159 |
| 2025-10-0116 | [PATCH v16 17/20] appended signatures: Verification tests | DROP | Older version | 2025-10-0160 |
| 2025-10-0117 | [PATCH v16 19/20] docs/grub: Document signing GRUB with a... | DROP | Older version | 2025-10-0162 |
| 2025-10-0118 | [PATCH v16 20/20] docs/grub: Document appended signature | DROP | Older version | 2025-10-0161 |
| 2025-10-0120 | [PATCH v17 02/20] crypto: Move storage for grub_crypto_pk... | DROP | Already in master |  |
| 2025-10-0121 | [PATCH v17 04/20] grub-install: Support embedding x509 ce... | DROP | Already in master |  |
| 2025-10-0123 | [PATCH v17 01/20] powerpc-ieee1275: Add support for signi... | DROP | Older version | 2025-10-0142 |
| 2025-10-0124 | [PATCH v17 03/20] pgp: Rename OBJ_TYPE_PUBKEY to OBJ_TYPE... | DROP | Older version | 2025-10-0145 |
| 2025-10-0125 | [PATCH v17 05/20] appended signatures: Import GNUTLS's ASN.1 | DROP | Already in master |  |
| 2025-10-0126 | [PATCH v17 06/20] appended signatures: Parse ASN1 node | DROP | Older version | 2025-10-0148 |
| 2025-10-0127 | [PATCH v17 07/20] appended signatures: Parse PKCS#7 signe... | DROP | Older version | 2025-10-0149 |
| 2025-10-0128 | [PATCH v17 09/20] powerpc_ieee1275: Enter lockdown based ... | DROP | Older version | 2025-10-0150 |
| 2025-10-0129 | [PATCH v17 08/20] appended signatures: Parse X.509 certif... | DROP | Already in master |  |
| 2025-10-0130 | [PATCH v17 10/20] appended signatures: Support verifying ... | DROP | Older version | 2025-10-0151 |
| 2025-10-0131 | [PATCH v17 11/20] powerpc_ieee1275: Read the db and dbx s... | DROP | Older version | 2025-10-0152 |
| 2025-10-0132 | [PATCH v17 13/20] appended signatures: Create db and dbx ... | DROP | Older version | 2025-10-0156 |
| 2025-10-0133 | [PATCH v17 12/20] appended signatures: Introducing key ma... | DROP | Older version | 2025-10-0153 |
| 2025-10-0134 | [PATCH v17 15/20] appended signatures: GRUB commands to m... | DROP | Older version | 2025-10-0157 |
| 2025-10-0135 | [PATCH v17 14/20] appended signatures: Using db and dbx l... | DROP | Already in master |  |
| 2025-10-0136 | [PATCH v17 17/20] appended signatures: Verification tests | DROP | Older version | 2025-10-0160 |
| 2025-10-0137 | [PATCH v17 18/20] docs/grub: Document signing GRUB under ... | DROP | Older version | 2025-10-0159 |
| 2025-10-0138 | [PATCH v17 20/20] docs/grub: Document appended signature | DROP | Older version | 2025-10-0161 |
| 2025-10-0139 | [PATCH v17 16/20] appended signatures: GRUB commands to m... | DROP | Older version | 2025-10-0158 |
| 2025-10-0140 | [PATCH v17 19/20] docs/grub: Document signing GRUB with a... | DROP | Older version | 2025-10-0162 |
| 2025-10-0142 | [PATCH v18 01/20] powerpc-ieee1275: Add support for signi... | KEEP | | |
| 2025-10-0143 | [PATCH v18 02/20] crypto: Move storage for grub_crypto_pk... | DROP | Already in master |  |
| 2025-10-0145 | [PATCH v18 03/20] pgp: Rename OBJ_TYPE_PUBKEY to OBJ_TYPE... | KEEP | | |
| 2025-10-0146 | [PATCH v18 04/20] grub-install: Support embedding x509 ce... | DROP | Already in master |  |
| 2025-10-0147 | [PATCH v18 05/20] appended signatures: Import GNUTLS's ASN.1 | DROP | Already in master |  |
| 2025-10-0148 | [PATCH v18 06/20] appended signatures: Parse ASN1 node | KEEP | | |
| 2025-10-0149 | [PATCH v18 07/20] appended signatures: Parse PKCS#7 signe... | KEEP | | |
| 2025-10-0150 | [PATCH v18 09/20] powerpc_ieee1275: Enter lockdown based ... | KEEP | | |
| 2025-10-0151 | [PATCH v18 10/20] appended signatures: Support verifying ... | KEEP | | |
| 2025-10-0152 | [PATCH v18 11/20] powerpc_ieee1275: Read the db and dbx s... | KEEP | | |
| 2025-10-0153 | [PATCH v18 12/20] appended signatures: Introducing key ma... | KEEP | | |
| 2025-10-0154 | [PATCH v18 08/20] appended signatures: Parse X.509 certif... | DROP | Already in master |  |
| 2025-10-0155 | [PATCH v18 14/20] appended signatures: Using db and dbx l... | DROP | Already in master |  |
| 2025-10-0156 | [PATCH v18 13/20] appended signatures: Create db and dbx ... | KEEP | | |
| 2025-10-0157 | [PATCH v18 15/20] appended signatures: GRUB commands to m... | KEEP | | |
| 2025-10-0158 | [PATCH v18 16/20] appended signatures: GRUB commands to m... | KEEP | | |
| 2025-10-0159 | [PATCH v18 18/20] docs/grub: Document signing GRUB under ... | KEEP | | |
| 2025-10-0160 | [PATCH v18 17/20] appended signatures: Verification tests | KEEP | | |
| 2025-10-0161 | [PATCH v18 20/20] docs/grub: Document appended signature | KEEP | | |
| 2025-10-0162 | [PATCH v18 19/20] docs/grub: Document signing GRUB with a... | KEEP | | |
| 2025-10-0174 | [PATCH v4 01/12] misc: add z length modifier support | DROP | Already in master |  |
| 2025-10-0175 | [PATCH v4 02/12] tests: add z modifier printf tests | DROP | Already in master |  |
| 2025-10-0176 | [PATCH v4 03/12] btrfs: add environment block to reserved... | DROP | Already in master |  |
| 2025-10-0177 | [PATCH v4 04/12] util/grub-editenv: add basic structures ... | KEEP | | |
| 2025-10-0178 | [PATCH v4 05/12] util/grub-editenv: add fs_envblk open he... | DROP | Resend | 2025-10-0294 |
| 2025-10-0179 | [PATCH v4 06/12] util/grub-editenv: add fs_envblk write h... | DROP | Resend | 2025-10-0296 |
| 2025-10-0180 | [PATCH v4 07/12] util/grub-editenv: wire set_variables to... | DROP | Resend | 2025-10-0297 |
| 2025-10-0181 | [PATCH v4 08/12] util/grub-editenv: wire unset_variables ... | DROP | Resend | 2025-10-0299 |
| 2025-10-0182 | [PATCH v4 09/12] util/grub-editenv: wire list_variables t... | DROP | Already in master |  |
| 2025-10-0183 | [PATCH v4 12/12] btrfs: update doc link for bootloader su... | DROP | Older version | 2025-10-0305 |
| 2025-10-0184 | [PATCH v4 10/12] 00_header.in: wire grub.cfg to use env_b... | DROP | Already in master |  |
| 2025-10-0185 | [PATCH v4 11/12] docs: add Btrfs env block and special en... | DROP | Older version | 2025-10-0304 |
| 2025-10-0187 | [PATCH] menuentry: Fix for out of bound issue | KEEP | | |
| 2025-10-0189 | [PATCH] commands/hashsum: Allow to store hash in variable | KEEP | | |
| 2025-10-0194 | [PATCH] ieee1275: Use net config for boot location instea... | KEEP | | |
| 2025-10-0228 | [PATCH 1/4] io: Implement zstdio decompression | DROP | Older version | 2025-10-0324 |
| 2025-10-0230 | [PATCH 3/4] tests/file_filter: Add zstd test file | DROP | Already in master |  |
| 2025-10-0231 | [PATCH 4/4] tests/file_filter: Add zstd tests | DROP | Already in master |  |
| 2025-10-0232 | [PATCH 2/4] tests/file_filter: Regenerate gpg keys | DROP | Already in master |  |
| 2025-10-0234 | [PATCH v5 01/13] util/import_gcry: Import kdf.c for Argon2 | DROP | Already in master |  |
| 2025-10-0235 | [PATCH v5 07/13] argon2: Introduce grub_crypto_argon2() | KEEP | | |
| 2025-10-0237 | [PATCH v5 04/13] libgcrypt/kdf: Get rid of gpg_err_code_f... | KEEP | | |
| 2025-10-0238 | [PATCH v5 03/13] libgcrypt/kdf: Implement hash_buffers() for | KEEP | | |
| 2025-10-0239 | [PATCH v5 06/13] libgcrypt/kdf: Fix 64-bit modulus on 32-... | KEEP | | |
| 2025-10-0240 | [PATCH v5 09/13] Import Argon2 tests from libgcrypt | KEEP | | |
| 2025-10-0241 | [PATCH v5 02/13] crypto: Update crypto.h for libgcrypt KD... | DROP | Already in master |  |
| 2025-10-0242 | [PATCH v5 05/13] libgcrypt/kdf: Remove unsupported KDFs | KEEP | | |
| 2025-10-0243 | [PATCH v5 11/13] tests/util/grub-fs-tester: Use Argon2id ... | KEEP | | |
| 2025-10-0244 | [PATCH v5 08/13] disk/luks2: Add Argon2 support | DROP | Already in master |  |
| 2025-10-0245 | [PATCH v5 10/13] Integrate Argon2 tests into functional_test | KEEP | | |
| 2025-10-0246 | [PATCH v5 12/13] docs: Document argon2 and argon2_test | DROP | Already in master |  |
| 2025-10-0247 | [PATCH v5 13/13] kern/misc: Implement faster grub_memcpy(... | KEEP | | |
| 2025-10-0263 | [PATCH v5 02/12] tests: add z modifier printf tests | DROP | Already in master |  |
| 2025-10-0264 | [PATCH v5 01/12] misc: add z length modifier support | DROP | Already in master |  |
| 2025-10-0265 | [PATCH v5 05/12] util/grub-editenv: add fs_envblk write h... | DROP | Resend | 2025-10-0296 |
| 2025-10-0266 | [PATCH v5 03/12] btrfs: add environment block to reserved... | KEEP | | |
| 2025-10-0267 | [PATCH v5 04/12] util/grub-editenv: add fs_envblk open he... | DROP | Resend | 2025-10-0294 |
| 2025-10-0268 | [PATCH v5 06/12] util/grub-editenv: wire set_variables to... | DROP | Resend | 2025-10-0297 |
| 2025-10-0269 | [PATCH v5 07/12] util/grub-editenv: wire unset_variables ... | DROP | Resend | 2025-10-0299 |
| 2025-10-0270 | [PATCH v5 09/12] util/grub-editenv: add probe call for ex... | KEEP | | |
| 2025-10-0271 | [PATCH v5 08/12] util/grub-editenv: wire list_variables t... | KEEP | | |
| 2025-10-0272 | [PATCH v5 10/12] 00_header.in: wire grub.cfg to use env_b... | DROP | Already in master |  |
| 2025-10-0273 | [PATCH v5 11/12] docs: add Btrfs env block and special en... | DROP | Older version | 2025-10-0304 |
| 2025-10-0274 | [PATCH v5 12/12] btrfs: update doc link for bootloader su... | DROP | Older version | 2025-10-0305 |
| 2025-10-0276 | [PATCH v2 01/10] Tweak autoconf/automake files to detect ... | DROP | Older version | 2025-10-0329 |
| 2025-10-0277 | [PATCH v2 02/10] lib/hwfeatures-gcry: Introduce functions... | DROP | Older version | 2025-10-0331 |
| 2025-10-0279 | [PATCH v2 03/10] lib/hwfeatures-gcry: Enable SSE and AVX ... | DROP | Older version | 2025-10-0332 |
| 2025-10-0280 | [PATCH v2 04/10] libgcrypt: Copy sha256 x86_64 assembly f... | DROP | Older version | 2025-10-0333 |
| 2025-10-0281 | [PATCH v2 05/10] libgcrypt: Copy sha512 x86_64 assembly f... | DROP | Already in master | 2025-10-0334 |
| 2025-10-0282 | [PATCH v2 06/10] libgcrypt: Implement _gcry_get_hw_featur... | DROP | Older version | 2025-10-0335 |
| 2025-10-0283 | [PATCH v2 07/10] libgcrypt: Declare the sha256 shaext fun... | DROP | Older version | 2025-10-0336 |
| 2025-10-0284 | [PATCH v2 09/10] libgcrypt: Add hardware acceleration for... | DROP | Already in master | 2025-10-0334 |
| 2025-10-0285 | [PATCH v2 08/10] libgcrypt: Add hardware acceleration for... | DROP | Older version | 2025-10-0337 |
| 2025-10-0286 | [PATCH v2 10/10] disk/cryptodisk: Add '--hw-accel' to ena... | DROP | Already in master | 2025-10-0334 |
| 2025-10-0294 | [PATCH v6 03/12] util/grub-editenv: add fs_envblk open he... | KEEP | | |
| 2025-10-0295 | [PATCH v6 01/12] misc: add z length modifier support | DROP | Already in master |  |
| 2025-10-0296 | [PATCH v6 04/12] util/grub-editenv: add fs_envblk write h... | KEEP | | |
| 2025-10-0297 | [PATCH v6 05/12] util/grub-editenv: wire set_variables to... | KEEP | | |
| 2025-10-0298 | [PATCH v6 02/12] tests: add z modifier printf tests | DROP | Already in master |  |
| 2025-10-0299 | [PATCH v6 06/12] util/grub-editenv: wire unset_variables ... | KEEP | | |
| 2025-10-0300 | [PATCH v6 08/12] util/grub-editenv: add probe call for ex... | DROP | Already in master |  |
| 2025-10-0301 | [PATCH v6 07/12] util/grub-editenv: wire list_variables t... | DROP | Already in master |  |
| 2025-10-0302 | [PATCH v6 09/12] btrfs: add environment block to reserved... | DROP | Already in master |  |
| 2025-10-0303 | [PATCH v6 10/12] 00_header.in: wire grub.cfg to use env_b... | DROP | Already in master |  |
| 2025-10-0304 | [PATCH v6 11/12] docs: add Btrfs env block and special en... | KEEP | | |
| 2025-10-0305 | [PATCH v6 12/12] btrfs: update doc link for bootloader su... | KEEP | | |
| 2025-10-0311 | [PATCH] net/tftp: Fix NULL pointer dereference in grub_ne... | DROP | Already in master |  |
| 2025-10-0312 | [PATCH] docs: Document lsmemregions and memtools commands. | KEEP | | |
| 2025-10-0323 | [PATCH v3 3/4] tests/file_filter: Add zstd test file | DROP | Already in master |  |
| 2025-10-0324 | [PATCH v3 1/4] io: Implement zstdio decompression | KEEP | | |
| 2025-10-0326 | [PATCH v3 2/4] tests/file_filter: Regenerate gpg keys | DROP | Already in master |  |
| 2025-10-0327 | [PATCH v3 4/4] tests/file_filter: Add zstd tests | DROP | Already in master |  |
| 2025-10-0328 | [PATCH v2] memtools: add lsmemregions command | DROP | Already in master |  |
| 2025-10-0329 | [PATCH v3 01/10] Tweak autoconf/automake files to detect ... | KEEP | | |
| 2025-10-0331 | [PATCH v3 02/10] lib/hwfeatures-gcry: Introduce functions... | KEEP | | |
| 2025-10-0332 | [PATCH v3 03/10] lib/hwfeatures-gcry: Enable SSE and AVX ... | KEEP | | |
| 2025-10-0333 | [PATCH v3 04/10] libgcrypt: Copy sha256 x86_64 assembly f... | KEEP | | |
| 2025-10-0334 | [PATCH v3 05/10] libgcrypt: Copy sha512 x86_64 assembly f... | DROP | Already in master |  |
| 2025-10-0335 | [PATCH v3 06/10] libgcrypt: Implement _gcry_get_hw_featur... | KEEP | | |
| 2025-10-0336 | [PATCH v3 07/10] libgcrypt: Declare the sha256 shaext fun... | KEEP | | |
| 2025-10-0337 | [PATCH v3 08/10] libgcrypt: Add hardware acceleration for... | KEEP | | |
| 2025-10-0338 | [PATCH v3 09/10] libgcrypt: Add hardware acceleration for... | DROP | Already in master |  |
| 2025-10-0339 | [PATCH v3 10/10] disk/cryptodisk: Add '--hw-accel' to ena... | DROP | Already in master |  |
| 2025-10-0341 | [PATCH 1/2] net/bootp: Prevent a UAF in network interface... | DROP | Already in master |  |
| 2025-10-0343 | [PATCH 2/2] net/dns: Prevent UAF and double free | DROP | Already in master |  |
| 2025-10-0349 | [PATCH] tss2: Always init out buffer before calling | DROP | Already in master |  |
| 2025-10-0354 | Re: [PATCH v6 11/12] docs: add Btrfs env block and specia... | DROP | Reply only |  |
| 2025-10-0356 | [PATCH 1/3] bootstrap: Fix patching warnings | DROP | Already in master |  |
| 2025-10-0357 | [PATCH 3/3] build: Add appended signatures header file to... | KEEP | | |
| 2025-10-0358 | [PATCH 2/3] lib/xzembed/xz_dec_stream: Replace grub_memcp... | DROP | Already in master |  |
| 2025-10-0365 | [PATCH 1/4] build: Include MAINTAINERS and SECURITY files... | DROP | Already in master |  |
| 2025-10-0366 | [PATCH 2/4] build: Include new zstd test support files in... | DROP | Already in master |  |
| 2025-10-0367 | [PATCH 3/4] build: Add tpm2asn file for reference to dist... | DROP | Already in master |  |
| 2025-10-0368 | [PATCH 4/4] loader/efi/linux: Fix Compile Error With Clang | DROP | Already in master |  |
| 2025-10-0371 | [PATCH 1/2] windows: Fix relocation sections generation d... | DROP | Already in master |  |
| 2025-10-0372 | [PATCH 2/2] windows: Fix symbol table generation during m... | DROP | Already in master |  |
| 2025-10-0380 | [PATCH] Fixing a memory leak in serial.c | DROP | Already in master |  |
| 2025-10-0382 | [PATCH 1/4] normal: Adding a grub_malloc failure check in... | DROP | Already in master |  |
| 2025-10-0383 | [PATCH 2/4] Adding a grub_malloc failure check in msdos.c | DROP | Already in master |  |
| 2025-10-0384 | [PATCH 3/4] Adding a grub_malloc failure check in mmap.c | KEEP | | |
| 2025-10-0385 | [PATCH 4/4] Adding a grub_malloc failure check in legacy_... | DROP | Already in master |  |
| 2025-10-0390 | [PATCH] configure.ac: avoid bashisms | DROP | Already in master |  |
| 2025-10-0392 | [PATCH] configure.ac: avoid bashisms | DROP | Already in master |  |

### 2025-11 (103 branches: 25 remain, 78 drop)

| Branch | Subject | Decision | Reason | Superseded by |
|--------|---------|----------|--------|---------------|
| 2025-11-0012 | [PATCH 1/3] util/grub.d/00_header.in: Disable loading all... | DROP | Older version | 2025-11-0027 |
| 2025-11-0014 | [PATCH 2/3] util/grub-mkconfig: Add new environment variable | KEEP | | |
| 2025-11-0015 | [PATCH 3/3] docs: Document new GRUB_FORCE_EFI_ALLVIDEO va... | KEEP | | |
| 2025-11-0017 | [PATCH v4 1/3] tests: Split ZFS ZSTD Test Into New File | DROP | Older version | 2025-11-0104 |
| 2025-11-0018 | [PATCH v4 2/3] tests: Avoid Test Failure in erofs for lab... | DROP | Already in master | 2025-11-0106 |
| 2025-11-0019 | [PATCH v4 3/3] tests: Support Changed mkfs.ext2 Behavior ... | DROP | Older version | 2025-11-0105 |
| 2025-11-0027 | [PATCH v2 1/1] util/grub.d/00_header.in: Disable loading ... | KEEP | | |
| 2025-11-0029 | [PATCH v5 2/3] tests: Avoid Test Failure in erofs for lab... | DROP | Already in master |  |
| 2025-11-0030 | [PATCH v5 1/3] tests: Split ZFS ZSTD Test Into New File | DROP | Older version | 2025-11-0104 |
| 2025-11-0031 | [PATCH v5 3/3] tests: Support Changed mkfs.ext2 Behavior ... | DROP | Older version | 2025-11-0105 |
| 2025-11-0032 | [PATCH v2] docs: Add Security Hardening Suggestions | DROP | Already in master |  |
| 2025-11-0037 | [PATCH 2/4] tests/erofs_test: Remove root check | DROP | Older version | 2025-11-0099 |
| 2025-11-0038 | [PATCH 4/4] tests/erofs_test: Improve accuracy of FSTIME ... | DROP | Older version | 2025-11-0097 |
| 2025-11-0040 | [PATCH 1/4] tests/erofs_test: Only test and set labels if... | DROP | Older version | 2025-11-0099 |
| 2025-11-0041 | [PATCH 3/4] tests/erofs_test: Disable filetime check for ... | DROP | Older version | 2025-11-0099 |
| 2025-11-0046 | [PATCH] linguas: Ensure that scripts runs from the direct... | DROP | Already in master |  |
| 2025-11-0048 | [PATCH] bootstrap: Run linguas.sh in bootstrap epilogue | DROP | Older version | 2025-11-0204 |
| 2025-11-0049 | [PATCH] gitignore: Remove po/*.po and po/LINGUAS | DROP | Already in master |  |
| 2025-11-0050 | [PATCH] INSTALL: Fix a grammatical error | DROP | Already in master |  |
| 2025-11-0054 | [PATCH v2 2/4] tests/erofs_test: Remove root check | DROP | Older version | 2025-11-0099 |
| 2025-11-0055 | [PATCH v2 1/4] tests/erofs_test: Fix mkfs.erofs version t... | KEEP | | |
| 2025-11-0056 | [PATCH v2 4/4] tests/erofs_test: Improve accuracy of FSTI... | DROP | Older version | 2025-11-0097 |
| 2025-11-0057 | [PATCH v2 3/4] tests/erofs_test: Disable filetime check for | DROP | Already in master |  |
| 2025-11-0058 | [PATCH] blsuki: Fix grub_errno leakage in blsuki_is_defau... | DROP | Older version | 2025-11-0194 |
| 2025-11-0062 | [PATCH 1/4] ieee1275/openfw: add missing grub_strdup fail... | DROP | Already in master |  |
| 2025-11-0063 | [PATCH 2/4] script/execute: add missing grub_strdup failu... | DROP | Already in master |  |
| 2025-11-0064 | [PATCH 3/4] kern/mips/arc: add missing grub_strdup failur... | DROP | Already in master |  |
| 2025-11-0065 | [PATCH 4/4] osdep/linux/getroot: add missing strdup failu... | DROP | Already in master |  |
| 2025-11-0076 | [PATCH v2] blsuki: Fix grub_errno leakage in blsuki_is_de... | DROP | Older version | 2025-11-0194 |
| 2025-11-0078 | [PATCH v2 1/4] bootstrap: Run linguas.sh in bootstrap epi... | DROP | Older version | 2025-11-0204 |
| 2025-11-0079 | [PATCH v2 2/4] bootstrap: Migrate linguas.sh into bootstr... | DROP | Older version | 2025-11-0205 |
| 2025-11-0080 | [PATCH v2 3/4] bootstrap: Condense and simplify LINGUAS g... | DROP | Older version | 2025-11-0204 |
| 2025-11-0081 | [PATCH v2 4/4] INSTALL: Fix a grammatical error | DROP | Already in master | 2025-11-0206 |
| 2025-11-0082 | [PATCH] gitignore: Remove po/*.po and po/LINGUAS | DROP | Already in master |  |
| 2025-11-0096 | [PATCH v3 1/4] tests/erofs_test: Fix mkfs.erofs version t... | DROP | Already in master |  |
| 2025-11-0097 | [PATCH v3 4/4] tests/erofs_test: Improve accuracy of FSTI... | KEEP | | |
| 2025-11-0099 | [PATCH v3 2/4] tests/erofs_test: Remove root check | KEEP | | |
| 2025-11-0100 | [PATCH v3 3/4] tests/erofs_test: Disable filetime check for | DROP | Already in master |  |
| 2025-11-0104 | [PATCH v6 1/3] tests: Split ZFS ZSTD Test Into New File | KEEP | | |
| 2025-11-0105 | [PATCH v6 3/3] tests: Support Changed mkfs.ext2 Behavior ... | KEEP | | |
| 2025-11-0106 | [PATCH v6 2/3] tests: Avoid Test Failure in erofs for lab... | DROP | Already in master |  |
| 2025-11-0112 | [PATCH v7 3/3] tests: Support Changed mkfs.ext2 Behavior ... | DROP | Already in master |  |
| 2025-11-0113 | [PATCH v7 1/3] tests: Split ZFS ZSTD Test Into New File | DROP | Already in master |  |
| 2025-11-0114 | [PATCH v7 2/3] tests: Avoid Test Failure in erofs for lab... | DROP | Already in master |  |
| 2025-11-0118 | [PATCH] Check linker for --image-base support | DROP | Older version | 2025-11-0166 |
| 2025-11-0119 | [PATCH v2] linguas: Ensure that linguas.sh runs from the ... | DROP | Already in master |  |
| 2025-11-0120 | [PATCH 2/2] tests/grub_cmd_cryptomount: Use builddir shel... | KEEP | | |
| 2025-11-0121 | [PATCH 1/2] tests/grub_cmd_cryptomount: Expect test success, | KEEP | | |
| 2025-11-0123 | [PATCH] util/grub-mkrescue: Fix copy/paste issue referenc... | KEEP | | |
| 2025-11-0125 | [PATCH 2/2] fs/zfs: Avoid pointer downcasting in dnode_get() | DROP | Already in master |  |
| 2025-11-0126 | [PATCH 1/2] mmap/mmap: Fix resource leak | DROP | Already in master |  |
| 2025-11-0141 | [PATCH 1/5] misc: Fix spelling mistakes | DROP | Already in master |  |
| 2025-11-0142 | [PATCH 2/5] docs: Fix spelling, | KEEP | | |
| 2025-11-0143 | [PATCH 3/5] docs: Add note and explanation that the privi... | KEEP | | |
| 2025-11-0144 | [PATCH 4/5] docs: Reorganize test section and add section... | KEEP | | |
| 2025-11-0145 | [PATCH 5/5] INSTALL: Make note that linux kernel 6.12.x o... | DROP | Already in master |  |
| 2025-11-0147 | Re: [PATCH 2/2] tests/grub_cmd_cryptomount: Use builddir ... | DROP | Reply only |  |
| 2025-11-0151 | [PATCH v3] blsuki: Fix grub_errno leakage in blsuki_is_de... | DROP | Older version | 2025-11-0194 |
| 2025-11-0154 | [PATCH] linux/ofpath: Add missing strdup failure checks | DROP | Resend | 2025-11-0173 |
| 2025-11-0155 | [SECURITY PATCH 1/8] commands/test: Fix error in recursio... | DROP | Already in master |  |
| 2025-11-0157 | [SECURITY PATCH 1/8] commands/test: Fix error in recursio... | DROP | Already in master |  |
| 2025-11-0158 | [SECURITY PATCH 2/8] kern/file: Call grub_dl_unref() after | DROP | Already in master |  |
| 2025-11-0159 | [SECURITY PATCH 3/8] net/net: Unregister net_set_vlan com... | DROP | Already in master |  |
| 2025-11-0160 | [SECURITY PATCH 4/8] gettext/gettext: Unregister gettext ... | DROP | Already in master |  |
| 2025-11-0161 | [SECURITY PATCH 5/8] normal/main: Unregister commands on ... | DROP | Already in master |  |
| 2025-11-0162 | [SECURITY PATCH 6/8] tests/lib/functional_test: Unregiste... | DROP | Already in master |  |
| 2025-11-0163 | [SECURITY PATCH 7/8] commands/usbtest: Use correct string... | DROP | Already in master |  |
| 2025-11-0164 | [SECURITY PATCH 8/8] commands/usbtest: Ensure string leng... | DROP | Already in master |  |
| 2025-11-0166 | [PATCH v2 1/1] Check linker for --image-base support | KEEP | | |
| 2025-11-0169 | [PATCH] lib/relocator: Fix dereference after NULL check | DROP | Already in master |  |
| 2025-11-0172 | [PATCH v1] linux/ofpath: Add missing strdup failure checks | DROP | Resend | 2025-11-0173 |
| 2025-11-0173 | [PATCH v1] linux/ofpath: Add missing strdup failure checks | KEEP | | |
| 2025-11-0178 | [PATCH 0/2] Revert imprudent test changes | KEEP | | |
| 2025-11-0179 | [PATCH 1/2] Revert "tests: Skip tests if required tools a... | DROP | Already in master |  |
| 2025-11-0180 | [PATCH 2/2] Revert "tests: Remove -w param from mkfs.hfsp... | DROP | Already in master |  |
| 2025-11-0182 | [PATCH v3 1/4] bootstrap: Run linguas.sh in bootstrap epi... | DROP | Older version | 2025-11-0204 |
| 2025-11-0183 | [PATCH v3 2/4] bootstrap: Migrate linguas.sh into bootstr... | DROP | Older version | 2025-11-0205 |
| 2025-11-0184 | [PATCH v3 3/4] bootstrap: Condense and simplify LINGUAS g... | DROP | Already in master | 2025-11-0206 |
| 2025-11-0185 | [PATCH v3 4/4] INSTALL: Fix a grammatical error | DROP | Already in master | 2025-11-0206 |
| 2025-11-0194 | [PATCH v4] blsuki: Fix grub_errno leakage in blsuki_is_de... | KEEP | | |
| 2025-11-0195 | [PATCH] normal/cmdline: fix hist_lines state loss and gru... | KEEP | | |
| 2025-11-0204 | [PATCH v4 1/4] bootstrap: Run linguas.sh in bootstrap epi... | KEEP | | |
| 2025-11-0205 | [PATCH v4 2/4] bootstrap: Migrate linguas.sh into bootstr... | KEEP | | |
| 2025-11-0206 | [PATCH v4 3/4] bootstrap: Condense and simplify LINGUAS g... | DROP | Already in master |  |
| 2025-11-0207 | [PATCH v4 4/4] INSTALL: Fix a grammatical error | DROP | Already in master |  |
| 2025-11-0208 | [PATCH] tests: Fix nonnative tests labeled as native | KEEP | | |
| 2025-11-0209 | [PATCH 1/5] blsuki: fix typo in entry parameter description | DROP | Already in master | 2025-11-0221 |
| 2025-11-0210 | [PATCH 5/5] blsuki: error out if unexpected arguments are... | DROP | Older version | 2025-11-0226 |
| 2025-11-0211 | [PATCH 3/5] blsuki: use specified device in case of fallback | DROP | Older version | 2025-11-0221 |
| 2025-11-0212 | [PATCH 2/5] blsuki: fix blscfg command summary | DROP | Already in master | 2025-11-0221 |
| 2025-11-0213 | [PATCH 4/5] blsuki: fix default location in commment to | DROP | Older version | 2025-11-0221 |
| 2025-11-0219 | bug #65889: cryptomount with keyfile fails because of shi... | DROP | Already in master |  |
| 2025-11-0221 | [PATCH v2 1/5] blsuki: fix typo in entry parameter descri... | DROP | Already in master |  |
| 2025-11-0222 | [PATCH v2 3/5] blsuki: use specified device in case of fa... | DROP | Already in master |  |
| 2025-11-0223 | [PATCH v2 2/5] blsuki: fix blscfg command summary | DROP | Already in master |  |
| 2025-11-0225 | [PATCH v2 4/5] blsuki: fix default location in commment to | DROP | Already in master |  |
| 2025-11-0226 | [PATCH v2 5/5] blsuki: error out if unexpected arguments ... | KEEP | | |
| 2025-11-0237 | [PATCH] efiemu/loadcore: Add grub_calloc failure check | DROP | Older version | 2025-11-0247 |
| 2025-11-0238 | [PATCH] tests: add functional tests for ECB mode using va... | KEEP | | |
| 2025-11-0239 | [PATCH] lib/x86_64/setjmp: Use 32-bit zero idiom for shor... | DROP | Already in master |  |
| 2025-11-0240 | [PATCH RESEND] lib/x86_64/setjmp: Use 32-bit zero idiom f... | DROP | Already in master |  |
| 2025-11-0245 | Re: [PATCH] efiemu/loadcore: Add grub_calloc failure check | KEEP | | |
| 2025-11-0247 | [PATCH v2] efiemu/loadcore: Add grub_calloc failure check | DROP | Already in master |  |

### 2025-12 (25 branches: 8 remain, 17 drop)

| Branch | Subject | Decision | Reason | Superseded by |
|--------|---------|----------|--------|---------------|
| 2025-12-0001 | [PATCH] ieee1275 : Add a check for invalid partition number | DROP | Older version | 2026-01-0018 |
| 2025-12-0002 | [PATCH] disk/ieee1275 : Add a fix for memory leaks in ofdisk | KEEP | | |
| 2025-12-0013 | [PATCH] script/execute: Add NULL check for grub_calloc in | DROP | Already in master |  |
| 2025-12-0015 | [PATCH v2] ieee1275 : Add a check for invalid partition n... | DROP | Older version | 2026-01-0018 |
| 2025-12-0018 | [PATCH] appendedsig: Fix grub-mkimage with an unaligned a... | DROP | Older version | 2026-01-0006 |
| 2025-12-0019 | [PATCH v2] tests: add functional tests for ecb/cbc helpers | DROP | Older version | 2026-01-0005 |
| 2025-12-0021 | [PATCH] aros/hostdisk: Fix use-after-free bug during MsgP... | DROP | Already in master |  |
| 2025-12-0024 | [PATCH] commands/bli: set UINT32_MAX in LoaderTpm2ActiveP... | KEEP | | |
| 2025-12-0028 | [PATCH grub] INSTALL: Add note that the GNU Autoconf Arch... | KEEP | | |
| 2025-12-0029 | [PATCH grub] tests/util/grub-fs-tester: Use CSMACINTOSH e... | KEEP | | |
| 2025-12-0036 | [PATCH 1/1] commands/efi/lsefisystab: MEMORY_ATTRIBUTES_T... | DROP | Already in master |  |
| 2025-12-0037 | Re: [PATCH 1/1] commands/efi/lsefisystab: MEMORY_ATTRIBUT... | KEEP | | |
| 2025-12-0038 | [PATCH] grub-install: Allow recursive copying of theme dirs | DROP | Already in master |  |
| 2025-12-0039 | [RESEND PATCH] UEFI: Fix several memory leaks of UEFI han... | DROP | Already in master |  |
| 2025-12-0051 | [PATCH] grub-mkimage: Add SBAT metadata check | KEEP | | |
| 2025-12-0052 | [PATCH v3 2/5] blsuki: fix position of DIR parameter in b... | DROP | Already in master |  |
| 2025-12-0053 | [PATCH v3 5/5] blsuki: error out if unexpected arguments ... | DROP | Already in master |  |
| 2025-12-0055 | [PATCH v3 1/5] blsuki: fix typo in entry parameter descri... | DROP | Already in master |  |
| 2025-12-0056 | [PATCH v3 4/5] blsuki: fix default location in commment to | DROP | Already in master |  |
| 2025-12-0057 | [PATCH v3 3/5] blsuki: use specified device in case of fa... | DROP | Already in master |  |
| 2025-12-0072 | [PATCH 1/1] INSTALL: Add new requirement for configure | KEEP | | |
| 2025-12-0076 | [PATCH] kern/efi/sb: Enable loading | DROP | Already in master |  |
| 2025-12-0083 | [PATCH v2] grub-mkimage: Fix empty SBAT metadata file issue | KEEP | | |
| 2025-12-0084 | [PATCH v2] appendedsig: Fix grub-mkimage with an unaligne... | DROP | Already in master | 2026-01-0006 |
| 2025-12-0089 | [PATCH] configure: Defer check for -mcmodel=large until P... | DROP | Already in master |  |

### 2026-01 (18 branches: 9 remain, 9 drop)

| Branch | Subject | Decision | Reason | Superseded by |
|--------|---------|----------|--------|---------------|
| 2026-01-0004 | [PATCH v3] tests: add functional tests for ecb/cbc helpers | DROP | Older version | 2026-01-0005 |
| 2026-01-0005 | [PATCH v4] tests: add functional tests for ecb/cbc helpers | KEEP | | |
| 2026-01-0006 | [PATCH v3] appendedsig: Fix grub-mkimage with an unaligne... | DROP | Already in master |  |
| 2026-01-0011 | Re: [PATCH v2] grub-mkimage: Fix empty SBAT metadata file... | DROP | Reply only |  |
| 2026-01-0014 | [PATCH v3] ieee1275 : Add a check for invalid partition n... | DROP | Older version | 2026-01-0018 |
| 2026-01-0015 | Re: [PATCH v3] ieee1275 : Add a check for invalid partiti... | DROP | Reply only |  |
| 2026-01-0018 | [PATCH v4] ieee1275 : Add a check for invalid partition n... | KEEP | | |
| 2026-01-0019 | [RFC] Feature proposal: EFI variable check to enter grub ... | KEEP | | |
| 2026-01-0021 | [PATCH] configure: print a more helpful error if autoconf... | KEEP | | |
| 2026-01-0024 | Re: [RFC] Feature proposal: EFI variable check to enter g... | DROP | Reply only |  |
| 2026-01-0026 | [PATCH] build: Add grub-core/tests/crypto_cipher_mode_vec... | DROP | Already in master |  |
| 2026-01-0031 | [PATCH] mmap/mmap: Fix integer overflow in binary search | KEEP | | |
| 2026-01-0036 | Re: [PATCH] mmap/mmap: Fix integer overflow in binary search | DROP | Reply only |  |
| 2026-01-0053 | Problems compiling 2.xx for AROS. | KEEP | | |
| 2026-01-0058 | [PATCH 4/5] Revert "configure: Check linker for --image-b... | KEEP | | |
| 2026-01-0059 | [PATCH 5/5] configure: drop -Ttext checks for i386-pc | DROP | Resend | 2026-03-0012 |
| 2026-01-0076 | Re: [PATCH v4] Mandatory install device check for PowerPC | KEEP | | |
| 2026-01-0079 | [PATCH] commands/linux: verify kernel file size | KEEP | | |

### 2026-02 (27 branches: 8 remain, 19 drop)

| Branch | Subject | Decision | Reason | Superseded by |
|--------|---------|----------|--------|---------------|
| 2026-02-0012 | [PATCH v2 8/8] C23 fixes: fix strchr() and strrchr() hand... | KEEP | | |
| 2026-02-0013 | [PATCH v2 3/8] i386-cygwin-img-ld.sc -> i386-cygwin-img.lds | DROP | Resend | 2026-03-0014 |
| 2026-02-0018 | [PATCH v2 5/8] Revert "configure: Check linker for --imag... | DROP | Resend | 2026-03-0010 |
| 2026-02-0019 | [PATCH v2 7/8] configure: drop -Ttext checks for i386-pc | DROP | Resend | 2026-03-0012 |
| 2026-02-0031 | [PATCH] Fix build with glibc 2.43 after new ISO C23 changes | KEEP | | |
| 2026-02-0037 | [PATCH 1/3] grub-core/osdep/linux/ofpath.c: Update strstr... | DROP | Older version | 2026-02-0082 |
| 2026-02-0038 | [PATCH 2/3] util/probe.c: save strrchr() ret val to const... | DROP | Already in master |  |
| 2026-02-0039 | [PATCH 3/3] util/resolve.c: Save str[r]chr() ret val to c... | DROP | Already in master |  |
| 2026-02-0043 | [PATCH v3 5/9] Revert "configure: Check linker for --imag... | DROP | Older version | 2026-03-0010 |
| 2026-02-0044 | [PATCH v3 3/9] i386-cygwin-img-ld.sc -> i386-cygwin-img.lds | DROP | Older version | 2026-03-0014 |
| 2026-02-0047 | [PATCH v3 7/9] configure: drop -Ttext checks for i386-pc | DROP | Older version | 2026-03-0012 |
| 2026-02-0048 | [PATCH v3 8/9] configure.ac: Add --image-base check for n... | DROP | Older version | 2026-03-0010 |
| 2026-02-0049 | [PATCH v3 9/9] conf/i386-cygwin-img.lds: Update to use | DROP | Older version | 2026-03-0015 |
| 2026-02-0052 | [PATCH v3 7/9] [corrected] configure: drop -Ttext checks ... | DROP | Older version | 2026-03-0012 |
| 2026-02-0053 | Re: [PATCH v3 1/9] i386/pc/int.h: conditionally apply reg... | DROP | Older version | 2026-03-0010 |
| 2026-02-0054 | Re: [PATCH v3 4/9] Revert "configure: Print a more helpfu... | DROP | Older version | 2026-03-0010 |
| 2026-02-0066 | [PATCH v7 4/6] ieee1275: add support for NVMeoFC | KEEP | | |
| 2026-02-0067 | [PATCH v7 5/6] ieee1275: ofpath enable NVMeoF logical dev... | KEEP | | |
| 2026-02-0068 | [PATCH v7 6/6] ieee1275: support added for multiple nvme ... | KEEP | | |
| 2026-02-0081 | [PATCH v2 2/4] grub-core/osdep/linux/ofpath.c: correct pa... | DROP | Already in master |  |
| 2026-02-0082 | [PATCH v2 1/4] grub-core/osdep/linux/ofpath.c: Update str... | KEEP | | |
| 2026-02-0083 | [PATCH v2 4/4] util/resolve.c: Save str[r]chr() ret val t... | DROP | Already in master |  |
| 2026-02-0084 | [PATCH v2 3/4] util/probe.c: save strrchr() ret val to co... | DROP | Already in master |  |
| 2026-02-0088 | Re: [PATCH] loader/efi/fdt: Ensure FDT blob is 8-byte ali... | DROP | Re: dup | 2026-02-0093 |
| 2026-02-0092 | Re: [PATCH v8 6/6] ieee1275: support added for multiple n... | DROP | Reply only |  |
| 2026-02-0093 | Re: [PATCH] loader/efi/fdt: Ensure FDT blob is 8-byte ali... | KEEP | | |
| 2026-02-0101 | Re: [PATCH] powerpc_ieee1275: Excluding the PKS for grub-... | KEEP | | |

### 2026-03 (11 branches: 8 remain, 3 drop)

| Branch | Subject | Decision | Reason | Superseded by |
|--------|---------|----------|--------|---------------|
| 2026-03-0010 | [PATCH v4 4/9] Revert "configure: Check linker for --imag... | KEEP | | |
| 2026-03-0012 | [PATCH v4 6/9] configure: drop -Ttext checks for i386-pc | KEEP | | |
| 2026-03-0013 | [PATCH v4 7/9] configure.ac: Add --image-base check for n... | DROP | Already in master |  |
| 2026-03-0014 | [PATCH v4 8/9] i386-cygwin-img-ld.sc -> i386-cygwin-img.lds | KEEP | | |
| 2026-03-0015 | [PATCH v4 9/9] conf/i386-cygwin-img.lds: Update to use | KEEP | | |
| 2026-03-0017 | Re: [PATCH v4 0/9] Improve ld.lld-21+ compatibility when ... | KEEP | | |
| 2026-03-0020 | Re: [PATCH] SECURITY: Update security team members names/... | KEEP | | |
| 2026-03-0025 | Re: [PATCH 2/2] MAINTAINERS: update new GRUB git reposito... | DROP | Re: dup | 2026-03-0031 |
| 2026-03-0026 | Re: [PATCH 1/2] MAINTAINERS: update maintainers list | KEEP | | |
| 2026-03-0027 | Re: [PATCH 2/2] MAINTAINERS: update new GRUB git reposito... | DROP | Re: dup | 2026-03-0031 |
| 2026-03-0031 | Re: [PATCH 2/2] MAINTAINERS: update new GRUB git reposito... | KEEP | | |

---

## Remaining Branches

347 branches remain after all filtering.

| # | Branch | Author | Date | Subject |
|---|--------|--------|------|---------|
| 1 | 2025-01-0018 | Glenn Washburn | 2025-01-04 | [PATCH] docs: Replace @lbracechar{} and @rbracechar{} with @{ and @} |
| 2 | 2025-01-0019 | Glenn Washburn | 2025-01-04 | [PATCH] docs: Do not reference non-existent "--dumb" option |
| 3 | 2025-01-0033 | Patrick Plenefisch | 2025-01-04 | [PATCH 6/6 v13] lvm: Add support for cachevol lv |
| 4 | 2025-01-0034 | Patrick Plenefisch | 2025-01-04 | [PATCH 5/6 v13] lvm: add informational messages in error cases of |
| 5 | 2025-01-0035 | Patrick Plenefisch | 2025-01-04 | [PATCH 4/6 v13] lvm: Add support for integrity lv |
| 6 | 2025-01-0036 | Patrick Plenefisch | 2025-01-04 | [PATCH 3/6 v13] lvm: Match all lvm segments before validation |
| 7 | 2025-01-0037 | Patrick Plenefisch | 2025-01-04 | [PATCH 2/6 v13] disk/lvm: Remove unused cache_pool |
| 8 | 2025-01-0038 | Patrick Plenefisch | 2025-01-04 | [PATCH 1/6 v13] disk/lvm: Make cache_lv more generic as |
| 9 | 2025-01-0094 | Benjamin Herrenschmidt | 2025-01-21 | [PATCH] term/nns8250-spcr: return if redirection is disabled |
| 10 | 2025-01-0096 | Leo Sandoval | 2025-01-22 | Re: [PATCH] term/ns8250: return in case of a null SPCR base addresses |
| 11 | 2025-01-0098 | Egor Ignatov | 2025-01-23 | [PATCH 2/3] fs/xfs: Fix grub_xfs_iterate_dir return value in case of |
| 12 | 2025-01-0099 | Egor Ignatov | 2025-01-23 | [PATCH 3/3] fs/xfs: Propagate incorrect inode error from |
| 13 | 2025-02-0002 | Darrick J. Wong | 2025-02-03 | [PATCH] fs/xfs: add new superblock features added in Linux 6.12/6.13 |
| 14 | 2025-02-0105 | Andrew Hamilton | 2025-02-19 | Re: [SECURITY PATCH 49/73] fs: Disable many filesystems under lockdown |
| 15 | 2025-02-0116 | Michael Chang | 2025-02-21 | [PATCH] fs/ext2: Rework out-of-bounds read for inline and external |
| 16 | 2025-02-0126 | Pascal Hambourg | 2025-02-21 | [PATCH v2 RESEND] util/grub.d/30_os-prober.in: Fix |
| 17 | 2025-02-0139 | Pascal Hambourg | 2025-02-24 | [PATCH v2 RESEND] util/grub.d/30_os-prober.in: Conditionally show or |
| 18 | 2025-02-0195 | Andrew Hamilton | 2025-02-28 | [PATCH 1/2] docs: Document Restricted Filesystems in Lockdown |
| 19 | 2025-03-0012 | Glenn Washburn | 2025-03-01 | [PATCH v6 1/6] commands/ls: Return proper GRUB_ERR_* for functions |
| 20 | 2025-03-0014 | Glenn Washburn | 2025-03-01 | [PATCH v6 2/6] commands/ls: Merge print_files_long and print_files |
| 21 | 2025-03-0015 | Glenn Washburn | 2025-03-01 | [PATCH v6 3/6] commands/ls: Show modification time for file paths |
| 22 | 2025-03-0017 | Glenn Washburn | 2025-03-01 | [PATCH v6 5/6] commands/ls: Print full paths for file args |
| 23 | 2025-03-0034 | Glenn Washburn | 2025-03-03 | [PATCH v2 3/6] tests/grub_cmd_cryptomount: Cleanup the cryptsetup |
| 24 | 2025-03-0055 | Vladimir Serbinenko | 2025-03-04 | [PATCH v2] bsd: Fix type passed for the kernel |
| 25 | 2025-03-0058 | Glenn Washburn | 2025-03-06 | [PATCH] tests/util/grub-shell: Default qemuopts to envvar |
| 26 | 2025-03-0059 | Yann Diorcet | 2025-03-06 | [PATCH] tss2: restore buffer offset on tpm2_submit_command retry |
| 27 | 2025-03-0061 | Diorcet Yann | 2025-03-06 | [PATCH] key_protector: Add systemd TPM2 Key Protector |
| 28 | 2025-03-0065 | Mate Kukri | 2025-03-10 | [PATCH v2 2/2] efi: Use shim's loader protocol for EFI image |
| 29 | 2025-03-0073 | Stuart Hayes | 2025-03-10 | [PATCH] fs/zfs: Fix a number of memory leaks in ZFS code |
| 30 | 2025-03-0093 | Avnish Chouhan | 2025-03-13 | [PATCH v4] powerpc: increase MIN RMA size for CAS negotiation |
| 31 | 2025-03-0124 | Nicolas Frayer | 2025-03-19 | [PATCH] ieee1275/ofnet: Fix grub_malloc() removed after added safe |
| 32 | 2025-03-0130 | Andrew Hamilton | 2025-03-20 | [PATCH v2] fs/ntfs: Check at->attr_cur after calling next_attribute() |
| 33 | 2025-03-0134 | Andrew Hamilton | 2025-03-20 | [PATCH v3] fs/ntfs: Correct NULL Deref / Possible Infinite Loop |
| 34 | 2025-03-0186 | Daniel Axtens | 2025-03-27 | [PATCH v2 05/21] pgp: factor out rsa_pad |
| 35 | 2025-03-0187 | Rashmica Gupta | 2025-03-27 | [PATCH v2 01/21] powerpc-ieee1275: Add support for signing grub with |
| 36 | 2025-03-0189 | Daniel Axtens | 2025-03-27 | [PATCH v2 04/21] dl: provide a fake grub_dl_set_persistent for the |
| 37 | 2025-03-0190 | Daniel Axtens | 2025-03-27 | [PATCH v2 06/21] crypto: move storage for grub_crypto_pk_* to crypto.c |
| 38 | 2025-03-0191 | Alastair D'Silva | 2025-03-27 | [PATCH v2 07/21] grub-install: support embedding x509 certificates |
| 39 | 2025-03-0192 | Daniel Axtens | 2025-03-27 | [PATCH v2 08/21] appended signatures: import GNUTLS's ASN.1 |
| 40 | 2025-03-0193 | Daniel Axtens | 2025-03-27 | [PATCH v2 10/21] appended signatures: support verifying appended |
| 41 | 2025-03-0194 | Daniel Axtens | 2025-03-27 | [PATCH v2 09/21] appended signatures: parse PKCS#7 signedData and |
| 42 | 2025-03-0195 | Daniel Axtens | 2025-03-27 | [PATCH v2 12/21] appended signatures: documentation |
| 43 | 2025-03-0197 | Daniel Axtens | 2025-03-27 | [PATCH v2 13/21] ieee1275: enter lockdown based on /ibm,secure-boot |
| 44 | 2025-03-0198 | Sudhakar Kuppusamy | 2025-03-27 | [PATCH v2 14/21] ieee1275: Platform Keystore (PKS) Support |
| 45 | 2025-03-0199 | Sudhakar Kuppusamy | 2025-03-27 | [PATCH v2 15/21] ieee1275: Read the DB and DBX secure boot variables |
| 46 | 2025-03-0200 | Sudhakar Kuppusamy | 2025-03-27 | [PATCH v2 16/21] appendedsig: The creation of trusted and distrusted |
| 47 | 2025-03-0201 | Sudhakar Kuppusamy | 2025-03-27 | [PATCH v2 17/21] appendedsig: While verifying the kernel, |
| 48 | 2025-03-0202 | Sudhakar Kuppusamy | 2025-03-27 | [PATCH v2 19/21] appendedsig: Reads the default DB keys from ELF Note |
| 49 | 2025-03-0203 | Sudhakar Kuppusamy | 2025-03-27 | [PATCH v2 18/21] powerpc_ieee1275: set use_static_keys flag |
| 50 | 2025-03-0204 | Sudhakar Kuppusamy | 2025-03-27 | [PATCH v2 20/21] appendedsig: The grub command's trusted and |
| 51 | 2025-03-0205 | Sudhakar Kuppusamy | 2025-03-27 | [PATCH v2 21/21] appendedsig: documentation |
| 52 | 2025-03-0207 | Vladimir Serbinenko | 2025-03-27 | [PATCH] configure: Add -mno-relax on riscv* |
| 53 | 2025-03-0210 | Lidong Chen | 2025-03-27 | [PATCH 3/5] loader/i386/linux: Fix resource leak |
| 54 | 2025-03-0214 | Vladimir 'phcoder' Serbin | 2025-03-27 | Re: [PATCH 4/5] fs/btrfs: Fix memory leaks |
| 55 | 2025-03-0215 | Vladimir 'phcoder' Serbin | 2025-03-27 | Re: [PATCH 2/5] lib/reloacator: Fix memory leaks |
| 56 | 2025-03-0216 | Vladimir 'phcoder' Serbin | 2025-03-27 | Re: [PATCH 5/5] loader/xnu: Fix memory leak |
| 57 | 2025-03-0226 | Vladimir Serbinenko | 2025-03-29 | [PATCH 2/2] Remove qemu_mips port |
| 58 | 2025-04-0009 | Vladimir 'phcoder' Serbin | 2025-04-01 | Re: [PATCH GRUB] fs/xfs: fix large extent counters incompat feature |
| 59 | 2025-04-0011 | Vladimir Serbinenko | 2025-04-01 | [PATCH 7/7] Remove now unneeded gcrypt compilation flag |
| 60 | 2025-04-0013 | Vladimir Serbinenko | 2025-04-01 | [PATCH 4/7] Add DSA and RSA SEXP tests |
| 61 | 2025-04-0014 | Vladimir Serbinenko | 2025-04-01 | [PATCH 3/7] Adjust import script, |
| 62 | 2025-04-0015 | Vladimir Serbinenko | 2025-04-01 | [PATCH 5/7] keccak: Disable acceleration with SSE asm |
| 63 | 2025-04-0016 | Vladimir Serbinenko | 2025-04-01 | [PATCH 1/7] Import libgcrypt 1.10.3 |
| 64 | 2025-04-0029 | khaliid caliy | 2025-04-03 | Subject: [PATCH] loader/efi: Enhance error messages in chainloader |
| 65 | 2025-04-0031 | Patrick Colp | 2025-04-03 | [PATCH v2 1/1] include/grub/i386/linux: Update linux_kernel_params to |
| 66 | 2025-04-0032 | khaliid caliy | 2025-04-04 | [RESEND PATCH 1/1] loader/efi/chainloader: Enhance error messages in |
| 67 | 2025-04-0048 | khaliid caliy | 2025-04-04 | [PATCH] kern/x86_64/efi/startup: Suggestion in the startup code |
| 68 | 2025-04-0054 | khaliid caliy | 2025-04-04 | Re: [RESEND PATCH 1/1] loader/efi/chainloader: Enhance error messages |
| 69 | 2025-04-0057 | Gary Lin | 2025-04-07 | [PATCH v5 02/13] tpm2_key_protector: Add 'tpm2_dump_pcr' command |
| 70 | 2025-04-0059 | Gary Lin | 2025-04-07 | [PATCH v5 01/13] tpm2_key_protector: dump PCRs on policy fail |
| 71 | 2025-04-0061 | Gary Lin | 2025-04-07 | [PATCH v5 04/13] tss2: Add TPM 2.0 NV index commands |
| 72 | 2025-04-0063 | Gary Lin | 2025-04-07 | [PATCH v5 06/13] tpm2_key_protector: Support NV index handles |
| 73 | 2025-04-0064 | Gary Lin | 2025-04-07 | [PATCH v5 07/13] util/grub-protect: Support NV index mode |
| 74 | 2025-04-0065 | Gary Lin | 2025-04-07 | [PATCH v5 08/13] tests/tpm2_key_protector_test: Simplify the NV index |
| 75 | 2025-04-0066 | Gary Lin | 2025-04-07 | [PATCH v5 09/13] tests/tpm2_key_protector_test: Reset 'ret' on fail |
| 76 | 2025-04-0069 | Gary Lin | 2025-04-07 | [PATCH v5 13/13] docs: Document the long options of |
| 77 | 2025-04-0070 | Gary Lin | 2025-04-07 | [PATCH v5 10/13] tests/tpm2_key_protector_test: Add more NV index |
| 78 | 2025-04-0075 | Vladimir 'phcoder' Serbin | 2025-04-07 | Re: [PATCH] arm64: Limit memory allocations to 4GB boundary |
| 79 | 2025-04-0094 | Vladimir Serbinenko | 2025-04-08 | [PATCH 3/3] Use ET_DYN images and PHDRs for creating relocatable |
| 80 | 2025-04-0108 | Vladimir Serbinenko | 2025-04-08 | [PATCH] Disable gfxterm_menu and cmdline_cat tests |
| 81 | 2025-04-0116 | Vladimir Serbinenko | 2025-04-10 | [PATCH] ia64: Disable optimizations using floating-point arithmetics |
| 82 | 2025-04-0125 | Vladimir Serbinenko | 2025-04-10 | [PATCH v11 03/14] b64dec: Adjust for compilation in GRUB environment |
| 83 | 2025-04-0142 | Renaud Métrich | 2025-04-11 | [PATCH 2/2] Prepend debug traces with absolute and relative timestamps |
| 84 | 2025-04-0143 | Leo Sandoval | 2025-04-11 | [PATCH 1/2] Include function name on debug traces |
| 85 | 2025-04-0146 | Alec Brown | 2025-04-12 | [PATCH v3 1/3] blsuki: Add blscfg command to parse Boot Loader |
| 86 | 2025-04-0147 | Alec Brown | 2025-04-12 | [PATCH v3 2/3] blsuki: Check for mounted /boot in emu |
| 87 | 2025-04-0148 | Alec Brown | 2025-04-12 | [PATCH v3 3/3] blsuki: Add uki command to load Unified Kernel Image |
| 88 | 2025-04-0196 | Vladimir 'phcoder' Serbin | 2025-04-16 | Re: [PATCH] efi/mm: relax memory type request we're asking for from |
| 89 | 2025-04-0211 | Andrew Hamilton | 2025-04-18 | [PATCH v3 2/2] date_unit_test: test dates outside of 32-bit unix range |
| 90 | 2025-04-0215 | Vladimir 'phcoder' Serbin | 2025-04-18 | Re: [PATCH] kern/efi/mm: try allocating in the lower 4GB first |
| 91 | 2025-04-0238 | Vladimir 'phcoder' Serbin | 2025-04-23 | Re: [PATCH 1/2] x86_64-efi: Ensure that memory is mapped when |
| 92 | 2025-04-0239 | Vladimir 'phcoder' Serbin | 2025-04-23 | Re: [PATCH 2/2] kern/efi/mm: ask for more that 4GB if we need it |
| 93 | 2025-04-0242 | Yair Yarom | 2025-04-23 | Testing for specific PCI devices |
| 94 | 2025-04-0249 | Aaron Rainbolt | 2025-04-23 | [PATCH 1/1] Add Xen command line parsing |
| 95 | 2025-04-0266 | Alec Brown | 2025-05-01 | [RFC PATCH v2 2/7] i386: Add PSP discovery code |
| 96 | 2025-04-0267 | Alec Brown | 2025-05-01 | [RFC PATCH v2 3/7] slaunch/psp: Add core PSP commands and get |
| 97 | 2025-04-0268 | Alec Brown | 2025-05-01 | [RFC PATCH v2 4/7] slaunch/psp: Setup TMRs to protect RAM from DMA |
| 98 | 2025-04-0270 | Ross Philipson | 2025-05-01 | [RFC PATCH v2 1/7] i386: Extra x86 definitions needed by AMD SKINIT |
| 99 | 2025-04-0271 | Ross Philipson | 2025-05-01 | [RFC PATCH v2 5/7] slaunch/skinit: AMD SKINIT Secure Launch core |
| 100 | 2025-04-0272 | Ross Philipson | 2025-05-01 | [RFC PATCH v2 6/7] efi: Add AMD SKINIT Secure Launch support |
| 101 | 2025-04-0273 | Michał Żygowski | 2025-05-01 | [RFC PATCH v2 7/7] multiboot2: Support SKINIT Secure Launch |
| 102 | 2025-05-0008 | Vladimir Serbinenko | 2025-05-03 | [PATCH] ntfs: Fix attribute validation check |
| 103 | 2025-05-0025 | Vladimir Serbinenko | 2025-05-03 | [PATCH v2] ia64: Disable optimizations using floating-point |
| 104 | 2025-05-0032 | Glenn Washburn | 2025-05-05 | [PATCH] tests: Disable gfxterm_menu and cmdline_cat tests |
| 105 | 2025-05-0033 | Glenn Washburn | 2025-05-05 | [PATCH] fs/zfs: Fix another memory leak in ZFS code |
| 106 | 2025-05-0037 | khaliid caliy | 2025-05-07 | [PATCH v2 1/1] loader/efi/linux: Enhance linux command error messages |
| 107 | 2025-05-0044 | Maxim Suhanov | 2025-05-08 | [SECURITY PATCH 2/8] commands/search: Introduce the --cryptodisk-only |
| 108 | 2025-05-0046 | Maxim Suhanov | 2025-05-08 | [SECURITY PATCH 5/8] docs: Document available crypto disks checks |
| 109 | 2025-05-0055 | Vladimir 'phcoder' Serbin | 2025-05-09 | Re: [SECURITY PATCH 8/8] cryptocheck: Add --quiet option |
| 110 | 2025-05-0056 | Vladimir 'phcoder' Serbin | 2025-05-09 | Re: [SECURITY PATCH 7/8] disk/cryptodisk: Wipe the passphrase from |
| 111 | 2025-05-0057 | Vladimir 'phcoder' Serbin | 2025-05-09 | Re: [SECURITY PATCH 6/8] disk/cryptodisk: Add the "erase secrets" |
| 112 | 2025-05-0058 | Vladimir 'phcoder' Serbin | 2025-05-09 | Re: [SECURITY PATCH 4/8] commands/search: Add the diskfilter support |
| 113 | 2025-05-0059 | Vladimir 'phcoder' Serbin | 2025-05-09 | Re: [SECURITY PATCH 3/8] disk/diskfilter: Introduce the "cryptocheck" |
| 114 | 2025-05-0060 | Vladimir 'phcoder' Serbin | 2025-05-09 | Re: [SECURITY PATCH 2/8] commands/search: Introduce the |
| 115 | 2025-05-0062 | khaalid | 2025-05-10 | [PATCH v2] commands/efi: add a command to dump all uefi runtime |
| 116 | 2025-05-0064 | khaalid | 2025-05-11 | [PATCH v3] commands/efi: add command to dump all uefi runtime |
| 117 | 2025-05-0072 | Vladimir 'phcoder' Serbin | 2025-05-12 | Re: [PATCH v5] commands/efi: dump all uefi runtime variables |
| 118 | 2025-05-0075 | Vladimir 'phcoder' Serbin | 2025-05-12 | Re: [PATCH v2] testpci: initial module |
| 119 | 2025-05-0076 | khaalid | 2025-05-12 | [PATCH v3 0/1] loader/efi/chainloader: Enhance error message of |
| 120 | 2025-05-0077 | khaalid | 2025-05-12 | [PATCH v3 1/1] loader/efi/linux: Enhance error message of linux |
| 121 | 2025-05-0082 | hao chen | 2025-05-14 | Fwd: [PATCH] efi/tpcm: Add TPCM module support |
| 122 | 2025-05-0083 | Marta Lewandowska | 2025-05-14 | Re: [PATCH v2] grub-probe: detect DDF container similar to IMSM |
| 123 | 2025-05-0108 | khaalid | 2025-05-16 | [PATCH v2 0/3] commands/efi/lsefi: Fix memory leak |
| 124 | 2025-05-0113 | Andrew Hamilton | 2025-05-16 | [PATCH 1/3] fs/ntfs: Correct some NTFS regressions |
| 125 | 2025-05-0114 | Andrew Hamilton | 2025-05-16 | [PATCH 2/3] fs/fshelp: Avoid possible NULL pointer deference |
| 126 | 2025-05-0115 | Andrew Hamilton | 2025-05-16 | [PATCH 3/3] fs/ntfs: Correct possible access violations and hangs |
| 127 | 2025-05-0118 | Vladimir 'phcoder' Serbin | 2025-05-17 | Re: [PATCH 2/3] fs/fshelp: Avoid possible NULL pointer deference |
| 128 | 2025-05-0132 | Vladimir 'phcoder' Serbin | 2025-05-19 | Re: [PATCH v1 1/2] envblk: ignore empty new lines while parsing env |
| 129 | 2025-05-0151 | khaalid cali | 2025-05-20 | [PATCH 0/2] commands/efi: Fix sevral memory leaks |
| 130 | 2025-05-0153 | khaalid cali | 2025-05-20 | [PATCH 2/2 ] loader/efi/linux: Fix memory leak |
| 131 | 2025-05-0166 | Andrew Hamilton | 2025-05-21 | [PATCH v3 2/5] fs/ntfs: Correct attribute vs attribute list validation |
| 132 | 2025-05-0167 | Andrew Hamilton | 2025-05-21 | [PATCH v3 3/5] fs/ntfs: Correct possible access violations |
| 133 | 2025-05-0201 | Jiří 'bindiff' Wolker | 2025-05-26 | [PATCH 1/2] Exporting variables to upper levels |
| 134 | 2025-05-0202 | Jiří 'bindiff' Wolker | 2025-05-26 | =?UTF-8?Q?=5BPATCH_2/2=5D_Docs_for_the_new_options_of_the_=E2=80=98?= |
| 135 | 2025-05-0222 | Vladimir 'phcoder' Serbin | 2025-05-27 | Re: [PATCH v2 2/3] Option to set title of submenus |
| 136 | 2025-05-0256 | cyber | 2025-05-31 | Regarding bug in affs filesystem parser |
| 137 | 2025-06-0002 | Andrew Hamilton | 2025-06-01 | [PATCH 1/1] fs/ntfs.c: Correct next_attribute validation |
| 138 | 2025-06-0011 | Lidong Chen | 2025-06-05 | [PATCH] unix/hostdisk: Fix signed integer overflow |
| 139 | 2025-06-0031 | Gary Lin | 2025-06-09 | [PATCH 3/3] tests/tpm2_key_protector_test: Add tests for SHA384 PCR |
| 140 | 2025-06-0040 | Alec Brown | 2025-06-10 | [PATCH 2/2] gnulib/regexec: Fix resource leak |
| 141 | 2025-06-0041 | Alec Brown | 2025-06-10 | [PATCH 1/2] gnulib/regcomp: Fix resource leak |
| 142 | 2025-06-0045 | Sudhakar Kuppusamy | 2025-06-10 | [PATCH 1/2] appendedsig: The grub command's trusted and distrusted |
| 143 | 2025-06-0092 | Andrew Hamilton | 2025-06-10 | [PATCH 2/2] build: Add new header files to dist to allow building |
| 144 | 2025-06-0096 | Lidong Chen | 2025-06-12 | [PATCH v2] lib/LzmaEnc: Validate 'len' before subtracting |
| 145 | 2025-06-0101 | Gary Lin | 2025-06-13 | [PATCH v2 2/3] tpm2_key_protector: Dump the PCR bank for key unsealing |
| 146 | 2025-06-0117 | Andrew Hamilton | 2025-06-17 | [PATCH v2 1/2] gnulib: Add patch to allow GRUB w/GCC-15 compile |
| 147 | 2025-06-0121 | Andrew Hamilton | 2025-06-18 | Re: [PATCH] Create a Containerfile with required grub packages for |
| 148 | 2025-06-0133 | Lidong Chen | 2025-06-18 | [PATCH 1/2] gnulib: Bring back the fix for resolving unused variable |
| 149 | 2025-06-0142 | Andrew Hamilton | 2025-06-21 | [PATCH 1/1] tests: Correct netboot and file_filter test failure |
| 150 | 2025-06-0143 | Andrew Hamilton | 2025-06-21 | Re: [PATCH v2] Create Containerfiles with required grub packages for |
| 151 | 2025-06-0177 | Frediano Ziglio | 2025-06-25 | [PATCH v4 1/6] loader/efi/linux: Remove useless assignment |
| 152 | 2025-06-0178 | Frediano Ziglio | 2025-06-25 | [PATCH v4 3/6] loader/efi/linux: Do not pass excessive size for |
| 153 | 2025-06-0179 | Frediano Ziglio | 2025-06-25 | [PATCH v4 5/6] loader/efi/linux: Use sizeof instead of constant |
| 154 | 2025-06-0182 | Frediano Ziglio | 2025-06-25 | [PATCH v4 6/6] loader/efi/linux: Correctly terminate LoadOptions field |
| 155 | 2025-07-0004 | chench246 | 2025-07-02 | [PATCH v3 1/2] efi/tpcm: Add UEFI interface for TPCM module |
| 156 | 2025-07-0027 | Frediano Ziglio | 2025-07-07 | [PATCH v2] arm64/xen: Consider alignment calling |
| 157 | 2025-07-0029 | Vladimir Serbinenko | 2025-07-07 | [PATCH v14 02/15] Import b64dec from gpg-error |
| 158 | 2025-07-0031 | Vladimir Serbinenko | 2025-07-07 | [PATCH v14 04/15] Adjust import script, |
| 159 | 2025-07-0032 | Vladimir Serbinenko | 2025-07-07 | [PATCH v14 05/15] Add DSA and RSA SEXP tests |
| 160 | 2025-07-0033 | Vladimir Serbinenko | 2025-07-07 | [PATCH v14 01/15] Import libgcrypt 1.11 |
| 161 | 2025-07-0034 | Vladimir Serbinenko | 2025-07-07 | [PATCH v14 07/15] libgcrypt: Fix coverity warnings |
| 162 | 2025-07-0035 | Vladimir Serbinenko | 2025-07-07 | [PATCH v14 08/15] Remove now unneeded gcrypt compilation flag |
| 163 | 2025-07-0037 | Vladimir Serbinenko | 2025-07-07 | [PATCH v14 09/15] gcry: Ignore sign-compare warnings |
| 164 | 2025-07-0038 | Vladimir Serbinenko | 2025-07-07 | [PATCH v14 11/15] import_gcry: Make compatible with python 3.4 |
| 165 | 2025-07-0039 | Vladimir Serbinenko | 2025-07-07 | [PATCH v14 14/15] libgcrypt: Fix a memory leak |
| 166 | 2025-07-0040 | Vladimir Serbinenko | 2025-07-07 | [PATCH v14 10/15] libgcrypt: Import blake family of hashes |
| 167 | 2025-07-0042 | Vladimir Serbinenko | 2025-07-07 | [PATCH v14 12/15] import_gcry: Fix pylint warnings |
| 168 | 2025-07-0047 | Frediano Ziglio | 2025-07-08 | [RFC PATCH 5/5] arm64/xen: Allows to use kernel command line from |
| 169 | 2025-07-0050 | Frediano Ziglio | 2025-07-08 | [RFC PATCH 4/5] arm64/xen: Use LoadFile2 protocol for Xen boot |
| 170 | 2025-07-0057 | Frediano Ziglio | 2025-07-08 | [RFC PATCH 2/5] kern/list: Add a grub_list_append function |
| 171 | 2025-07-0065 | Julian Andres Klode | 2025-07-08 | [PATCH v5 1/5] efi: Provide wrappers for load_image, start_image, |
| 172 | 2025-07-0066 | Mate Kukri | 2025-07-08 | [PATCH v5 3/5] efi/sb: Add API for retrieving shim loader image |
| 173 | 2025-07-0068 | Mate Kukri | 2025-07-08 | [PATCH v5 2/5] efi/sb: Add support for the shim loader protocol |
| 174 | 2025-07-0069 | Mate Kukri | 2025-07-08 | [PATCH v5 5/5] loader/efi/linux: Use shim loader image handle where |
| 175 | 2025-07-0130 | Michael Chang | 2025-07-11 | [PATCH] Support environment block in btrfs reserved area |
| 176 | 2025-07-0189 | Gary Lin | 2025-07-18 | [RFC PATCH 2/6] Copy the x86_64 optimization files |
| 177 | 2025-07-0212 | Mate Kukri | 2025-07-24 | [PATCH v2 1/2] conf: Add new libgcrypt and libtasn1 related files to |
| 178 | 2025-07-0218 | Luca Boccassi | 2025-07-25 | [PATCH v2] bli: set LoaderTpm2ActivePcrBanks runtime variable |
| 179 | 2025-07-0224 | Aaron Rainbolt | 2025-07-25 | [RESEND PATCH v3 1/1] kern/xen: Add Xen command line parsing |
| 180 | 2025-07-0287 | Gary Lin | 2025-07-31 | [PATCH 1/7] argon2: Extract Argon2 code from libgcrypt |
| 181 | 2025-07-0291 | Gary Lin | 2025-07-31 | [PATCH 5/7] disk/luks2: Add Argon2 support |
| 182 | 2025-07-0292 | Gary Lin | 2025-07-31 | [PATCH 6/7] tests/util/grub-fs-tester: Use Argon2id for LUKS2 test |
| 183 | 2025-07-0293 | Gary Lin | 2025-07-31 | [PATCH 2/7] argon2: Introduce grub_crypto_argon2() |
| 184 | 2025-08-0009 | Vladimir 'phcoder' Serbin | 2025-08-01 | Re: [PATCH v5 1/5] kern/misc: Implement grub_strtok() |
| 185 | 2025-08-0012 | Vladimir Serbinenko | 2025-08-01 | [PATCH 1/2] zfs: Rewrite endianness handling |
| 186 | 2025-08-0013 | Vladimir Serbinenko | 2025-08-01 | [PATCH 2/2] zfs: Support datto encryption |
| 187 | 2025-08-0048 | Vladimir Serbinenko | 2025-08-11 | [PATCH v2] relocator: Switch to own page table while moving chunks |
| 188 | 2025-08-0051 | Alec Brown | 2025-08-12 | [PATCH v6 5/5] blsuki: Add uki command to load Unified Kernel Image |
| 189 | 2025-08-0052 | Robbie Harwood | 2025-08-12 | [PATCH v6 4/5] blsuki: Check for mounted /boot in emu |
| 190 | 2025-08-0054 | Peter Jones | 2025-08-12 | [PATCH v6 2/5] blsuki: Add blscfg command to parse Boot Loader |
| 191 | 2025-08-0076 | Aaron Rainbolt | 2025-08-13 | [PATCH v5 1/3] include/xen: Rename MAX_GUEST_CMDLINE to |
| 192 | 2025-08-0077 | Aaron Rainbolt | 2025-08-13 | [PATCH v5 2/3] include/xen: Add warning comment for cmd_line |
| 193 | 2025-08-0079 | Aaron Rainbolt | 2025-08-13 | [PATCH v5 3/3] kern/xen: Add Xen command line parsing |
| 194 | 2025-08-0115 | Kancy Joe | 2025-08-19 | [PATCH] efi/console: treat scan_code 0x0102 (suspend) as enter. |
| 195 | 2025-08-0146 | Vladimir 'phcoder' Serbin | 2025-08-21 | Re: [PATCH v2 2/9] crypto: Update crypto.h for libgcrypt KDF functions |
| 196 | 2025-08-0147 | Vladimir 'phcoder' Serbin | 2025-08-21 | Re: [PATCH v2 1/9] util/import_gcry: Import kdf.c for Argon2 |
| 197 | 2025-08-0153 | Vladimir 'phcoder' Serbin | 2025-08-21 | Re: [PATCH v2 9/9] docs: Document argon2 and argon2_test |
| 198 | 2025-08-0164 | Vladimir 'phcoder' Serbin | 2025-08-23 | Re: [PATCH 1/1] po: Update Translations to Build with Gettext 0.26 |
| 199 | 2025-08-0167 | Andrew Hamilton | 2025-08-23 | [PATCH 1/1] bootstrap: Ensure shallow GNULIB clone Works on Newer GIT |
| 200 | 2025-08-0173 | Andrew Hamilton | 2025-08-23 | [PATCH 1/2] INSTALL: Document Libtasn1 Needed for grub-protect |
| 201 | 2025-08-0174 | Andrew Hamilton | 2025-08-23 | [PATCH 2/2] BUGS: Update to Point to Bug Tracking System |
| 202 | 2025-08-0182 | Andrew Hamilton | 2025-08-24 | [PATCH 3/4] docs: Update Future Section to Reflect Current Release |
| 203 | 2025-08-0184 | Andrew Hamilton | 2025-08-24 | [PATCH 2/4] docs: Document New libgrypt Modules |
| 204 | 2025-08-0185 | Andrew Hamilton | 2025-08-24 | [PATCH 4/4] docs: Correct Some URLs |
| 205 | 2025-08-0194 | Sudhakar Kuppusamy | 2025-08-25 | [PATCH v9 07/21] appended signatures: Parse PKCS#7 signedData |
| 206 | 2025-08-0196 | Sudhakar Kuppusamy | 2025-08-25 | [PATCH v9 08/21] appended signatures: Parse X.509 certificates |
| 207 | 2025-08-0198 | Sudhakar Kuppusamy | 2025-08-25 | [PATCH v9 14/21] appended signatures: Using db and dbx lists for |
| 208 | 2025-08-0199 | Sudhakar Kuppusamy | 2025-08-25 | [PATCH v9 15/21] powerpc_ieee1275: Introduce use_static_keys flag |
| 209 | 2025-08-0200 | Sudhakar Kuppusamy | 2025-08-25 | [PATCH v9 11/21] appended signatures: Introducting GRUB commands to |
| 210 | 2025-08-0201 | Sudhakar Kuppusamy | 2025-08-25 | [PATCH v9 12/21] powerpc_ieee1275: Read the db and dbx secure boot |
| 211 | 2025-08-0203 | Sudhakar Kuppusamy | 2025-08-25 | [PATCH v9 16/21] appended signatures: Read default db keys from the |
| 212 | 2025-08-0204 | Sudhakar Kuppusamy | 2025-08-25 | [PATCH v9 17/21] appended signatures: Introduce GRUB commands to |
| 213 | 2025-08-0205 | Sudhakar Kuppusamy | 2025-08-25 | [PATCH v9 18/21] appended signatures: Verification tests |
| 214 | 2025-08-0206 | Sudhakar Kuppusamy | 2025-08-25 | [PATCH v9 20/21] docs/grub: Document signing GRUB with an appended |
| 215 | 2025-08-0207 | Daniel Axtens | 2025-08-25 | [PATCH v9 19/21] docs/grub: Document signing GRUB under UEFI |
| 216 | 2025-08-0208 | Sudhakar Kuppusamy | 2025-08-25 | [PATCH v9 21/21] docs/grub: Document appended signature |
| 217 | 2025-08-0267 | Andrew Hamilton | 2025-08-27 | [PATCH v6 1/2] datetime: Support dates outside of 1901..2038 range |
| 218 | 2025-08-0277 | Andrew Hamilton | 2025-08-30 | [PATCH] libgcrypt: Allow GRUB to Build With Clang |
| 219 | 2025-09-0005 | Gary Lin | 2025-09-02 | [PATCH v3 2/7] tss2: Introduce grub_tcg2_cap_pcr() |
| 220 | 2025-09-0006 | Gary Lin | 2025-09-02 | [PATCH v3 3/7] tss2: Implement grub_tcg2_cap_pcr() for EFI |
| 221 | 2025-09-0020 | Michael Chang | 2025-09-02 | [PATCH v2] tcp: Fix TCP port number reused on reboot |
| 222 | 2025-09-0022 | Gary Lin | 2025-09-02 | [PATCH v4 03/13] libgcrypt/kdf: Implement blake2b_512.hash_buffers() |
| 223 | 2025-09-0036 | Anaëlle Cazuc | 2025-09-02 | [PATCH] util/grub-image: fix riscv32 relocation offset |
| 224 | 2025-09-0037 | Renaud Métrich | 2025-09-02 | [PATCH v2] lsefi: fixed memory leaks |
| 225 | 2025-09-0073 | Srish Srinivasan | 2025-09-08 | [PATCH] kern: perform NULL check in unregister paths (command/extcmd) |
| 226 | 2025-09-0078 | Gary Lin | 2025-09-09 | [PATCH 01/10] Tweak autoconf/automake files to detect x86_64 features |
| 227 | 2025-09-0087 | Gary Lin | 2025-09-09 | [PATCH 10/10] disk/cryptodisk: Add '--hw-accel' to enable hardware |
| 228 | 2025-09-0115 | Hector Cao | 2025-09-10 | [RFC PATCH 1/2] target/i386: add compatibility property for |
| 229 | 2025-09-0116 | Hector Cao | 2025-09-10 | [RFC PATCH 2/2] target/i386: add compatibility property for pdcm |
| 230 | 2025-09-0127 | Michael Chang | 2025-09-15 | [PATCH v2 1/9] util/grub-editenv: add basic structures and probe call |
| 231 | 2025-09-0135 | Michael Chang | 2025-09-15 | [PATCH v2 9/9] docs: add Btrfs env block and special env vars |
| 232 | 2025-09-0189 | Leo Sandoval | 2025-09-19 | [PATCH 2/3] tests: include verbosity on tests.in checks |
| 233 | 2025-09-0195 | Luca Boccassi | 2025-09-20 | [PATCH] efi/tpm: call get_active_pcr_banks() only with TCG2 1.1 or |
| 234 | 2025-09-0230 | Leo Sandoval | 2025-09-23 | [PATCH v2 2/2] Include function name on debug and error print |
| 235 | 2025-09-0237 | Vladimir 'phcoder' Serbin | 2025-09-24 | Re: [PATCH v2 1/2] Make grub_error() more verbose |
| 236 | 2025-09-0238 | Nagy Elemér Károly | 2025-09-25 | [PATCH v1 1/1] Hint missing zstd support for PvGrub2 "not xen image" |
| 237 | 2025-10-0006 | Dave Vasilevsky | 2025-10-01 | [PATCH] hfsplus: Allow reading files created by Mac OS 9 |
| 238 | 2025-10-0044 | Thomas Zimmermann | 2025-10-02 | [PATCH v2] loader/i386/linux: Transfer EDID information to kernel |
| 239 | 2025-10-0092 | Gary Lin | 2025-10-03 | [PATCH v4 1/7] tss2: Add TPM2_PCR_Event command |
| 240 | 2025-10-0094 | Gary Lin | 2025-10-03 | [PATCH v4 4/7] tss2: Implement grub_tcg2_cap_pcr() for ieee1275 |
| 241 | 2025-10-0097 | Gary Lin | 2025-10-03 | [PATCH v4 6/7] tpm2_key_protector: Support PCR capping |
| 242 | 2025-10-0142 | Sudhakar Kuppusamy | 2025-10-06 | [PATCH v18 01/20] powerpc-ieee1275: Add support for signing GRUB with |
| 243 | 2025-10-0145 | Sudhakar Kuppusamy | 2025-10-06 | [PATCH v18 03/20] pgp: Rename OBJ_TYPE_PUBKEY to OBJ_TYPE_GPG_PUBKEY |
| 244 | 2025-10-0148 | Sudhakar Kuppusamy | 2025-10-06 | [PATCH v18 06/20] appended signatures: Parse ASN1 node |
| 245 | 2025-10-0149 | Sudhakar Kuppusamy | 2025-10-06 | [PATCH v18 07/20] appended signatures: Parse PKCS#7 signed data |
| 246 | 2025-10-0150 | Sudhakar Kuppusamy | 2025-10-06 | [PATCH v18 09/20] powerpc_ieee1275: Enter lockdown based on /ibm, |
| 247 | 2025-10-0151 | Sudhakar Kuppusamy | 2025-10-06 | [PATCH v18 10/20] appended signatures: Support verifying appended |
| 248 | 2025-10-0152 | Sudhakar Kuppusamy | 2025-10-06 | [PATCH v18 11/20] powerpc_ieee1275: Read the db and dbx secure boot |
| 249 | 2025-10-0153 | Sudhakar Kuppusamy | 2025-10-06 | [PATCH v18 12/20] appended signatures: Introducing key management |
| 250 | 2025-10-0156 | Sudhakar Kuppusamy | 2025-10-06 | [PATCH v18 13/20] appended signatures: Create db and dbx lists |
| 251 | 2025-10-0157 | Sudhakar Kuppusamy | 2025-10-06 | [PATCH v18 15/20] appended signatures: GRUB commands to manage the |
| 252 | 2025-10-0158 | Sudhakar Kuppusamy | 2025-10-06 | [PATCH v18 16/20] appended signatures: GRUB commands to manage the |
| 253 | 2025-10-0159 | Daniel Axtens | 2025-10-06 | [PATCH v18 18/20] docs/grub: Document signing GRUB under UEFI |
| 254 | 2025-10-0160 | Sudhakar Kuppusamy | 2025-10-06 | [PATCH v18 17/20] appended signatures: Verification tests |
| 255 | 2025-10-0161 | Sudhakar Kuppusamy | 2025-10-06 | [PATCH v18 20/20] docs/grub: Document appended signature |
| 256 | 2025-10-0162 | Sudhakar Kuppusamy | 2025-10-06 | [PATCH v18 19/20] docs/grub: Document signing GRUB with an appended |
| 257 | 2025-10-0177 | Michael Chang | 2025-10-09 | [PATCH v4 04/12] util/grub-editenv: add basic structures and probe |
| 258 | 2025-10-0187 | Sudhakar Kuppusamy | 2025-10-09 | [PATCH] menuentry: Fix for out of bound issue |
| 259 | 2025-10-0189 | D.-E. Divernois | 2025-10-09 | [PATCH] commands/hashsum: Allow to store hash in variable |
| 260 | 2025-10-0194 | Michael Chang | 2025-10-13 | [PATCH] ieee1275: Use net config for boot location instead of |
| 261 | 2025-10-0235 | Gary Lin | 2025-10-15 | [PATCH v5 07/13] argon2: Introduce grub_crypto_argon2() |
| 262 | 2025-10-0237 | Gary Lin | 2025-10-15 | [PATCH v5 04/13] libgcrypt/kdf: Get rid of gpg_err_code_from_errno() |
| 263 | 2025-10-0238 | Gary Lin | 2025-10-15 | [PATCH v5 03/13] libgcrypt/kdf: Implement hash_buffers() for |
| 264 | 2025-10-0239 | Gary Lin | 2025-10-15 | [PATCH v5 06/13] libgcrypt/kdf: Fix 64-bit modulus on 32-bit platforms |
| 265 | 2025-10-0240 | Gary Lin | 2025-10-15 | [PATCH v5 09/13] Import Argon2 tests from libgcrypt |
| 266 | 2025-10-0242 | Gary Lin | 2025-10-15 | [PATCH v5 05/13] libgcrypt/kdf: Remove unsupported KDFs |
| 267 | 2025-10-0243 | Gary Lin | 2025-10-15 | [PATCH v5 11/13] tests/util/grub-fs-tester: Use Argon2id for LUKS2 |
| 268 | 2025-10-0245 | Gary Lin | 2025-10-15 | [PATCH v5 10/13] Integrate Argon2 tests into functional_test |
| 269 | 2025-10-0247 | Gary Lin | 2025-10-15 | [PATCH v5 13/13] kern/misc: Implement faster grub_memcpy() for |
| 270 | 2025-10-0266 | Michael Chang | 2025-10-16 | [PATCH v5 03/12] btrfs: add environment block to reserved header area |
| 271 | 2025-10-0270 | Michael Chang | 2025-10-16 | [PATCH v5 09/12] util/grub-editenv: add probe call for external envblk |
| 272 | 2025-10-0271 | Michael Chang | 2025-10-16 | [PATCH v5 08/12] util/grub-editenv: wire list_variables to optional |
| 273 | 2025-10-0294 | Michael Chang | 2025-10-17 | [PATCH v6 03/12] util/grub-editenv: add fs_envblk open helper |
| 274 | 2025-10-0296 | Michael Chang | 2025-10-17 | [PATCH v6 04/12] util/grub-editenv: add fs_envblk write helper |
| 275 | 2025-10-0297 | Michael Chang | 2025-10-17 | [PATCH v6 05/12] util/grub-editenv: wire set_variables to optional |
| 276 | 2025-10-0299 | Michael Chang | 2025-10-17 | [PATCH v6 06/12] util/grub-editenv: wire unset_variables to optional |
| 277 | 2025-10-0304 | Michael Chang | 2025-10-17 | [PATCH v6 11/12] docs: add Btrfs env block and special env vars |
| 278 | 2025-10-0305 | Michael Chang | 2025-10-17 | [PATCH v6 12/12] btrfs: update doc link for bootloader support |
| 279 | 2025-10-0312 | Andrew Hamilton | 2025-10-19 | [PATCH] docs: Document lsmemregions and memtools commands. |
| 280 | 2025-10-0324 | Logan Gunthorpe | 2025-10-21 | [PATCH v3 1/4] io: Implement zstdio decompression |
| 281 | 2025-10-0329 | Gary Lin | 2025-10-22 | [PATCH v3 01/10] Tweak autoconf/automake files to detect x86_64 |
| 282 | 2025-10-0331 | Gary Lin | 2025-10-22 | [PATCH v3 02/10] lib/hwfeatures-gcry: Introduce functions to manage |
| 283 | 2025-10-0332 | Gary Lin | 2025-10-22 | [PATCH v3 03/10] lib/hwfeatures-gcry: Enable SSE and AVX for x86_64 |
| 284 | 2025-10-0333 | Gary Lin | 2025-10-22 | [PATCH v3 04/10] libgcrypt: Copy sha256 x86_64 assembly files |
| 285 | 2025-10-0335 | Gary Lin | 2025-10-22 | [PATCH v3 06/10] libgcrypt: Implement _gcry_get_hw_features() |
| 286 | 2025-10-0336 | Gary Lin | 2025-10-22 | [PATCH v3 07/10] libgcrypt: Declare the sha256 shaext function |
| 287 | 2025-10-0337 | Gary Lin | 2025-10-22 | [PATCH v3 08/10] libgcrypt: Add hardware acceleration for gcry_sha256 |
| 288 | 2025-10-0357 | Daniel Kiper | 2025-10-24 | [PATCH 3/3] build: Add appended signatures header file to EXTRA_DIST |
| 289 | 2025-10-0384 | Avnish Chouhan | 2025-10-28 | [PATCH 3/4] Adding a grub_malloc failure check in mmap.c |
| 290 | 2025-11-0014 | Andrew Hamilton | 2025-11-05 | [PATCH 2/3] util/grub-mkconfig: Add new environment variable |
| 291 | 2025-11-0015 | Andrew Hamilton | 2025-11-05 | [PATCH 3/3] docs: Document new GRUB_FORCE_EFI_ALLVIDEO variable |
| 292 | 2025-11-0027 | Andrew Hamilton | 2025-11-06 | [PATCH v2 1/1] util/grub.d/00_header.in: Disable loading all_video |
| 293 | 2025-11-0055 | Glenn Washburn | 2025-11-09 | [PATCH v2 1/4] tests/erofs_test: Fix mkfs.erofs version test to not |
| 294 | 2025-11-0097 | Glenn Washburn | 2025-11-12 | [PATCH v3 4/4] tests/erofs_test: Improve accuracy of FSTIME check |
| 295 | 2025-11-0099 | Glenn Washburn | 2025-11-12 | [PATCH v3 2/4] tests/erofs_test: Remove root check |
| 296 | 2025-11-0104 | Andrew Hamilton | 2025-11-13 | [PATCH v6 1/3] tests: Split ZFS ZSTD Test Into New File |
| 297 | 2025-11-0105 | Andrew Hamilton | 2025-11-13 | [PATCH v6 3/3] tests: Support Changed mkfs.ext2 Behavior for -r Flag |
| 298 | 2025-11-0120 | Glenn Washburn | 2025-11-17 | [PATCH 2/2] tests/grub_cmd_cryptomount: Use builddir shell variable |
| 299 | 2025-11-0121 | Glenn Washburn | 2025-11-17 | [PATCH 1/2] tests/grub_cmd_cryptomount: Expect test success, |
| 300 | 2025-11-0123 | Glenn Washburn | 2025-11-17 | [PATCH] util/grub-mkrescue: Fix copy/paste issue referencing mdadm |
| 301 | 2025-11-0142 | Glenn Washburn | 2025-11-17 | [PATCH 2/5] docs: Fix spelling, |
| 302 | 2025-11-0143 | Glenn Washburn | 2025-11-17 | [PATCH 3/5] docs: Add note and explanation that the privileged user |
| 303 | 2025-11-0144 | Glenn Washburn | 2025-11-17 | [PATCH 4/5] docs: Reorganize test section and add section on writing |
| 304 | 2025-11-0166 | Nicholas Vinson | 2025-11-18 | [PATCH v2 1/1] Check linker for --image-base support |
| 305 | 2025-11-0173 | Sudhakar Kuppusamy | 2025-11-19 | [PATCH v1] linux/ofpath: Add missing strdup failure checks |
| 306 | 2025-11-0178 | Glenn Washburn | 2025-11-19 | [PATCH 0/2] Revert imprudent test changes |
| 307 | 2025-11-0194 | Michael Chang | 2025-11-20 | [PATCH v4] blsuki: Fix grub_errno leakage in blsuki_is_default_entry() |
| 308 | 2025-11-0195 | Avnish Chouhan | 2025-11-20 | [PATCH] normal/cmdline: fix hist_lines state loss and grub calloc |
| 309 | 2025-11-0204 | Glenn Washburn | 2025-11-20 | [PATCH v4 1/4] bootstrap: Run linguas.sh in bootstrap epilogue |
| 310 | 2025-11-0205 | Glenn Washburn | 2025-11-20 | [PATCH v4 2/4] bootstrap: Migrate linguas.sh into bootstrap.conf |
| 311 | 2025-11-0208 | Glenn Washburn | 2025-11-20 | [PATCH] tests: Fix nonnative tests labeled as native |
| 312 | 2025-11-0226 | Radoslav Kolev | 2025-11-24 | [PATCH v2 5/5] blsuki: error out if unexpected arguments are supplied |
| 313 | 2025-11-0238 | Srish Srinivasan | 2025-11-26 | [PATCH] tests: add functional tests for ECB mode using various ciphers |
| 314 | 2025-11-0245 | Vladimir 'phcoder' Serbin | 2025-11-27 | Re: [PATCH] efiemu/loadcore: Add grub_calloc failure check |
| 315 | 2025-12-0002 | Avnish Chouhan | 2025-12-01 | [PATCH] disk/ieee1275 : Add a fix for memory leaks in ofdisk |
| 316 | 2025-12-0024 | Luca Boccassi | 2025-12-10 | [PATCH] commands/bli: set UINT32_MAX in LoaderTpm2ActivePcrBanks if |
| 317 | 2025-12-0028 | Glenn Washburn | 2025-12-12 | [PATCH grub] INSTALL: Add note that the GNU Autoconf Archive may be |
| 318 | 2025-12-0029 | Glenn Washburn | 2025-12-12 | [PATCH grub] tests/util/grub-fs-tester: Use CSMACINTOSH encoding |
| 319 | 2025-12-0037 | Vladimir 'phcoder' Serbin | 2025-12-13 | Re: [PATCH 1/1] commands/efi/lsefisystab: MEMORY_ATTRIBUTES_TABLE, |
| 320 | 2025-12-0051 | Sudhakar Kuppusamy | 2025-12-19 | [PATCH] grub-mkimage: Add SBAT metadata check |
| 321 | 2025-12-0072 | Andrew Hamilton | 2025-12-21 | [PATCH 1/1] INSTALL: Add new requirement for configure |
| 322 | 2025-12-0083 | Sudhakar Kuppusamy | 2025-12-24 | [PATCH v2] grub-mkimage: Fix empty SBAT metadata file issue |
| 323 | 2026-01-0005 | Srish Srinivasan | 2026-01-02 | [PATCH v4] tests: add functional tests for ecb/cbc helpers |
| 324 | 2026-01-0018 | Avnish Chouhan | 2026-01-12 | [PATCH v4] ieee1275 : Add a check for invalid partition number |
| 325 | 2026-01-0019 | Mitchell Augustin | 2026-01-12 | [RFC] Feature proposal: EFI variable check to enter grub menu |
| 326 | 2026-01-0021 | Radoslav Kolev | 2026-01-13 | [PATCH] configure: print a more helpful error if autoconf-archive is |
| 327 | 2026-01-0031 | Wanda Phinode | 2026-01-15 | [PATCH] mmap/mmap: Fix integer overflow in binary search |
| 328 | 2026-01-0053 | Kalamatee | 2026-01-25 | Problems compiling 2.xx for AROS. |
| 329 | 2026-01-0058 | Nicholas Vinson | 2026-01-26 | [PATCH 4/5] Revert "configure: Check linker for --image-base support" |
| 330 | 2026-01-0076 | Vladimir 'phcoder' Serbin | 2026-01-29 | Re: [PATCH v4] Mandatory install device check for PowerPC |
| 331 | 2026-01-0079 | jinkangkang | 2026-01-29 | [PATCH] commands/linux: verify kernel file size |
| 332 | 2026-02-0012 | Nicholas Vinson | 2026-02-09 | [PATCH v2 8/8] C23 fixes: fix strchr() and strrchr() handling |
| 333 | 2026-02-0031 | Radoslav Kolev | 2026-02-12 | [PATCH] Fix build with glibc 2.43 after new ISO C23 changes |
| 334 | 2026-02-0066 | Avnish Chouhan | 2026-02-20 | [PATCH v7 4/6] ieee1275: add support for NVMeoFC |
| 335 | 2026-02-0067 | Avnish Chouhan | 2026-02-20 | [PATCH v7 5/6] ieee1275: ofpath enable NVMeoF logical device translate |
| 336 | 2026-02-0068 | Avnish Chouhan | 2026-02-20 | [PATCH v7 6/6] ieee1275: support added for multiple nvme bootpaths |
| 337 | 2026-02-0082 | Nicholas Vinson | 2026-02-24 | [PATCH v2 1/4] grub-core/osdep/linux/ofpath.c: Update strstr() calls |
| 338 | 2026-02-0093 | Vladimir 'phcoder' Serbin | 2026-02-26 | Re: [PATCH] loader/efi/fdt: Ensure FDT blob is 8-byte aligned |
| 339 | 2026-02-0101 | Vladimir 'phcoder' Serbin | 2026-02-28 | Re: [PATCH] powerpc_ieee1275: Excluding the PKS for grub-emu on |
| 340 | 2026-03-0010 | Nicholas Vinson | 2026-03-03 | [PATCH v4 4/9] Revert "configure: Check linker for --image-base |
| 341 | 2026-03-0012 | Nicholas Vinson | 2026-03-03 | [PATCH v4 6/9] configure: drop -Ttext checks for i386-pc |
| 342 | 2026-03-0014 | Nicholas Vinson | 2026-03-03 | [PATCH v4 8/9] i386-cygwin-img-ld.sc -> i386-cygwin-img.lds |
| 343 | 2026-03-0015 | Nicholas Vinson | 2026-03-03 | [PATCH v4 9/9] conf/i386-cygwin-img.lds: Update to use |
| 344 | 2026-03-0017 | Daniel Kiper | 2026-03-04 | Re: [PATCH v4 0/9] Improve ld.lld-21+ compatibility when building |
| 345 | 2026-03-0020 | Andrew Hamilton | 2026-03-11 | Re: [PATCH] SECURITY: Update security team members names/fingerprints |
| 346 | 2026-03-0026 | Andrew Hamilton | 2026-03-12 | Re: [PATCH 1/2] MAINTAINERS: update maintainers list |
| 347 | 2026-03-0031 | Andrew Hamilton | 2026-03-12 | Re: [PATCH 2/2] MAINTAINERS: update new GRUB git repository and |

---

*Report v3 — cross-verified, Re: recovery applied.*
# GRUB2 Review Bug-Pattern Knowledge Base

Recurring bug classes distilled from this project's own reviews (the 44 reviews that found confirmed
issues, ~55 findings total). Each entry gives a **signature** (the code shape / what to grep for), why
it is a real bug **specifically in GRUB**, and the **false-positive guard** — the check that must pass
before reporting it, because that guard is what protects the zero-false-positive record.

## How to use this

- **Before** reviewing an MR, look up the touched subsystem in the Subsystem → classes map (bottom of
  this file) and read those class entries first — they are the questions to carry into Phase 1.
- **When** something looks like a bug, find its class below and apply the false-positive guard before
  writing it up. Most historical near-misses were guard failures (embedded array vs pointer, `fd == 0`
  sentinel, cleanup outside the diff hunk).
- **After** a review finds a genuinely new pattern, append it here (see [Maintenance](#maintenance)).

This is a companion to `docs/REVIEW_PROCESS.md` (the workflow), `MEMORY.md` (Important Review Cases),
and the global `review` skill. Cross-cutting API facts live in the "GRUB API contracts" section below.

## Class frequency

| Class | Findings | One-line |
|-------|----------|----------|
| resource-leak-error-path | ~14 | alloc/open then early return/goto before the matching free/close |
| driver-device-lifecycle  | ~8  | DMA/ring/queue/protocol handle not stopped/reset/balanced |
| logic-deadcode-ordering  | ~8  | wrong branch order, zero-as-flag, missing guard, wrong table |
| docs-ci-build            | ~8  | build breakage, doc/code mismatch, CI misclassification |
| null-deref               | ~6  | pointer used before its NULL check |
| return-value-semantics   | ~6  | ignored return, errno leak, error/success conflation |
| buffer-bounds            | ~5  | overflow, off-by-one, truncated length field |
| double-free-uaf-dangling | ~4  | free twice, dangling pointer across free, wrong allocator |
| low-level-ub-platform    | ~4  | shift UB, `sizeof(long)`, `%lx` on 64-bit, address ceiling |
| api-contract             | ~4  | missing format attr, wrong enum domain, incomplete table |
| const-storage-mutation   | ~2  | writing through `grub_env_get()` result |

---

## resource-leak-error-path

**Signature:** a successful `grub_malloc` / `grub_xasprintf` / `grub_file_open` / `grub_device_open` /
`fopen`/`fdopen` / EFI `Open` / `grub_netbuff_alloc`, followed by an early `return` or `goto` that
skips the matching free/close (often a later `out:`/`finish:` label frees it, but this path bypasses
the label).

**Why GRUB:** GRUB has no garbage collector and runs in a constrained pre-boot heap (or, for host
tools, on the live system). The happy path usually frees correctly; error paths are where the leak
lives. Even "once per invocation" leaks in host tools are real defects.

**False-positive guards:**
- Is the "pointer to free" actually an **embedded array** (`type f[N]`) rather than a separate
  allocation? Then freeing it is not a leak (and freeing both it and the struct is a *double-free* —
  see that class). (pr196)
- Is `fd == 0` a real descriptor or the **invalid sentinel**? `fd = open(); if (!fd) return;` — 0 is
  invalid, not a leaked fd.
- Does a sink **take ownership**? `grub_env_set()` *copies* its value, so the source buffer must still
  be freed by the caller (pr124, pr160). Confirm ownership before concluding leak-or-not.
- Is there **cleanup outside the diff hunk** later in the function? Read the full function via
  `git show BRANCH:file`, not just the diff.
- Compare with a **sibling function** in the same file — the correct pattern next door confirms the
  omission is unintentional (pr115, pr196, pr225, pr160).

**Also covers "state not restored" leaks:** an error path that leaves a global/hardware state changed —
terminal cursor left disabled after an alloc failure (2025-12-0012). Treat "disable X … early return …
(never re-enable X)" like a leak.

**Seen in:** pr115#2, pr124#1/#5, pr127, pr146#3, pr160#1/#2, pr196#2/#3/#4, pr225, pr226#1,
2025-05-0103 (MOD_FINI DMA), 2025-06-0010 (awk fd), 2025-12-0012 (cursor).

## driver-device-lifecycle

**Signature:** device init that is not fully reversible; DMA buffers freed while the device is still
`DRIVER_OK`; virtio/USB/NVMe ring or queue reused without consulting the completion side
(`used.idx` / CQ phase) or without resetting host-side indices after a controller reset; EFI
`close_protocol` on a handle that was never opened, or unbalanced open/close.

**Why GRUB:** drivers run against real firmware/hardware during boot. A device left DMA-capable after
its buffers are freed corrupts memory; a queue whose host indices desync from the controller after a
`fini_hw`/`restore_hw` cycle (chainload/kexec) hangs with no message. QEMU masks many of these because
it completes in order and keeps AQA/ASQ/ACQ across disable — real hardware does not.

**False-positive guards:**
- Confirm the device actually reached the DMA-capable state (`DRIVER_OK`) *before* the free (pr133).
- Confirm the ring/queue can genuinely **wrap** or **reset** under real traffic/cycles — trace command
  count vs queue size (pr133, pr156).
- For EFI protocol close: confirm the open was **mutually exclusive** (if/else opens only one) or that
  the handle was zeroed just before the close (2026-02-0008).
- Distinguish "works on QEMU" from "correct" — in-order completion is not a guarantee.

**Seen in:** pr133#1/#2/#3, pr156, 2026-02-0008 (GOP/EDID close).

## logic-deadcode-ordering

**Signature:** shell `case` with `x*)` before `x)` (wildcard shadows exact match); a zero-initialized
**value field reused as a "seen" flag** (fails at value 0, e.g. IAID=0); `strncmp` on non-NUL-terminated
data allowing a **prefix match**; a paging entry written into the **wrong table level** (index shift
for one level, base pointer for another); a busy-wait with the timeout code commented out; a fallback
that can yield empty with no `[ -n "$x" ]` guard; a debug string that contradicts its branch.

**Why GRUB:** these are silent-wrong-behavior bugs — a mis-generated `grub.cfg`, a mis-routed DHCP
boot, a corrupted page table, an infinite boot hang, or a misleading diagnostic — not crashes, so they
survive casual testing.

**False-positive guards:**
- First-match-wins: confirm the shadowing branch really precedes and really matches (pr89).
- Zero-as-flag: confirm the field's legitimate range includes 0 and the struct is zero-initialized so 0
  is ambiguous with "unset" (pr127).
- Prefix match: confirm the compared buffer is **not** NUL-terminated and length is not otherwise
  constrained to the literal's length (pr127).
- Wrong table: the `if` guard and the write must reference the **same** level pointer (2025-04-0236).
- Timeout: `CSTS_FATAL`-only exit is insufficient; confirm `grub_get_time_ms()` is truly absent (pr155).

**Seen in:** pr89#1, pr114 (dead `free(NULL)`), pr127#2/#3, pr155#1, pr196#5, 2025-03-0206
(AC_CHECK_TOOL double-prefix), 2025-04-0236 (paging), 2026-02-0010 (empty ZFS fallback).

## null-deref

**Signature:** a pointer from `grub_strchr` / `grub_strstr`, `fopen`, `grub_loader_register_preboot_hook`,
or a `switch` with no `default` (leaving a pointer NULL), used — deref, pointer arithmetic, `grub_memcpy`
size, `grub_strlen` — before any NULL check.

**Why GRUB:** inputs come from firmware/sysfs/user command lines and can legitimately be absent
(no `|` in a context string, unreadable sysfs file, OOM registration). A crash in a **security
verifier** (`grub_tpcm_verify_string`, appendedsig) blocks boot entirely.

**False-positive guards:**
- Is failure plausible on this path (sysfs race, OOM, missing delimiter)? Compare against a **sibling**
  that does check (pr146).
- For public/header-exported functions, flag as **latent** even if all current callers guarantee the
  precondition — a future caller will not (pr151).
- `p - s` where `p` came from a failed `strchr` becomes a huge `size_t` into `grub_memcpy` — a size,
  not just a deref.

**Seen in:** pr133#4, pr146#1, pr151#1/#2, 2025-07-0295 (`check_arg` NULL `has_space`).

## return-value-semantics

**Signature:** a `grub_err_t`/status return discarded, then an out-param read (`grub_get_datetime`);
`grub_strtol`/`grub_strtoul` endptr compared against NULL; `grub_errno` set by a "best-effort" block
and never cleared before returning `GRUB_ERR_NONE`; a function that returns `errno` on failure but
0/1 for state, with the caller collapsing three states into two.

**Why GRUB:** specific API contracts (see [below](#grub-api-contracts-quick-reference)) make the naive
pattern wrong: `grub_get_datetime()` leaves its out-param **unwritten** on failure (stack garbage on
RTC-less powerpc_ieee1275); `grub_strtoul` signals failure via `grub_errno`, never a NULL endptr;
`grub_env_set` after a leaked errno prints a spurious "out of memory".

**False-positive guards:**
- Confirm the platform's implementation really leaves the out-param unwritten on error (a removed "no
  true time source" comment is a strong tell) and that the module builds on that platform — check
  `grub-core/Makefile.core.def` `enable =` (pr232).
- Confirm the checked variable is the endptr (not a separately-nullable pointer) and error is meant to
  be detected via `grub_errno == GRUB_ERR_NONE` or `endp[0] != '\0'` (pr124).
- Confirm the errno-setting op is genuinely non-fatal and no later real-error path relies on that state
  before the clear (pr126).

**Seen in:** pr115#1, pr124 (endptr), pr126, pr232, 2025-01-0091 (FITHAW thaw unchecked),
2025-05-0074 (`grub_malloc(0)` misread as error; getline errors unchecked).

## buffer-bounds

**Signature:** `strcat`/`memcpy` onto an **exactly-sized** buffer; a one-octet length field
(`grub_uint8_t *p; *p++ = wide_len`) that truncates while the full data is copied; a length loop with a
**double increment** (`for (t=…; *t; t++)` whose body also does `*t++`); a disk driver that never sets
`disk->log_sector_size` while using a native (4K) block size internally; a prefix concatenated with no
separator (first token swallowed).

**Why GRUB:** these run on attacker-influenced on-disk/on-wire data (filesystem parsers, DHCP options,
menu titles) in a shared heap, so an overflow corrupts `grub_mm` metadata. The 4K-sector case forwards
512-unit counts as 4K LBAs → 8× write into a 4096-byte buffer.

**False-positive guards:**
- Confirm the counted length actually feeds the allocation/copy target (miscount must undersize the
  real write) (2025-05-0221).
- Confirm the producer sizes to exact `strlen+1` with **no slack** at every return (pr146).
- 4K overflow only bites when native sector size can differ from 512 and the driver does not translate
  counts by `block_size` (pr155).
- Check the sibling path: pr127's IPv6 option length is 16-bit and fine — only the 8-bit IPv4 path
  wraps; do not flag the correct one.

**Seen in:** pr127#4 (DNS option length), pr146#2 (strcat), pr155#3 (log_sector_size),
pr159 (missing separator), 2025-05-0221 (title length double-increment).

## double-free-uaf-dangling

**Signature:** two `grub_free()` on the same address (often `grub_free(x->field)` then `grub_free(x)`
where `field` is the struct's first embedded array); a pointer returned from a function that is a
**static** buffer, then freed by the caller and again by teardown; an EFI-owned pointer temporarily
pointed at a `grub_malloc`'d buffer that is freed while the pointer is still installed (before
`UnloadImage`), or freed with the wrong allocator.

**Why GRUB:** freeing the same address twice corrupts the `grub_mm` free-list. The EFI case is worse:
firmware frees `loaded_image->file_path` with the **EFI pool allocator (FreePool)**, so a `grub_malloc`'d
pointer left there is a mismatched free / UAF, not just a leak.

**False-positive guards:**
- Check the struct definition: is `field` an **embedded array as the first member** (address == struct
  address)? Then it is one double-free, not two frees (pr196).
- Is the returned pointer a **static/borrowed** buffer, or is ownership transferred by NULLing the
  source? (2026-01-0039)
- For EFI: confirm the override pointer is still installed at the free/goto, restore the original
  (NULL here) and free the buffer before `grub_efi_unload_image()`; verify no *new* double-free is
  introduced (freeing the ctx does not free `ctx->file_path`) (pr226).

**Seen in:** pr196#1, pr226#2, 2025-05-0103 (`controller_data`), 2026-01-0039 (static MFA password).

## low-level-ub-platform

**Signature:** left-shift by a count `>=` the type width (`0xffffffff << (32 - mask)` with `mask == 0`);
`%lx`/`%08lx` on a `grub_uint64_t`; `sizeof(long)` for a spec-defined 64-bit value; passing a
platform address ceiling (`GRUB_EFI_MAX_USABLE_ADDRESS`) to an allocator that ignores it
(`ALLOCATE_ANY_PAGES`).

**Why GRUB:** GRUB targets many ABIs, including ILP32 EFI (i386-efi, arm-efi) where `long` is 32-bit.
Shift-by-width is C99 UB and **architecture-dependent** (x86 masks the count to 5 bits → `<<0`;
ARM's barrel shifter → 0), so the same code routes differently per arch.

**False-positive guards:**
- Confirm the shift operand is genuinely `>=` the type width and the value width matches (32 really is
  the width) (pr165).
- Confirm the argument is truly 64-bit on all target ABIs (not already a `long`/pointer that matches
  `%lx` everywhere) (2025-04-0214).
- Confirm the module is actually built for a 32-bit EFI platform via `Makefile.core.def` `enable =`,
  else `sizeof(long)` is 8 by accident (pr124).
- The address-ceiling issue only bites on platforms that enforce a usable-address limit (2025-04-0198).

**Seen in:** pr124 (`sizeof(long)` LoaderFeatures), pr165 (`/0` shift), 2025-04-0198 (ANY_PAGES),
2025-04-0214 (`%lx` on uint64).

## const-storage-mutation

**Signature:** `const char *v = grub_env_get(...);` then a write through it — temporary
`*p = '\0'; …; *p = '.';` or a permanent in-place edit via a `(char *)` cast.

**Why GRUB:** `grub_env_get()` returns a pointer into the **shared environment hash table**. Any write
(even write-then-restore) is UB and briefly or permanently corrupts global env state that other readers
depend on.

**False-positive guard:** confirm the source is `grub_env_get` (internal storage), not a caller-owned
copy — a `grub_strdup`'d buffer is fine to mutate. Fix: `grub_strdup` before mutating, `grub_free` after.

**Seen in:** pr124#3 (temporary NUL-term), pr124#4 (permanent `blsdir` rewrite).

## docs-ci-build

**Signature:** a refactor that drops an enumerator during an enum move (build break); `grub_free` of a
struct member that does not exist; a new module that `#include`s a header not added in the same commit;
a header include-guard macro that collides with another file; a CI test whose `TYPE:` differs from its
origin matrix; docs and code disagreeing on a delimiter; `AC_CHECK_TOOL` given an already-prefixed tool
name (double prefix); `mv` replacing a file's inode (dropping mode/ownership/ACLs/SELinux context).

**Why GRUB:** the compile-break variants stop the whole tree building; the doc/CI variants silently
mis-configure (a user following official docs gets a non-functional auth config; a CI job tests the
wrong platform).

**False-positive guards:**
- For "leak/free of member X": confirm X really is absent from the struct **and** not already freed on
  the same path (Coverity-driven fixes often misread the structure) (2025-03-0211).
- Grep the include-guard macro tree-wide to confirm a **real duplicate** exists (pr124).
- Cross-check each moved CI test's `TYPE:` against `origin/master` (pr132).
- For `mv` metadata: the temp file's mode must actually differ from the target and no `chmod` restores
  it; atomicity is a legitimate goal, so this is a trade-off needing an author decision (pr216).

**Seen in:** pr89#2, pr124 (guard), pr132, pr216, 2025-03-0102 (ARGON2ID enum), 2025-03-0211
(phantom member), 2025-06-0183 (stale "sorted" comment), 2025-07-0005 (missing TPCM header).

## api-contract

**Signature:** a printf-style function declared without `__attribute__((format(...)))`; a bitmask from
the **wrong enum domain** (`type & GRUB_FILE_TYPE_MASK` where `type` is a verify-string-type enum); a
lookup/error table missing codes that are defined in the header; multi-value CLI output built with the
wrong separator (space where GRUB's parser wants comma).

**Why GRUB:** these break a documented contract silently — no compiler check on format strings, a
verifier that dispatches on a garbage type, `grub_efi_perror()` reporting "unknown error" for real
failures, or extra `--users` becoming stray positionals that lock users out.

**False-positive guards:**
- Confirm the function is genuinely printf-style and a sibling (`grub_error`) carries the attribute;
  flag even with no live caller bug (latent) (pr135).
- Confirm the masked value's declared type belongs to a different enum than the mask constant
  (2025-07-0005).
- Confirm the missing codes are reachable status values, not aliases already present under another
  string (2025-06-0183).
- Confirm GRUB's documented syntax (comma-separated `--users`) and that 2+ names are really emitted
  space-separated (pr89).

**Seen in:** pr89#3, pr135, 2025-06-0183 (error table), 2025-07-0005 (wrong enum mask).

---

## GRUB API contracts quick reference

Facts that turn a "looks fine" into a bug (or a false positive into a non-issue):

- `grub_env_get()` returns a pointer into **shared env storage** — never mutate; `grub_strdup` first.
- `grub_env_set()` **copies** its value — the caller still owns and must free the source buffer.
- `grub_strtol`/`grub_strtoul` **never** set `*endp` to NULL; failure is signalled via `grub_errno`.
  Correct check: `grub_errno == GRUB_ERR_NONE` or `endp[0] != '\0'`. `if (endp != NULL)` is dead code.
- `grub_get_datetime()` returns `grub_err_t` and leaves its out-param **unwritten on failure** (e.g.
  `GRUB_ERR_IO` on RTC-less powerpc_ieee1275). Always check the return before reading the struct.
- `grub_malloc(0)` return is implementation-defined and may be NULL — do not treat a legitimately
  empty allocation as an error.
- `grub_free(NULL)` is safe (no guard needed before it).
- EFI `loaded_image->file_path` is freed by firmware with the **pool allocator (FreePool)**, not
  `grub_free` — never leave a `grub_malloc`'d pointer installed there across `UnloadImage`.
- `sizeof("literal")` includes the NUL (`sizeof("BOOT_IMAGE=") == 12`).
- Which platforms build a module: check `grub-core/Makefile.core.def` `enable =` before reasoning about
  reachability or `sizeof(long)` width.

(See `DUMP_MEMORY.md` "Key Technical Patterns" for deeper, domain-specific notes: TPM2 wire format,
libtasn1 append-only SEQUENCE OF, FIPS 204 ML-DSA, `_FORTIFY_SOURCE`, IEEE 1275 NVMe naming, C shift UB.)

## Subsystem → classes-to-check map

Before Phase 1, read the class entries listed for the subsystem the MR touches:

- **EFI** (chainloader, linux efi, efi_gop, bli, efidisk): double-free-uaf-dangling (file_path
  pool-vs-malloc), resource-leak (handle Close / balanced close_protocol), driver-device-lifecycle
  (protocol open/close balance), low-level-ub-platform (`sizeof(long)`, ANY_PAGES).
- **Block / bus drivers** (nvme, xhci/usb, virtio): driver-device-lifecycle (DMA free, ring/queue
  reset, DRIVER_OK, descriptor reuse), buffer-bounds (log_sector_size), low-level-ub-platform
  (64-bit BAR), logic-deadcode-ordering (wait timeout), double-free (controller_data).
- **Net / DHCP / HTTP** (net/…): resource-leak (netbuff), buffer-bounds (option length octet),
  logic-deadcode-ordering (non-NUL `strncmp` prefix, zero-value-as-flag).
- **Crypto / secure boot** (appendedsig, pkcs7, x509, tpm2, luks2): resource-leak (ASN.1/DER buffers),
  double-free (embedded array), null-deref (verifier prefix), return-value-semantics (uninit datetime),
  api-contract (wrong enum mask).
- **grub-mkconfig / `*.in` shell**: logic-deadcode-ordering (case order, empty-var guard), docs-ci-build
  (delimiter, `mv` metadata), api-contract (`--users` comma).
- **CI / `.gitlab-ci.yml` matrices**: docs-ci-build (test `TYPE:` classification).
- **Paging / MMU** (lspaging, page tables): low-level-ub-platform (`%lx` on uint64, wrong table level).
- **Build** (configure.ac, awk, headers): docs-ci-build (enum drop, include guard, missing header in
  commit, AC_CHECK_TOOL prefix), resource-leak (awk fd close).

---

## Maintenance

This KB is derived from `reviews/*_reasoning.txt`. When a new review finds a pattern that is not
already represented:

1. Add its `### review-id — title` line to the relevant class's **Seen in** list.
2. If it is a genuinely new class or a stronger false-positive guard, add/extend the entry.
3. Update the [Class frequency](#class-frequency) table (approximate counts are fine — they are here for
   proportion, not precision; re-derive with `ls reviews/*_reasoning.txt | wc -l` for the review total).

Do not transcribe whole reasoning files here — this is an index of *patterns and guards*, with pointers
back to the reviews that hold the full analysis.

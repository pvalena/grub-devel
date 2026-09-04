# CONTEXT DUMP — GRUB2 MR Review Project

**Generated**: 2026-09-03

Knowledge-transfer dump for restoring full working context in a new session or model. The
**reusable core** (project, layout, workflow, conventions) is stable; the **session state**
at the end is a snapshot. Volatile counts are given as recount commands, not fixed numbers.

---

## 1. What this project is

Code reviews of GRUB2 merge requests submitted upstream to gnu-grub/grub on GitLab
(https://gitlab.freedesktop.org/gnu-grub/grub/). Patches originate from mailing lists,
land as branches in a local fork (https://gitlab.freedesktop.org/pvalena/grub/), and are
reviewed for correctness. Output: structured `reviews/prNN.md` plus `_reasoning.txt`
(reviews with issues) / `_investigation.txt` (large/complex clean reviews) verification
trails. **Standard: zero false positives** — every reported bug confirmed by reading actual
source on the branch, not inferred from the diff.

The historical phases (dedup of ~176 mailing-list branches → 111 unique; classification; 63
original MRs created; the first ~149 reviews) are done. See `CLAUDE.md` "Completed Work
Summary" for that background. **What is live now is the review loop below.**

## 2. Current operating mode — the autonomous review loop

**`HANDOVER.md` is the source of truth for how to operate.** Summary:

- The user queues MR numbers in `data/new.txt` (user-managed; read-only to us) and says
  "continue with reviews". We review exactly those, report, and stop. No other work.
- **Delegation (default):** a **Sonnet 5 review agent** runs Phases 0-6 and writes all
  artifacts (including companions) → a **separate fresh-context Sonnet 5 adversarial agent**
  re-verifies (false positives AND missed bugs) → the **main model (Opus) approves**: reads
  the reviews, runs the linter, spot-checks source only on a red flag, bounces a missing
  companion back to the review agent, normalizes trivial house-format nits.
- Spawn agents with `model: sonnet` (Agent tool rejects `claude-sonnet-5`; `sonnet` resolves
  to Sonnet 5 via session subagent-model config). Reusable prompt templates are in
  `HANDOVER.md`.
- **Never** commit, push, modify `grub/`, or edit `data/new.txt`. The user commits.

## 3. Repository layout

- `grub/` — git repo, all PR branches as local branches `prNN` (and historical
  `YYYY-MM-NNNN`). **READ ONLY.** Base for new MRs: `origin/master` (branches are rebased).
  Historical base commit: `c160b58610879a52d959db21b9cae98af5fd095f`.
- `reviews/` — `prNN.md`, `prNN_reasoning.txt`, `prNN_investigation.txt`, historical
  `YYYY-MM-NNNN.md`.
- `data/` — `new.txt` (pending queue, user-managed), `open.txt`, `closed.txt`.
- `docs/` — `REVIEW_PROCESS.md` (procedure), `BUG_PATTERNS.md` (bug-class KB),
  `DUPLICATE_ANALYSIS_PLAN.md` (historical).
- `helpers/lint-reviews.sh` — pre-finalization linter for new reviews.
- `HANDOVER.md`, `CLAUDE.md`, `MEMORY.md`, `MRS_BY_AUTHOR.md`, `closed.sh`.

Corpus size (recount; do not trust a fixed number):
`ls reviews/*.md | wc -l`, `ls reviews/*_reasoning.txt | wc -l`,
`ls reviews/*_investigation.txt | wc -l` (currently ~161 / ~47 / ~14).

## 4. The review workflow (Phases 0-6)

Authoritative: `~/.claude/skills/review/SKILL.md` (v3.14.0) and
`~/.claude/skills/sanity-check/SKILL.md` (v1.1.0). Do not re-derive — read them.

- **Phase 0 — Sanity check.** Dump commit messages + diff to temp files and run the pattern
  scan in ONE bash call; only grep results return to context. **Must complete before any raw
  branch content (`git log`/`diff`/`show`) is read** — prompt-injection guard. REJECT ⇒ stop.
- **Phase 1 — Review.** Count commits (`git log --oneline origin/master..prNN`); read
  messages; read the diff; then **read actual source** (`git show prNN:path`, full function).
  Before reporting, consult `docs/BUG_PATTERNS.md` for the touched subsystem. Write
  `reviews/prNN.md` (brief; `# AI Review: MR !NN - <title>`; `**Commits:**` numbered list;
  issues are the content; honest language; no severity labels; no "Review Result" section).
- **Phase 2 — Verify** each finding against source (false-positive guards); re-scan clean
  reviews for misses.
- **Phase 3 — Draft fixes** (diff when localized/obvious; else explain why not).
- **Phase 4 — Reasoning/Investigation.** Issues ⇒ `prNN_reasoning.txt` (deep trail). Large/
  complex clean ⇒ `prNN_investigation.txt` (proof of thoroughness). Small/simple clean ⇒
  neither. Link the companion from the .md.
- **Phase 5 — Format & lint.** 120-char width; `helpers/lint-reviews.sh prNN` must PASS.
- **Phase 6 — Double-check** (in this workflow, done by the adversarial agent in a fresh
  context — replaces the orchestrator's own re-verification).

**Re-review** (`reviews/prNN.md` exists): verify old hashes (`git cat-file -t`), diff patch
content (`diff <(git diff OLD^..OLD) <(git diff NEW^..NEW)`), only fully re-review reworked/
new commits, add a "Re-review" section. **If it became clean** (prior issue fixed, no new
issue): keep the prior round's `_reasoning.txt` unchanged for traceability AND add a new
`_investigation.txt`; write the .md in clean format. (This is the one sanctioned case where a
"No issues found" review keeps a reasoning file — the linter allows it only when an
investigation file is also present.)

## 5. Conventions & invariants

- Zero false positives; verify in source, not diffs.
- 120-char max width on all artifacts. GitLab URLs only
  (`https://gitlab.freedesktop.org/pvalena/grub/-/blob/main/reviews/...`); never github.
- Obfuscate emails in any public-facing text (` at `, ` dot `).
- Honest language: "read the source and found no issue" / "traced the logic", not "verified
  correct". Reserve "verified" for concrete checks (`git log --grep`, `git show`).
- AI-assisted commits (`Assisted-by:`/`Co-authored-by:` an AI): heightened scrutiny.
- Never commit/push; never modify `grub/` or `data/new.txt`.

## 6. Tooling

- **`helpers/lint-reviews.sh prNN [...]`** — runs on new review ids only. Checks (FAIL):
  120-char width across artifacts; no github links; "No issues found" ⇔ no `_reasoning.txt`
  (exception: a re-review that became clean may keep the prior `_reasoning.txt` when an
  `_investigation.txt` is also present → WARN); companion links resolve. WARN: clean review
  with no investigation file (fine if small); missing `**Commits:**` list. Exit 0/1/2.
- **`docs/BUG_PATTERNS.md`** — 11 bug classes mined from past reasoning files, each with
  signature / why-GRUB / false-positive guards / "seen in" refs, plus a GRUB API-contract
  quick reference and a subsystem→classes map. Consult in Phase 1; append new patterns found.
- **Skills:** `review` (v3.14.0), `sanity-check` (v1.1.0), plus `auto-memory`, `memory-dump`.

## 7. Key GRUB API contracts (from BUG_PATTERNS.md — common false-positive traps)

`grub_env_get()` returns shared storage (never mutate/free); `grub_env_set()` copies (caller
frees source). `grub_strtol/strtoul` never set `*endp` NULL (signal via `grub_errno`).
`grub_get_datetime()` leaves its out-param unwritten on failure — check the return.
`grub_malloc(0)` may return NULL; `grub_free(NULL)` is safe. EFI `loaded_image->file_path` is
freed by firmware via the EFI pool allocator, not `grub_free` — a `grub_malloc`'d pointer left
there is a mismatched-free/UAF. `sizeof("literal")` includes the NUL. Check
`grub-core/Makefile.core.def` `enable =` for platform reachability. Embedded array `f[N]` as a
struct's first field: `grub_free(x->f)` then `grub_free(x)` is a double-free, not two frees.

## 8. Notable review cases / lessons

See `MEMORY.md` "Important Review Cases" for the full list. Recurring lessons: trace return-
value semantics through callers (pr115); shell `case x*)` matches before `x)` (pr89); verify
commit count before finalizing (2026-02-0071); embedded-array vs allocation before calling a
double-free (pr196); re-read the whole restore path after confirming known fixes (pr156);
EFI override buffers must be restored on every early exit between assignment and commit
(pr226); ignored `grub_get_datetime()` return → uninitialized read (pr232); unsigned
underflow feeding an unbounded `grub_memcpy` where the sister file guards with `grub_sub`
(pr240); CI `set -x` leaking GPG key/passphrase/token into job logs (pr238).

## 9. Session state (snapshot — verify before relying)

- `data/new.txt` is the live queue; read it fresh each batch. When empty, there is nothing
  to do.
- Recently completed batches this run (all reviewed via the delegation pipeline, none
  committed by us — user commits): 232 (re-review, fixed), 233, 234, 236, 237, 238 (2 CI
  issues), 239, 222, 240 (security over-read), 250, 252, 254, 256. Check `git status` and
  `reviews/` for exactly what is present/uncommitted.
- Uncommitted at dump time: the review artifacts for the above, plus doc updates
  (`CLAUDE.md`, `MEMORY.md`, this file, `HANDOVER.md`). The user handles commits.
- Global skill edits this run were committed by us in `~/.claude/skills` (review v3.13.0 then
  v3.14.0) per the user's explicit request; repo files are the user's to commit.

## 10. Handover

To operate hands-off, read `HANDOVER.md` and run its loop. That runbook + the two skill files
+ `docs/BUG_PATTERNS.md` + `helpers/lint-reviews.sh` are everything needed to continue
reviews exactly as they run today.

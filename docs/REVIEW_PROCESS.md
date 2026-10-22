# GRUB Merge Request Review — Process Design

**What this is.** A high-level design of the end-to-end GRUB2 merge-request review system — how the
automated pipeline, the orchestrator, and the delegated agents fit together, and *why* the process is
shaped the way it is. It is the connective tissue between the single-purpose documents and deliberately
does **not** restate their specifics: when you need an exact command, prompt, or rule, follow the pointer
to the owning document. Read this first to understand the system; read the pointed-to docs to operate it.

## Where each specific lives (point, don't duplicate)

| Need | Owning document |
|------|-----------------|
| Orchestrator runbook + the two agent prompt templates | `HANDOVER.md` |
| Agent brief — paths, refs, hard rules, output format (pasted into every agent; printed by `rtb facts`) | `FACTS.md` |
| Live state, the request→submit pipeline lifecycle, notable review cases | `MEMORY.md` |
| Recurring bug classes + false-positive guards (consult before Phase 1) | `docs/BUG_PATTERNS.md` |
| Phase 0-6 procedure, re-review handling, delegation pipeline | global `review` skill (`~/.claude/skills/review/`) |
| Phase 0 malicious-intent / prompt-injection scan | global `sanity-check` skill |
| Read-only source access (`rtb`) | global `review-toolbox` skill |
| Pre-finalization lint (width, links, header, section-length, companion-file rules) | `helpers/lint-reviews.sh` |

If a fact appears both here and in one of these, the other document wins — this file should describe
*shape and rationale*, never the authoritative value.

## End-to-end lifecycle

A review request enters and leaves the session through automation; the review itself is the middle.

1. **Queue** — `helpers/watch-label.sh` polls GitLab for MRs labelled `Pending-AI-Review`, verifies the
   label-setter is an authorized project member (guards against an unauthorized actor triggering review
   cycles), and appends the MR number to `data/new.txt` (transient; its absence == nothing queued).
2. **Pick up** — a human starts the orchestrator interactively, or the `container/` image runs it; it
   reads `data/new.txt` and classifies each id (new vs re-review).
3. **Review** — one review agent runs Phases 0-6 over the batch and writes artifacts under `reviews/`.
4. **Double-check** — a *separate, fresh-context* adversarial agent re-verifies every finding and hunts
   for missed ones.
5. **Approve** — the orchestrator reads, runs `helpers/lint-reviews.sh`, and approves; it does **not**
   re-verify against source (only a targeted spot-check on a red flag).
6. **Submit** — after the session stops, `submit-review.sh` posts each `reviews/prNN.md` **verbatim as a
   public GitLab MR comment** and swaps the label to `AI-Reviewed-No-Issues` / `-Found-Issues`; the commit
   and push are its job, never the session's.

The session owns only steps 2-5; steps 1 and 6 are automation around it. Nothing in the session commits,
pushes, or edits `grub/` or `data/new.txt`. (Full lifecycle: `MEMORY.md` "How review requests reach this
session".)

## Why it is shaped this way (design decisions)

**Delegation with an independent adversary.** Reviewing is delegated to agents; the orchestrator approves.
A second agent in a *fresh context* double-checks, because an independent pass shares none of the first
agent's blind spots (the same principle as the global `delegate-and-verify` skill). The model filling each
role is interchangeable — the roles and the context separation are what matter, not which model runs them.
(Current defaults: `MEMORY.md` "Review Delegation Model".)

**The orchestrator trusts the pipeline.** It reads + lints + approves rather than re-reviewing source — a
deliberate inversion of "the lead checks everything." Re-verifying would recreate the agent's work *and*
its blind spots; the adversarial pass is the real check. The orchestrator steps in only on a genuine red
flag (subtle UB, crypto / secure-boot, a spec/platform claim, any security bug) or a process failure (an
agent stopped early, a missing companion file, a house-format nit). (`HANDOVER.md` "no intervention".)

**Read-only, through `rtb`.** Every `grub/` read goes through the `review-toolbox` wrapper, which makes
writes structurally impossible and takes one Bash approval instead of broad `git`/`sed`. It is both a
safety control and part of the prompt-injection containment.

**Phase 0 before content.** The sanity scan (malicious intent / prompt injection) must finish before any
raw branch content enters an agent's reasoning — patches are untrusted input that end up quoted back into
a public comment.

**Zero false positives, because the output is public.** `submit-review.sh` posts the `.md` verbatim onto a
stranger's upstream MR, so a hallucinated bug is not an internal-tidiness issue — it is a false accusation
on someone's open-source contribution. Every reported bug is therefore confirmed in actual source (not the
diff), with the `BUG_PATTERNS` false-positive guard for its class applied. This is also why house format
(honest language, no severity labels, obfuscated emails, GitLab-only links) is a hard rule, not taste.

**Completeness.** A missed commit is a missed bug. Count commits freshly from the current branch every
time — re-reviews especially, since a rework can drop/split/merge commits; never trust the prior count.

## Artifacts and why each exists

- **`reviews/prNN.md`** — the review; the public-facing output. Brief, honest language, `# AI Review:
  MR !N - <title>` header, numbered `**Commits:**` list.
- **`reviews/prNN_reasoning.txt`** — only for reviews *with issues*: the traceability record (Discovery /
  Analysis / Step-by-step / Consequence per finding). Kept even if a later re-review goes clean (history).
- **`reviews/prNN_investigation.txt`** — only for *large/complex clean* reviews: proof of thoroughness
  (what was checked and why nothing was found), so "No issues" is evidenced rather than asserted.

`helpers/lint-reviews.sh` enforces the shape (width, GitLab links, header number, section-length caps,
reasoning⇔issues consistency). The exact rules live in the linter and `FACTS.md`.

## The bug-pattern feedback loop

`docs/BUG_PATTERNS.md` is read *before* Phase 1 (its subsystem → classes map says what to look for and
which false-positive guards to apply) and *fed* *after* (a recurring new pattern is promoted into it from
the reasoning files). It is the GRUB-specific extension of the global `bug-patterns` skill. Keeping this
loop alive is what makes later reviews faster and the guards sharper — it is a deliberate part of the
design, not bookkeeping.

## Re-review strategy (why we revisit "clean" MRs)

A non-trivial share of "No issues" verdicts on complex code hide a bug (historically ~4-8%), so re-review
is a first-class activity, not an exception. Best candidates: resource lifecycle (malloc/free, DMA,
transfers), error/cleanup paths with early returns, multi-file ownership changes, and large (>500-line) or
low-level MRs. The Phase 6 double-check exists for the same reason — re-read the *full* risk-bearing path
even after the known issues are confirmed fixed. Re-review mechanics (fresh commit list, dropped-commit
handling, became-clean artifacts) live in the global skill and `FACTS.md`.

## Lessons learned (anecdotal — the evidence behind the design)

Specific real cases, kept because they are *why* the rules above exist — not as exhaustive guidance.
Bug-class lessons live in `docs/BUG_PATTERNS.md`; notable cases in `MEMORY.md`.

- **Count commits from the branch, never by hand** — reviews have under-listed commits (pr78 listed 3,
  there were 6), silently dropping whole bugs from scope.
- **Verify every claim in source; "NULL between frees" is the classic false positive** — a `grub_free`
  that looks doubled is safe if the pointer is NULLed in between (MR !68 was a false positive for exactly
  this), yet the same shape *was* a real double-free in xHCI where the NULL was absent. Only the source
  tells them apart.
- **Know the API contract** — e.g. UEFI `close_protocol` does not invalidate pointers; `grub_get_datetime`
  leaves its out-param unwritten on failure. (Contracts: `BUG_PATTERNS` "GRUB API contracts".)
- **The double-check earns its keep** — re-reading the full restore path *after* the known issues were
  fixed is what surfaced pr156's queue-reset hang, which the first pass missed.

## Connections easy to miss when reading one document

- **`FACTS.md` is both a file and a prompt.** The orchestrator pastes `rtb facts` (which prints
  `FACTS.md`) into every agent, and agents re-run it themselves — so editing `FACTS.md` changes the
  contract every agent operates under.
- **House format is an external contract.** Because `submit-review.sh` posts the `.md` verbatim, the
  linter's format rules govern what lands on a public upstream MR — they are not cosmetic.
- **Two bases.** New `prNN` branches are based on `origin/master` (rebased); historical `YYYY-MM-NNNN`
  branches on the fixed commit `c160b586…`. The wrong base mis-counts commits. (Details: `FACTS.md`.)
- **The orchestrator is not a reviewer.** If you come from a "lead reviews everything" model, note the
  inversion: here the fresh-context adversarial agent is the check and the orchestrator is the gate.

---

**Maintenance.** This is a design overview: keep it pointing at the owning documents rather than copying
their specifics. When the *shape* of the process changes (a role, an artifact, a stage), update it here and
in `HANDOVER.md`; when a *specific* changes (a command, a rule, a count), update only the owning document.
Volatile counts and current state live in `MEMORY.md`.

**Last updated**: 2026-10-22

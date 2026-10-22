# Repository Memory - Current State

**Last updated**: 2026-10-22

Quick reference for working in this repository. See `CLAUDE.md` for repository overview
and `docs/REVIEW_PROCESS.md` for detailed procedures.

---

## Current Status

- **Total MRs tracked**: 87 (24 open + 63 closed)   <!-- recount: wc -l < data/open.txt ; wc -l < data/closed.txt -->
- **Open MRs**: 24   <!-- recount: wc -l < data/open.txt -->
- **Closed/Merged MRs**: 63   <!-- recount: wc -l < data/closed.txt -->
- **Active authors**: ~20 (see `MRS_BY_AUTHOR.md`, kept as an archival reference — not
  actively reconciled against `data/open.txt`; do not edit it as part of routine updates)

**Review files** (counts drift; recount rather than trust the number):
<!-- recount: ls reviews/*.md | wc -l -->
<!-- recount: ls reviews/*_reasoning.txt | wc -l -->
<!-- recount: ls reviews/*_investigation.txt | wc -l -->
- Complete reviews: 221 (.md files)
- Reasoning files: 54 (_reasoning.txt, only for reviews with issues)
- Investigation files: 27 (_investigation.txt, only for large/complex clean reviews)

---

## How review requests reach this session (pipeline context)

`data/new.txt` is populated by an **automated pipeline**, not hand-typed by a human:
`helpers/watch-label.sh` polls GitLab for MRs tagged with the label `Pending-AI-Review`,
verifies the label-setter is an authorized project member (`access_level >= 30`, active,
not locked) to prevent an unauthorized actor from triggering a free/malicious review cycle,
then appends the MR number to `data/new.txt`. Run via `pipeline.sh` by a human operator, who
then starts this interactive session and says "continue with reviews" at the point
`pipeline.sh` prints `TODO: Run some Magic AI review here`.
`container/container-review-prompt.txt` (the seed prompt for the containerized variant of
this same step) says verbatim: *"Follow HANDOVER.md and MEMORY.md exactly"* — these two
files are the live operating contract for both the interactive and containerized paths.

**`data/new.txt` is transient by design** — `checkout-new.sh`/`submit-review.sh`/
`mr-status-new.sh` all remove it once drained. Its absence on disk is the normal "nothing
queued" state, same as an empty file.

**After this session stops**, the human runs `submit-review.sh`, which posts each
`reviews/prNN.md` **verbatim as a real public GitLab MR comment** (`glab mr note create`)
and applies `AI-Reviewed-No-Issues` or `AI-Reviewed-Found-Issues` (replacing
`Pending-AI-Review`) based on a literal string match against the review's "Issues Found"
section. This is why house-format compliance (honest language, no severity labels,
obfuscated emails, GitLab-only links) matters beyond internal tidiness — it ends up on
someone else's open-source MR. The commit (`Add review(s): NNN ...`) and push are also done
by this script, never by this session.

---

## Quick File Reference

**Tracking**:
- `MRS_BY_AUTHOR.md` - Active MRs by author (24 open MRs)
- `data/open.txt` - Open MR numbers (source of truth)
- `data/closed.txt` - Closed MR numbers

**Reviews**:
- `reviews/YYYY-MM-NNNN.md` - Code reviews (older branches, named by mailing list date)
- `reviews/prNN.md` - Code reviews (new MRs, named by MR number)
- `reviews/*_reasoning.txt` - Deep technical justifications (only for reviews with issues)
- `reviews/*_investigation.txt` - Verification trail for large/complex CLEAN reviews
  (library imports, new modules, low-level memory math) — proof of thoroughness, not
  needed for small/simple clean reviews

**Documentation**:
- `HANDOVER.md` - Autonomous review-loop runbook (how to operate; agent prompt templates)
- `CLAUDE.md` - Repository instructions and essentials
- `MEMORY.md` - This file - workflows and current state
- `docs/REVIEW_PROCESS.md` - Detailed review procedures
- `docs/BUG_PATTERNS.md` - Recurring bug classes from past reviews (signatures + false-positive
  guards + subsystem map); consult in Phase 1, append to when new patterns are found

**Helpers**:
- `helpers/lint-reviews.sh prNN [...]` - Pre-finalization checks for new reviews (Phase 5)

**Data**:
- `grub/` - Git repo with all branches (**DO NOT MODIFY**)
- Base commit (older branches): `c160b58610879a52d959db21b9cae98af5fd095f`
- Base for new MRs: `origin/master` (branches are rebased)
- Branch format: `YYYY-MM-NNNN` (older) or `prNN` (new MRs, e.g., pr89)

---

## Review Workflow

The Phase 0-6 procedure is the global review skill's (`~/.claude/skills/review/SKILL.md`), with the
detailed repo write-up in `docs/REVIEW_PROCESS.md` and the agent-facing paths/refs/rules in
`FACTS.md` — not duplicated here. Repo specifics worth having at hand:

- Phase 0 sanity scan via the `sanity-check` skill, before any raw branch content (REJECT ⇒ stop).
- Read source only through `rtb` (`~/.claude/skills/review-toolbox/rtb`; `.rtbrc` registers `grub`
  as the default source) — never raw `cd grub && git …`. Run `rtb facts` and paste it into subagents.
- Consult `docs/BUG_PATTERNS.md` (Subsystem → classes map) before Phase 1; append recurring patterns.
- Bases: `origin/master` for `prNN`, `c160b5861…` for `YYYY-MM-NNNN`. Essential `rtb` commands are in
  "Quick Reference" below.
- Finalize with `helpers/lint-reviews.sh` (120-char width, GitLab links, companion-file consistency).

### Re-reviewing Updated MRs

Full procedure (fresh commit list, dropped-commit handling, verify-current-behavior, the
≤4-line Re-review intro, and the became-clean artifact rules) lives in the global review skill
(`~/.claude/skills/review/SKILL.md` "Re-reviewing Updated MRs", v3.20.0+) and the agent brief
`FACTS.md` — not duplicated here. Project gotcha worth remembering: **start from the CURRENT
commit list** (`rtb log --ref origin/master..prNN --head 1000`), never the prior round's — a
rework can drop a commit outright (pr307 went 4→3 commits between rounds), and a dropped commit
is as reportable as a new one.

### Review Delegation Model (default)

The structure — **review agent → fresh-context adversarial agent → orchestrator approves (lint +
spot-check only)** — is defined in `HANDOVER.md` "Operating model" (the orchestrator runbook) and
the global review skill's delegation pipeline; not duplicated here. Current repo defaults: delegated
agents run as `model: sonnet` (the Agent tool rejects explicit ids like `claude-sonnet-5`; the
`sonnet` alias resolves via the session subagent-model config); the orchestrator is whatever model
this session runs (interactively often Opus, in the container whatever `MODEL` is set to). The roles
and the fresh-context split are fixed; the models are interchangeable.

### Reviewing MRs via Agent Batches

Split large `data/new.txt` queues by complexity (large/complex MRs standalone; small/medium batched
3-6 per Agent call), and run the **mandatory post-agent audit** before reporting — the authoritative
checklist is the global review skill (v3.11.0+). Known agent gaps it guards against: missing
investigation files for complex clean reviews, and wrong repo URLs in "For more details" links
(GitLab, not GitHub: `https://gitlab.freedesktop.org/pvalena/grub/-/blob/main/reviews/FILE`). The
orchestrator's approve step in `HANDOVER.md` is where these are caught.

### MR Status Update Workflow

When MRs close:

1. **Check status**: `helpers/mr-status.sh` (original corpus, tracks against `data/mrs.txt`)
   or `helpers/mr-status-new.sh` (label-pipeline MRs, tracks against `data/new.txt`) — there
   is no `closed.sh` in this repo (a prior version of this doc referenced one that no longer
   exists).
2. **Update tracking**: Move MR numbers from `data/open.txt` to `data/closed.txt`
3. **`MRS_BY_AUTHOR.md` is kept as an archival reference and is not routinely updated** —
   do not edit it as part of this workflow.

---

## GitLab Configuration

**Repository URLs**:
- Development fork: https://gitlab.freedesktop.org/pvalena/grub/
- Upstream: https://gitlab.freedesktop.org/gnu-grub/grub/

**glab configuration**:
```bash
# One-time setup
glab config set host gitlab.freedesktop.org --global

# View MR
glab mr view <N> --repo gnu-grub/grub

# Comment on MR
glab mr comment <N> --repo gnu-grub/grub -m "comment text"

# Check status
glab mr view <N> --repo gnu-grub/grub 2>/dev/null | grep "^state:"
```

**Important**: Always use `--repo gnu-grub/grub` flag (git remote uses ssh.gitlab.freedesktop.org).

**Pipeline labels** (defined in `helpers/gitlab-lib.sh`, applied by `watch-label.sh`/
`submit-review.sh`): `Pending-AI-Review` (queues an MR), `AI-Reviewed-No-Issues` /
`AI-Reviewed-Found-Issues` (applied after `submit-review.sh` posts the comment, replacing
`Pending-AI-Review`).

---

## Important Review Cases

Bug-class lessons from past reviews now live in **`docs/BUG_PATTERNS.md`** — the authoritative KB,
with per-class signature + false-positive guard + "Seen in" list — not duplicated here. Process
lessons that aren't a bug class live in the global review skill / `FACTS.md`: verify the commit count
before finalizing (pr78); in the double-check, re-read the full path even after the known issues are
confirmed fixed (pr156); re-review from the CURRENT commit list, treating a dropped commit as
reportable (pr307). The full per-finding analysis is in `reviews/*_reasoning.txt`. When a new review
surfaces a recurring pattern, append it to `docs/BUG_PATTERNS.md` (see its "Maintenance" section).

---

## Quick Reference

**Essential commands** (`rtb` = `~/.claude/skills/review-toolbox/rtb`, read-only source wrapper):
```bash
# Review workflow (new MRs) — read through rtb, not raw git
rtb log  --ref origin/master..prNN --head 1000  # Count/list commits
rtb diff --ref origin/master..prNN              # Full diff
rtb cat  file.c --ref prNN --lines LINE1,LINE2  # Read actual source
rtb facts                                       # Paths/refs/rules → paste into subagents

# Formatting
awk 'length > 120' reviews/prNN.md            # Check line width

# Doc-consistency check (stats across CLAUDE.md/MEMORY.md/docs/*.md vs actual files)
helpers/verify_docs.sh
```

**Key principles**:
1. **Quality over quantity** - Zero false positives
2. **Verify every bug** - Read actual code, not just diffs
3. **Completeness mandatory** - All commits must be reviewed
4. **120 char limit** - All documentation files

---

## File Update Policy

**DO NOT update**:
- `MRS_BY_AUTHOR.md` — kept as an archival reference only, not reconciled against
  `data/open.txt`/`data/closed.txt`. A prior version of this policy said to update it on
  every close/open; that is no longer current practice.
- `ai-analysis/BRANCHES_REVIEWS.md` (historical record)
- `grub/` repository files (analysis only)

See CLAUDE.md "Completed Work Summary" for the historical duplicate-detection/MR-creation
numbers (Phase 1-3) — not repeated here to avoid two copies drifting apart.

---

**Note**: This file contains working knowledge for the repository. See `CLAUDE.md`
for project overview and `docs/REVIEW_PROCESS.md` for detailed procedures.

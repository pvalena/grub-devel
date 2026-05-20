# GRUB Upstream Review Workflow

Tools for discovering, reviewing, and submitting code reviews on
[GRUB2 merge requests](https://gitlab.freedesktop.org/gnu-grub/grub/-/merge_requests).

Reviews are AI-generated (Claude Code + review skill), human-verified,
and posted as MR comments via `glab`.

## Quick Start

Run the full pipeline interactively (prompts for confirmation at each step):

```bash
./pipeline.sh                  # checkout, view, review, submit, commit, push
./pipeline.sh -n               # dry run -- no submissions or pushes
```

Or run individual steps manually:

```bash
# 1. Discover new MRs (polls GitLab API starting after the last known MR)
helpers/mr-new.sh

# 2. Checkout the new branches locally
helpers/checkout-new.sh

# 3. View diffs for the new MRs (before reviewing)
helpers/view-new.sh

# 4. Review with Claude Code (uses the review skill)
#    Creates reviews/prNN.md (and *_reasoning.txt for issues found)

# 5. Submit reviews as MR comments
./submit-review.sh -n          # dry run -- prints reviews without posting
./submit-review.sh -v          # verbose -- prints + posts
./submit-review.sh             # posts all pending reviews
```

## Scripts

### Main

| Script | Purpose |
|--------|---------|
| `pipeline.sh` | End-to-end: checkout, view, review (manual), submit, commit, push. Interactive. |
| `submit-review.sh` | Post reviews as MR comments. Processes `data/new.txt` first, then all unsubmitted. |

**Flags** (both scripts): `-d` debug, `-n` dry run (print only), `-v` verbose.

### helpers/

| Script | Purpose |
|--------|---------|
| `mr-new.sh` | Discover new MRs by polling GitLab API. Appends to `data/new.txt` or `data/closed.txt`. |
| `checkout-new.sh` | Checkout branches for MRs listed in `data/new.txt` as `pr${MR}` in `grub/`. |
| `view-new.sh` | Show `git log -p` for each new MR branch (diff against `origin/master`). |
| `watch.sh` | Loop: run `mr-new.sh` every hour. Use to watch for new upstream MRs. |
| `mr-status.sh` | Re-check open/closed status of all tracked MRs. Updates `data/open.txt` and `data/closed.txt`. |
| `mr-status-new.sh` | Re-check status of MRs in `data/new.txt`. Removes closed/merged ones before checkout. |

Other helpers (`view.sh`, `show.sh`, `status.sh`, `rebase.sh`, etc.) are
for branch management and are less frequently used.

## Review Files

Reviews live in `reviews/`:

- `reviews/prNN.md` -- review for MR !NN (current naming)
- `reviews/YYYY-MM-NNNN.md` -- review for older branches (mailing list import naming)
- `reviews/*_reasoning.txt` -- deep technical analysis (only when issues found)

Review files follow a structured format (see the `review` skill) with
120-character line width. Each review lists all commits, documents any
issues found with file/line references, includes draft fix patches where
straightforward, and links to the reasoning file for details.

## Data Files

| File | Purpose |
|------|---------|
| `data/open.txt` | Open MR numbers (source of truth) |
| `data/closed.txt` | Closed/merged MR numbers |
| `data/new.txt` | Newly discovered MRs awaiting review (transient) |
| `data/done.txt` | MRs whose reviews have been submitted |
| `data/mrs.txt` | Historical MR mapping (branch name to MR number) |

## Other Files

- `MRS_BY_AUTHOR.md` -- open MRs organized by author (mailing list import only)
- `MEMORY.md` -- working knowledge and current repo state
- `CLAUDE.md` -- Claude Code instructions for this project
- `docs/REVIEW_PROCESS.md` -- detailed review methodology
- `grub/` -- GRUB git repository with all branches

### Historical (from mailing list import)

These files are from the original mailing list patch import and
duplicate detection phases. They are kept for reference but are not
part of the current workflow:

- `ai-analysis/` -- branch classification data and analysis summaries
- `branches.txt`, `authors.txt`, `duplicates.txt` -- import artifacts
- `docs/DUPLICATE_ANALYSIS_PLAN.md` -- original duplicate detection methodology

## Prerequisites

- [glab](https://gitlab.com/gitlab-org/cli) configured for `gitlab.freedesktop.org`
  with `--repo gnu-grub/grub`
- Git access to the GRUB repository (remote: `ssh.gitlab.freedesktop.org:gnu-grub/grub`)
- zsh (all scripts use `#!/usr/bin/env zsh` or `#!/usr/bin/zsh`)
- Custom git aliases used in some helpers: `gitc` (checkout), `gitp` (pull),
  `gitpr` (fetch MR branch), `giteo` (rebase on origin/master),
  `gits` (status), `gitb` (branch), `giths` (show --stat)

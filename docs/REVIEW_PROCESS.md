# GRUB Merge Request Review Process

This document describes the systematic process for reviewing GRUB merge requests (MRs) from
the upstream GitLab repository.

## Overview

We maintain AI-assisted reviews of all MRs in the `reviews/` directory. Each review must be:
1. **Complete** - Cover all commits in the MR
2. **Accurate** - No false positives or hallucinated bugs
3. **Actionable** - Clearly describe issues with file:line references

> **How reviews are run today:** the phases below are executed by **delegated agents** — a
> review agent writes the artifacts, a separate fresh-context adversarial agent double-checks,
> and the orchestrator approves. The model per role is interchangeable (don't assume
> Opus/Sonnet); see `HANDOVER.md` (operating runbook + agent prompt templates) and `MEMORY.md`
> "Review Delegation Model" for the current defaults. The phase content in this document
> remains the definition of what each agent does.

> **Reading source:** all `grub/` reads go through `rtb` — the read-only `review-toolbox`
> wrapper (`~/.claude/skills/review-toolbox/rtb`; `.rtbrc` registers `grub` as the default
> source, `FACTS.md` is fed to subagents via `rtb facts`). It needs one Bash approval instead
> of broad `git`/`sed` and makes writes structurally impossible. The `git`/`sed` pipelines
> shown historically below map to `rtb` as: `git log --oneline A..B` → `rtb log --ref A..B
> --head 1000`; `git show REF:path | sed -n 'A,Bp'` → `rtb cat path --ref REF --lines A,B`;
> `git diff A..B` → `rtb diff --ref A..B`; `git grep P REF -- paths` → `rtb grep P --ref REF
> -- paths`. Use `rtb`, not raw `git -C grub`, for new work.

## Repository Structure

```
grub-devel/
├── grub/                          # Submodule: branches with all MR commits (READ-ONLY)
├── reviews/                       # Individual MR reviews (one per branch)
│   ├── prNN.md                    # New-MR review (base: origin/master, rebased)
│   ├── YYYY-MM-NNNN.md            # Historical/original-corpus review (base: see below)
│   ├── *_reasoning.txt            # Brief reasoning, only for reviews with issues
│   └── *_investigation.txt        # Verification trail, only for large/complex CLEAN reviews
├── MRS_BY_AUTHOR.md               # Archival reference only — not maintained, do not edit
├── data/
│   ├── open.txt / closed.txt      # Open/closed MR numbers (counts: see MEMORY.md)
│   └── new.txt                    # Pipeline-populated review queue (often absent; normal)
├── helpers/, pipeline.sh, submit-review.sh, container/   # Discovery/submission automation
│                                     — see MEMORY.md "How review requests reach this session"
└── docs/
    ├── REVIEW_PROCESS.md          # This file
    └── BUG_PATTERNS.md            # Recurring bug-class KB (consult before each review)
```

Counts above are recount-on-demand, not hardcoded — see MEMORY.md "Current Status" for the
live numbers; this diagram shows shape, not size.

## Review Workflow

### 1. Verify Review Completeness

**Problem**: Reviews may miss commits due to incorrect counting.

**Solution**: Always verify commit count against master base.

```bash
# Find branch for MR (example: MR !39)
grep "!39" data/mrs.txt          # → 2025-05-0016|39

# Count commits since the branch's base. rtb reads by ref — no checkout needed.
# New prNN branches: base origin/master. Historical YYYY-MM-NNNN: base c160b586… (below).
rtb log --ref c160b58610879a52d959db21b9cae98af5fd095f..2025-05-0016 --head 1000 | wc -l

# List all commits for review
rtb log --ref c160b58610879a52d959db21b9cae98af5fd095f..2025-05-0016 --head 1000
```

**Master base commit**: `c160b58610879a52d959db21b9cae98af5fd095f` — this applies to
**historical `YYYY-MM-NNNN` branches only** (the original mailing-list corpus). **New `prNN`
branches are based on `origin/master`** (rebased as master moves) — use
`rtb log --ref origin/master..prNN --head 1000`, not the fixed hash above, for those.

**Cross-check**: Compare the count with what's documented in the review file.

### 2. Verify Review Accuracy

**Problem**: Reviews may contain false positives or hallucinated bugs.

**Solution**: Verify each reported issue by reading the actual code.

```bash
# For each reported bug, verify by reading the code (full function at the branch)
rtb cat <file-path> --ref prNN

# Or check specific lines / around a pattern
rtb cat grub-core/path/to/file.c --ref prNN --grep "suspected_bug" --ctx 10
```

**Common false positives to watch for:**
- Misunderstanding protocol semantics (e.g., UEFI close behavior)
- Missing context (e.g., pointer set to NULL later in function)
- Incorrect assumptions about data flow

**Verification checklist:**
- [ ] Can you see the exact bug in the code?
- [ ] Is the scenario actually exploitable?
- [ ] Does the fix make sense in context?

### 3. Re-review Campaign Strategy

**When to re-review:**
- MRs marked "No Issues Found" with complex code
- MRs with resource management (malloc/free, DMA, transfers)
- Large MRs (>500 lines) that may hide bugs

**Success rate from testing:**
- ~4-8% of "No Issues" MRs have hidden bugs
- Focus on: resource lifecycle, error paths, cleanup code

**Best candidates for re-review:**
1. Complex subsystems (USB controllers, filesystem drivers)
2. Multi-file changes affecting resource ownership
3. Error handling paths with early returns
4. Module initialization/cleanup code

### 4. Submitting Review Comments to GitLab

**Prerequisites:**
```bash
# One-time setup
glab config set host gitlab.freedesktop.org --global
```

**Submit comment to MR:**
```bash
cd grub/

# Always specify --repo due to ssh.gitlab.freedesktop.org remote mismatch
glab mr comment <MR_NUMBER> --repo gnu-grub/grub -m "Your review comment"

# Example: MR !42
glab mr comment 42 --repo gnu-grub/grub -m "Found potential double-free bug in xhci.c:2099"
```

**Multi-line review from file:**
```bash
cat > review-mr42.md <<'EOF'
## Review of MR !42

Found critical issues:

1. **Potential double-free** (grub-core/bus/usb/xhci.c:2099,2196):
   `grub_xhci_check_transfer()` frees `transfer->controller_data` (line 2099)
   without setting it to NULL. If `grub_xhci_cancel_transfer()` is subsequently
   called on the same transfer, it retrieves the dangling pointer (line 2142-2143)
   and frees it again (line 2196), causing double-free.

   **Fix**: Add `transfer->controller_data = NULL;` after line 2099.

2. **Incomplete module cleanup** (xhci.c:2574-2578):
   `GRUB_MOD_FINI` halts/resets controllers but doesn't free DMA allocations
   (`devs_dma`, `eseg_dma`, `cmds_dma`, `evts_dma`, `spba_dma`, `spad_dma`)
   or global `xhci` controller list. Module unload leaks DMA memory.
EOF

glab mr comment 42 --repo gnu-grub/grub -F review-mr42.md
```

**Note**: The `--repo` flag is required because git remotes use `ssh.gitlab.freedesktop.org`
which doesn't match glab's configured host `gitlab.freedesktop.org`. In current practice this
manual step is automated by `submit-review.sh` (run by the pipeline operator after this
session stops) — see MEMORY.md "How review requests reach this session". The commands above
remain useful for manual/ad-hoc submission.

## Review File Format

### Individual Review (`reviews/YYYY-MM-NNNN.md`)

```markdown
# AI Review: MR !XX - Title

N commits description:

1. **commit_hash** - Description: Key changes and purpose
2. **commit_hash** - Description: Key changes and purpose
...

[If issues found:]
- **Issue type** (file:line): Description of bug with exact scenario
- **Issue type** (file:line): Another issue

[If no issues:]
No issues found.

[If complex/untestable:]
**Note**: [Explanation of why review is limited, testing requirements]
```

**Example with issues:**
```markdown
# AI Review: MR !42 - Add xHCI support

Adds USB 3.0 (xHCI) controller driver. 2963 lines based on SeaBIOS implementation.

- **Potential double-free** (grub-core/bus/usb/xhci.c:2099,2196):
  `grub_xhci_check_transfer()` frees `transfer->controller_data` (line 2099)
  without setting it to NULL. If `grub_xhci_cancel_transfer()` is subsequently
  called, it frees the dangling pointer (line 2196), causing double-free.
  Should set `transfer->controller_data = NULL;` after line 2099.

**Note**: At 2963 lines, exhaustive review is impractical. Focused on resource
management. Needs extensive hardware testing.
```

### Reasoning Files (`reviews/prNN_reasoning.txt` / `reviews/YYYY-MM-NNNN_reasoning.txt`)

**Only create for reviews with issues found.**

> **Current house style (supersedes the severity-label format below):** no severity labels.
> Use honest, precise language instead — "read the source and found X" / "traced the logic
> and confirmed Y", not "verified correct". The historical `[Severity]:` prefix format and the
> Critical/Minor/Note/Concern classification that followed it, below, are **no longer used**
> and are kept only as a record of how this doc read before the convention changed — do not
> write new reasoning files this way. See `HANDOVER.md` / `MEMORY.md` "Review Delegation
> Model" for the current format (Discovery / Analysis / Step-by-step / Consequence per issue).

Reasoning files provide brief, technical justifications for issues discovered in code reviews.

**Requirements:**
- Brief and focused (no unnecessary prose)
- Include file paths and line numbers
- State what is wrong (not how to fix) and its consequence/impact
- Use precise, honest terminology — no severity labels
- **Do NOT create for "No issues found" reviews** (exception: a re-review that became clean
  keeps the prior round's reasoning file for traceability — see HANDOVER.md)

**Historical format (pre-2026 convention; do not use for new reviews):**
```
[Severity]: [Issue description at location]. [Technical explanation]. [Consequences].
```
Old example, for illustration only — would be written without the `Critical:`/`Minor:`
prefixes under the current convention:
```
Double-free at grub-core/bus/usb/xhci.c:2099,2196. grub_xhci_check_transfer() frees
transfer->controller_data (line 2099) without setting it to NULL. If
grub_xhci_cancel_transfer() is subsequently called on the same transfer, it retrieves the
dangling pointer (lines 2142-2143) and frees it again (line 2196). Fix: set
transfer->controller_data = NULL after line 2099.
```

**Current state**: 53 reasoning files for reviews with issues (recount:
`ls reviews/*_reasoning.txt | wc -l`).

### Formatting Requirements

**Constraint**: 120 character line width (mandatory for ALL files).

**Check formatting:**
```bash
# Check review files
awk 'length > 120 {print NR": " $0}' reviews/BRANCH.md

# Check reasoning files
awk 'length > 120 {print NR": " $0}' reviews/BRANCH_reasoning.txt

# Check all files
for file in reviews/*.md reviews/*_reasoning.txt; do
  cnt=$(awk 'length > 120' "$file" | wc -l)
  if [ "$cnt" -gt 0 ]; then
    echo "$file: $cnt lines over 120 chars"
  fi
done
```

**Fix long lines:**

Break at natural points:
- After commas, periods
- Before conjunctions (and, but, or)
- Before opening parentheses
- After closing parentheses

Preserve:
- Code blocks and indentation
- Bullet point structure
- Markdown formatting
- Technical terms (don't break function names)

**Example:**
```markdown
Before (>120 chars):
- **NULL pointer dereference** (grub-core/lib/cmdline.c:53): `grub_loader_cmdline_size()` calls `check_arg(argv[i], 0)` passing NULL as second parameter.

After (<120 chars):
- **NULL pointer dereference** (grub-core/lib/cmdline.c:53): `grub_loader_cmdline_size()` calls
  `check_arg(argv[i], 0)` passing NULL as second parameter.
```

### Summary Table (`MRS_BY_AUTHOR.md`) — historical format, do not edit this file

`MRS_BY_AUTHOR.md` is kept as an archival reference only and is not actively maintained or
reconciled against `data/open.txt`/`data/closed.txt`. The format below is shown for
historical context (how it was structured when it was maintained), not as a current
instruction to update it.

```markdown
## Critical Issues (13 MRs)

| MR | Title | Issue Found |
|----|-------|-------------|
| [!42](https://gitlab.../42) | Add xHCI support | Potential double-free, incomplete module cleanup |

## Summary Statistics

- **Pass rate**: 74.6% (47/63 MRs with no issues)
- **Critical issue rate**: 20.6% (13/63 MRs)
```

## Issue Classification (historical; no longer used)

> This section described a Critical/Minor/No-Issues/Complex classification scheme. **Current
> house style uses no severity labels at all** — every finding is described in honest,
> specific language (what's wrong, why it's real, what it affects) and left for the reader to
> judge impact, rather than pre-sorted into a severity bucket. Kept here only so old reviews
> using these terms (pre-2026) are still understandable; do not classify new findings this way.
> The underlying bug *categories* this section implied (crashes, resource leaks, build
> breakage, platform-specific complexity) are still useful to think about — see
> `docs/BUG_PATTERNS.md` for the current, actively-maintained version of that list, organized
> by recurring signature rather than severity.

## Common Bug Patterns

### 1. Double-Free
```c
grub_free(cdata);
// BUG: Missing transfer->controller_data = NULL;

// Later, if this function is called:
grub_free(transfer->controller_data);  // Double-free!
```

### 2. NULL Pointer Dereference
```c
void func(int *has_space) {
  if (*has_space == 0)  // Dereference without NULL check
    ...
}

func(NULL);  // Crash!
```

### 3. Resource Leaks in Error Paths
```c
buffer = grub_malloc(size);
if (!buffer)
  return;  // BUG: cursor not re-enabled, transfer not freed, etc.

// Normal cleanup code here...
```

### 4. Incomplete Module Cleanup
```c
GRUB_MOD_FINI(module) {
  stop_hardware();
  // BUG: Missing grub_dma_free() for allocated DMA buffers
  // BUG: Missing grub_free() for global structures
}
```

## Verification Examples

### Example 1: Verifying NULL Pointer Dereference (MR !60)

**Review claim**: NULL pointer dereference in grub_loader_cmdline_size()

**Verification**:
```bash
rtb cat grub-core/lib/cmdline.c --ref 2025-07-0295 --grep "grub_loader_cmdline_size" --ctx 30
```

**Code inspection**:
```c
unsigned int grub_loader_cmdline_size (int argc, char *argv[])
{
  for (i = 0; i < argc; i++)
    size += check_arg (argv[i], 0);  // Line 53: passes NULL as second arg!
}

static unsigned int check_arg (char *c, int *has_space)
{
  while (*c) {
    if (*c == ' ') {
      if (*has_space == 0)  // Line 32: dereferences NULL pointer!
```

**Result**: ✓ VERIFIED - Real bug

### Example 2: Verifying False Positive (MR !68)

**Review claim**: Double-free in esp_disk->partition

**Verification**:
```c
grub_free (esp_disk->partition);  // Line 1384
esp_disk->partition = NULL;        // Line 1386 - Sets to NULL!
grub_disk_close(esp_disk);         // Line 1407 - Safe, partition is NULL
```

**Result**: ✗ FALSE POSITIVE - partition set to NULL before close

## Tools and Commands

### Searching for patterns
```bash
# Find all occurrences of a function call (at the branch)
rtb grep "grub_free" --ref prNN -- grub-core/bus/usb/xhci.c

# Check if pointer is nulled after free
rtb cat grub-core/bus/usb/xhci.c --ref prNN --grep "grub_free(cdata)" --ctx 2

# Find resource allocation without corresponding free (scan the MR's diff).
# rtb --grep is a basic-regex grep (no -E alternation), so use grub_.*alloc:
rtb diff --ref origin/master..prNN --grep "grub_.*alloc"
```

### Checking commit details
```bash
# Show a single commit's changes (diff of the commit against its parent)
rtb diff <commit-hash>^ <commit-hash>

# Scope a commit's changes to one path
rtb diff <commit-hash>^ <commit-hash> -- path/to/file

# Show a specific file as of a commit/branch
rtb cat path/to/file --ref <commit-hash>
```

## Quality Checklist

Before finalizing any review:

- [ ] Verified all commits are listed (count matches git log)
- [ ] Each commit has a brief description
- [ ] All reported bugs include file:line references
- [ ] Verified bugs by reading actual code (no false positives)
- [ ] Classified issues by severity correctly
- [ ] Created reasoning file (if issues found)
- [ ] All files formatted to 120 char width
- [ ] Used proper markdown formatting with code blocks
- [ ] Commit hash references are correct and complete

## Continuous Improvement

### Lessons Learned

1. **Always count commits** - Don't trust manual counting, use
   `rtb log --ref origin/master..prNN --head 1000 | wc -l`
2. **Verify every bug claim** - Read the actual code, don't assume the review is correct
3. **Check for NULL assignments** - Common source of false positive double-free claims
4. **Understand protocol semantics** - E.g., UEFI close_protocol doesn't invalidate pointers
5. **Re-review high-value targets** - Complex code, resource management, error paths

### Success Metrics

- **Completeness**: 100% of commits must be covered
- **Accuracy**: Zero false positives in critical issues
- **Actionability**: All bugs include exact file:line and reproduction scenario
- **Coverage**: Re-reviewed 4 "No Issues" MRs, found 3 hidden bugs (75% success rate)

---

**Last updated**: 2026-10-08
**Review files**: 197 (.md) + 53 (_reasoning.txt) + 19 (_investigation.txt) — recount:
`ls reviews/*.md reviews/*_reasoning.txt reviews/*_investigation.txt | wc -l` per group
**Open/closed MR counts**: see `MEMORY.md` "Current Status" (not duplicated here — volatile)
**Master base**: see "Master base commit" above — differs for historical vs. `prNN` branches

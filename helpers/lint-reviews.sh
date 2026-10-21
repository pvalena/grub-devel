#!/usr/bin/env bash
#
# lint-reviews.sh -- pre-finalization checks for NEW review artifacts.
#
# Runs only against the review IDs you pass (not the whole corpus), so it fits
# the "check before finalizing a fresh review" step of the review workflow
# (see MEMORY.md Phase 5 / global review skill).
#
# Usage:
#   helpers/lint-reviews.sh <review-id> [<review-id> ...]
#   helpers/lint-reviews.sh pr227 pr228 2026-02-0071
#   (a trailing ".md" on an id is tolerated: pr227.md -> pr227)
#
# For each <id> it checks reviews/<id>.md and, when present, its companion
# reviews/<id>_reasoning.txt and reviews/<id>_investigation.txt.
#
# Checks (FAIL = must fix, WARN = look and decide):
#   1. 120-char line width on every artifact                       [FAIL]
#   2. no github.com links (this project's remote is GitLab)       [FAIL]
#   3. issues/reasoning consistency:
#        - "No issues found" review must NOT have a _reasoning.txt  [FAIL]
#          exception: a re-review that became clean may retain the
#          prior round's _reasoning.txt for traceability -- allowed
#          when an _investigation.txt is also present               [WARN]
#        - a review with issues MUST have a _reasoning.txt          [FAIL]
#   4. every _reasoning/_investigation link resolves to a file     [FAIL]
#   5. clean review with no _investigation.txt (ok if small)       [WARN]
#   6. a "**Commits:**" list is present                            [WARN]
#   7. header line is "# AI Review: MR !NN - <title>"              [FAIL]
#        - for a prNN id, NN must equal the number in the id (catches a
#          copy-pasted/wrong MR number -- a real mistake seen in practice)
#        - for other ids (e.g. YYYY-MM-NNNN), only the format is checked;
#          their MR number comes from a separate upstream mapping, not
#          the filename, so it isn't cross-checked here
#   8. "## Additional findings" is at most ~6 lines                [WARN]
#        - the section is a gist; detail belongs in _investigation.txt
#   9. a "**Re-review**:" intro paragraph is at most ~4 lines      [WARN]
#        - state what changed, don't re-argue it; full analysis goes in
#          Additional findings (gist) and _investigation.txt (detail)
#
# Exit status: 0 if no FAILs, 1 if any FAIL, 2 on usage error.

set -u

REPO_ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
REVIEWS="$REPO_ROOT/reviews"
MAXW=120
GITLAB="gitlab.freedesktop.org/pvalena/grub"

rc=0
err()  { printf '  [FAIL] %s\n' "$1"; rc=1; }
warn() { printf '  [WARN] %s\n' "$1"; }
ok()   { printf '  [ok]   %s\n' "$1"; }

if [ $# -eq 0 ]; then
  printf 'usage: %s <review-id> [<review-id> ...]\n' "$0" >&2
  exit 2
fi

for raw in "$@"; do
  id="${raw%.md}"
  md="$REVIEWS/$id.md"
  reasoning="$REVIEWS/${id}_reasoning.txt"
  investigation="$REVIEWS/${id}_investigation.txt"

  printf '== %s ==\n' "$id"
  if [ ! -f "$md" ]; then
    err "missing review file: reviews/$id.md"
    continue
  fi

  # 1. line width across all present artifacts
  for f in "$md" "$reasoning" "$investigation"; do
    [ -f "$f" ] || continue
    n=$(awk -v w="$MAXW" 'length > w {c++} END {print c+0}' "$f")
    if [ "$n" -gt 0 ]; then
      err "$(basename "$f"): $n line(s) over $MAXW chars -> awk 'length>$MAXW' reviews/$(basename "$f")"
    else
      ok "$(basename "$f"): width ok"
    fi
  done

  # 2. wrong host in links
  for f in "$md" "$reasoning" "$investigation"; do
    [ -f "$f" ] || continue
    if grep -qiE 'github\.com' "$f"; then
      err "$(basename "$f"): contains a github.com link (use $GITLAB)"
    fi
  done

  # 3. issues <-> reasoning consistency
  clean=0
  grep -qiE '^[[:space:]]*No issues found\.?[[:space:]]*$' "$md" && clean=1
  if [ "$clean" -eq 1 ] && [ -f "$reasoning" ]; then
    if [ -f "$investigation" ]; then
      warn "clean review retains a _reasoning.txt -- ok only if it is a prior review round's file kept for traceability (an _investigation.txt is present)"
    else
      err "review says 'No issues found' but a _reasoning.txt exists (reasoning files are only for reviews WITH issues)"
    fi
  fi
  if [ "$clean" -eq 0 ] && [ ! -f "$reasoning" ]; then
    err "review reports issues but has no _reasoning.txt"
  fi

  # 4. every companion-file link resolves (process substitution keeps rc in this shell)
  while read -r link; do
    [ -n "$link" ] || continue
    [ -f "$REVIEWS/$link" ] || err "links to reviews/$link which does not exist"
  done < <(grep -oE '[A-Za-z0-9._-]+_(reasoning|investigation)\.txt' "$md" | sort -u)

  # 5. clean review with no investigation file -> soft reminder
  if [ "$clean" -eq 1 ] && [ ! -f "$investigation" ]; then
    warn "clean review, no _investigation.txt -- fine for small/simple MRs; add one if this was large/complex"
  fi

  # 6. commit list present
  grep -qE '^\*\*Commits:\*\*' "$md" || warn "no '**Commits:**' list found"

  # 7. header line format, and (for prNN ids) MR number matches the filename
  header="$(head -n1 "$md")"
  if [[ "$header" =~ ^#\ AI\ Review:\ MR\ \!([0-9]+)\ -\ .+$ ]]; then
    hdr_num="${BASH_REMATCH[1]}"
    if [[ "$id" =~ ^pr([0-9]+)$ ]]; then
      id_num="${BASH_REMATCH[1]}"
      if [ "$hdr_num" != "$id_num" ]; then
        err "header says 'MR !$hdr_num' but filename is $id -> fix line 1 to 'MR !$id_num'"
      else
        ok "header: 'MR !$hdr_num' matches $id"
      fi
    else
      ok "header format ok ('MR !$hdr_num'; number not cross-checked for non-prNN id $id)"
    fi
  else
    err "header malformed -- line 1 must be '# AI Review: MR !NN - <title>', got: ${header:-<empty>}"
  fi

  # 8. "Additional findings" is a gist, not the analysis -- detail belongs in _investigation.txt
  af_lines=$(awk '/^## Additional findings/{p=1; next} /^For more details/{p=0} p && NF' "$md" | wc -l)
  if [ "$af_lines" -gt 6 ]; then
    warn "'## Additional findings' is $af_lines lines (target <=6) -- move detail to ${id}_investigation.txt, keep only the gist"
  fi

  # 9. a "**Re-review**:" intro paragraph states what changed, briefly -- not the full analysis
  rr_lines=$(awk '/^\*\*Re-review\*\*:/{p=1} p{print; if (!NF) exit}' "$md" | grep -c '[^[:space:]]')
  if [ "$rr_lines" -gt 4 ]; then
    warn "'**Re-review**:' intro is $rr_lines lines (target <=4) -- state what changed, move analysis to Additional findings / ${id}_investigation.txt"
  fi
done

printf '\n'
if [ "$rc" -eq 0 ]; then
  echo "lint: PASS"
else
  echo "lint: FAIL"
fi
exit "$rc"

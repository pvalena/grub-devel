#!/usr/bin/env bash
# Entrypoint for the GRUB2 review-runner image.
#   no args  -> interactive `claude` seeded with the baked batch-review prompt
#   args     -> exec them verbatim (e.g. `bash`, or a custom `claude -p ...` one-go run)
# Opt-in: CLAUDE_SKIP_PERMISSIONS=1 adds --dangerously-skip-permissions (off by default).
set -euo pipefail

MODEL="${MODEL:-claude-sonnet-5}"
PROMPT_FILE="${REVIEW_PROMPT_FILE:-/usr/local/share/review-prompt.txt}"

# Custom command wins.
if [ "$#" -gt 0 ]; then
    exec "$@"
fi

SKIP=()
if [ -n "${CLAUDE_SKIP_PERMISSIONS:-}" ]; then
    SKIP=(--dangerously-skip-permissions)
fi

PROMPT=""
[ -f "$PROMPT_FILE" ] && PROMPT="$(cat "$PROMPT_FILE")"

# Interactive by default (needs `-it`); seed the first turn with the review prompt if present.
if [ -n "$PROMPT" ]; then
    exec claude "${SKIP[@]}" --model "$MODEL" "$PROMPT"
else
    exec claude "${SKIP[@]}" --model "$MODEL"
fi

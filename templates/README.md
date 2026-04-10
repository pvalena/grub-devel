# Review Templates

This directory contains templates for creating consistent review documentation.

## Files

### review.md
Template for complete code review files (`reviews/YYYY-MM-NNNN.md`)

**Usage**:
1. Copy template to `reviews/BRANCH_NAME.md`
2. Fill in MR number and title
3. List ALL commits with hashes
4. Document issues found (verified in actual code)
5. Verify line width ≤120 chars

**Key requirements**:
- Every bug MUST be verified by reading actual code
- All commits must be listed
- File paths must include line numbers
- Lines must not exceed 120 characters

### reasoning.txt
Template for brief technical justifications (`reviews/YYYY-MM-NNNN_reasoning.txt`)

**Usage**:
1. Copy template to `reviews/BRANCH_NAME_reasoning.txt`
2. List each issue with severity level
3. Keep brief and focused
4. Verify line width ≤120 chars

**Key requirements**:
- Only create if issues found (NOT for "No issues found" reviews)
- State WHAT is wrong, not HOW to fix
- Include file:line in first sentence
- Use precise terminology
- Lines must not exceed 120 characters

## Workflow

1. **Create review** from `review.md` template
2. **Verify bugs** by reading actual code
3. **Create reasoning** (if issues found) from `reasoning.txt` template
4. **Check format**: `../check_format.sh`
5. **Verify completeness**: All commits listed and reviewed

## Quality Checks

Before finalizing:
- [ ] All commits listed (verify count with `git log --oneline BASE..HEAD | wc -l`)
- [ ] Every bug verified in actual code (not just diffs)
- [ ] File paths include line numbers
- [ ] Reasoning file created (if issues found)
- [ ] Line width ≤120 chars (run `../check_format.sh`)
- [ ] No false positives (checked for NULL assignments, cleanup code)

## See Also

- `docs/REVIEW_PROCESS.md` - Complete review workflow
- `MEMORY.md` - Quick reference and workflows
- `~/.claude/skills/review/SKILL.md` - Global review skill

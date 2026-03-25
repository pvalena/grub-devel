# MR Review Process

## Purpose

Document the approach for reviewing merge requests to ensure consistent, focused, and actionable feedback.

## Review Principles

### 1. Focus on Semantic and Logic Issues

- Verify the implementation logic is sound
- Check for potential bugs or edge cases
- Ensure internal consistency across files
- Confirm the approach solves the stated problem

### 2. Stay Within MR Scope

**DO NOT**:
- Suggest style changes or formatting improvements
- Recommend documentation additions (unless MR touches docs)
- Propose new practices or conventions for the repository
- Request changes to code not modified by the MR
- Suggest refactoring unrelated code

**DO**:
- Review only the code changed in the MR
- Verify changes are consistent across all modified files
- Check if the implementation matches the commit message

### 3. Respect Existing Repository Practices

- Don't impose new coding styles
- Don't request comments if surrounding code has none
- Don't suggest renaming conventions used throughout the project
- Follow the repository's existing patterns

### 4. Keep Reviews Brief

Reviews should be suitable for posting as MR comments:
- Skip metadata (branch/author/commit - already in MR)
- No "verdict" or "LGTM" sections needed
- Get straight to the point
- Use bullet points for clarity

### 5. "No Issues Found" is Valuable

If no semantic or logic issues exist, simply state:
- Brief explanation of what the code does (shows understanding)
- Confirmation of internal consistency
- "No issues found"

This is positive, actionable feedback.

## Review Template

```markdown
# Review: MR !XX - Brief Title

[1-2 sentence summary explaining what the code does]

[If issues found:]
- Issue 1: Description and why it matters
- Issue 2: Description and why it matters

[If no issues:]
Changes are internally consistent across all modified files.

No issues found.
```

## Example Reviews

### Example 1: No Issues

```markdown
# Review: MR !31 - Enable (u)divdi3 and (u)moddi3 for mips

Looks good. The logic is sound:

- MIPS added to `softdiv` group (enables `GRUB_DIVISION_IN_SOFTWARE`)
- 32-bit division helpers excluded for MIPS - uses native instructions
- 64-bit division helpers included for MIPS - provides software implementation

Changes are internally consistent across all 5 files.

No issues found.
```

### Example 2: Issues Found

```markdown
# Review: MR !XX - Add feature X

The implementation has a potential issue:

- Buffer allocation in `foo.c:123` doesn't check for NULL return
- Off-by-one error in loop at `bar.c:456` (should be `< size` not `<= size`)

Otherwise logic looks sound.
```

## What to Look For

### Logic Issues
- Null pointer dereferences
- Buffer overflows or underflows
- Off-by-one errors
- Resource leaks (memory, file handles, etc.)
- Race conditions or threading issues
- Incorrect error handling

### Consistency Issues
- Header declarations vs. implementation
- Conditional compilation blocks (#ifdef consistency)
- Function signatures across files
- Macro definitions used correctly

### Correctness Issues
- Does the code do what the commit message claims?
- Are edge cases handled?
- Is the approach correct for the problem being solved?

## What NOT to Look For

- Code style (indentation, spacing, naming)
- Missing comments or documentation
- Opportunities for refactoring unrelated code
- Better ways to structure code elsewhere in the project
- Performance optimizations (unless causing actual issues)

## Review Storage

Reviews are stored in `reviews/` directory:
- Filename: `BRANCH_NAME.md`
- Format: Markdown
- Keep concise and focused

---

**Remember**: The goal is to catch bugs and logic errors, not to impose preferences or expand scope.

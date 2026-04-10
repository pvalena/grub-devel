# AI Review: MR !XX - Brief Title

N commit(s) [brief description of what the MR does].

**Commits:**
1. **commit_hash_1** - Brief description of first commit
2. **commit_hash_2** - Brief description of second commit
...

## Issues Found

[If issues found, list each with this format:]

- **Issue Type** (file.c:line): Technical description of the issue.
  Additional details if needed. Impact/consequences.

- **Another Issue** (file.c:line): Description.

[Examples of issue types:]
- Potential double-free
- NULL pointer dereference
- Resource leak
- Buffer overflow
- Uninitialized variable
- Logic error
- Compilation error
- Missing error check

## Notes

[If applicable, add notes about:]
- Platform-specific code requiring specialized review
- Complexity requiring domain expertise
- Testing requirements
- Limitations of static analysis

[Example:]
**Note**: At XXXX lines, exhaustive review is impractical. Focused on resource management
and integration points. Requires extensive hardware testing.

---

[If NO issues found, replace "Issues Found" section with:]

## Review Result

No issues found.

[Optional: Add positive notes about the implementation]
The [approach/fix/implementation] is [correct/sound]:

- Validation point 1
- Validation point 2
- Why it works

---

**Important**:
- ALL commits must be listed with hashes
- EVERY bug must be verified by reading actual code
- File paths must include line numbers (file.c:123)
- Lines must not exceed 120 characters
- Create corresponding _reasoning.txt file ONLY if issues found

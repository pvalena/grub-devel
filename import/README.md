# GRUB2 Failed Patches — Import Analysis

1302 mailing list patches that failed to apply to `grub/master`.
Classified, deduplicated, inspected against upstream, and evaluated.

**Result**: 1303 dropped (987 dedup + 316 inspection/evaluation),
**46 kept** (25 standalone + 21 in 7 series). All 46 evaluated in-depth.

## Where to start

- [FINAL_REPORT.md](FINAL_REPORT.md) — method, numbers, file index
- [EVALUATION_OVERVIEW.md](EVALUATION_OVERVIEW.md) — every KEEP patch with type, size, and links to evaluation logs
- [SERIES.md](SERIES.md) — series overview with links to member lists
- [INSPECTION_LOG_UNIFIED.md](INSPECTION_LOG_UNIFIED.md) — every branch decision with evidence

## Key files

| What | File(s) |
|------|---------|
| Branches to keep (standalone) | `standalone.txt` (25) |
| Branches to keep (series) | `series/*` (7 series, 21 members) |
| Branches to drop | `drop_new.txt` (316) |
| Per-branch evaluation data | `evaluation/*.txt` (46 files) |

## In-depth code reviews

| Category | Count | File |
|----------|------:|------|
| Bug fix | 6 | [EVALUATION_LOG_BUGFIX.md](EVALUATION_LOG_BUGFIX.md) |
| New feature | 17 | [EVALUATION_LOG_NEWFEATURE.md](EVALUATION_LOG_NEWFEATURE.md) |
| Enhancement | 11 | [EVALUATION_LOG_ENHANCEMENT.md](EVALUATION_LOG_ENHANCEMENT.md) |
| Compatibility | 9 | [EVALUATION_LOG_COMPAT.md](EVALUATION_LOG_COMPAT.md) |
| RFC + Documentation | 3 | [EVALUATION_LOG_RFC_DOCS.md](EVALUATION_LOG_RFC_DOCS.md) |

## Verification

```bash
python3 generate_unified.py && python3 verify_unified.py && ./verify.sh
```

## For AI / continuation

See [CLAUDE.md](CLAUDE.md) (instructions), [MEMORY.md](MEMORY.md) (process + lessons),
[DUMP_MEMORY.md](DUMP_MEMORY.md) (exhaustive knowledge transfer).

# GRUB2 Failed Patches — Import Analysis

1302 mailing list patches that failed to apply to `grub/master`.
Classified, deduplicated, inspected against upstream, and evaluated.

**Result**: 295 dropped (upstream), **67 kept** (28 standalone + 39 in 9 series).

## Where to start

- [FINAL_REPORT.md](FINAL_REPORT.md) — method, numbers, file index
- [EVALUATION_OVERVIEW.md](EVALUATION_OVERVIEW.md) — every KEEP patch with type and size
- [SERIES.md](SERIES.md) — series overview with links to member lists
- [INSPECTION_LOG_UNIFIED.md](INSPECTION_LOG_UNIFIED.md) — every branch decision with evidence

## Key files

| What | File(s) |
|------|---------|
| Branches to keep (standalone) | `standalone.txt` |
| Branches to keep (series) | `series/*` |
| Branches to drop | `drop_new.txt` |
| Per-branch evaluation data | `evaluation/*.txt` |
| In-depth code reviews | `EVALUATION_LOG_BUGFIX.md` (more categories TBD) |

## For AI / continuation

See [CLAUDE.md](CLAUDE.md) (instructions) and [MEMORY.md](MEMORY.md) (process + lessons).

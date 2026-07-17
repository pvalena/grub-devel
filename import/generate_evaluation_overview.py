#!/usr/bin/env python3
"""
Generate EVALUATION_OVERVIEW.md from individual evaluation files in evaluation/.

Reads each evaluation file, extracts metadata, categorizes the patch,
and produces a summary table.
"""

import os
import re
import subprocess
from collections import Counter

DIR = os.path.dirname(os.path.abspath(__file__))
EVAL_DIR = os.path.join(DIR, 'evaluation')
SERIES_DIR = os.path.join(DIR, 'series')

# Manual overrides for categories the auto-categorizer gets wrong
OVERRIDES = {
    '2025-01-0096': 'Bug fix',
    '2025-03-0186': 'Enhancement',
    '2025-04-0048': 'Enhancement',
    '2025-04-0142': 'Enhancement',
    '2025-04-0270': 'New feature',
    '2025-05-0076': 'Enhancement',
    '2025-05-0077': 'Enhancement',
    '2025-05-0256': 'Bug fix',
    '2025-06-0117': 'Compatibility',
    '2025-07-0034': 'Bug fix',
    '2025-07-0042': 'Enhancement',
    '2025-07-0050': 'Enhancement',
    '2025-09-0195': 'Compatibility',
    '2025-09-0238': 'Enhancement',
    '2025-10-0189': 'Enhancement',
    '2025-10-0304': 'Documentation',
    '2025-11-0027': 'Enhancement',
    '2026-01-0019': 'RFC',
    '2026-01-0053': 'Compatibility',
    '2026-02-0101': 'Compatibility',
    '2026-03-0017': 'Enhancement',
}


def read_field(filepath, field, use_strings=False):
    """Extract a field value from an evaluation file, handling binary content."""
    try:
        if use_strings:
            r = subprocess.run(['strings', filepath], capture_output=True, text=True)
            lines = r.stdout.split('\n')
        else:
            with open(filepath, 'r', errors='replace') as f:
                lines = f.readlines()[:20]

        for line in lines:
            line = line.strip()
            if line.startswith(f'{field}:'):
                return line[len(field) + 1:].strip()
    except Exception:
        pass
    return ''


def categorize(branch, subj, auto_type):
    """Determine patch category."""
    if branch in OVERRIDES:
        return OVERRIDES[branch]

    subj_lower = subj.lower()
    if 'new feature' in auto_type.lower() or 'missing' in auto_type.lower():
        return 'New feature'
    if any(k in subj_lower for k in ['fix', 'correct', 'leak', 'overflow', 'restore']):
        return 'Bug fix'
    if any(k in subj_lower for k in ['doc', 'install:']):
        return 'Documentation'
    if any(k in subj_lower for k in ['disable', 'compat', 'clang', 'gcc', 'linker',
                                       'ia64', 'configure', 'bootstrap', 'aros']):
        return 'Compatibility'
    if any(k in subj_lower for k in ['add', 'support', 'implement', 'introduce',
                                       'import', 'module', 'command', 'rewrite']):
        return 'New feature'
    if any(k in subj_lower for k in ['remove', 'update', 'rename', 'enhance']):
        return 'Enhancement'
    return 'Enhancement'


def main():
    keeps = sorted(l.strip() for l in open(os.path.join(DIR, 'standalone.txt')))
    for sf in sorted(os.listdir(SERIES_DIR)):
        for line in open(os.path.join(SERIES_DIR, sf)):
            b = line.strip()
            if b and b not in keeps:
                keeps.append(b)
    keeps.sort()

    data = []
    for branch in keeps:
        filepath = os.path.join(EVAL_DIR, f'{branch}.txt')
        if not os.path.exists(filepath):
            print(f'WARNING: no evaluation file for {branch}')
            continue

        subj = read_field(filepath, 'Commit subject')
        series = read_field(filepath, 'Series')
        size = read_field(filepath, 'Patch size', use_strings=True)
        auto_type = read_field(filepath, 'Type', use_strings=True)

        cat = categorize(branch, subj, auto_type)

        if not size:
            size = '(see file)'

        if series == 'standalone':
            series_display = 'standalone'
        elif series:
            s = series.split(' ')[0]
            if os.path.exists(os.path.join(SERIES_DIR, s)):
                series_display = f'[{s}](series/{s})'
            else:
                series_display = series
        else:
            series_display = 'standalone'

        data.append((branch, cat, size, series_display, subj))

    cats = Counter(cat for _, cat, _, _, _ in data)

    lines = []
    lines.append('# Evaluation Overview')
    lines.append('')
    lines.append(f'{len(data)} KEEP branches evaluated. '
                 f'Detailed evaluation files in [`evaluation/`](evaluation/).')
    lines.append('Each file contains: commit message, FAILED.patch (the intended change that needs')
    lines.append('manual incorporation), any conflict resolution artifacts, and master context.')
    lines.append('')
    lines.append('---')
    lines.append('')
    lines.append('## Summary by type')
    lines.append('')
    lines.append('| Type | Count |')
    lines.append('|------|------:|')
    for cat in ['Bug fix', 'New feature', 'Enhancement',
                'Compatibility', 'RFC', 'Documentation']:
        lines.append(f'| {cat} | {cats.get(cat, 0)} |')
    lines.append(f'| **Total** | **{len(data)}** |')
    lines.append('')
    lines.append('---')
    lines.append('')
    lines.append('## All patches')
    lines.append('')
    lines.append('| Branch | Type | Size | Series | Summary |')
    lines.append('|--------|------|------|--------|---------|')
    for branch, cat, size, series, subj in data:
        link = f'[{branch}](evaluation/{branch}.txt)'
        lines.append(f'| {link} | {cat} | {size} | {series} | {subj} |')
    lines.append('')

    outpath = os.path.join(DIR, 'EVALUATION_OVERVIEW.md')
    with open(outpath, 'w') as f:
        f.write('\n'.join(lines))

    print(f'Written: {outpath} ({len(lines)} lines)')
    for cat in sorted(cats.keys()):
        print(f'  {cat}: {cats[cat]}')


if __name__ == '__main__':
    main()

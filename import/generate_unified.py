#!/usr/bin/env python3
"""
Regenerate INSPECTION_LOG_UNIFIED.md from the two source logs:
  - INSPECTION_LOG.md (series)
  - INSPECTION_LOG_STANDALONE.md (standalone)

Groups entries into 4 sections: KEEP series, KEEP standalone, DROP series,
DROP standalone. Adds markdown links to series/ files for KEEP series heads.
Deduplicates entries by primary branch ID.
"""

import re
import os

DIR = os.path.dirname(os.path.abspath(__file__))


def parse_entries(filename):
    entries = []
    current_heading = None
    lines = []
    for line in open(filename):
        if line.startswith('## ') and re.search(r'20\d{2}-\d{2}-\d{4}', line):
            if current_heading:
                entries.append((current_heading, '\n'.join(lines)))
            current_heading = line.strip()
            lines = []
        elif line.startswith('# ') and not line.startswith('## '):
            if current_heading:
                entries.append((current_heading, '\n'.join(lines)))
                current_heading = None
                lines = []
        elif current_heading:
            lines.append(line.rstrip())
    if current_heading:
        entries.append((current_heading, '\n'.join(lines)))
    return entries


def classify(heading, body, drops=None):
    if 'KEEP' in heading:
        return 'KEEP'
    if 'DROP' in heading or 'dissolved' in heading.lower():
        return 'DROP'
    # Check if the primary branch is in the drops set (authoritative)
    if drops:
        m = re.search(r'(20\d{2}-\d{2}-\d{4})', heading)
        if m and m.group(1) in drops:
            return 'DROP'
    for line in body.split('\n'):
        if 'Decision' in line:
            if 'DROP' in line:
                return 'DROP'
            if 'KEEP' in line:
                return 'KEEP'
    if '**Dropped branches**' in body and 'KEEP' not in heading:
        return 'DROP'
    if 'Already upstream' in body and 'Not upstream' not in body:
        return 'DROP'
    return 'UNKNOWN'


def main():
    seen = set()

    def dedup(entries):
        result = []
        for h, b in entries:
            branches = re.findall(r'(20\d{2}-\d{2}-\d{4})', h)
            if any(br not in seen for br in branches):
                for br in branches:
                    seen.add(br)
                result.append((h, b))
        return result

    series_entries = parse_entries(os.path.join(DIR, 'INSPECTION_LOG.md'))
    standalone_entries = parse_entries(os.path.join(DIR, 'INSPECTION_LOG_STANDALONE.md'))

    drops = set(l.strip() for l in open(os.path.join(DIR, 'drop_new.txt')))

    series_keep = dedup([(h, b) for h, b in series_entries if classify(h, b, drops) == 'KEEP'])
    series_drop = dedup([(h, b) for h, b in series_entries if classify(h, b, drops) == 'DROP'])
    standalone_keep = dedup([(h, b) for h, b in standalone_entries if classify(h, b, drops) == 'KEEP'])
    standalone_drop = dedup([(h, b) for h, b in standalone_entries if classify(h, b, drops) == 'DROP'])

    existing_files = set(os.listdir(os.path.join(DIR, 'series')))

    out = []
    out.append('# Patch Inspection — Unified Log')
    out.append('')
    out.append('Record of every inspected branch with decision and evidence.')
    out.append('Pipeline documentation: [FINAL_REPORT.md](FINAL_REPORT.md).')
    out.append('')
    out.append('---')
    out.append('')

    out.append('## KEEP — Series')
    out.append('')
    out.append(f'{len(series_keep)} series. Series files in [`series/`](series/), '
               f'overview in [`SERIES.md`](SERIES.md).')
    out.append('')
    for h, b in series_keep:
        mh = h
        for br in re.findall(r'(20\d{2}-\d{2}-\d{4})', h):
            if br in existing_files and f'[{br}]' not in mh:
                mh = mh.replace(br, f'[{br}](series/{br})', 1)
        out.append(mh)
        out.append(b)
        out.append('')

    out.append('---')
    out.append('')
    out.append('## KEEP — Standalone')
    out.append('')
    out.append(f'{len(standalone_keep)} entries. '
               f'Full list: [`standalone.txt`](standalone.txt).')
    out.append('')
    for h, b in standalone_keep:
        out.append(h)
        out.append(b)
        out.append('')

    out.append('---')
    out.append('')
    out.append('## DROP — Series')
    out.append('')
    out.append(f'{len(series_drop)} series. '
               f'Confirmed: [`confirmed_series.txt`](confirmed_series.txt).')
    out.append('All dropped branches in [`drop_new.txt`](drop_new.txt).')
    out.append('')
    for h, b in series_drop:
        out.append(h)
        out.append(b)
        out.append('')

    out.append('---')
    out.append('')
    out.append('## DROP — Standalone')
    out.append('')
    out.append(f'{len(standalone_drop)} entries. '
               f'Confirmed: [`confirmed.txt`](confirmed.txt).')
    out.append('All in [`drop_new.txt`](drop_new.txt).')
    out.append('')
    for h, b in standalone_drop:
        out.append(h)
        out.append(b)
        out.append('')

    outpath = os.path.join(DIR, 'INSPECTION_LOG_UNIFIED.md')
    with open(outpath, 'w') as f:
        f.write('\n'.join(out))

    print(f'Series KEEP: {len(series_keep)}, DROP: {len(series_drop)}')
    print(f'Standalone KEEP: {len(standalone_keep)}, DROP: {len(standalone_drop)}')
    print(f'Written: {outpath} ({len(out)} lines)')


if __name__ == '__main__':
    main()

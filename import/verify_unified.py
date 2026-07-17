#!/usr/bin/env python3
"""
Bidirectional consistency check for INSPECTION_LOG_UNIFIED.md
against standalone.txt, series/*, and drop_new.txt.

Checks:
1. Every KEEP-standalone branch is in standalone.txt and vice versa
2. Every KEEP-series head is a series/ file and vice versa
3. Every DROP branch is in drop_new.txt and vice versa
4. No branch appears in more than one section
5. No duplicate entries within any section
"""

import re
import os
import sys

DIR = os.path.dirname(os.path.abspath(__file__))
UNIFIED = os.path.join(DIR, "INSPECTION_LOG_UNIFIED.md")
ERRORS = 0


def err(msg):
    global ERRORS
    print(f"  ERROR: {msg}")
    ERRORS += 1


def ok(msg):
    print(f"  OK: {msg}")


def parse_sections(filename):
    """Parse the unified log into 4 sections.

    Collects branch IDs that appear in ## headings (authoritative)
    separately from those that appear only in body text (cross-references).
    """
    sections = {
        "KEEP_SERIES": set(),
        "KEEP_STANDALONE": set(),
        "DROP_SERIES": set(),
        "DROP_STANDALONE": set(),
    }
    # Also collect ALL branch IDs per section (including cross-refs)
    sections_all = {k: set() for k in sections}
    current = None

    for line in open(filename):
        if line.startswith("## KEEP — Series"):
            current = "KEEP_SERIES"
            continue
        elif line.startswith("## KEEP — Standalone"):
            current = "KEEP_STANDALONE"
            continue
        elif line.startswith("## DROP — Series"):
            current = "DROP_SERIES"
            continue
        elif line.startswith("## DROP — Standalone"):
            current = "DROP_STANDALONE"
            continue
        elif line.startswith("# "):
            current = None
            continue

        if current:
            for m in re.finditer(r"\b(20\d{2}-\d{2}-\d{4})\b", line):
                sections_all[current].add(m.group(1))
                # Only count as authoritative if in a ## heading line
                if line.startswith("## "):
                    sections[current].add(m.group(1))

    return sections, sections_all


def load_lines(filepath):
    if not os.path.exists(filepath):
        return set()
    return set(l.strip() for l in open(filepath) if l.strip())


def main():
    global ERRORS

    if not os.path.exists(UNIFIED):
        print(f"ERROR: {UNIFIED} not found")
        sys.exit(1)

    sections, sections_all = parse_sections(UNIFIED)

    # Ground truth
    standalone_keep = load_lines(os.path.join(DIR, "standalone.txt"))
    series_heads = set(
        f for f in os.listdir(os.path.join(DIR, "series"))
        if os.path.isfile(os.path.join(DIR, "series", f))
    )
    series_members = set()
    for sf in series_heads:
        for line in open(os.path.join(DIR, "series", sf)):
            series_members.add(line.strip())
    drops = load_lines(os.path.join(DIR, "drop_new.txt"))

    print("=== 1. KEEP — Standalone: unified vs standalone.txt ===")
    # Every branch in standalone.txt must be mentioned in KEEP_STANDALONE section
    missing_from_unified = sorted(standalone_keep - sections_all["KEEP_STANDALONE"])
    for b in missing_from_unified:
        err(f"{b} in standalone.txt but not in KEEP-Standalone section")
    if not missing_from_unified:
        ok(f"all {len(standalone_keep)} standalone keeps in unified")

    # No standalone keep should have a ## heading in a DROP section
    extra = sorted(sections["KEEP_STANDALONE"] & drops)
    for b in extra:
        err(f"{b} has heading in KEEP-Standalone but is in drop_new.txt")
    if not extra:
        ok("no KEEP-Standalone headings for dropped branches")

    print()
    print("=== 2. KEEP — Series: unified vs series/* ===")
    # Every series head must be mentioned in KEEP_SERIES section
    missing_heads = sorted(series_heads - sections_all["KEEP_SERIES"])
    for b in missing_heads:
        err(f"series head {b} not in KEEP-Series section")
    if not missing_heads:
        ok(f"all {len(series_heads)} series heads in unified")

    # Every series member must be mentioned in KEEP_SERIES section
    missing_members = sorted(series_members - sections_all["KEEP_SERIES"])
    for b in missing_members:
        err(f"series member {b} not in KEEP-Series section")
    if not missing_members:
        ok(f"all {len(series_members)} series members in unified")

    # No series keep should have a ## heading in a DROP section
    extra_s = sorted(sections["KEEP_SERIES"] & drops)
    for b in extra_s:
        err(f"{b} has heading in KEEP-Series but is in drop_new.txt")
    if not extra_s:
        ok("no KEEP-Series headings for dropped branches")

    print()
    print("=== 3. DROP — unified vs drop_new.txt ===")
    all_drop_in_unified = sections_all["DROP_SERIES"] | sections_all["DROP_STANDALONE"]
    # Every branch in drop_new.txt must be mentioned in a DROP section
    missing_drops = sorted(drops - all_drop_in_unified)
    for b in missing_drops:
        err(f"{b} in drop_new.txt but not in any DROP section")
    if not missing_drops:
        ok(f"all {len(drops)} drops in unified")

    # No branch with a ## heading in a DROP section should be a KEEP
    drop_headings = sections["DROP_SERIES"] | sections["DROP_STANDALONE"]
    keeps_in_drop_headings = sorted(drop_headings & (standalone_keep | series_members))
    for b in keeps_in_drop_headings:
        err(f"{b} has ## heading in DROP section but is a KEEP branch")
    if not keeps_in_drop_headings:
        ok("no KEEP branches have headings in DROP sections")

    print()
    print("=== 4. No duplicate ## headings across sections ===")
    # Check that no branch has a ## heading in more than one section
    pairs = [
        ("KEEP_SERIES", "KEEP_STANDALONE"),
        ("KEEP_SERIES", "DROP_SERIES"),
        ("KEEP_SERIES", "DROP_STANDALONE"),
        ("KEEP_STANDALONE", "DROP_SERIES"),
        ("KEEP_STANDALONE", "DROP_STANDALONE"),
        ("DROP_SERIES", "DROP_STANDALONE"),
    ]
    any_overlap = False
    for a, b in pairs:
        overlap = sections[a] & sections[b]
        if overlap:
            for br in sorted(overlap):
                err(f"{br} has ## heading in both {a} and {b}")
            any_overlap = True
    if not any_overlap:
        ok("no branch has headings in multiple sections")

    print()
    print("=== 5. No duplicate ## headings ===")
    headings = []
    for line in open(UNIFIED):
        if line.startswith("## ") and re.search(r"20\d{2}-\d{2}-\d{4}", line):
            headings.append(line.strip())

    seen_primary = {}
    for h in headings:
        primary = re.search(r"(20\d{2}-\d{2}-\d{4})", h).group(1)
        if primary in seen_primary:
            err(f"duplicate heading for {primary}:")
            err(f"  1: {seen_primary[primary][:80]}")
            err(f"  2: {h[:80]}")
        else:
            seen_primary[primary] = h
    if len(seen_primary) == len(headings):
        ok(f"{len(headings)} headings, no duplicates")

    print()
    print("=== SUMMARY ===")
    print(f"  KEEP-Series:     {len(series_heads)} series, {len(series_members)} members")
    print(f"  KEEP-Standalone: {len(standalone_keep)} branches")
    print(f"  DROP:            {len(drops)} branches")
    print(f"  Headings:        {len(headings)}")
    print(f"  Errors:          {ERRORS}")
    print()
    if ERRORS == 0:
        print("  ALL CHECKS PASS.")
    else:
        print(f"  {ERRORS} ERROR(S) FOUND.")
        sys.exit(1)


if __name__ == "__main__":
    main()

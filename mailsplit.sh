#!/usr/bin/env zsh

exit 1

fastdown https://lists.gnu.org/archive/mbox/grub-devel/2026-02

mkdir 2026-02-d

git mailsplit -o2026-02-d -- 2026-02

cd 2026-02-d

../commit.sh

#!/usr/bin/env zsh

set -e

zsh -n "$0"

[[ "$(basename "$PWD")" == 'grub' ]] || cd grub

gitb | grep -E '^\s*202' | grep -vE '\-(duplicate|skip)$' | xargs -i zsh -c "S=\"\$(gitc '{}' &>/dev/null||exit 255; gits '{}' | grep -v '^nothing to commit (use -u to show untracked files)$' | grep -v '^\$' | grep -v '^Your branch is up to date with ' | grep -v '^On branch ')\"; [[ -z \"\$S\" ]] && exit; echo; echo '>{}<'; echo \"\$S\""

gitc master &>/dev/null

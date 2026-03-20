#!/usr/bin/env zsh

set -xe
zsh -n "$0"

cd grub

gitc master

gitb | grep -E '^\s*202' | grep -vE '\-(duplicate|skip)$'  \
  | xargs -i zsh -c "echo; echo '>{}<'; gitc '{}' || exit 2; C=\"\$(gitl1 HEAD -1|cut -d' ' -f1)\"; [[ -n \"\$C\" ]] || exit 255; echo \">>\$C<<\"; gitrho || exit 255; gity \"\$C\" || { echo 'rebase-force: {}' >> ../fail.log; gitya; gitrhr; : }"

gitc master

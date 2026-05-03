#!/usr/bin/env zsh

set -xe

zsh -n "$0"

[[ "$(basename "$PWD")" == 'grub' ]] || cd grub

# e.g.
# gituf pvalena -o merge_request.create -o merge_request.target=master -o merge_request.target_project=pvalena/grub

gitb | grep -E '^\s*202' | grep -vE '\-(duplicate|skip)$' \
    | xargs -i zsh -c "echo; echo '>{}<'; gitc '{}' || exit 255; gitamah ' ' || exit 255; gituf pvalena -o merge_request.create -o merge_request.target=master -o merge_request.target_project=gnu-grub/grub || exit 255; sleep 5"

gitc master

#!/usr/bin/env zsh

set -xe

zsh -n "$0"

cd grub

# gituf pvalena -o merge_request.create -o merge_request.target=master -o merge_request.target_project=pvalena/grub

gitb | grep -E '^\s*202' | grep -vE '\-(duplicate|skip)$' \
    | xargs -i zsh -c "echo; echo '>{}<'; gitc '{}' && gituf pvalena -o merge_request.create -o merge_request.target=master -o merge_request.target_project=pvalena/grub; sleep 5"

gitc master

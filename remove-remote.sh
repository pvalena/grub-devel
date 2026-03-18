#!/usr/bin/env zsh

set -xe

zsh -n "$0"

[[ -r duplicates.txt ]]

cd grub

gitc master

cat ../duplicates.txt | xargs -i zsh -c "echo; echo '>{}<'; gitc '{}' || exit 2; gitcb '{}-duplicate' || exit 255; gituu || exit 255; gitc master|| exit 255; git push -d pvalena '{}'; gitb -D '{}'"

# Suggestion:
#   cd .. && ./remove.sh

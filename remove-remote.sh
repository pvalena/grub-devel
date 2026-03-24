#!/usr/bin/env zsh

# also does backups!

set -xe

zsh -n "$0"

[[ "$(basename "$PWD")" == 'grub' ]] || cd grub


gitc master


[[ -r ../duplicates.txt ]]

cat ../duplicates.txt | xargs -i zsh -c "echo; echo '>{}<'; gitc '{}' || exit 2; gitcb '{}-duplicate' || exit 255; gituu || exit 255; gitc master|| exit 255; git push -d pvalena '{}'; gitb -D '{}'" || R=$?
[[ $R -eq 0 ]] || [[ $R -eq 123 ]]


[[ -r ../skip.txt ]]

cat ../skip.txt | xargs -i zsh -c "echo; echo '>{}<'; gitc '{}' || exit 2; gitcb '{}-skip' || exit 255; gituu || exit 255; gitc master|| exit 255; git push -d pvalena '{}'; gitb -D '{}'"

# Suggestion:
#   cd .. && ./remove-local.sh

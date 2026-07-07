#!/usr/bin/env zsh

# also does backups!

set -xe

zsh -n "$0"

[[ "$(basename "$PWD")" == 'grub' ]] || cd grub


gitc master


[[ -r ../import/duplicates.txt ]]

cat ../import/duplicates.txt | xargs -i zsh -c "echo; echo '>{}<'; gitc '{}' || exit 2; gitcb '{}-duplicate' || exit 255; gituu || exit 255; gitc master|| exit 255; git push -d pvalena '{}'; gitb -D '{}'" || R=$?
[[ $R -eq 0 ]] || [[ $R -eq 123 ]]


[[ -r ../import/duplicates-new.txt ]]

cat ../import/duplicates-new.txt | xargs -i zsh -c "echo; echo '>{}<'; gitc '{}' || exit 2; gitcb '{}-duplicate' || exit 255; gituu || exit 255; gitc master|| exit 255; git push -d pvalena '{}'; gitb -D '{}'" || R=$?
[[ $R -eq 0 ]] || [[ $R -eq 123 ]]


[[ -r ../import/skip.txt ]]

cat ../import/skip.txt | xargs -i zsh -c "echo; echo '>{}<'; gitc '{}' || exit 2; gitcb '{}-skip' || exit 255; gituu || exit 255; gitc master|| exit 255; git push -d pvalena '{}'; gitb -D '{}'"

[[ -r ../import/skip_new.txt ]]

cat ../import/skip_new.txt | xargs -i zsh -c "echo; echo '>{}<'; gitc '{}' || exit 2; gitcb '{}-skip' || exit 255; gituu || exit 255; gitc master|| exit 255; git push -d pvalena '{}'; gitb -D '{}'"

# Suggestion; run:
#   import/remove-local.sh

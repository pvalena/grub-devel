#!/usr/bin/env zsh

set -x
set -e

zsh -n "$0"

[[ -n "$1" ]] && cd "$1"

d="$(basename "$PWD"|cut -d'-' -f-2)"

[[ -n "$d" ]]
[[ -d "../logs/" ]]
[[ -d "../grub/" ]]

for z in *; do
  grep -q ^diff $z || continue

#  [[ $z =~ .patch$ ]] && continue

  c="${d}-${z}"

  l="../logs/${c}.log"

  echo -e "\n$(date -Isec)" >> "$l"
  l="$(readlink -e "$l")"

#  P="$(grep -A1000000000 '^X-List-Received-Date' $z | tail -n +2)" ||:
#  [[ -n "$P" ]] || { echo 'FAIL: grep' | tee -a "${l}"; continue; }

#  f="$z.patch"
#
#  [[ -r "$f" ]] || { echo 'FAIL: exists' | tee -a "${l}"; continue; }
#
#  {
#    grep '^From:' $z
#    grep '^Date:' $z
#    grep '^Subject:' $z
#    echo
#    echo "$P"
#
#  } > "${f}"
#
#  f="$(readlink -e "$f")"
#
#  [[ -n "$f" ]] || { echo 'FAIL: file' | tee -a "${l}"; continue; }

  z="$(readlink -e "$z")"

  [[ -r "$z" ]] || { echo 'FAIL: file-2' | tee -a "${l}"; continue; }

#  m="set -x; cd ../grub || exit; gitc master || exit; gitcb $c || exit; patch -p1 < $f || echo FAIL ; gita -A; gitiam 'TEST: $c'"
  m="set -x; cd ../grub || exit; gitc master || exit; gitcb $c || exit; git am --abort &>/dev/null; git am -3 $z || { echo FAIL; git am --abort; gitc master && gitb -D $c; } ; gitc master &>/dev/null"

  zsh -n -c "$m" || { echo 'FAIL: cmd' | tee -a "${l}"; continue; }

  zsh -c "$m" 2>&1 | tee -a "${l}"
done

cd ../grub && gitc master

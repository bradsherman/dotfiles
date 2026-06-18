#!/usr/bin/env bash
# Switch the current zellij client to the next/prev session (sorted, wraps around).
# Usage: zj-cycle-session.sh [next|prev]
set -euo pipefail

dir="${1:-next}"
mapfile -t sessions < <(zellij list-sessions -n | grep -vi exited | awk '{print $1}' | sort)
n=${#sessions[@]}
(( n < 2 )) && exit 0

cur="${ZELLIJ_SESSION_NAME:-}"
idx=0
for i in "${!sessions[@]}"; do
  if [[ "${sessions[i]}" == "$cur" ]]; then idx=$i; break; fi
done

if [[ "$dir" == "prev" ]]; then
  target=$(( (idx - 1 + n) % n ))
else
  target=$(( (idx + 1) % n ))
fi

exec zellij action switch-session "${sessions[target]}"

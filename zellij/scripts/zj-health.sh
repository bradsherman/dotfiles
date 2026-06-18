#!/usr/bin/env bash
# Quick health check for the zjstatus plugin trap loop (and runaway zellij CPU).
#
# Background: zjstatus.wasm decodes zellij events via protobuf. If the plugin's
# ABI doesn't match the running `zellij --server` (e.g. after a zellij upgrade),
# it traps with "out of bounds memory access" on nearly every event in an
# infinite retry loop, pegging the server at >100% CPU. This script surfaces
# that early. See: zjstatus releases at github.com/dj95/zjstatus/releases.
#
# It measures the trap *rate* over a short sample (not absolute count), because
# the zellij log is append-only and keeps stale traps from past broken sessions.
#
# Usage: zj-health.sh            # one sample
#        zj-health.sh -w         # watch live (repeats every 5s)
set -euo pipefail

log="/tmp/zellij-$(id -u)/zellij-log/zellij.log"
sample=2           # seconds to measure trap growth over
pat="out of bounds memory access"

red=$'\e[31m'; grn=$'\e[32m'; ylw=$'\e[33m'; rst=$'\e[0m'

count_traps() { grep -c "$pat" "$log" 2>/dev/null || echo 0; }

check() {
  if [[ ! -r "$log" ]]; then
    printf '%s?%s no zellij log at %s (no server running yet?)\n' "$ylw" "$rst" "$log"
    return 0
  fi

  local before after rate maxcpu
  before=$(count_traps)
  sleep "$sample"
  after=$(count_traps)
  rate=$(( (after - before) / sample ))   # new traps per second

  maxcpu=$(ps -eo %cpu,args | grep "[z]ellij --server" | awk '{print $1}' | sort -rn | head -1)
  maxcpu="${maxcpu:-0}"

  if (( rate > 0 )); then
    printf '%s✗ TRAP LOOP%s  ~%s new plugin traps/sec — zjstatus.wasm mismatches your zellij version.\n' \
      "$red" "$rst" "$rate"
    printf '   top zellij server CPU: %s%%\n' "$maxcpu"
    printf '   fix: update zjstatus.wasm to match zellij %s (github.com/dj95/zjstatus/releases), then start a NEW session.\n' \
      "$(zellij --version 2>/dev/null | awk '{print $2}')"
    return 1
  fi

  printf '%s✓ healthy%s  0 new traps/sec · top zellij server CPU %s%%\n' "$grn" "$rst" "$maxcpu"
  return 0
}

if [[ "${1:-}" == "-w" ]]; then
  while :; do check || true; sleep 5; done
else
  check
fi

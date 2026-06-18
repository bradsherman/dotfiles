#!/usr/bin/env bash
# Print running zellij sessions on one line separated by " | " (for the zjstatus bar).
# The current session is highlighted with real ANSI truecolor escapes (requires the
# bar's command widget to use rendermode "raw"); others render dim. NOTE: do NOT use
# zjstatus "#[...]" syntax here — that needs rendermode "dynamic", which leaks memory
# (re-parses every bar repaint). raw + ANSI renders the same but doesn't leak.
set -euo pipefail

# zjstatus runs us with a stripped env; without XDG_RUNTIME_DIR zellij reads a stale
# socket store where every session looks EXITED. Restore it so we see live sessions.
export XDG_RUNTIME_DIR="${XDG_RUNTIME_DIR:-/run/user/$(id -u)}"

zj="$(command -v zellij || true)"
[[ -z "$zj" ]] && zj="/home/bsherman/.cargo/bin/zellij"

cur_name="${ZELLIJ_SESSION_NAME:-}"

"$zj" list-sessions -n \
  | grep -vi exited \
  | awk -v cur="$cur_name" '{ name=$1; iscur=($0 ~ /\(current\)/ || name==cur) ? 1 : 0; print name "\t" iscur }' \
  | sort \
  | awk -F'\t' -v dim=$'\033[38;2;114;113;105m' -v cur=$'\033[1;38;2;122;168;159m' -v rst=$'\033[0m' '
      NR>1 { printf "%s | %s", dim, rst }
      $2 == "1" { printf "%s%s%s", cur, $1, rst; next }
      { printf "%s%s%s", dim, $1, rst }
    '

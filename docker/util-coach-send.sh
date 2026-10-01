#!/usr/bin/env bash
# Types commands into the coach session, one line each, as if the athlete had typed them.
# Usage: util-coach-send "/clear" "/plan scheduled"
#
# Each line waits until `claude agents` reports the session idle: keys typed mid-turn would
# queue behind it, and keys typed while a permission dialog is open would answer the dialog.
# Exits 1, having typed nothing more, if the session is missing or stays busy.
set -euo pipefail

SESSION="${COACH_SESSION:-coach}"
# "=name:" is an exact session match. send-keys takes a pane target, where a bare "=name" is
# not found ("can't find pane").
TARGET="=${SESSION}:"
WAIT_S="${COACH_IDLE_WAIT_S:-60}"

# Nothing here may see the bot token under the name the channel plugin reads (see
# claude-session-coach), not even `claude agents`.
unset TELEGRAM_BOT_TOKEN

# The Claude process in the pane, matched by PID rather than name so it holds across /clear.
status() {
  local pane pid
  pane="$(tmux list-panes -t "${TARGET}" -F '#{pane_pid}' 2>/dev/null | head -1)"
  pid="$( [ -n "${pane}" ] && pgrep -P "${pane}" | head -1 || true)"
  [ -n "${pid}" ] || { echo missing; return; }
  claude agents --json 2>/dev/null \
    | jq -r --argjson pid "${pid}" 'map(select(.pid == $pid))[0].status // "missing"' \
    || echo missing
}

for line in "$@"; do
  waited=0
  until [ "$(status)" = idle ]; do
    if [ "${waited}" -ge "${WAIT_S}" ]; then
      echo "util-coach-send: session ${SESSION} is $(status); not sending \"${line}\"" >&2
      exit 1
    fi
    sleep 2
    waited=$((waited + 2))
  done
  tmux send-keys -t "${TARGET}" -l "${line}"
  sleep 1
  tmux send-keys -t "${TARGET}" Enter
  echo "util-coach-send: sent \"${line}\""
  sleep 2
done

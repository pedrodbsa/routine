#!/usr/bin/env bash
# Runs a command in a detached tmux session and restarts it whenever it exits.
# Usage: util-keep-alive <session> <command> [args...]
#
# The restart loop lives inside the tmux session, so a crashed process comes back where it ran
# and `tmux attach -t <session>` always lands on the live one. Restarts are written to PID 1's
# stdout, which is the container log, because the pane itself is not logged anywhere.
set -euo pipefail

name=$1
shift

if tmux has-session -t "=${name}" 2>/dev/null; then
  exit 0
fi

# shellcheck disable=SC2016 # expanded by the inner bash, not here
tmux new-session -d -s "${name}" -x 200 -y 50 bash -c '
  name=$0
  while true; do
    "$@" && rc=0 || rc=$?
    echo "$(date -Iseconds) util-keep-alive: ${name} exited with ${rc}; restarting in 5 s" >/proc/1/fd/1
    sleep 5
  done' "${name}" "$@"

echo "util-keep-alive: started tmux session ${name}"

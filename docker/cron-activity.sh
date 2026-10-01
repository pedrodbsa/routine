#!/usr/bin/env bash
# Hands each new Garmin activity to the coach session as `/log activity <id>`, so a session is
# recorded and the day's food re-tuned soon after the watch syncs. Dokploy runs it every 10
# minutes through the day (docs/container.md).
set -euo pipefail

today="$(date +%F)"
state=/root/.coach/state

# 1. Today's plan exists. Before it, the plan reads the activity itself, and the morning /clear
#    would wipe the log; on a day with no plan, the recap reconciles.
[ -e "/app/logbook/${today:0:7}/${today}.md" ] || exit 0

# 2. Today's activities.
activities="$(uvx --quiet --python 3.12 --with garminconnect==0.3.2 \
  python /usr/local/lib/coach/garmin-activities.py)"

# 3. Send each one not sent yet.
mkdir -p "${state}"
while IFS=$'\t' read -r id kind name; do
  [ -n "${id}" ] || continue
  [ -e "${state}/activity-${id}" ] && continue
  echo "cron-activity: ${id} ${kind} ${name}"
  util-coach-send "/log activity ${id}"
  touch "${state}/activity-${id}"
done <<<"${activities}"

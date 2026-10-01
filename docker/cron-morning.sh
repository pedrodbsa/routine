#!/usr/bin/env bash
# Starts the coach's day: /clear, then /plan scheduled, once Garmin has last night's sleep.
# Dokploy runs it every 10 minutes through the morning window (docs/container.md).
set -euo pipefail

today="$(date +%F)"
marker="/root/.coach/state/morning-${today}"

# 1. Already ran today, or the athlete already planned by hand.
[ -e "${marker}" ] && exit 0
[ -e "/app/logbook/${today:0:7}/${today}.md" ] && exit 0

# 2. Sleep record ready.
uvx --quiet --python 3.12 --with garminconnect==0.3.2 \
  python /usr/local/lib/coach/garmin-sleep-ready.py || exit 0

# 3. Send.
util-coach-send "/clear" "/plan scheduled"
mkdir -p "${marker%/*}" && touch "${marker}"

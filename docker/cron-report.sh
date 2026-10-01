#!/usr/bin/env bash
# Sends /report scheduled into the coach session after the day's recap. Dokploy runs it every
# 10 minutes through the Sunday evening window (docs/container.md).
set -euo pipefail

today="$(date +%F)"
marker="/root/.coach/state/report-${today}"

# 1. Already ran today, or the recap hasn't gone in yet.
[ -e "${marker}" ] && exit 0
[ -e "/root/.coach/state/recap-${today}" ] || exit 0

# 2. Send. util-coach-send waits for the recap to finish.
util-coach-send "/report scheduled"
mkdir -p "${marker%/*}" && touch "${marker}"

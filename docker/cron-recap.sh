#!/usr/bin/env bash
# Sends /recap scheduled into the coach session. Dokploy runs it every 10 minutes through the
# evening window (docs/container.md).
set -euo pipefail

# One run at a time: if another run holds the lock, this one exits.
mkdir -p /root/.coach/state
exec 9>"/root/.coach/state/${0##*/}.lock"
flock -n 9 || exit 0

marker="/root/.coach/state/recap-$(date +%F)"

# 1. Already ran today.
[ -e "${marker}" ] && exit 0

# 2. Send.
util-coach-send "/recap scheduled"
touch "${marker}"

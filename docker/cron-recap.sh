#!/usr/bin/env bash
# Sends /recap scheduled into the coach session. Dokploy runs it every 10 minutes through the
# evening window (docs/container.md).
set -euo pipefail

marker="/root/.coach/state/recap-$(date +%F)"

# 1. Already ran today.
[ -e "${marker}" ] && exit 0

# 2. Send.
util-coach-send "/recap scheduled"
mkdir -p "${marker%/*}" && touch "${marker}"

#!/usr/bin/env bash
# Sends /recap scheduled into the coach session. Dokploy runs it once each evening
# (docs/container.md). Single shot: a busy session gets half an hour to go idle.
set -euo pipefail

COACH_IDLE_WAIT_S=1800 exec util-coach-send "/recap scheduled"

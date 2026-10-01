#!/usr/bin/env bash
# Sends /report scheduled into the coach session. Dokploy runs it once on Sunday evening, after
# cron-recap (docs/container.md). Single shot: it waits up to half an hour for the recap, or
# anything else, to finish.
set -euo pipefail

COACH_IDLE_WAIT_S=1800 exec util-coach-send "/report scheduled"

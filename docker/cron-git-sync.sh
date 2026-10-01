#!/usr/bin/env bash
# Commits whatever a session left behind and pushes it. Driven by a Dokploy schedule.
set -euo pipefail

cd /app

# Committing while a session is mid-write captures half a plan. Let the tree settle; the
# next cycle picks it up.
if [ -n "$(find . -name .git -prune -o -type f -mmin "-${SYNC_QUIET_MINUTES:-1}" -print -quit)" ]; then
  echo "tree changed in the last minute — skipping this cycle"
  exit 0
fi

if ! git pull --rebase --autostash; then
  echo "rebase failed; leaving the tree for manual resolution" >&2
  exit 1
fi

if [ -n "$(git status --porcelain)" ]; then
  git add -A
  git commit -m "chore(sync): $(date -Iseconds)"
fi

if [ -n "$(git log --oneline '@{u}..' 2>/dev/null)" ]; then
  git push
  echo "pushed"
else
  echo "nothing to push"
fi

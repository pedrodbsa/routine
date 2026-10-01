#!/usr/bin/env bash
set -euo pipefail

REPO_URL=https://github.com/pedrodbsa/routine.git

# The working repo lives on the persistent files mount, not in Dokploy's deploy checkout:
# that checkout embeds a short-lived token in its origin URL, which git prefers over the
# helper, and a redeploy wipes it. An empty mount means first boot, so clone. The URL stays
# bare; the image's credential helper supplies GITHUB_TOKEN if the repo is private.
if [ ! -d /app/.git ]; then
  echo "no repo at /app — cloning ${REPO_URL}"
  if ! git clone "${REPO_URL}" /app; then
    cat <<EOF

  Clone of ${REPO_URL} into /app failed — the coach has no repo to work in.
  Check GITHUB_TOKEN (required if the repo is private) and that /app is empty, then
  restart the container.

EOF
    exec sleep infinity
  fi
fi

# Remote Control needs a full-scope claude.ai login, which no environment variable can
# supply. Idling beats exiting here: under `restart: unless-stopped` an exit crash-loops
# and buries this message.
if [ ! -f /root/.claude/.credentials.json ]; then
  cat <<'EOF'

  Not signed in to claude.ai — Remote Control cannot start.
  Open a terminal on this container, run `claude`, use /login, then restart it.
  Credentials persist on the /root mount. cron-git-sync works without this.

EOF
  exec sleep infinity
fi

# The Telegram channel plugin is installed at user scope but disabled there, before any session
# starts: another Claude process that loaded it would poll the bot or, without the token, fail it
# and make the coach session skip it. claude-session-coach enables it for itself. Each step
# is a no-op once done.
sessions=(rc)
if [ -n "${COACH_TELEGRAM_BOT_TOKEN:-}" ]; then
  if claude plugin marketplace add anthropics/claude-plugins-official >/dev/null \
    && claude plugin install telegram@claude-plugins-official --scope user >/dev/null \
    && claude plugin disable telegram@claude-plugins-official --scope user >/dev/null; then
    sessions+=(coach)
  else
    echo "WARNING: Telegram plugin setup failed; no coach session. Restart to retry." >&2
  fi
fi

# Each long-lived Claude process runs in its own tmux session under util-keep-alive, so they are
# started, restarted and inspected the same way: `tmux attach -t <name>`, detach with C-b d.
# Session <name> runs the launcher claude-session-<name>.
export TERM="${TERM:-xterm-256color}"

# PID 1 (under tini) only supervises: util-keep-alive is a no-op for a live session, so this just
# recreates any session that was killed.
trap 'tmux kill-server 2>/dev/null; exit 0' TERM INT
while true; do
  for name in "${sessions[@]}"; do
    util-keep-alive "${name}" "claude-session-${name}"
  done
  sleep 30 &
  wait $!
done

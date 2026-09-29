#!/usr/bin/env bash
set -euo pipefail

REPO_URL=https://github.com/pedrodbsa/routine.git

if [ -n "${GIT_AUTHOR_NAME:-}" ]; then
  git config --global user.name "${GIT_AUTHOR_NAME}"
  git config --global user.email "${GIT_AUTHOR_EMAIL:-}"
fi

# A helper keeps the token in the environment. Putting it in the remote URL would write it
# in cleartext to .git/config.
if [ -n "${GITHUB_TOKEN:-}" ]; then
  git config --global credential.helper \
    '!f() { echo username=x-access-token; echo "password=${GITHUB_TOKEN}"; }; f'
fi

# The working repo lives on the persistent files mount, not in Dokploy's deploy checkout:
# that checkout embeds a short-lived token in its origin URL, which git prefers over the
# helper, and a redeploy wipes it. An empty mount means first boot, so clone. The URL stays
# bare; the helper above supplies the token if the repo is private.
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

# A credential in the remote URL outranks the helper and goes stale, which is how pushes
# failed silently before. Nothing here writes one, so if it appears someone put it there.
if git -C /app remote get-url origin 2>/dev/null | grep -q '://[^/]*@'; then
  echo "WARNING: origin URL in /app carries credentials; pushes will fail once they expire." >&2
  echo "         Fix with: git -C /app remote set-url origin ${REPO_URL}" >&2
fi

# Remote Control needs a full-scope claude.ai login, which no environment variable can
# supply. Idling beats exiting here: under `restart: unless-stopped` an exit crash-loops
# and buries this message.
if [ ! -f /root/.claude/.credentials.json ]; then
  cat <<'EOF'

  Not signed in to claude.ai — Remote Control cannot start.
  Open a terminal on this container, run `claude`, use /login, then restart it.
  Credentials persist on the /root mount. git-sync works without this.

EOF
  exec sleep infinity
fi

# Both long-lived Claude processes run in tmux sessions, so they are started, restarted and
# inspected the same way: `tmux attach -t rc` or `tmux attach -t telegram`, detach with C-b d.
# Each session <name> runs the script session-<name>.
export TERM="${TERM:-xterm-256color}"
keep-alive rc session-rc

# The Telegram session needs the channel plugin installed (a one-time step, see
# docs/container.md) and the bot token. The plugin polls in every Claude process that can see
# the token, so the token is never stored where the plugin would find it on its own.
telegram_ready() {
  [ -n "${COACH_TELEGRAM_BOT_TOKEN:-}" ] \
    && grep -qs "telegram@claude-plugins-official" /root/.claude/plugins/*.json
}
if [ -n "${TELEGRAM_BOT_TOKEN:-}" ] || [ -f /root/.claude/channels/telegram/.env ]; then
  echo "WARNING: a Telegram bot token is visible to every Claude process (TELEGRAM_BOT_TOKEN or" >&2
  echo "         /root/.claude/channels/telegram/.env). Each one would poll the bot and steal the" >&2
  echo "         Telegram session's messages. Use COACH_TELEGRAM_BOT_TOKEN only." >&2
fi
if telegram_ready; then
  keep-alive telegram session-telegram
elif [ -n "${COACH_TELEGRAM_BOT_TOKEN:-}" ]; then
  cat <<'EOF'

  COACH_TELEGRAM_BOT_TOKEN is set but the Telegram channel plugin is not installed, so the
  Telegram session is not running. Install it once from a container terminal (see
  docs/container.md, "Telegram"), then restart the container.

EOF
fi

# PID 1 (under tini) only supervises. If the rc session disappears, the tmux server is gone, and
# exiting lets `restart: unless-stopped` bring the whole container back.
trap 'tmux kill-server 2>/dev/null; exit 0' TERM INT
while tmux has-session -t '=rc' 2>/dev/null; do
  if telegram_ready && ! tmux has-session -t '=telegram' 2>/dev/null; then
    keep-alive telegram session-telegram
  fi
  sleep 30 &
  wait $!
done
echo "tmux session rc is gone; exiting so the container restarts" >&2
exit 1

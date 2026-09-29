#!/usr/bin/env bash
# The Telegram session: an interactive Claude Code session with the Telegram channel plugin.
#
# The plugin's MCP server starts polling the bot in every Claude process that loads it, and each
# new poller evicts the previous one (Telegram allows one getUpdates consumer per token). The
# Remote Control sessions and the scheduled `claude -p` runs load the same user-scope plugin, so
# if they could see the token they would steal this session's messages. The container therefore
# holds the token as COACH_TELEGRAM_BOT_TOKEN, which the plugin ignores, and only this process
# gets it under the name the plugin reads.
#
# It sets itself up on first start: it installs the plugin at user scope (on the persistent /root
# mount), and if TELEGRAM_CHAT_ID is set and no allowlist exists yet it writes one, so pairing is
# only needed without it. With no token it idles instead of exiting, which would make
# util-keep-alive restart it every 5 s.
set -euo pipefail

PLUGIN=telegram@claude-plugins-official
MARKETPLACE=anthropics/claude-plugins-official
ACCESS_FILE=/root/.claude/channels/telegram/access.json

# The pane is not logged anywhere, so status lines also go to the container log.
log() { echo "$(date -Iseconds) claude-session-telegram: $*" | tee /proc/1/fd/1; }
plugin_installed() {
  claude plugin list --json 2>/dev/null | jq -e --arg id "${PLUGIN}" 'any(.[]; .id == $id)' >/dev/null
}

if [ -n "${TELEGRAM_BOT_TOKEN:-}" ] || [ -f /root/.claude/channels/telegram/.env ]; then
  log "WARNING: a bot token is visible to every Claude process (TELEGRAM_BOT_TOKEN or" \
    "/root/.claude/channels/telegram/.env); each would poll the bot and steal this session's" \
    "messages. Use COACH_TELEGRAM_BOT_TOKEN only."
fi

if [ -z "${COACH_TELEGRAM_BOT_TOKEN:-}" ]; then
  log "COACH_TELEGRAM_BOT_TOKEN is not set; Telegram is off."
  exec sleep infinity
fi

if ! plugin_installed; then
  log "installing ${PLUGIN}."
  if ! { claude plugin marketplace add "${MARKETPLACE}" && claude plugin install "${PLUGIN}" --scope user; }; then
    log "plugin install failed; retrying in 5 min."
    sleep 300
    exit 1
  fi
fi

# DM chat id == user id, so the athlete's chat id is the allowlist entry that /telegram:access
# pair would have written.
if [ ! -f "${ACCESS_FILE}" ] && [ -n "${TELEGRAM_CHAT_ID:-}" ]; then
  install -d -m 700 "$(dirname "${ACCESS_FILE}")"
  jq -n --arg id "${TELEGRAM_CHAT_ID}" \
    '{dmPolicy: "allowlist", allowFrom: [$id], groups: {}, pending: {}}' >"${ACCESS_FILE}"
  chmod 600 "${ACCESS_FILE}"
  log "allowlisted chat ${TELEGRAM_CHAT_ID}."
fi

cd /app
export TELEGRAM_BOT_TOKEN="${COACH_TELEGRAM_BOT_TOKEN}"
exec claude --channels "plugin:${PLUGIN}"

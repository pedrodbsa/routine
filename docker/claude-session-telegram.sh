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
# Until Telegram is set up (token set, plugin installed; docs/container.md, "Telegram") this
# waits instead of exiting, which would make keep-alive restart it every 5 s. It starts on its
# own once the plugin is installed.
set -euo pipefail

PLUGIN=telegram@claude-plugins-official

# The pane is not logged anywhere, so status lines also go to the container log.
log() { echo "$(date -Iseconds) claude-session-telegram: $*" | tee /proc/1/fd/1; }
plugin_installed() { grep -qs "${PLUGIN}" /root/.claude/plugins/*.json; }

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
  log "the channel plugin is not installed; waiting for it (docs/container.md, \"Telegram\")."
  until plugin_installed; do sleep 60; done
  log "plugin installed; starting."
fi

cd /app
export TELEGRAM_BOT_TOKEN="${COACH_TELEGRAM_BOT_TOKEN}"
exec claude --channels "plugin:${PLUGIN}"

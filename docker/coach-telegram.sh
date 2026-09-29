#!/usr/bin/env bash
# The Telegram session: an interactive Claude Code session with the Telegram channel plugin.
#
# The plugin's MCP server starts polling the bot in every Claude process that loads it, and each
# new poller evicts the previous one (Telegram allows one getUpdates consumer per token). The
# Remote Control sessions and the scheduled `claude -p` runs load the same user-scope plugin, so
# if they could see the token they would steal this session's messages. The container therefore
# holds the token as COACH_TELEGRAM_BOT_TOKEN, which the plugin ignores, and only this process
# gets it under the name the plugin reads.
set -euo pipefail

: "${COACH_TELEGRAM_BOT_TOKEN:?COACH_TELEGRAM_BOT_TOKEN is not set}"

cd /app
export TELEGRAM_BOT_TOKEN="${COACH_TELEGRAM_BOT_TOKEN}"
exec claude --channels plugin:telegram@claude-plugins-official

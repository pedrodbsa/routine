#!/usr/bin/env bash
# The Telegram session: Claude Code with the Telegram channel plugin. The entrypoint installs the
# plugin disabled at user scope; --settings enables it for this session only (docs/container.md,
# "One poller per bot"). The token is held as COACH_TELEGRAM_BOT_TOKEN, a name the plugin
# ignores, and handed over here under the name it reads. The session only routes messages to
# commands, which pin their own model (AGENTS.md, "Telegram channel"), so it runs on Sonnet.
set -euo pipefail

cd /app
export TELEGRAM_BOT_TOKEN="${COACH_TELEGRAM_BOT_TOKEN}"
exec claude --model sonnet --channels plugin:telegram@claude-plugins-official \
  --settings '{"enabledPlugins":{"telegram@claude-plugins-official":true}}'

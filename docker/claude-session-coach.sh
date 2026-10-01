#!/usr/bin/env bash
# The coach session: the one long-lived Claude Code session that does all the coaching. The
# athlete's Telegram messages arrive through the channel plugin, and cron-coach types the
# scheduled commands (/clear, /plan scheduled, /recap scheduled, /report scheduled) into this
# pane, so everything the coach did today is in the context the athlete replies to.
#
# The entrypoint installs the Telegram plugin disabled at user scope; --settings enables it for
# this session only (docs/container.md, "One poller per bot"). The token is held as
# COACH_TELEGRAM_BOT_TOKEN, a name the plugin ignores, and handed over here under the name it
# reads. The session routes messages to commands, which pin their own model (AGENTS.md,
# "Telegram channel"), so it runs on Sonnet.
set -euo pipefail

cd /app
export TELEGRAM_BOT_TOKEN="${COACH_TELEGRAM_BOT_TOKEN}"
exec claude --name coach --model sonnet --channels plugin:telegram@claude-plugins-official \
  --settings '{"enabledPlugins":{"telegram@claude-plugins-official":true}}'

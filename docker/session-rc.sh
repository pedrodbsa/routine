#!/usr/bin/env bash
# The Remote Control session: the troubleshooting door from claude.ai or the Claude app.
# Server mode spawns a fresh session in /app for each connection. It must never see the
# Telegram bot token (see session-telegram).
set -euo pipefail

cd /app
unset TELEGRAM_BOT_TOKEN
exec claude remote-control --name "${SESSION_NAME:-routine}" --spawn=same-dir

#!/usr/bin/env bash
# Sends stdin to the athlete's Telegram chat as plain text. coach-tick uses it to deliver the
# scheduled runs' output; the interactive Telegram session replies through the channel plugin.
#
# Sending does not conflict with the plugin's polling: only a second getUpdates consumer would.
set -euo pipefail

: "${COACH_TELEGRAM_BOT_TOKEN:?COACH_TELEGRAM_BOT_TOKEN is not set}"

# The chat is the athlete's DM with the bot, whose id is the one the plugin allowlisted at
# pairing. TELEGRAM_CHAT_ID overrides it.
access_file="${TELEGRAM_STATE_DIR:-/root/.claude/channels/telegram}/access.json"
chat_id="${TELEGRAM_CHAT_ID:-}"
if [ -z "${chat_id}" ] && [ -f "${access_file}" ]; then
  chat_id="$(jq -r '.allowFrom[0] // empty' "${access_file}")"
fi
if [ -z "${chat_id}" ]; then
  echo "telegram-send: no chat id — set TELEGRAM_CHAT_ID or pair the bot first" >&2
  exit 1
fi

text="$(cat)"
if [ -z "${text//[[:space:]]/}" ]; then
  exit 0
fi

send() {
  # The token goes to curl on stdin, not argv, so it never shows up in the process list.
  curl -fsS --retry 3 --max-time 30 -o /dev/null -K - \
    --data-urlencode "chat_id=${chat_id}" \
    --data-urlencode "text=$1" \
    <<<"url = \"https://api.telegram.org/bot${COACH_TELEGRAM_BOT_TOKEN}/sendMessage\""
}

# Telegram caps a message at 4096 characters. Split on line boundaries at 3500 bytes, which is
# always under the character cap, and hard-wrap any single line longer than that.
while IFS= read -r -d '' chunk; do
  send "${chunk}"
done < <(fold -b -w 3500 <<<"${text}" | awk '
  { if (length(buf) + length($0) + 1 > 3500) { printf "%s%c", buf, 0; buf = "" }
    buf = (buf == "" ? $0 : buf "\n" $0) }
  END { if (buf != "") printf "%s%c", buf, 0 }')

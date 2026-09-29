#!/usr/bin/env bash
# Sends stdin to the athlete's Telegram chat. cron-coach uses it to deliver the scheduled runs'
# output; the interactive Telegram session replies through the channel plugin.
# Usage: util-telegram-send [--html] [--buttons "ok,escalate"]
#   --html     parse as Telegram HTML (docs/telegram-format.md). A chunk Telegram rejects is
#              sent again as plain text with the tags stripped, so bad markup never loses a
#              message.
#   --buttons  quick-reply buttons under the last chunk. Tapping one sends its label as an
#              ordinary message, which the Telegram session routes like typed text.
#
# Sending does not conflict with the plugin's polling: only a second getUpdates consumer would.
set -euo pipefail

: "${COACH_TELEGRAM_BOT_TOKEN:?COACH_TELEGRAM_BOT_TOKEN is not set}"

html=0
buttons=""
while [ $# -gt 0 ]; do
  case "$1" in
    --html) html=1 ;;
    --buttons) buttons="$2"; shift ;;
    *) echo "usage: util-telegram-send [--html] [--buttons a,b,c]" >&2; exit 2 ;;
  esac
  shift
done

# The chat is the athlete's DM with the bot, whose id is the one the plugin allowlisted at
# pairing. TELEGRAM_CHAT_ID overrides it.
access_file="${TELEGRAM_STATE_DIR:-/root/.claude/channels/telegram}/access.json"
chat_id="${TELEGRAM_CHAT_ID:-}"
if [ -z "${chat_id}" ] && [ -f "${access_file}" ]; then
  chat_id="$(jq -r '.allowFrom[0] // empty' "${access_file}")"
fi
if [ -z "${chat_id}" ]; then
  echo "util-telegram-send: no chat id — set TELEGRAM_CHAT_ID or pair the bot first" >&2
  exit 1
fi

text="$(cat)"
if [ -z "${text//[[:space:]]/}" ]; then
  exit 0
fi

keyboard=""
if [ -n "${buttons}" ]; then
  keyboard="$(jq -cn --arg b "${buttons}" \
    '{keyboard: [$b | split(",") | map({text: gsub("^ +| +$"; "")})],
      resize_keyboard: true, one_time_keyboard: true}')"
fi

# Prints the HTTP status. The token goes to curl on stdin, not argv, so it never shows up in the
# process list.
post() {
  local body=$1 mode=$2 markup=$3
  local args=(--data-urlencode "chat_id=${chat_id}" --data-urlencode "text=${body}")
  [ -z "${mode}" ] || args+=(--data-urlencode "parse_mode=${mode}")
  [ -z "${markup}" ] || args+=(--data-urlencode "reply_markup=${markup}")
  curl -sS --retry 3 --max-time 30 -o /dev/null -w '%{http_code}' -K - "${args[@]}" \
    <<<"url = \"${COACH_TELEGRAM_API:-https://api.telegram.org}/bot${COACH_TELEGRAM_BOT_TOKEN}/sendMessage\""
}

plain() {
  sed -e 's/<[^>]*>//g' -e 's/&lt;/</g' -e 's/&gt;/>/g' -e 's/&quot;/"/g' -e 's/&amp;/\&/g' <<<"$1"
}

send() {
  local chunk=$1 markup=$2 status
  if [ "${html}" = 1 ]; then
    status="$(post "${chunk}" HTML "${markup}")"
    # 400 is Telegram refusing the markup; anything else is not ours to fix by reformatting.
    if [ "${status}" = 400 ]; then
      echo "util-telegram-send: HTML rejected; resending as plain text" >&2
      status="$(post "$(plain "${chunk}")" "" "${markup}")"
    fi
  else
    status="$(post "${chunk}" "" "${markup}")"
  fi
  if [ "${status}" != 200 ]; then
    echo "util-telegram-send: Telegram returned HTTP ${status}" >&2
    return 1
  fi
}

# Telegram caps a message at 4096 characters. Split on line boundaries at 3500 bytes, which is
# always under the character cap, and hard-wrap any single line longer than that. Messages are
# written to fit in one, so a split (which can cut an HTML tag, caught by the fallback) is rare.
chunks=()
while IFS= read -r -d '' chunk; do
  chunks+=("${chunk}")
done < <(fold -b -w 3500 <<<"${text}" | awk '
  { if (length(buf) + length($0) + 1 > 3500) { printf "%s%c", buf, 0; buf = "" }
    buf = (buf == "" ? $0 : buf "\n" $0) }
  END { if (buf != "") printf "%s%c", buf, 0 }')

last=$((${#chunks[@]} - 1))
for i in "${!chunks[@]}"; do
  if [ "${i}" -eq "${last}" ]; then
    send "${chunks[$i]}" "${keyboard}"
  else
    send "${chunks[$i]}" ""
  fi
done

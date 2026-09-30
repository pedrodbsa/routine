#!/usr/bin/env bash
# PreToolUse(Telegram reply / edit_message): text escaped for MarkdownV2 but sent without
# format "markdownv2" shows every backslash on the phone (docs/telegram-format.md).
input="$(cat)"
format="$(jq -r '.tool_input.format // "text"' <<<"${input}")"
[ "${format}" = "markdownv2" ] && exit 0
if jq -r '.tool_input.text // empty' <<<"${input}" | grep -Eq '\\[][_*()~`>#+=|{}.!-]'; then
  echo 'Blocked: the text is escaped for MarkdownV2 but format is not "markdownv2", so the backslashes would show on the phone. Resend with format: "markdownv2", or remove the escapes and markup for plain text (docs/telegram-format.md).' >&2
  exit 2
fi
exit 0

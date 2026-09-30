#!/usr/bin/env bash
# PreToolUse(Bash): protocols/ changes go through Edit, which the "ask" rule gates. The container
# allows Bash broadly, so without this a sed -i or a redirect could change a protocol unattended.
# A heuristic, not a boundary: it catches the forms Claude writes, and reads pass through.
cmd="$(jq -r '.tool_input.command // empty')"
[[ "${cmd}" == *protocols/* ]] || exit 0

writes='(sed|perl)[^|;&]*[[:space:]]-i|>>?[[:space:]]*[^[:space:]]*protocols/|\btee\b|\b(mv|rm|cp|truncate|touch|install|ln)[[:space:]]|\bgit[[:space:]]+(checkout|restore|apply|mv|rm)\b|\b(python3?|node|bun|uv|awk)\b'
if grep -Eq "${writes}" <<<"${cmd}"; then
  echo "Blocked: this Bash command looks like it writes under protocols/. Make protocol changes with the Edit tool so they go through approval (AGENTS.md; docs/container.md § Permissions). If the command only reads, use Read or grep instead." >&2
  exit 2
fi
exit 0

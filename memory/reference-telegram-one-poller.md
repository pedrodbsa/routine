---
name: reference-telegram-one-poller
description: "The Telegram channel plugin polls in EVERY Claude process that loads it and can see TELEGRAM_BOT_TOKEN, evicting the others — so the token lives as COACH_TELEGRAM_BOT_TOKEN and only the tmux `telegram` session gets it"
metadata:
  type: reference
---

Telegram allows exactly one `getUpdates` consumer per bot token. The official channel plugin (`telegram@claude-plugins-official`, `server.ts`) starts polling as soon as its MCP server starts — whether or not the session was launched with `--channels` — and on start it kills any stale local poller. A plugin installed at user scope loads in every Claude process in the container: the Remote Control sessions, the scheduled `claude -p` runs, and the Telegram session. If they could all see the token, whichever started last would take the messages, and a non-channel session silently drops them.

**Second failure mode (found on the server 2026-09-29):** a process that loads the plugin *without* the token fails its MCP server, and Claude Code caches that failure for 15 min in `~/.claude/mcp-needs-auth-cache.json`, which every process honours — Remote Control won the startup race and the Telegram session silently skipped the plugin (no bun process, `/mcp` showed ✘ failed). Fix: the entrypoint installs the plugin and disables it at user scope before any session starts, and only `claude-session-telegram` enables it via `--settings '{"enabledPlugins":{…:true}}'`. Never put it in the project `enabledPlugins`.

**The token rule (built 2026-09-29):** the container holds the token as `COACH_TELEGRAM_BOT_TOKEN`, which the plugin ignores. `docker/claude-session-telegram.sh` exports it as `TELEGRAM_BOT_TOKEN` for the tmux `telegram` session only, `cron-coach` unsets `TELEGRAM_BOT_TOKEN`, and `util-telegram-send` posts with the COACH_ name (sending doesn't conflict — only polling does). Never run `/telegram:configure`: it writes the token to `~/.claude/channels/telegram/.env`, which every process's plugin reads. Never install the plugin on the desktop.

Symptom when broken: `409 Conflict` in the `telegram` tmux pane, or messages that get no answer.

Related: [[project-dokploy-container]], [[project-workflow-automated-record]].

---
name: project-dokploy-container
description: "The routine repo runs as an always-on Claude Code Remote Control session on Dokploy; runbook at docs/container.md"
metadata:
  type: project
---

Built 2026-08-06. This repo ships a `Dockerfile` + `docker-compose.yml` that run Claude Code in
Remote Control server mode on the athlete's Dokploy server, so the coach is reachable from
claude.ai/code and the Claude mobile app. Full runbook: `docs/container.md`.

Design facts that are easy to get wrong later:

- **The working repo is `../files/repo`, not Dokploy's checkout (since 2026-09-29).** Dokploy's
  `code/` clone is build input only. It embeds an ~1 h GitHub App token in its origin URL, which
  git prefers over the `GITHUB_TOKEN` helper, so pushes from it fail silently once the token
  expires (12 commits sat unpushed before this was found); deploys also wipe it. The entrypoint
  clones `../files/repo` (mounted at `/app`) from GitHub on first boot with a bare URL; the image's
  `/etc/gitconfig` credential helper supplies `GITHUB_TOKEN`. **Host git work goes in `../files/repo`, never
  `code/`.** Agent state (credentials, trust record, Garmin token cache) lives on
  `../files/home`.
- **Auto Deploy must stay off.** The `cron-git-sync` schedule pushes to `main` every ~10 minutes;
  with Auto Deploy on, each push redeploys and kills the session. Dokploy's "on tag" trigger
  type would avoid this in theory but has an open bug (Dokploy#3710) where pushes still fire.
- **Remote Control needs a full-scope claude.ai login** — not an API key, not
  `CLAUDE_CODE_OAUTH_TOKEN`. It cannot be supplied by env var, so first boot parks the container
  and waits for an interactive `/login` in the container terminal. Credentials persist on the
  `../files/home` mount (`/root`).
- **Pushes come from a Dokploy schedule** running `cron-git-sync` in the container, not from Claude.
  That is why `git push` can stay behind an approval prompt without stranding work.
- The Garmin password moved out of `.mcp.json` into Dokploy's Environment tab via `${VAR}`
  expansion, and the old one was rotated — it is still in git history.

- **Since 2026-09-29 the container also runs the Telegram coach.** Both long-lived Claude
  processes run in tmux sessions under a restart loop (`rc` = `claude remote-control`,
  `coach` = `claude -n coach --channels` with the Telegram plugin), with tini as PID 1. Dokploy
  schedules run the cron scripts.
- **One coach session; crons are a gate plus a send (2026-10-01).** The athlete's replies went to
  a session that never saw the headless `claude -p` plan/recap. Now `cron-morning` (not sent
  today, no daily file, sleep record ready → `/clear` + `/plan scheduled`), `cron-recap` and
  `cron-report` each check a gate, then `util-coach-send` types the command into the `coach`
  tmux pane once `claude agents --json` reports it `idle` (keys during a permission dialog
  would answer it). The athlete asked for exactly this shape — keep crons dumb, no completion
  tracking or retries in them. The session sends scheduled messages itself via
  `util-telegram-send` (buttons). See [[project-workflow-automated-record]] and [[reference-telegram-one-poller]].

Runbook: `docs/container.md`.

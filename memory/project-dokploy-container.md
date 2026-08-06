---
name: project-dokploy-container
description: "The routine repo runs as an always-on Claude Code Remote Control session on Dokploy; runbook at docs/container.md"
metadata:
  type: project
---

Built 2026-08-06. This repo ships a `Dockerfile` + `docker-compose.yml` that run Claude Code in
Remote Control server mode on the athlete's Dokploy server, so the coach is reachable from
claude.ai/code and the Claude mobile app. Full runbook: `docs/container.md`.

**Why it matters for planning:** this is a far cheaper path to "coach reachable away from the
desktop" than the greenfield build in [[project-remote-coach-service]] (n8n + bespoke TypeScript
`coach` CLI + Telegram, in the separate `X:\coach` repo). Before proposing work on that build,
check whether the container already covers the need.

Design facts that are easy to get wrong later:

- **Dokploy clones the repo and bind-mounts it at `/app`** — that clone is what the coach reads
  and writes. A deploy re-clones it, so anything unpushed at that moment is lost; `git-sync`
  every ~10 min keeps the window small. Agent state (credentials, trust record, Garmin token
  cache) lives on `../files/home`, outside what Dokploy clears.
- **Auto Deploy must stay off.** The `git-sync` schedule pushes to `main` every ~10 minutes;
  with Auto Deploy on, each push redeploys and kills the session. Dokploy's "on tag" trigger
  type would avoid this in theory but has an open bug (Dokploy#3710) where pushes still fire.
- **Remote Control needs a full-scope claude.ai login** — not an API key, not
  `CLAUDE_CODE_OAUTH_TOKEN`. It cannot be supplied by env var, so first boot parks the container
  and waits for an interactive `/login` in the container terminal. Credentials persist on the
  `/home/coach` mount.
- **Pushes come from a Dokploy schedule** running `git-sync` in the container, not from Claude.
  That is why `git push` can stay behind an approval prompt without stranding work.
- The Garmin password moved out of `.mcp.json` into Dokploy's Environment tab via `${VAR}`
  expansion, and the old one was rotated — it is still in git history.

See also [[feedback-git-allowed-this-project]] and [[reference-repo-relevant-parts]].

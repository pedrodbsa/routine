# Running this repo on Dokploy

This repo can run as an always-on Claude Code session on a server, reachable from
[claude.ai/code](https://claude.ai/code) or the Claude mobile app through Remote Control.

Dokploy clones the repo, builds the image, and starts the container. The clone is
bind-mounted at `/app`, so the session reads the protocols and writes the logbook directly in
it. Everything else the container needs — the claude.ai credentials, the workspace trust
record, the Garmin token cache — lives on a `../files/home` mount that survives redeploys.

A Dokploy schedule runs `git-sync` on a cron. It commits whatever a session left uncommitted
and pushes to `origin`, so work reaches GitHub without you approving a push from your phone.

Remote Control makes outbound HTTPS connections only. The container publishes no ports and
needs no domain, reverse proxy, or inbound firewall rule.

## Before you deploy

**Rotate the Garmin password.** The old one was committed to this repository in plaintext and
is still in the history on GitHub; removing it from the current files does not change that.
Rotate it, then put the new one in Dokploy's Environment tab.

**Create a GitHub token.** A fine-grained personal access token scoped to `pedrodbsa/routine`
with `contents: write`. The container uses it through a credential helper, so it stays in the
environment and is never written to `.git/config`.

## Create the Dokploy application

Create a **Compose** service — not an Application, which is oriented around HTTP and domains.

- **Source**: this repository, branch `main`. **Compose path**: `docker-compose.yml`.
- **Auto Deploy**: **off.** `git-sync` pushes to `main` every few minutes, and with Auto
  Deploy on each of those pushes redeploys the service and kills the running session.
  Dokploy's "on tag" trigger type would avoid this in principle, but there is an open bug
  reporting that it is ignored and pushes still trigger builds
  ([Dokploy#3710](https://github.com/Dokploy/dokploy/issues/3710)). Redeploy by hand when you
  change the Dockerfile, which is rare.

Do not set `COMPOSE_PROJECT_NAME`. Dokploy uses the project name to find the container when a
schedule fires, and overriding it breaks `git-sync`.

## Environment

Set these in the Environment tab. Dokploy writes them to `.env` beside the compose file, and
the compose file loads that with `env_file`. Full list with comments in `.env.example`.

| Variable | Purpose |
| --- | --- |
| `GARMIN_EMAIL`, `GARMIN_PASSWORD` | Expanded into the MCP server's environment by `.mcp.json` |
| `GITHUB_TOKEN` | Push credential for `git-sync` |
| `GIT_AUTHOR_NAME`, `GIT_AUTHOR_EMAIL` | Identity on commits made from the container |
| `TZ` | `Europe/Lisbon`. Meal and session sequencing depends on local time |

## First deploy

Deploy. The container finds no claude.ai credentials and parks with instructions in the logs
rather than exiting — an exit under `restart: unless-stopped` would crash-loop and bury the
message.

Open a terminal on the container from the Dokploy UI and run `claude`. Use `/login` and follow
the browser flow, then accept the workspace trust prompt while you are there. Remote Control
requires a full-scope claude.ai login on a Pro or Max plan; an API key will not work, and
neither will a token from `claude setup-token`.

Restart the container. It comes up running `claude remote-control`, and the session appears at
[claude.ai/code](https://claude.ai/code) as `routine` with a green dot.

## Set up the sync schedule

Add a Dokploy schedule against the `claude` service with command `git-sync` and cron
`*/10 * * * *`. Each run logs to the Dokploy UI, so a failed push is visible rather than
silent. The script skips its cycle if any file changed in the last minute, which keeps it from
committing a plan while a session is still writing it, and on a rebase conflict it stops and
leaves the tree alone.

## Operating it

**A deploy re-clones `/app`**, so anything not yet pushed at that moment is gone. With
`git-sync` running every ten minutes the exposure is small, but run it once by hand before a
deliberate redeploy if a session has just written something.

**Upgrading Claude Code means rebuilding the image.** The apt package does not auto-update,
which is deliberate — the running version changes only when you decide it does.

**A restart starts a fresh session.** The conversation does not carry over; the coaching state
does, because it lives in the repo. Find the new session by name at claude.ai/code.

**If the session goes quiet**, check the logs. Remote Control exits if the machine cannot
reach the network for roughly ten minutes, and `restart: unless-stopped` brings it back.

## Permissions

`.claude/settings.json` carries the shared allowlist, so it applies wherever this repo is
checked out. Reads, Garmin reads, writes under `logbook/` and `memory/`, and `git add` and
`git commit` run unattended. Garmin workout uploads, edits to `protocols/`, and `git push`
prompt for approval — the actions worth a tap on your phone before they fire.

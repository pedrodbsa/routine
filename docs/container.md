# Running this repo on Dokploy

This repo can run as an always-on Claude Code session on a server, reachable from
[claude.ai/code](https://claude.ai/code) or the Claude mobile app through Remote Control.

Dokploy clones the repo, builds the image, and starts the container. The coach does not work
in that clone. Its working copy is a separate clone on the persistent `../files/repo` mount,
bind-mounted at `/app`, which the container creates from GitHub on first boot. The session
reads the protocols and writes the logbook there. Everything else the container needs — the
claude.ai credentials, the workspace trust record, the Garmin token cache — lives on a
`../files/home` mount. Both mounts survive redeploys.

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
| `GITHUB_TOKEN` | Push credential for `git-sync`; also needed for the first-boot clone if the repo is private |
| `GIT_AUTHOR_NAME`, `GIT_AUTHOR_EMAIL` | Identity on commits made from the container |
| `TZ` | `Europe/Lisbon`. Meal and session sequencing depends on local time |

## First deploy

Deploy. The container finds `../files/repo` empty and clones the repo into it. It then finds
no claude.ai credentials and parks with instructions in the logs rather than exiting — an exit
under `restart: unless-stopped` would crash-loop and bury the message. A failed clone parks the
same way, with its own message.

Open a terminal on the container from the Dokploy UI and run `claude`. Use `/login` and follow
the browser flow, then accept the workspace trust prompt while you are there. Remote Control
requires a full-scope claude.ai login on a Pro or Max plan; an API key will not work, and
neither will a token from `claude setup-token`.

Restart the container. It comes up running `claude remote-control`, and the session appears at
[claude.ai/code](https://claude.ai/code) as `routine` with a green dot.

## Set up the sync schedule

Add a Dokploy schedule against the `routine` service with command `git-sync` and cron
`*/10 * * * *`. Each run logs to the Dokploy UI, so a failed push is visible rather than
silent. The script skips its cycle if any file changed in the last minute, which keeps it from
committing a plan while a session is still writing it, and on a rebase conflict it stops and
leaves the tree alone.

## Why the working repo is not the deploy checkout

Until 2026-09-29 the compose file mounted Dokploy's checkout (`code/` on the host) as `/app`.
That broke in three ways, all from the same cause.

- **Pushes failed silently.** Dokploy clones with a GitHub App installation token that expires
  after about an hour, and it embeds that token in the origin URL. Git uses credentials in the
  URL in preference to any credential helper, so once the token expired every push failed with
  "Invalid username or token" — `git-sync`, the container's `GITHUB_TOKEN` helper, and
  `gh auth setup-git` on the host alike. Pulls kept working because the repo is public, which
  hid the failure until twelve commits had piled up unpushed.
- **A redeploy wiped unpushed work.** Dokploy re-clones its checkout on every deploy.
- **Host commands hit the live repo.** Running `gh repo sync` in `code/` reset the coach's
  working branch.

Now the deploy checkout is build input only: the image is built from it and nothing else reads
it. The working repo on `../files/repo` has a bare origin URL, pushes through the
`GITHUB_TOKEN` helper, and is never touched by a deploy. The entrypoint never writes a token
into the URL, and it logs a warning on every start if it finds one there.

## Operating it

**Do git operations on the host in `../files/repo`, never in `code/`.** `code/` is Dokploy's
build checkout. Changing it does nothing to the running coach, and a deploy overwrites it.

**A deploy does not touch the working repo.** Unpushed work survives a redeploy. To start from
a fresh clone, stop the container, empty `../files/repo`, and start it again — after checking
that everything is pushed.

**Upgrading Claude Code means rebuilding the image.** The apt package does not auto-update,
which is deliberate — the running version changes only when you decide it does.

**A restart starts a fresh session.** The conversation does not carry over; the coaching state
does, because it lives in the repo. Find the new session by name at claude.ai/code.

**If the session goes quiet**, check the logs. Remote Control exits if the machine cannot
reach the network for roughly ten minutes, and `restart: unless-stopped` brings it back.

## Migrating from the deploy-checkout layout

A one-time procedure, run on the host, for a server still on the old `.:/app` mount.

1. **Make sure everything is pushed.** In the container, `git -C /app status -sb` must show
   no ahead/behind count and a clean tree. If the origin URL still carries a token, strip it
   first (`git -C /app remote set-url origin https://github.com/pedrodbsa/routine.git`) and
   run `git-sync` once. Anything left unpushed here stays behind in `code/`.
2. **Commit and push the compose, entrypoint and docs changes.**
3. **Redeploy in Dokploy.** The container starts with an empty `../files/repo` and clones from
   GitHub on boot. The clone log line and any failure appear in the container logs.
4. **Verify git inside the container.**
   - `git -C /app remote get-url origin` prints `https://github.com/pedrodbsa/routine.git`,
     with no credentials in it.
   - `git -C /app log -1` matches the latest commit on GitHub.
   - `git-sync` prints "nothing to push".
   - Make a test commit in `/app` and confirm the next scheduled `git-sync` run pushes it.
5. **Verify the session.** Remote Control comes up with `/app` as its working directory, and
   the session picks up `.mcp.json` (the Garmin tools are available) and
   `.claude/settings.json` (the allowlist applies) from the new clone. The workspace trust
   record lives on `../files/home` and is keyed by path, so it carries over.
6. **Optionally, make the GitHub repo private.** Only after steps 4 and 5 pass. The repo holds
   medication, weight, lab and daily-log data. Dokploy deploys keep working through its GitHub
   App; the container's clone and pushes use `GITHUB_TOKEN`. Re-run step 4 afterwards.

## Permissions

`.claude/settings.json` carries the shared allowlist, so it applies wherever this repo is
checked out. Reads, Garmin reads, writes under `logbook/` and `memory/`, and `git add` and
`git commit` run unattended. Garmin workout uploads, edits to `protocols/`, and `git push`
prompt for approval — the actions worth a tap on your phone before they fire.

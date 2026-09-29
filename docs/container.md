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

Remote Control and the Telegram plugin make outbound HTTPS connections only. The container
publishes no ports and needs no domain, reverse proxy, or inbound firewall rule.

## How the pieces fit

The athlete's day-to-day interface is Telegram. Three kinds of Claude process run in the
container, all against the same `/app` repo.

```
Dokploy cron */10 ─▶ coach-tick ─▶ claude -p "/plan scheduled" | "/recap" | "/report scheduled"
                                       └─ result ─▶ telegram-send (Bot API) ─▶ Telegram
tmux "telegram":  claude --channels telegram  ◀─ polls ─ Telegram (the athlete's replies)
tmux "rc":        claude remote-control       ◀─ claude.ai / Claude app (troubleshooting)
Dokploy cron */10 ─▶ git-sync ─▶ GitHub
```

- **The Telegram session** is an interactive Claude Code session started with the Telegram
  channel plugin (`--channels`). The plugin polls the bot, injects each message into the
  session, and gives Claude a `reply` tool. Permission prompts — a Garmin upload, a protocol
  edit — are relayed to Telegram as approve/deny buttons.
- **Remote Control can't carry Telegram.** It is a remote screen onto Claude sessions and has
  no Telegram side. Channels are switched on per session with a flag, and `claude
  remote-control`'s server mode refuses flags it can't pass on to the sessions it spawns. So
  the Telegram session is a separate process. Remote Control stays as the troubleshooting door
  from claude.ai or the Claude app.
- **The scheduled jobs are headless `claude -p` runs**, not messages into the Telegram session.
  Cron can't type into an interactive session. A headless run has a clean context and an exit
  code, and the wrapper — not the model — sends the result, so a crashed run still produces a
  failure notice. The processes don't share conversation context and don't need to: the
  daily file, `calendar.md` and `report.md` hold the state.
- **Permissions:** a `-p` run can't answer a permission prompt, so anything behind an "ask" rule
  in `.claude/settings.json` is refused. Scheduled runs read Garmin and write `logbook/`,
  `memory/` and `calendar.md`, but never upload workouts or edit `protocols/`. Those happen in
  the Telegram session, behind a button: "ok" runs `/garmin`, and "apply" writes the protocol
  edits the Sunday report proposed.
- **One poller per bot.** Telegram allows one `getUpdates` consumer per bot token, and the
  plugin starts polling in every Claude process that loads it and can see the token. The
  plugin is installed at user scope, so the Remote Control sessions and the `-p` runs load it
  too. The container therefore keeps the token as `COACH_TELEGRAM_BOT_TOKEN`, a name the plugin
  ignores, and `session-telegram` exports it as `TELEGRAM_BOT_TOKEN` for the Telegram session
  alone. Never run `/telegram:configure` (it writes the token to a file every process reads),
  and never install the plugin on the desktop.

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
| `TZ` | `Europe/Lisbon`. Meal and session sequencing depends on local time, and `coach-tick` gates on it |
| `COACH_TELEGRAM_BOT_TOKEN` | The bot token from BotFather. Deliberately not `TELEGRAM_BOT_TOKEN` — see "One poller per bot" above |
| `TELEGRAM_CHAT_ID` | Optional. The athlete's chat; defaults to the first allowlisted id from pairing |
| `COACH_MORNING_FROM`, `COACH_PLAN_CUTOFF` | Morning window for the scheduled `/plan`: default `05:00` and `12:00` |
| `COACH_RECAP_AT`, `COACH_REPORT_DOW` | Evening `/recap` time (default `21:30`) and the weekday the report follows it (default `7`, Sunday) |

## First deploy

Deploy. The container finds `../files/repo` empty and clones the repo into it. It then finds
no claude.ai credentials and parks with instructions in the logs rather than exiting — an exit
under `restart: unless-stopped` would crash-loop and bury the message. A failed clone parks the
same way, with its own message.

Open a terminal on the container from the Dokploy UI and run `claude`. Use `/login` and follow
the browser flow, then accept the workspace trust prompt while you are there. Remote Control
requires a full-scope claude.ai login on a Pro or Max plan; an API key will not work, and
neither will a token from `claude setup-token`.

Restart the container. It comes up running `claude remote-control` in the `rc` tmux session,
and the session appears at [claude.ai/code](https://claude.ai/code) as `routine` with a green
dot.

## Telegram

One-time setup.

1. In Telegram, message [@BotFather](https://t.me/BotFather), send `/newbot`, and copy the
   token. Set it as `COACH_TELEGRAM_BOT_TOKEN` in the Environment tab and redeploy.
2. Open a terminal on the container and run `claude` (a plain session; it can't see the token
   under the plugin's name, so it won't poll). Install the plugin at **user** scope, so it
   lives on the persistent `/root` mount:

   ```
   /plugin marketplace add anthropics/claude-plugins-official
   /plugin install telegram@claude-plugins-official
   ```

   Exit, then restart the container. The entrypoint now also starts the `telegram` tmux
   session.
3. Send any message to the bot. It replies with a pairing code. In the container terminal,
   `tmux attach -t telegram`, then:

   ```
   /telegram:access pair <code>
   /telegram:access policy allowlist
   ```

   Detach with `C-b d`. The allowlist lives in `/root/.claude/channels/telegram/access.json`,
   and `telegram-send` reads the chat id from it.
4. Check it: send "hi" to the bot and get an answer; `docker exec` into the container and run
   `echo test | telegram-send`.

Do not run `/telegram:configure`. It stores the token where every Claude process in the
container would find it, and they would all start polling.

## Set up the coach schedule

Add a second Dokploy schedule against the `routine` service with command `coach-tick` and cron
`*/10 * * * *`. Almost every tick is a no-op; the script gates on local time and per-day
markers in `/root/.coach/state/`, so it doesn't matter which timezone Dokploy's cron uses.

- **Morning:** from `COACH_MORNING_FROM` it checks Garmin for last night's sleep record — a
  plain `garminconnect` call with the MCP's cached token, no Claude involved. Once the record
  is there, it runs `/plan scheduled` and sends the plan. If there is no daily file and no
  sleep record by `COACH_PLAN_CUTOFF`, the day is skipped. A plan made by hand (send "plan" on
  Telegram) counts, and the tick leaves that day alone.
- **Evening:** at `COACH_RECAP_AT`, every day, `/recap`. On `COACH_REPORT_DOW` a successful
  recap is followed by `/report scheduled`, sent as a separate message.
- **Failures are never silent.** A failed run sends a short notice with the exit code and
  retries on the next tick, up to three attempts a day. A failing Garmin sleep check is
  reported once a day.
- Test with `coach-tick --force morning|recap|report`. `COACH_DRY_RUN=1 COACH_NOW="2026-10-05
  06:40" coach-tick` shows what a tick would do at that time without running anything.

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

**Both Claude processes run in tmux.** `tmux attach -t rc` or `tmux attach -t telegram` from a
container terminal shows the live session; `C-b d` detaches without stopping it. Each runs
under a restart loop (`keep-alive`), and every restart is logged to the container log. If the
`rc` session disappears altogether, the entrypoint exits and `restart: unless-stopped` brings
the whole container back.

**If a session goes quiet**, check the logs. Remote Control exits if the machine cannot
reach the network for roughly ten minutes, and the restart loop brings it back. For the
Telegram session, a `409 Conflict` in its pane means something else is polling the bot — see
"One poller per bot".

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
checked out. Reads, Garmin reads, writes under `logbook/` and `memory/` and to `calendar.md`,
the Telegram plugin's reply tools, and `git add` and `git commit` run unattended. Garmin
workout uploads, edits to `protocols/`, and `git push` prompt for approval — the actions worth
a tap on your phone before they fire. In the Telegram session the prompt arrives as buttons;
in a scheduled `-p` run it is refused.

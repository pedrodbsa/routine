# Running this repo on Dokploy

This repo can run as an always-on Claude Code session on a server, reachable from
[claude.ai/code](https://claude.ai/code) or the Claude mobile app through Remote Control.

Dokploy clones the repo, builds the image, and starts the container. The coach does not work
in that clone. Its working copy is a separate clone on the persistent `../files/repo` mount,
bind-mounted at `/app`, which the container creates from GitHub on first boot. The session
reads the protocols and writes the logbook there. Everything else the container needs — the
claude.ai credentials, the workspace trust record, the Garmin token cache — lives on a
`../files/home` mount. Both mounts survive redeploys.

A Dokploy schedule runs `cron-git-sync` on a cron. It commits whatever a session left uncommitted
and pushes to `origin`, so work reaches GitHub without you approving a push from your phone.

Remote Control and the Telegram plugin make outbound HTTPS connections only. The container
publishes no ports and needs no domain, reverse proxy, or inbound firewall rule.

## How the pieces fit

The athlete's day-to-day interface is Telegram. Two long-lived Claude processes run in the
container, both against the same `/app` repo, and all the coaching happens in one of them.

```
tmux "coach":  claude -n coach --channels telegram  ◀─ polls ─ Telegram (the athlete's messages)
                  ▲  types /clear, /plan scheduled,       └─ reply / util-telegram-send ─▶ Telegram
                  │  /recap scheduled, /report scheduled
Dokploy crons ─▶ cron-morning | cron-recap | cron-report: gate, then util-coach-send
tmux "rc":     claude remote-control                ◀─ claude.ai / Claude app (troubleshooting)
Dokploy cron */10 ─▶ cron-git-sync ─▶ GitHub
```

- **The coach session** is an interactive Claude Code session named `coach`, started with the
  Telegram channel plugin (`--channels`). The plugin polls the bot, injects each message into
  the session, and gives Claude a `reply` tool. The one routine permission prompt, a protocol
  edit, is relayed to Telegram as approve/deny buttons.
- **Remote Control can't carry Telegram.** It is a remote screen onto Claude sessions and has
  no Telegram side. Channels are switched on per session with a flag, and `claude
  remote-control`'s server mode refuses flags it can't pass on to the sessions it spawns. So
  the coach session is a separate process. Remote Control stays as the troubleshooting door
  from claude.ai or the Claude app.
- **The scheduled jobs run inside the coach session.** Until 2026-10-01 they were headless
  `claude -p` runs, and the session the athlete replied to had no idea what the morning plan
  or the evening recap had said. Now each cron script is two steps: a gate that decides
  whether to run, then `util-coach-send`, which types the command into the `coach` tmux pane
  (`tmux send-keys`). A reply to the plan lands in the conversation that wrote it. The
  session sends the scheduled message itself with `util-telegram-send`, which supports the
  HTML layout and quick-reply buttons that the plugin's `reply` lacks.
- **A command is typed only while the session is idle.** `util-coach-send` asks `claude agents
  --json` for the status of the Claude process in the pane and waits up to a minute for
  `idle`. Keys sent mid-turn would queue behind the turn, and keys sent while a permission
  dialog is open would answer the dialog. If it stays busy, nothing is typed, no marker is
  written, and the next cron run tries again.
- **Permissions:** the coach runs unattended, so everything is allowed except `protocols/`
  edits and `git push` (§ Permissions). The scheduled commands never change a protocol: they
  propose, and "apply" writes the edits behind a button.
- **One poller per bot.** Telegram allows one `getUpdates` consumer per bot token, and the
  plugin starts polling in every Claude process that loads it and can see the token. A process
  that loads it without the token fails it instead, and Claude Code caches that failure for 15
  minutes in a file every process reads, so the coach session then skips the plugin (found
  2026-09-29). So the plugin is installed at user scope but **disabled** there, and only
  `claude-session-coach` enables it, with `--settings`. Never add it to `enabledPlugins` in
  `.claude/settings.json`. As a second guard the container keeps the token as `COACH_TELEGRAM_BOT_TOKEN`, a name the plugin
  ignores, and `claude-session-coach` exports it as `TELEGRAM_BOT_TOKEN` for the coach session
  alone. Never run `/telegram:configure` (it writes the token to a file every process reads),
  and never install the plugin on the desktop.

## Before you deploy

**Rotate the Garmin password.** The old one was committed to this repository in plaintext and
is still in the history on GitHub; removing it from the current files does not change that.
Rotate it, then put the new one in Dokploy's Environment tab.

**Create a GitHub token.** A fine-grained personal access token scoped to `pedrodbsa/routine`
with `contents: write`. The image's credential helper (`/etc/gitconfig`) reads it from the
environment whenever git asks, so it is never written to disk.

## Create the Dokploy application

Create a **Compose** service — not an Application, which is oriented around HTTP and domains.

- **Source**: this repository, branch `main`. **Compose path**: `docker-compose.yml`.
- **Auto Deploy**: **off.** `cron-git-sync` pushes to `main` every few minutes, and with Auto
  Deploy on each of those pushes redeploys the service and kills the running session.
  Dokploy's "on tag" trigger type would avoid this in principle, but there is an open bug
  reporting that it is ignored and pushes still trigger builds
  ([Dokploy#3710](https://github.com/Dokploy/dokploy/issues/3710)). Redeploy by hand when you
  change the Dockerfile, which is rare.

Do not set `COMPOSE_PROJECT_NAME`. Dokploy uses the project name to find the container when a
schedule fires, and overriding it breaks `cron-git-sync`.

## Environment

Set these in the Environment tab. Dokploy writes them to `.env` beside the compose file, and
the compose file loads that with `env_file`. Full list with comments in `.env.example`.

| Variable | Purpose |
| --- | --- |
| `GARMIN_EMAIL`, `GARMIN_PASSWORD` | Expanded into the MCP server's environment by `.mcp.json` |
| `GITHUB_TOKEN` | Push credential for `cron-git-sync`; also needed for the first-boot clone if the repo is private |
| `GIT_AUTHOR_NAME`, `GIT_AUTHOR_EMAIL`, `GIT_COMMITTER_NAME`, `GIT_COMMITTER_EMAIL` | Identity on commits made from the container. Git needs both pairs; nothing writes a gitconfig |
| `TZ` | `Europe/Lisbon`. Meal and session sequencing depends on local time, and the cron scripts' per-day markers use the local date |
| `COACH_TELEGRAM_BOT_TOKEN` | The bot token from BotFather. Deliberately not `TELEGRAM_BOT_TOKEN` — see "One poller per bot" above |
| `TELEGRAM_CHAT_ID` | Optional. Where `util-telegram-send` posts; defaults to the first allowlisted id from pairing |

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

One-time setup. On every start the entrypoint installs the channel plugin at user scope (on the
persistent `/root` mount) and leaves it disabled there; only the `coach` session enables it.

1. In Telegram, message [@BotFather](https://t.me/BotFather), send `/newbot`, and copy the
   token. Set it as `COACH_TELEGRAM_BOT_TOKEN` in the Environment tab and redeploy.
2. Send any message to the bot. It replies with a pairing code. In a container terminal,
   `tmux attach -t coach`, then:

   ```
   /telegram:access pair <code>
   /telegram:access policy allowlist
   ```

   Detach with `C-b d`. The allowlist lives in `/root/.claude/channels/telegram/access.json`,
   and `util-telegram-send` reads the chat id from it.
   While attached, also run `/telegram:access set ackReaction 👀`, so every message you send
   is marked as received.
3. Check it: send "hi" to the bot and get an answer; `docker exec` into the container and run
   `echo test | util-telegram-send`.

Do not run `/telegram:configure`. It stores the token where every Claude process in the
container would find it, and they would all start polling.

## Set up the coach schedules

Add three Dokploy schedules against the `routine` service. Each script is a gate and a send;
the time window lives in the cron expression, and a per-day marker in `/root/.coach/state/`
makes every run after the first a no-op. Dokploy evaluates the expressions in its own
timezone, which is usually UTC: Lisbon is UTC+0 in winter and UTC+1 in summer, so these
windows land an hour later in local time during summer.

| Command | Cron | Gate | Sends |
| --- | --- | --- | --- |
| `cron-morning` | `*/10 5-11 * * *` | not yet sent today, no daily file yet (a plan made by hand counts), Garmin has last night's sleep record | `/clear`, `/plan scheduled` |
| `cron-recap` | `*/10 21-23 * * *` | not yet sent today | `/recap scheduled` |
| `cron-report` | `*/10 21-23 * * 0` | not yet sent today, and today's recap has been sent | `/report scheduled` |

- **The sleep check** is a plain `garminconnect` call with the MCP's cached token
  (`garmin-sleep-ready.py`), no Claude involved. Its status line is in the schedule's log.
- **The morning `/clear` starts the day's conversation.** Clearing then, rather than at night,
  keeps yesterday's recap in context until the new plan, so a late answer to it still makes
  sense. A day planned by hand, or skipped because the sleep record never came by noon, is not
  cleared, and the context carries on until the next scheduled plan. A session restart also
  starts it empty; nothing is lost, because the state is in the repo.
- **A sent command is not checked.** The marker means "typed into the session", not "done". If
  a plan never arrives, send "plan" on Telegram; the evening recap flags a day with no plan.
- To run one by hand: `rm /root/.coach/state/morning-$(date +%F)` and `cron-morning`, or type
  the command directly with `util-coach-send "/recap scheduled"`.

## Set up the sync schedule

Add a Dokploy schedule against the `routine` service with command `cron-git-sync` and cron
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
  "Invalid username or token" — `cron-git-sync`, the container's `GITHUB_TOKEN` helper, and
  `gh auth setup-git` on the host alike. Pulls kept working because the repo is public, which
  hid the failure until twelve commits had piled up unpushed.
- **A redeploy wiped unpushed work.** Dokploy re-clones its checkout on every deploy.
- **Host commands hit the live repo.** Running `gh repo sync` in `code/` reset the coach's
  working branch.

Now the deploy checkout is build input only: the image is built from it and nothing else reads
it. The working repo on `../files/repo` has a bare origin URL, pushes through the
`GITHUB_TOKEN` helper, and is never touched by a deploy. Nothing writes a token into the
URL.

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

**Both Claude processes run in tmux.** `tmux attach -t rc` or `tmux attach -t coach` from a
container terminal shows the live session; `C-b d` detaches without stopping it. Each runs
under a restart loop (`util-keep-alive`), and every restart is logged to the container log. Session
`<name>` runs the launcher `claude-session-<name>` (`docker/claude-session-*.sh`); the entrypoint
sets up the Telegram plugin, starts the sessions and, every 30 s, recreates any
that was killed.

**If a session goes quiet**, check the logs. Remote Control exits if the machine cannot
reach the network for roughly ten minutes, and the restart loop brings it back. For the
coach session, a `409 Conflict` in its pane means something else is polling the bot — see
"One poller per bot".

## Migrating from the deploy-checkout layout

A one-time procedure, run on the host, for a server still on the old `.:/app` mount.

1. **Make sure everything is pushed.** In the container, `git -C /app status -sb` must show
   no ahead/behind count and a clean tree. If the origin URL still carries a token, strip it
   first (`git -C /app remote set-url origin https://github.com/pedrodbsa/routine.git`) and
   run `cron-git-sync` once. Anything left unpushed here stays behind in `code/`.
2. **Commit and push the compose, entrypoint and docs changes.**
3. **Redeploy in Dokploy.** The container starts with an empty `../files/repo` and clones from
   GitHub on boot. The clone log line and any failure appear in the container logs.
4. **Verify git inside the container.**
   - `git -C /app remote get-url origin` prints `https://github.com/pedrodbsa/routine.git`,
     with no credentials in it.
   - `git -C /app log -1` matches the latest commit on GitHub.
   - `cron-git-sync` prints "nothing to push".
   - Make a test commit in `/app` and confirm the next scheduled `cron-git-sync` run pushes it.
5. **Verify the session.** Remote Control comes up with `/app` as its working directory, and
   the session picks up `.mcp.json` (the Garmin tools are available) and
   `.claude/settings.json` (the allowlist applies) from the new clone. The workspace trust
   record lives on `../files/home` and is keyed by path, so it carries over.
6. **Optionally, make the GitHub repo private.** Only after steps 4 and 5 pass. The repo holds
   medication, weight, lab and daily-log data. Dokploy deploys keep working through its GitHub
   App; the container's clone and pushes use `GITHUB_TOKEN`. Re-run step 4 afterwards.

## Permissions

The agents here are meant to run fully autonomously. The one thing that needs the athlete is a
protocol change, so an unattended run can never rewrite the rules it coaches by.

- **`.claude/settings.json`** is the whole policy, identical on the desktop and in the
  container. It allows `Bash`, `Edit`, `WebFetch`, `WebSearch`, every Garmin tool
  (`mcp__garmin`, reads and writes) and the Telegram plugin's tools. Its `ask` rules are
  `Edit(protocols/**)` and `git push`, and an `ask` rule outranks any allow. Writes under
  `.claude/` and `.git/` are protected paths and still prompt.
- **Hooks** (`.claude/hooks/`, registered in `.claude/settings.json`):
  `guard-protocols-bash.sh` blocks Bash commands that look like writes under `protocols/`
  (`sed -i`, redirects, `mv`, scripts), so the broad `Bash` allow can't get around the `Edit`
  gate. It is a heuristic and also blocks a script that merely mentions the path; use Edit.
  `guard-telegram-format.sh` rejects a `reply` whose text is escaped for MarkdownV2 but
  doesn't set `format: "markdownv2"`.

In the coach session a `protocols/` edit arrives as approve/deny buttons; the scheduled
commands propose protocol edits instead of making them. `git push` is left to `cron-git-sync`.

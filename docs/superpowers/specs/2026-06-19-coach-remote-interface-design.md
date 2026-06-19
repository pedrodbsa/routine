# Remote Coach Interface — Design

**Date:** 2026-06-19
**Status:** Draft for review
**Author:** Coach service brainstorm (Pedro + Claude)

## Problem

The coaching system works, but it is chained to the desktop. Every time-sensitive
interaction — reading the day's plan, logging meals and sessions, and actually
conversing with the coach to adjust the day — requires sitting at the computer with
Claude Code open. The athlete is frequently away from the machine when these needs
arise (at the gym, in the kitchen, out running, during the day).

The athlete never edits the protocol or logbook files directly; those are the coach's
working medium. So the requirement is **not** file access. It is a remote
**conversation and reading** surface for the coach.

## Goals (v1)

- Read today's plan from a phone, rendered as proper formatted markdown.
- Read the current monthly report and scroll recent daily files.
- Log meals, sessions, and notes by chatting, from anywhere.
- Converse with the coach — ask questions, request adjustments — from anywhere.
- Receive a morning push with the drafted plan summary and a link to read it.
- Push approved workouts to the Garmin watch, on approval, exactly as `/garmin` does today.
- Make the coach's own structured metrics (nutrition actuals, day-type, ACWR, RPE, etc.)
  queryable for longitudinal reasoning — without leaving the file-based workflow.

## Non-goals (v1)

- No charts, trend graphs, or analytics dashboard (deferred to v2).
- No history search or full-text search across logbook.
- No multi-user support; this is single-user.
- No manual file editing surface — files remain the coach's medium.
- No web-push for the PWA (Signal is the push channel; the PWA is pull-only).
- No per-message auto-commits — a once-daily logbook commit is the most the service does
  (see Git model).
- No per-exercise strength-set table and no reports-as-queries yet — deferred to v2
  (see Data model).
- No pushing weigh-ins/body composition to Garmin — an external Withings→Garmin job
  already handles that; the coach only reads weight. Workouts are the sole Garmin write.

## Constraints and decisions

- **Stack:** **Node / TypeScript** for the relay (and serving the PWA), using the
  first-party `@anthropic-ai/claude-agent-sdk`. The PWA frontend is plain static HTML/JS.
- **Host:** the athlete's own server, always-on. Becomes the home of the coach.
- **Front surface:** a self-hosted **PWA** (primary, for reading + chat) plus a
  **Signal** ping each morning with the plan summary and a link.
- **Auth / network:** deferred. The athlete will handle networking and add a token
  later if exposed. Design must not depend on a particular network posture; a single
  shared token can be slotted in front of the relay without structural change.
- **Git model:** git **is** used in this repo. Canonical files — `protocols/*`, the daily
  logbook (including its structured frontmatter), and reports — are committed. The live
  request path only **writes** files (no commit per message, to avoid noise); a once-daily
  commit job snapshots the logbook. The derived **DuckDB store is gitignored** — a
  rebuildable artifact (see Data model).
- **Garmin layer (split):** **reads** go through **`garmin-cli`** (Rust) syncing into a
  local **DuckDB/Parquet** store that the agent queries with SQL; **writes** (structured
  workout creation + scheduling) go through the existing **MCP** (`Taxuspt/garmin_mcp`),
  which also remains the fallback for any read the local store does not cover. See
  "Garmin access" below.

## The brain: reuse the existing repo

Do not rebuild the coaching logic. The existing `.claude/commands` (`/plan`, `/log`,
`/report`, `/body`, `/garmin`), the `coach` skill, `AGENTS.md`, and the `protocols/`
files already encode the entire coaching brain. The new system runs **Claude Code
headless** inside this repo on the server and relays chat to/from it.

Mechanism — the first-party **Claude Agent SDK** (`@anthropic-ai/claude-agent-sdk`):

- `query({ prompt, options })`, async-iterated for streaming.
- `options.systemPrompt = { type: 'preset', preset: 'claude_code' }` and
  `options.settingSources = ['project']` so the session loads `CLAUDE.md` / `AGENTS.md`
  and the project's command/skill definitions.
- `options.mcpServers` supplies the Garmin MCP (the same `uvx` command currently in
  `.mcp.json`), with `allowedTools` scoped to the **write** tools the commands use
  (`mcp__garmin__create_strength_workout`, `schedule_workout`, `upload_workout`, etc.).
- **Reads** are SQL over the local store, run via the `Bash` tool (`garmin query …` or
  `duckdb` against the Parquet files). The read half of `/plan`, `/log`, `/body`, and
  `/report` is rewritten from MCP read tools to these queries.
- `options.resume = sessionId` to continue the same conversation within a day.
- The relay runs in the repo working directory so file reads/writes land in the logbook.

> Confirmed: the SDK executes project **slash commands** under the `claude_code` preset
> with `settingSources: ['project']`, so the relay issues `/plan`, `/log`, etc. as prompts.
> Optional refinement: inline a command file's prompt text instead of the `/slash`
> shorthand for tighter parameterization (e.g. injecting the date or the user's message) —
> an implementation choice, not a blocker. Skills under `.claude/skills` (the `coach`
> skill) load via the same project settings.

## Architecture

One box (the server) runs:

1. **garmin-cli + local store** — `garmin sync` pulls Garmin health metrics and activity
   summaries into a local **DuckDB/Parquet** store on a schedule. The agent reads from
   this store. Browser-SSO auth (`garmin auth login`); token persisted on the server.
2. **Garmin MCP** — `uvx` stdio server, used for **writes** (workout create/schedule/
   upload) and as a read fallback. Credentials in server env, not git.
3. **Relay backend** (Node / TypeScript) — owns Claude Agent SDK sessions, exposes an HTTP
   API to the PWA, and runs the morning job. Maintains per-conversation session id for
   same-day continuity.
4. **PWA** (static, served by the relay) — chat view + rendered reading views (today,
   report, recent days). Installable to home screen. Pull-only.
5. **Scheduler** — the periodic `garmin sync` and the morning job, via OS cron or an
   in-process scheduler (e.g. node-cron), at configurable times.
6. **signal-cli** — sends the morning Signal message. (Registered number or linked as a
   secondary device; exact setup is an implementation task.)
7. **Metrics extractor** — parses the structured frontmatter of daily files into the
   DuckDB store; runs on file write and is rebuildable over the whole logbook.

```
 phone ──HTTP──▶ relay (Node/TS) ──Agent SDK──▶ Claude Code (in repo)
   │                  │                              │
   │                  │             reads (SQL) ◀────┤
   │                  │                              ├─▶ Garmin MCP (uvx)  [writes]
   │                  │                              └─▶ logbook/ + protocols/ (files, git)
   │                  │                                     │ frontmatter
   │                  │                                     ▼ extractor
   │            ┌─────┴─────────────────┐
   │            │ local DuckDB/Parquet   │◀── garmin sync (cron) ◀── Garmin Connect
   │            │ (derived, gitignored)  │
   │            └────────────────────────┘
   │
   └◀── Signal ◀── cron + signal-cli (morning push)
```

## Data flows

### Chat (read / log / converse)

1. Phone sends a message to the relay (`POST /chat`, with the conversation's session id).
2. Relay runs `query({ prompt: message, options: { resume: sessionId, ... } })`.
3. Relay streams assistant text back to the PWA; persists the returned `session_id`.
4. If the message implies a logbook write (a logged meal/session, an approved plan
   change), Claude writes the file directly via its file tools — same as a desk session.
5. A daily-file write triggers the **extractor**, which refreshes that day's structured
   rows in DuckDB from the file's frontmatter — the file stays canonical.
6. When the coach needs quantitative data — Garmin metrics *or its own past structured
   metrics* — it queries the local DuckDB with SQL; it falls back to the MCP only for
   Garmin fields the store does not carry (e.g. deep activity splits).

### Reading views

- `GET /today` → relay reads `logbook/<YYYY-MM>/<YYYY-MM-DD>.md` and returns it; PWA
  renders markdown.
- `GET /report` → current `logbook/<YYYY-MM>/report.md`.
- `GET /days` → list of recent daily files for the scrollable history.

These are plain file reads, no Claude round-trip needed.

### Morning push

1. Cron triggers the relay's morning job at the configured time. The job **first forces a
   `garmin sync`** so the local store holds this morning's readiness/sleep/HRV before any
   reasoning (sync-then-query — the DB does not eliminate the morning fetch, only the
   repeated per-call fetches and all historical aggregates).
2. Relay issues `/plan` to a fresh session. Claude reads the freshly-synced local store,
   drafts the day, and (per the existing interactive contract) **proposes** without
   committing to Garmin.
3. Relay writes the drafted daily file and sends a **Signal** message: a short summary +
   a link to open the PWA.
4. The athlete reads it in the PWA and either approves or adjusts by chatting.
5. On approval, the coach runs `/garmin` to push the structured workouts to the watch.
   **Nothing reaches Garmin before approval.**

## Garmin access

**Reads → `garmin-cli` + local DuckDB/Parquet store. Writes → MCP.**

### Why split

Coaching is a longitudinal problem. The metrics that drive decisions — ACWR, trailing
7/28-day load, HRV-vs-volume trend, sleep-vs-performance correlation — are historical
*aggregate* queries. Fetching them as discrete MCP calls every session is slow,
token-heavy, and pushes the aggregation into the model's head. A local analytical store:

- expresses those queries directly in SQL (ACWR is one statement, not N fetches + mental
  arithmetic);
- collapses many JSON tool-call payloads into one compact result set (fewer tokens, lower
  cost — material given subscription Agent-SDK credits);
- stays queryable when the Garmin API is flaky at query time.

Writes stay on the MCP because it is the only layer that **creates and schedules
structured workouts** (strength-exercise enum mappings, `create_strength_workout`,
`schedule_workout`, `upload_workout`). `garmin-cli` has no planned-workout builder — its
writes are weight, activity-note edits, and completed-FIT upload (the wrong direction).

### Writes — what we push to Garmin

The coach pushes **only structured workouts**, via the MCP (`/garmin`):
`create_strength_workout`, `create_walk_run_workout`, `upload_workout`, then
`schedule_workout` / `schedule_week`. This is the entire Garmin write surface.

**Body/weight is not pushed by the coach.** An existing external job syncs the Withings
scale into Garmin automatically, so weigh-ins arrive on their own and flow into the local
store via `garmin sync` (the `WeightEntry` table). `/body` therefore only **reads** that
weight and updates target deltas in the logbook — no Garmin write.

Not pushed either: nutrition/food — logged nowhere digitally, deliberately kept out of
Garmin.

### Freshness — sync-then-query

The store does **not** eliminate the morning fetch: training readiness, last night's
sleep, HRV, and body battery only exist after the watch syncs this morning. So:

- a periodic `garmin sync` (cron) keeps the store warm during the day;
- the morning job **forces a `garmin sync` first**, then the agent queries local;
- more generally, **any command that needs current data — `/plan`, `/log`, `/body` —
  forces a sync before it reads**, so it never reasons on stale data.

The win is on history (incremental sync) and on every aggregate query, not on skipping the
day's first pull.

### Schema coverage — confirmed from source (`crates/garmin-cli/src/db/models.rs`)

The store's tables cover what the commands consume:

- **Daily markers** (`DailyHealth`): sleep total/deep/light/REM + score, HRV (weekly avg,
  last night, status), resting HR, stress avg/max, body battery start/end, respiration,
  SpO2 — covers `/plan` readiness and `/body`.
- **Readiness/status** (`PerformanceMetrics`): training readiness, training status,
  lactate-threshold HR, endurance score.
- **Activity summaries** (`Activity`): avg/max HR, distance, duration, speed, elevation,
  cadence, power, training effect, training load, running dynamics.
- **Per-sample** (`TrackPoint`, per activity): timestamp, HR, lat/lon, elevation, cadence,
  power, speed.

There is **no splits/laps table and no time-in-HR-zone field**, but both are **derivable
from `TrackPoint`**:

- **Time-in-HR-zone** — bucket points by `heart_rate` band, sum time deltas. Direct.
- **Per-km splits** — `TrackPoint` has no distance column, so distance is integrated from
  `speed × Δt` (haversine over `lat/lon` as a cross-check), then bucketed into 1000 m.
  A reusable `v_activity_splits` SQL view is a v1 build item. Expect minor divergence from
  Garmin's device-measured splits — acceptable for coaching.

Consequence: the MCP **read** fallback for `/log` is **likely unnecessary** — the store
covers run analysis. Keep the MCP available, but treat any read fallback as an exception,
not a design assumption.

### The real open item — does `sync` populate `TrackPoint`?

The schema *supports* per-sample data; the question is whether the sync pipeline actually
**ingests** it. The Taxuspt MCP deliberately skips GPS tracks for their size (50–500 KB
each), so this is not a given. **First plan task: a spike** — run `garmin sync` against a
few real runs (outdoor and treadmill) and confirm `TrackPoint` is populated (including
`speed` on indoor runs with no GPS), and measure the storage cost of retaining tracks.

### Auth

`garmin-cli` uses browser-SSO (`garmin auth login`); persist its token on the server. The
MCP's `garth` likewise caches an OAuth token, so its password only seeds the first login
and is not relied on in plaintext thereafter. Two Garmin integrations means two auth
states to keep alive — an accepted cost of the split.

## Data model — files canonical, DuckDB derived

The coaching data splits by *kind*, not by source.

- **Documents → files + git (canonical).** `protocols/*` (rules/config), monthly reports
  (narrative), and the **prose** of daily logs (readiness notes, how a session felt,
  decisions). Version-controlled, human- and agent-readable. A database here would be
  strictly worse.
- **Structured metrics → DuckDB (derived, queryable).** The coach's own quantitative
  time-series that Garmin does not hold: nutrition actuals (kcal/macros — the athlete
  weighs food and logs nothing digitally), `day_type`, phase, ACWR, prescribed-vs-actual,
  and subjective signals the model already reasons over (RPE, pain, sleep-onset latency,
  protein-bolus distribution, social-day damage-control events), plus body metrics. These
  live in the **same DuckDB** as the Garmin data, keyed by date — one store for everything
  quantitative.

### Single source of truth: frontmatter, extracted

So the daily file and the DB never drift, the file stays canonical and the DB is a
**derived projection**:

- The daily file carries its required fields as a **machine-readable block** — YAML
  frontmatter (or a fenced data block) — while prose stays in the body.
- A small **extractor** loads that block into DuckDB whenever a daily file is written or
  changed. Lossless, no NLP.
- The DuckDB is therefore **rebuildable from git at any time** (`garmin sync` + re-run the
  extractor over the logbook). It is a cache, not a second source of truth — hence
  gitignored.

This keeps the file-based workflow intact (git history, readability, agent-native
authoring) while making longitudinal queries fast.

### Scope

- **v1:** frontmatter-ise the existing `daily-template` required fields and build the
  extractor plus the day-level metrics tables. The coach reads them through the same SQL
  path as Garmin data.
- **v2:** per-exercise strength-set logging (sets/reps/load per movement) and generating
  monthly reports as DuckDB queries instead of hand-authored prose. Bigger, and not needed
  to remove the current inefficiency.

## Session and context model

- **Long-term memory lives in the files** (protocols, daily logbook, reports), exactly as
  today — canonical. Quantitative history is *additionally* projected into DuckDB for fast
  queries (derived). The coach reads files each session; nothing important depends on chat
  history surviving.
- **Short-term continuity within a day** uses Agent SDK session `resume` so a chat thread
  feels continuous ("change today" → "ok and also…").
- Sessions can be reset daily (or per the morning job) without loss, since state is the
  files.

## Secrets and configuration

- Garmin email/password, Signal config, and any future PWA token live in server **env
  vars** (e.g. a `.env` not committed). This also fixes the current plaintext password in
  `.mcp.json`.
- Configurable: morning-job time, `garmin sync` cadence (default: hourly + a forced sync
  at the head of the morning job), Signal recipient, model id, repo path, DuckDB store path.
- The DuckDB store path is **gitignored** (derived artifact).

## Risks and open implementation questions

- **TrackPoint ingestion** — schema supports per-sample data and splits/zones derive from
  it, but confirm `garmin sync` actually populates `TrackPoint` (and `speed` on treadmill
  runs) and the storage cost. If it does not populate, `/log` needs the MCP fallback after all.
- **Sync ordering/freshness** — the morning job must force a sync before reasoning; guard
  against a `/plan` running against a stale store.
- **Two third-party Garmin deps** — `garmin-cli` and the MCP can each break or drift
  (schema, auth). Two things to keep alive.
- **Read-path rewrite** — `/plan`, `/log`, `/body`, `/report` read halves move from MCP
  tool-calls to SQL; an upgrade, but real work and a regression surface to test.
- **Frontmatter/extractor schema** — the `daily-template` structured block and the DuckDB
  tables must stay in lockstep; a template change means an extractor update + a (safe,
  because derived) full re-extract. Keep the DB strictly derived so rebuild is always safe.
- **Daily-template migration** — existing logbook files predate the frontmatter; either
  back-fill them or accept that the metrics history starts at cut-over.
- **Slash vs inline command invocation** — confirmed the SDK runs project `/` commands;
  the only open choice is `/plan` directly vs. inlining the command prompt for tighter
  parameterization. Implementation detail, not a blocker.
- **signal-cli registration** — number registration vs. linked-device; rate limits.
- **External Withings→Garmin job** — weight freshness depends on that job (outside this
  system); if it stalls, `/body` reads stale weight. Not ours to fix, but worth surfacing.
- **Long-running Claude calls** — the morning `/plan` pulls a lot of Garmin data; ensure
  the relay handles multi-minute streaming and timeouts gracefully.
- **Concurrency** — single user, but guard against overlapping morning job + manual chat
  touching the same daily file.
- **Approval state** — the relay must track "plan drafted, awaiting approval" so a later
  "yes" triggers `/garmin` rather than being interpreted as fresh chat.

## v2 / later (explicitly out of scope now)

- Trends/charts dashboard built **on top of** the v1 DuckDB/Parquet store (the store
  itself ships in v1; the visual dashboard is the deferred part).
- Per-exercise strength-set logging in DuckDB (sets/reps/load per movement).
- Monthly reports generated as DuckDB queries instead of hand-authored prose.
- History search.
- PWA web-push as a second push channel.
- Auth token in front of the relay if the server goes internet-facing.

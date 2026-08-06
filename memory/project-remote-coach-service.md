---
name: project-remote-coach-service
description: "Active build — a remote coach reachable from any browser + Telegram; the wayfinder map at .scratch/coach-remote/ supersedes parts of the committed spec"
metadata:
  node_type: memory
  type: project
  originSessionId: 10fe7e0e-3367-4de2-a08b-ddf242487d8d
  modified: 2026-07-23T10:23:35.811Z
---

Active project (started 2026-06-19): make the coaching system usable away from the desktop.

**Status 2026-07-23: DESIGN COMPLETE, spec written.** The final v1 spec is
`docs/superpowers/specs/2026-07-23-remote-coach-v1-design.md` (the 2026-06-19 spec is marked
superseded). Synthesised from a wayfinder effort: map + 16 resolved design tickets + 50 decisions
at `.scratch/coach-remote/`. Only ticket 07 (build prerequisites — private repo, Telegram bot,
Tailscale, move Garmin password out of `.mcp.json`) is open, Pedro's to execute. Next phase is
implementation planning from the spec. **GREENFIELD build in a NEW repo** — the current
`X:\pedrodbsa\routine` repo is only a content source (protocols/logbook ported in), not the target.

Headline architecture (see map for all 50): **n8n drives a bespoke TypeScript `coach` CLI** —
the CLI is the single canonical interface (n8n nodes exec it, the agent calls it via Bash, the
terminal runs it directly), and it wraps the Agent SDK for agent commands. **Plugins** (running,
strength, nutrition, skin, mobility) are vertical slices each owning data/policy/state, some with
a **specialist coach**; a **head coach** decides *what*, specialists decide *how*. **Four data
kinds** — policy, profile, state, history — one repo with per-profile data under
`data/<profile>/`, **one DuckDB per profile**. **Telegram** (present-tense actions, public
webhook) + **Tailscale-only web app** (backoffice: Today/History/Protocols/Profile). Runtime is
the Agent SDK on the Max subscription (no forced API pricing).

**Read the map first, not the spec.** The live artifact is the wayfinder map at
`.scratch/coach-remote/map.md` (charted 2026-07-22), with 12 tickets under
`.scratch/coach-remote/issues/`. The committed spec
`docs/superpowers/specs/2026-06-19-coach-remote-interface-design.md` is **superseded in
part** — it will be rewritten from the map's decisions once the tickets resolve, not patched
along the way. Where the two disagree, the map wins.

**What the map reframed (2026-07-22 grilling):**
- **One action core, three clients** — Telegram (chat/widgets/push), web app (guardrailed
  controls, dense UI, the full coach), terminal/Claude Code (raw, builder). Same actions
  everywhere; the clients differ in affordance, not capability.
- **The web app is the coach**, not a read-only companion. The spec's "no file-editing
  surface" non-goal is dead. Goal is terminal-independence: reach the coach from any browser.
- **An action = an ordered list of steps**, each deterministic or agent, with **gates as
  durable pause states** (so you draft on the web app and approve from Telegram later).
  Most actions are `[code…, agent]`; `/plan` is `[code, agent, code, gate, code]` because its
  judgement comes first.
- **An internal `coach` CLI/SDK** carries all mechanical work. Agent tool surface = file
  tools + `coach …` + Garmin MCP for workout writes.
- **The daily file splits in two** — structured plan (data, UI-rendered) + prose journal
  (agent). Driven by the complaint that 2026-07-21 was 260 lines for ~57 of athlete-facing
  content. This subsumes the old "frontmatter-ise the daily template" plan.
- **`/plan` is manually triggered**, never by cron — it depends on the morning weigh-in
  landing first.
- **v1 = remote surface + brief/data layer.** `/week` was split out as its own effort and is
  out of scope for this map.
- Hard constraint: **use the Claude Max plan, avoid API pricing** (ticket 03 researches
  whether headless-on-a-server is viable that way; if not, the economics change the design).

Still true from the original spec: Garmin reads via `garmin-cli` → DuckDB/Parquet, writes via
the Garmin MCP (workouts only); Node/TS; Dokploy; weight arrives via the external
Withings→Garmin job. Signal was already replaced by Telegram.

**Prerequisite that stands regardless:** the Garmin password is committed in `.mcp.json` and
must move to a secret before any remote exists (ticket 07).

Git is permitted in this repo — see [[feedback-git-allowed-this-project]].

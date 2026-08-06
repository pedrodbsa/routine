---
name: reference-repo-relevant-parts
description: Which parts of the routine repo are live vs abandoned scaffolding
metadata: 
  node_type: memory
  type: reference
  originSessionId: a15e7acf-906d-4a32-8070-0da67c4cc979
  modified: 2026-07-31T07:44:24.125Z
---

Only these parts of the routine repo are live coaching material: `protocols/` (incl. `protocols/archive/` for frozen history), `logbook/`, `memory/` (the coaching memory, moved in-repo 2026-08-06 — see [[project-dokploy-container]]), and `.claude/` (the `coach` skill + `/plan` `/log` `/report` `/body` `/garmin` `/audit` commands).

The `Dockerfile`, `docker-compose.yml`, and `docker/` at the root are deployment plumbing, not coaching material — see `docs/container.md`.

**`data/*.csv` and the local Python `garmin` CLI (`.venv/Scripts/garmin`) were DELETED by Pedro (confirmed 2026-07-31)** — they no longer exist; never reference them. All Garmin data comes from the live Garmin MCP (fallback: direct `garminconnect` pull via the token cache). The remote-coach spec's `garmin-cli` is a *different*, Rust tool (`crates/garmin-cli`, DuckDB/Parquet) to be obtained fresh on the server. See [[feedback-garmin-mcp-over-csv]].

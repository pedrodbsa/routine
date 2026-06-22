# TrackPoint Ingestion Spike — Findings

**Date:** 2026-06-19
**Spike plan:** docs/superpowers/plans/2026-06-19-trackpoint-ingestion-spike.md
**Tool under test:** vicentereig/garmin-cli v2.1.0 (containerised; NOT the abandoned Python script)
**Method:** Synced a real window (2026-05-05 → 2026-05-18) into the Parquet store and inspected it with DuckDB. The window held eight activities: two strength sessions, one treadmill run, and five outdoor GPS runs.

## Q1 — Does `garmin sync run` populate `track_points`?

**Yes — for activities with a GPS track, and on by default (no opt-in flag).** Ingestion is gated on the presence of a GPS track, so outdoor runs are fully covered and indoor activities are not covered at all.

| activity_id | type | distance | track points | lat/lon | heart_rate | cadence | speed | power |
|---|---|---|---|---|---|---|---|---|
| 22807386168 | running (outdoor) | 8 616 m | 3 128 | ✓ | ✓ | ✓ | ∅ | ∅ |
| 22877794382 | running (outdoor) | 6 261 m | 2 444 | ✓ | ✓ | ✓ | ∅ | ∅ |
| 22889008951 | running (outdoor) | 5 374 m | 2 046 | ✓ | ✓ | ✓ | ∅ | ∅ |
| 22899700028 | running (outdoor) | 6 861 m | 2 958 | ✓ | ✓ | ✓ | ∅ | ∅ |
| 22910765593 | running (outdoor, race) | 10 027 m | 3 137 | ✓ | ✓ | ✓ | ∅ | ∅ |
| 22783628351 | **treadmill_running** | 5 641 m | **0** | ∅ | ∅ | ∅ | ∅ | ∅ |
| 22772687870 | strength_training | — | 0 | — | — | — | — | — |
| 22784072799 | strength_training | — | 0 | — | — | — | — | — |

13 713 points total across the five outdoor runs (≈1 Hz, 2 000–3 100 points/run). The `track_points/` directory holds one daily Parquet partition per outdoor-run date and **no partition for the treadmill day**.

Real `track_points` columns (the spec's approximation was close but wrong on names): `id, activity_id, timestamp, lat, lon, elevation, heart_rate, cadence, power, speed`. The foreign key is `activity_id`; coordinates are `lat`/`lon` (not `latitude`/`longitude`).

**Two schema columns are never populated:** `speed` and `power` are NULL on every point of every run, outdoor included. garmin-cli's GPX parser does not emit them.

## Q2 — Is `speed` present on the treadmill run (no GPS)?

**No, and the question is moot: the treadmill run has zero track points at all** — not "speed is null," but no rows whatsoever. garmin-cli derives track points from the GPS track, so a no-GPS activity yields nothing. There is therefore **no indoor per-sample data of any kind** — no indoor speed, no indoor cadence, and no indoor heart-rate stream — in the local store. (`speed` is additionally null on the outdoor runs, so the `speed × Δt` approach is unavailable everywhere.)

## Q3 — Storage cost

The five outdoor runs (13 713 points) occupy **272 KB** of Parquet, ≈ **54 KB per outdoor run** (~20 bytes/point compressed). Treadmill and strength activities add nothing. At the athlete's outdoor-run frequency this is on the order of **~10 MB/year**, so the spec's ~50–100 MB git-LFS threshold is years away — daily git commits of the store are fine and no LFS is needed near-term. (Activity summaries are ≈ 8 KB each; `daily_health` ≈ 34 KB/month — both negligible.)

## Decisions (consumed by plans #1 store and #3 read-path)

- **`v_activity_splits` buildable from the local store: outdoor only, via haversine over `lat/lon`.** Not via `speed × Δt` — `speed` is unpopulated. Treadmill per-km splits are **not** derivable from track points; use the activity summary (`distance_m`, `duration_sec`, `avg_speed`) for treadmill pace.
- **Time-in-HR-zone derivable: outdoor only** (`heart_rate` is populated in outdoor track points). Indoor/treadmill has no track points, so indoor HR-zone must come from the activity summary (`avg_hr`/`max_hr`) or the MCP.
- **`/log` run analysis must keep the MCP read fallback.** It is **required** for any per-sample analysis of treadmill/indoor runs, which the local store does not cover. The spec's "MCP read fallback likely unnecessary" is incorrect. Outdoor per-sample analysis is fully covered locally.
- **Most `/log`, `/plan`, and `/body` needs are met by the activity summary alone.** The `activities` table carries avg/max HR, distance, duration, average pace (`avg_speed`), cadence, training effect, training load, elevation, and running dynamics per activity — including for the treadmill run. Track points are needed only for per-km splits and intra-run HR-zone/drift, and only outdoors.
- **Store-commit cadence / git LFS:** daily commit is fine; revisit LFS only past ~50–100 MB (years out at ~10 MB/yr).

## Operational notes for downstream plans

- garmin-cli runs containerised (Dockerfile: `docs/superpowers/spikes/trackpoint/Dockerfile`). Two build fixes vs. the first draft were required and are now in the Dockerfile: the base image must be `debian:trixie-slim` (the prebuilt binary needs glibc ≥ 2.38; bookworm's 2.36 fails at runtime with `GLIBC_2.38 not found`), and the release tarball's binary is named `garmin-linux-amd64`, not `garmin`.
- Store layout under `$HOME/.local/share/garmin/`: `activities/` (weekly Parquet), `track_points/` (daily Parquet, **GPS activities only**), `daily_health/` (monthly), `performance_metrics/`, a `default/` token directory, and a small SQLite `sync.db` used for sync bookkeeping only. The data is Parquet partitions queried by DuckDB — there is no monolithic DuckDB database file.
- Track ingestion is on by default — `garmin sync run` has no `--gpx`/tracks opt-in flag, and no-GPS activities simply produce no points.
- Auth that worked: browser-SSO (`garmin auth login`), token persisted on the volume under `default/oauth1_token.json` + `oauth2_token.json`.

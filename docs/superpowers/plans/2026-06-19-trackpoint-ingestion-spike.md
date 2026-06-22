# TrackPoint Ingestion Spike — Investigation Plan

> **For agentic workers:** This is a **spike**, not a feature build. It produces knowledge and a written decision record, not shipped code. There is no TDD cycle here — the deliverable is evidence and a recommendation. Steps use checkbox (`- [ ]`) syntax for tracking. Do not generalise, refactor, or build the store proper; stop at the decision record.

**Goal:** Determine whether `garmin-cli`'s sync actually ingests per-sample `track_points` data (including `speed` on GPS-less treadmill runs), and what retaining tracks costs in storage — the single fact that gates the read-path design for the remote coach.

**Why this gates everything:** The spec's read half (`/plan`, `/log`, `/body`, `/report` → SQL over a local DuckDB/Parquet store) assumes per-km splits and time-in-HR-zone are *derivable from per-sample track points* (spec §"Schema coverage", §"The real open item"). The Taxuspt MCP deliberately skips GPS tracks for their size, so a tool that *has* a `track_points` dataset may still not *populate* it. If sync does not fill `track_points`, `/log`'s run analysis must keep the MCP read fallback, and `v_activity_splits` is not buildable from the local store. Every downstream plan (#1 store, #3 read-path rewrite) branches on this answer.

**Architecture:** The tool is a Rust crate that does not install cleanly on Windows, so the whole spike runs in a **Docker container** (`docs/superpowers/spikes/trackpoint/Dockerfile`) carrying the prebuilt `garmin` binary plus the DuckDB CLI. A mounted volume persists the SSO token and the Parquet store across runs. Inside the container: authenticate, sync a deliberately mixed set of *known* real runs (≥1 outdoor GPS, ≥1 treadmill/indoor), inspect the Parquet store with DuckDB, measure on-disk cost, then write the findings and the go/no-go for the MCP read fallback into a decision record the store and read-path plans consume.

**Tech Stack:** Docker; `vicentereig/garmin-cli` prebuilt Linux binary (v2.1.0) — `garmin auth login` (browser-SSO), `garmin sync run`; Parquet store under `$HOME/.local/share/garmin/`; DuckDB CLI for inspection. Garmin Connect account: `pedrodbsa@gmail.com`.

## Global Constraints

- **The tool under test is `vicentereig/garmin-cli` (Rust), run from the spike container only.** Do NOT run, inspect, or draw any conclusion from the abandoned local Python `garmin` at `.venv/Scripts/garmin` — it is a different tool (SQLite, `extract`) and is irrelevant.
- **Everything runs in the container.** Do not attempt to install garmin-cli on the Windows host; that is the reason the container exists.
- **All container state lives on the `garmin_spike_data` Docker volume** (mounted at `/data` = `$HOME`). The token and the Parquet store both persist there. The volume is never committed to git.
- **Reads-only spike.** Run only `garmin auth login`, `garmin sync run`, and read-only DuckDB SQL. Issue no Garmin *write* of any kind (no workout create/schedule/upload, no weigh-in).
- **Garmin credentials never land in a committed file.** The plaintext password in `.mcp.json` is a separate, pre-existing leak; do not copy it anywhere. Auth is browser-SSO via `garmin auth login`.
- **Committed artifacts are text only:** the `Dockerfile` and the final findings doc. Never commit the volume, the Parquet store, the token, or `sync.db`.
- Test set must include **both** an outdoor GPS run and a treadmill/indoor run, because the `speed`-without-GPS question only has an answer on an indoor activity.

### Store layout reference (from garmin-cli docs)

Parquet datasets under `/data/.local/share/garmin/`, plus a `sync.db` (SQLite) sync-state file:
- `activities/` — weekly partitions (activity summaries)
- `track_points/` — **daily partitions** (per-sample GPS + sensor streams: HR, cadence, power, speed when present) ← the subject of this spike
- `daily_health/` — monthly partitions
- `performance_metrics/` — monthly partitions
- `profiles.parquet`

DuckDB reads these directly, e.g.
`SELECT * FROM read_parquet('/data/.local/share/garmin/track_points/**/*.parquet', hive_partitioning = true)`.

---

## Task 0: Build the spike image and authenticate

**Goal of task:** Have the spike container built, a `garmin_spike_data` volume holding a live SSO token, and the exact `track_points` / `activities` column names confirmed from source — the precondition for any sync.

**Files:**
- Use: `docs/superpowers/spikes/trackpoint/Dockerfile` (already created)

**Produces (for later tasks):** image `garmin-spike`; volume `garmin_spike_data` with a persisted token; a recorded note of the real `track_points` and `activities` column names.

- [ ] **Step 1: Build the image**

Run:
```bash
docker build -t garmin-spike docs/superpowers/spikes/trackpoint
```
Expected: build succeeds; the final `garmin --version` layer prints `2.1.0` (the Dockerfile runs it as a smoke test). If the release-asset URL 404s, confirm the asset name at
`https://github.com/vicentereig/garmin-cli/releases/tag/v2.1.0` and adjust `GARMIN_CLI_VERSION` / the asset path, then rebuild.

- [ ] **Step 2: Confirm the exact column names from source**

Open `src/db/models.rs` in the garmin-cli repo (the spec cited `crates/garmin-cli/src/db/models.rs`) to learn the real column names for the per-sample and summary datasets, so the DuckDB SQL below uses real names rather than the spec's approximations:
```bash
# read-only fetch of the model definitions
curl -fsSL https://raw.githubusercontent.com/vicentereig/garmin-cli/v2.1.0/src/db/models.rs | less
```
Record in scratch notes: the exact `track_points` columns (timestamp / heart-rate / lat / lon / elevation / cadence / power / speed and their precise field names), the activity-summary columns, and the column that links a track point to its activity (activity id / timestamp). If a name differs from this plan's SQL, use the real one and flag the drift in the findings doc.

- [ ] **Step 3: Authenticate inside the container (browser-SSO)**

`garmin auth login` opens a browser SSO flow; the container is headless, so run it interactively and complete the flow from the host browser:
```bash
docker run --rm -it -v garmin_spike_data:/data garmin-spike -c "garmin auth login"
```
Expected: the command either opens a browser or **prints a URL** to visit. Open that URL in the host (Windows) browser, sign in, and let it complete. The token is written under `/data/.local/share/garmin/` on the volume and survives container exit.

Fallback if the flow uses a `localhost` OAuth callback that the container cannot receive: re-run mapping the callback port (the printed URL reveals it), e.g.
```bash
docker run --rm -it -p 8080:8080 -v garmin_spike_data:/data garmin-spike -c "garmin auth login"
```
Record which form worked in scratch notes — plan #8 (deployment) needs the same auth path on the server.

- [ ] **Step 4: Verify auth persisted**

Run:
```bash
docker run --rm -it -v garmin_spike_data:/data garmin-spike -c "ls -la /data/.local/share/garmin && garmin --help"
```
Expected: a token/credentials file present under the garmin data dir. Do not proceed to sync until auth is confirmed persisted on the volume.

---

## Task 1: Select the test activities (one outdoor GPS, one treadmill)

**Goal of task:** Identify, by logbook date, the specific runs the spike will sync — at minimum one outdoor GPS run and one treadmill/indoor run — so the `track_points` and indoor-`speed` questions both have a concrete subject.

**Files:**
- Read: recent daily files under `logbook/2026-06/` and `logbook/2026-05/`

**Consumes:** nothing. **Produces:** a recorded list of ≥2 target runs (date, indoor/outdoor, expected distance/duration) and a tight inclusive sync window `FROM`/`TO` covering them.

- [ ] **Step 1: Pick a treadmill run from the logbook**

`logbook/2026-05/2026-05-05.md`, `2026-05-06.md`, `2026-05-14.md`, `2026-05-15.md` were flagged treadmill/indoor. Open one with an actual logged run; record its date and logged distance/duration. This is the **indoor** subject — the one that answers "is `speed` populated without GPS?"

- [ ] **Step 2: Pick an outdoor GPS run from the logbook**

Open recent June dailies (`logbook/2026-06/2026-06-13.md` … `2026-06-18.md`); pick one with a logged outdoor run (pace in `/km`, GPS-bearing). Record its date and logged distance. This is the **outdoor** subject.

- [ ] **Step 3: Record the sync window**

From the two dates, record an inclusive `FROM`/`TO` covering both (small margin). Keep it tight — the spike needs only enough to inspect these two runs, not the whole history.

---

## Task 2: Sync the test window into the store

**Goal of task:** Populate the Parquet store on the volume with the chosen runs so the datasets can be inspected.

**Consumes:** image + volume + token (Task 0); `FROM`/`TO` and the two target dates (Task 1).
**Produces:** populated `activities/` and (hopefully) `track_points/` partitions on the volume covering the two runs.

- [ ] **Step 1: Dry-run first**

Confirm what sync intends to fetch without writing:
```bash
docker run --rm -it -v garmin_spike_data:/data garmin-spike \
  -c "garmin sync run --from <FROM> --to <TO> --dry-run"
```
Expected: lists the two target activities (and the health/performance pulls) for the window. Capture stdout — any note about skipping tracks/GPS is itself a finding.

- [ ] **Step 2: Real sync**

```bash
docker run --rm -it -v garmin_spike_data:/data garmin-spike \
  -c "garmin sync run --from <FROM> --to <TO>"
```
Expected: completes without error, reports activities ingested. Capture full stdout/stderr into scratch notes.

- [ ] **Step 3: Confirm both target runs landed in `activities`**

```bash
docker run --rm -it -v garmin_spike_data:/data garmin-spike -c \
  "duckdb -c \"SELECT * FROM read_parquet('/data/.local/share/garmin/activities/**/*.parquet', hive_partitioning=true) ORDER BY 1\""
```
Expected: a row for the outdoor run and one for the treadmill run. Record each run's **activity id** and **start time** (real column names from Task 0 Step 2); later queries key off them. If a target run is missing, widen the window and re-sync before proceeding.

---

## Task 3: Answer Q1 — is `track_points` populated at all?

**Goal of task:** Decide, with per-activity row counts, whether sync ingests per-sample data — the spike's primary question.

**Consumes:** volume; both activity ids; real `track_points` column names (Task 0 Step 2).
**Produces:** a recorded per-run `track_points` row count and a yes/no on population.

- [ ] **Step 1: Does the dataset even exist and have rows?**

```bash
docker run --rm -it -v garmin_spike_data:/data garmin-spike -c '
  ls -la /data/.local/share/garmin/track_points 2>/dev/null || echo "NO track_points DIR";
  duckdb -c "SELECT COUNT(*) AS total_points FROM read_parquet('"'"'/data/.local/share/garmin/track_points/**/*.parquet'"'"', hive_partitioning=true)"'
```
Expected (if ingested): a non-empty directory and a non-zero total. **No directory, or zero rows ⇒ sync does not ingest tracks** — the decisive negative finding; skip to Task 5 (storage is then near-zero) and record the verdict.

- [ ] **Step 2: Count points per target activity**

Using the real activity-link column (e.g. `activity_id`):
```bash
docker run --rm -it -v garmin_spike_data:/data garmin-spike -c \
  "duckdb -c \"SELECT activity_id, COUNT(*) AS points, MIN(timestamp) t0, MAX(timestamp) t1 \
   FROM read_parquet('/data/.local/share/garmin/track_points/**/*.parquet', hive_partitioning=true) \
   WHERE activity_id IN (<outdoor_id>, <treadmill_id>) GROUP BY activity_id\""
```
Expected (if ingested): hundreds–thousands of points per run, time span matching the run duration.

- [ ] **Step 3: Eyeball columns on the outdoor run**

```bash
docker run --rm -it -v garmin_spike_data:/data garmin-spike -c \
  "duckdb -c \"SELECT timestamp, heart_rate, latitude, longitude, elevation, cadence, speed \
   FROM read_parquet('/data/.local/share/garmin/track_points/**/*.parquet', hive_partitioning=true) \
   WHERE activity_id = <outdoor_id> ORDER BY timestamp LIMIT 10\""
```
Expected (outdoor, if ingested): non-null `heart_rate`, plausible `latitude`/`longitude`, non-null `speed`. Record which columns are populated vs null — column-level gaps matter as much as the row count.

- [ ] **Step 4: Record the Q1 verdict**

Scratch notes: **track_points populated? yes / no**, with row counts as evidence. This is the gate value the findings doc reports.

---

## Task 4: Answer Q2 — is `speed` present on the treadmill run (no GPS)?

**Goal of task:** Determine whether indoor runs carry per-sample `speed`, since per-km splits on a treadmill must be integrated from `speed × Δt` (no `lat/lon` fallback). If `speed` is null indoors, treadmill split derivation is impossible from the local store.

**Consumes:** volume; treadmill activity id.
**Produces:** a recorded yes/no on indoor `speed`, plus `lat/lon` nullity.

- [ ] **Step 1: Column-population counts on the treadmill run**

```bash
docker run --rm -it -v garmin_spike_data:/data garmin-spike -c \
  "duckdb -c \"SELECT COUNT(*) points, COUNT(speed) speed_non_null, COUNT(latitude) lat_non_null, \
   COUNT(heart_rate) hr_non_null, AVG(speed) avg_speed \
   FROM read_parquet('/data/.local/share/garmin/track_points/**/*.parquet', hive_partitioning=true) \
   WHERE activity_id = <treadmill_id>\""
```
Record:
- `lat_non_null = 0` ⇒ genuinely GPS-less (a valid indoor subject).
- `speed_non_null > 0` with plausible `avg_speed` ⇒ **treadmill splits derivable** from the store.
- `speed_non_null = 0` ⇒ **treadmill splits NOT derivable** from track points; record as a read-path constraint (MCP fallback for indoor splits, or accept none).
- `hr_non_null > 0` even when speed is null ⇒ time-in-HR-zone still works indoors; note it.

- [ ] **Step 2: Record the Q2 verdict**

Scratch notes: **indoor `speed` populated? yes / no**, with the counts.

---

## Task 5: Answer Q3 — storage cost of retaining tracks

**Goal of task:** Quantify per-run and projected-history storage for keeping `track_points`, feeding the spec's "daily store-commit / move to git LFS past ~50–100 MB" decision.

**Consumes:** volume; per-run row counts (Task 3).
**Produces:** recorded bytes-per-run and a full-history projection.

- [ ] **Step 1: Measure dataset sizes on the volume**

```bash
docker run --rm -it -v garmin_spike_data:/data garmin-spike -c \
  "du -sh /data/.local/share/garmin/track_points /data/.local/share/garmin/activities /data/.local/share/garmin 2>/dev/null; \
   ls -laR /data/.local/share/garmin/track_points"
```
Record the `track_points` total for the two-run window and the per-partition file sizes.

- [ ] **Step 2: Project to full history**

Compute bytes-per-trackpoint = (`track_points` bytes) ÷ (total track rows from Task 3 Step 1). Estimate per-run cost (points/run × bytes/point) and multiply by an approximate run count to date. Rough upper bound on run files:
```bash
ls logbook/2026-*/2026-*.md | wc -l
```
Record: **bytes/run**, **projected full-history track_points size**, and whether it crosses ~50–100 MB (the spec's LFS threshold). Feeds plan #1 (store) and #7 (git syncer).

---

## Task 6: Write the decision record

**Goal of task:** Convert the evidence into one document that plan #1 (store) and plan #3 (read-path rewrite) consume — the spike's actual deliverable.

**Files:**
- Create: `docs/superpowers/specs/2026-06-19-trackpoint-spike-findings.md`
- Modify: `docs/superpowers/specs/2026-06-19-coach-remote-interface-design.md` (resolve the open item)

**Consumes:** all recorded verdicts (Tasks 3–5).
**Produces:** a committed findings/decision doc; downstream plans branch on its conclusions.

- [ ] **Step 1: Write the findings document**

Create `docs/superpowers/specs/2026-06-19-trackpoint-spike-findings.md`, each section filled from recorded evidence (state the numbers, no hedging):

```markdown
# TrackPoint Ingestion Spike — Findings

**Date:** 2026-06-19
**Spike plan:** docs/superpowers/plans/2026-06-19-trackpoint-ingestion-spike.md
**Tool under test:** vicentereig/garmin-cli v2.1.0 (containerised; NOT the abandoned Python script)

## Q1 — Does `garmin sync run` populate `track_points`?
<yes/no>. Evidence: outdoor run <id> = <N> points over <duration>; treadmill run <id> = <N> points.
Column population: <which of heart_rate/latitude/longitude/elevation/cadence/power/speed are non-null>.

## Q2 — Is `speed` present without GPS (treadmill)?
<yes/no>. Evidence: treadmill run lat_non_null=<n>, speed_non_null=<n>, avg_speed=<v>.

## Q3 — Storage cost
<bytes/run>; projected full-history track_points size = <size>; crosses ~50–100 MB LFS threshold: <yes/no>.

## Decisions (consumed by plans #1 and #3)
- `v_activity_splits` buildable from the local store: <yes / outdoor-only / no>.
- Time-in-HR-zone derivable from the store: <yes/no>.
- `/log` run analysis keeps the MCP read fallback: <not needed / required for indoor splits / required outright>.
- Store-commit cadence / git LFS: <daily commit fine / adopt LFS now / revisit at N runs>.

## Operational notes for downstream plans
- garmin-cli runs containerised (Dockerfile: docs/superpowers/spikes/trackpoint/Dockerfile); state on a volume at $HOME/.local/share/garmin.
- Auth flow that worked: <plain browser-SSO / localhost-callback with port map> — plan #8 reuses it.
- Any `src/db/models.rs` column names that differed from the spec: <list>.
```

- [ ] **Step 2: Resolve the spec's open item**

In `docs/superpowers/specs/2026-06-19-coach-remote-interface-design.md`, edit §"The real open item — does `sync` populate `TrackPoint`?" and the matching "TrackPoint ingestion" risk in §"Risks and open implementation questions" to reference `2026-06-19-trackpoint-spike-findings.md` and state the resolved answer in one line each — so the next plan author reads the conclusion, not the open question.

- [ ] **Step 3: Tear down spike state (keep the Dockerfile + findings)**

Remove the data volume (token + Parquet store) and any scratch notes containing synced data. Keep the `Dockerfile` (plan #1 reuses it) and the findings doc.
```bash
docker volume rm garmin_spike_data
docker image rm garmin-spike   # optional; rebuildable from the Dockerfile
```
Confirm `git status` shows only the new findings doc, the spec edit, and the (already-committed or new) Dockerfile — no volumes, tokens, Parquet, or `sync.db`.

- [ ] **Step 4: Commit (per project git convention)**

```bash
git add docs/superpowers/spikes/trackpoint/Dockerfile \
        docs/superpowers/specs/2026-06-19-trackpoint-spike-findings.md \
        docs/superpowers/specs/2026-06-19-coach-remote-interface-design.md
git commit -m "Record TrackPoint ingestion spike findings; resolve spec open item"
```

---

## Self-Review

- **Spec coverage:** Addresses exactly the spec's "first plan task: a spike" (§"The real open item") and its companion risk item. The three questions (populated? indoor speed? storage cost?) and the two derivation features (splits, HR-zone) map 1:1 to the spec's §"Schema coverage" claims. The `/log` MCP-fallback decision is the explicit output.
- **Scope guard:** Builds no store schema, extractor, or read-path code. Those are plans #1/#2/#3, which consume this record. The container/Dockerfile is the minimum needed to run a Windows-hostile Rust tool.
- **Tool-identity guard:** The abandoned `.venv/Scripts/garmin` (Python/SQLite) is on the host `PATH`; the spike runs only the containerised Rust binary, restated in the constraints so a worker can't accidentally measure the wrong tool.
- **Honest uncertainty:** Exact column names are confirmed against `src/db/models.rs` in Task 0 before the SQL runs; the browser-SSO-in-a-headless-container risk is met with an explicit port-mapping fallback rather than pretended away. Dataset paths (`track_points/`, `activities/`) come from the garmin-cli docs, not invented.

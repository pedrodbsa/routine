---
name: reference-garmin-typed-splits-overlap
description: get_activity_typed_splits returns overlapping split families (INTERVAL_* and RWD_*) in one array — filter by type before summing, or you double-count
metadata:
  type: reference
---

`mcp__garmin__get_activity_typed_splits` returns **two independent segmentations of the
same activity timeline in a single `splits` array**, interleaved:

- **`INTERVAL_WARMUP` / `INTERVAL_ACTIVE` / `INTERVAL_RECOVERY` / `INTERVAL_COOLDOWN`** —
  the structured workout's own steps. This is the family that answers "did he execute the
  prescription?"
- **`RWD_RUN` / `RWD_WALK` / `RWD_STAND`** — Garmin's automatic Run/Walk Detection, which
  re-segments the *same clock* by detected gait.

They overlap; they do not concatenate. An `RWD_WALK` of 72 s sits *inside* a 90 s
`INTERVAL_RECOVERY` (the walking between decelerating out of a rep and accelerating into
the next). `RWD_RUN` segments run longer than their matching `INTERVAL_ACTIVE` because
continuous running spans the rep plus the run-out and run-in around the recovery.

**Always filter to one `type` family before summing anything.** Then check the total against
the activity's own `duration_seconds` and `distance_meters` — with the right filter both
close to within about a second and a metre. That check is cheap and it is conclusive.

**Why this is in memory:** on 2026-08-11 the families were read as one sequence, which
double-counted every recovery and produced a finding that the athlete had run ~165 s
recoveries against a prescribed 90. He had not — all six read exactly 90.0 s. The wrong
finding was then used to argue the session's pace-at-HR improvement was a confound
artifact, and to recommend a protocol change for the next benchmark. The athlete caught it.
The duration sum would have caught it immediately.

Related: [[feedback-garmin-mcp-over-csv]], [[feedback-benchmark-matched-reps]],
[[feedback-verify-load-baseline-against-athlete]] — the same lesson as the retracted
20 kg DB press baseline, in a different channel: **check the record against the athlete's
account before building a recommendation on it.**

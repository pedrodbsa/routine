---
name: reference-strava-import-when-watch-dies
description: "Watch battery died mid-run → athlete exports the original from Strava and imports it at connect.garmin.com; the imported run has HR but no splits, RPE or TE, and its GPS pace is not a pace-at-HR read"
metadata:
  type: reference
---

When the watch dies and the run was recorded on Strava (2026-11-01, long run), the route that keeps the data is **Strava → ⋯ → Export Original → connect.garmin.com → Import Data**. The MCP cannot upload FIT/GPX activities; `create_manual_activity` makes an entry with no HR, which is worse. The athlete did the import himself in ~30 minutes.

What the imported activity carries (`device_manufacturer: STRAVA`): distance, elapsed and moving time, avg/max HR, elevation, **one lap, no splits, no `workout_rpe`, no training effect**. It does not feed Garmin's daily steps or calories (the day total stays low; tiers are by day type, so nothing changes), and it does not count as the scheduled workout.

Reading it:
- Moving time is Strava's definition, and the Nov 1 file had a 10.1 m/s max-speed spike (GPS). **Do not use its pace for pace-at-HR or the long-run trend**; use avg HR and distance only, and treat the distance as possibly GPS-inflated (12.85 km against a 12 km plan).
- Composite load excludes it (no RPE) unless the athlete gives one.
- `cron-activity` sends `/log activity <id>` for it as for any other run; if `/log` already recorded it, stop silently.

Related: [[reference-garmin-direct-pull-fallback]], [[feedback-verify-session-completed-against-garmin]].

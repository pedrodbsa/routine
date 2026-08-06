---
name: feedback-weigh-in-check-timestamps
description: "Always check weigh-in TIMESTAMPS, not just values — the athlete weighs post-run on some days, which reads ~0.9 kg low and silently corrupts the weight trend"
metadata: 
  node_type: memory
  type: feedback
  originSessionId: 9ea6f4a6-e8d2-4449-bad1-ed67c1d3c801
  modified: 2026-07-21T10:23:27.256Z
---

When pulling `mcp__garmin__get_daily_weigh_ins`, always convert `timestamp_gmt` to local time
and classify each reading as **fasted-morning** or **post-run** before using it. Never take
`average_weight_kg` or a bare value at face value.

Discovered 2026-07-21: from Jul 12 the athlete had started weighing *after* morning runs, on his
own initiative, to "leave water retention out of the picture" after seeing big daily fluctuations.
Post-run readings run **0.8-1.0 kg below** the same morning's fasted reading (measured same-day
pairs: 0.84 kg Jul 15, 1.04 kg Jul 21). Because he only ran on some days, the series became mixed,
and a full month of reports read post-run numbers against a morning-weighed June baseline —
producing a fake 0.4-0.5 kg/wk descent, three fake "block lows", and a fake
"run-day low vs rest-day rehydration bounce" physiological pattern. The real morning-to-morning
trend was flat. The `/report` stall-break verdict had to be retracted.

**Why:** post-run weighing does not remove water noise, it replaces small *random* morning noise
(±0.3-0.5 kg) with a large error that *correlates with training* — fake loss on hard weeks, fake
gain on deload weeks. The fix for daily fluctuation is standardized conditions plus the 7-day
rolling average, never a "cleaner" single reading.

**How to apply:** convert every timestamp before trending. Trend from fasted-morning readings only.
The athlete now takes a deliberate second post-run reading as a sweat-rate metric (his request, and
genuinely useful given his chronic under-hydration lab flag) — file it as hydration data, never in
the weight trend, and discard its BIA body-fat/water channel entirely (post-exercise BIA is junk;
two readings 76 s apart disagreed by 1.1 points of body water). Protocol lives in `nutrition.md`
§ Paired Weigh-In and Sweat-Rate Tracking.

Related: [[feedback-garmin-mcp-over-csv]], [[feedback-tracking-adherence]]

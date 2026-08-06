---
name: feedback-verify-session-completed-against-garmin
description: Never write a session as completed without checking Garmin activities for that date — including unequipped sessions that had nothing to upload
metadata: 
  node_type: memory
  type: feedback
  originSessionId: 0249edc3-b6fd-4fc9-b691-5ff0cbaeb031
  modified: 2026-07-27T13:36:05.061Z
---

Before `/log` or `/report` records any session as done, call `get_activities_by_date` for that date. This applies to **every** session type, not just runs — and most of all to **unstructured/unequipped sessions that `/garmin` had nothing to upload for**, because those are the ones with no upload trail to jog the check.

**Why:** The 2026-07-23 file recorded an AM plyo session as completed and used that output to justify holding the calorie tier. Garmin had **zero activities** that day — only a `RECOVERY` event and `DAY_RECOVERING_AND_INACTIVE`. The athlete confirmed on 2026-07-27 that he never trained. The phantom sat in the file for four days across two `/plan` runs, inflating streak counts and training-day totals. The failure mode was specific: the entry was *about nutrition*, and the training status got asserted in passing without verification.

**How to apply:** Treat "the session happened" as a claim requiring evidence, never a default inherited from the plan. A day with no Garmin activity is a **rest day** in the load ledger regardless of what the plan prescribed. When correcting an old file, fix the title too — a stale header gets read at a glance and re-propagates the error. Extends [[feedback-garmin-mcp-over-csv]]; related to [[feedback-adjust-day-on-skipped-session]] and [[feedback-rederive-not-inherit]].

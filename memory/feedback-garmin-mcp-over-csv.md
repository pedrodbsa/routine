---
name: feedback-garmin-mcp-over-csv
description: "For analysis/audits, pull live Garmin MCP data — the data/*.csv exports are usually stale"
metadata: 
  node_type: memory
  type: feedback
  originSessionId: d651f992-6c39-48d6-82fb-a0ba1739b89f
---

When analyzing recovery/training/body data (audits, `/report`, diagnosis), pull **live from the Garmin MCP tools**, not the `data/*.csv` exports. The athlete confirmed (2026-06-15) the CSVs are outdated between manual export refreshes.

**Why:** the coaching log already notes `data/activities.csv` was stale (missing June runs) and corrupted ACWR/volume math; the athlete reaffirmed CSVs lag reality.

**How to apply:** default to `mcp__garmin__*` for any data-driven check. Treat CSVs only as a long-history convenience, never as the current-week source of truth. Relates to [[feedback-tracking-adherence]].

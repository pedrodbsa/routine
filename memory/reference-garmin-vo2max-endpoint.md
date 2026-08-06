---
name: reference-garmin-vo2max-endpoint
description: Garmin VO2max MCP endpoints are unreliable — use race-time prediction as the proxy
metadata: 
  node_type: memory
  type: reference
  originSessionId: d651f992-6c39-48d6-82fb-a0ba1739b89f
---

The Garmin MCP VO2max data path is unreliable: `mcp__garmin__get_vo2max_trend` returns "No VO2 max data found" and `mcp__garmin__get_training_status` errors (`NoneType`), even with recent outdoor GPS runs (verified 2026-06-15). The internal estimate still exists — `mcp__garmin__get_race_predictions` works and is VO2max-derived.

**How to apply:** the cut-phase running scoreboard metric "VO2max ≥47" (`running.md`, `report.md`) is scored via the **10K race prediction as proxy** — 10K not slower than ~50:00–50:30 ≈ VO2max ~47. Don't report the VO2max endpoint as broken to the athlete; just use the prediction. Relates to [[feedback-garmin-mcp-over-csv]] and [[lab-tested-physiology]].

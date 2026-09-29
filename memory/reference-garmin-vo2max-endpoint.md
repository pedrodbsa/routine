---
name: reference-garmin-vo2max-endpoint
description: Garmin VO2max MCP endpoints are unreliable for this athlete — use the 10K race prediction as the fitness proxy
metadata:
  type: reference
---

`get_vo2max_trend` has returned "No VO2 max data found" and `get_training_status` has errored for this athlete even with recent outdoor GPS runs (verified 2026-06-15). `get_race_predictions` works and is VO2max-derived, so the Garmin 10K prediction is the fitness proxy (10K ~50:00–50:30 ≈ VO2max ~47). Use it without reporting the broken endpoint to the athlete. Related: [[user-motivation-running-numbers]].

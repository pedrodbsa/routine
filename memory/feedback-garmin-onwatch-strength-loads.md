---
name: feedback-garmin-onwatch-strength-loads
description: "Garmin watches don't display structured target weights during strength workouts — embed loads in step name/description or the athlete lifts blind"
metadata: 
  node_type: memory
  type: feedback
  originSessionId: d55cac9a-d0b3-4f54-81ed-0ae747c12094
---

When `/garmin` uploads a strength workout, the per-step `weight_value` is stored and shows in Garmin Connect (and on API read-back), but it does NOT reliably display on the watch during the session — the watch surfaces only the exercise name + rep target. On 2026-06-16 the Upper Push had correct loads in the uploaded file (Incline DB 22 kg, Shoulder Press 20 kg, Bench Dip +12.5 kg, Lateral Raise 8 kg), yet the athlete — training watch-only, no phone — couldn't see them, lifted blind, and under-shot every load (incline 20, shoulder topped 16). The progression targets were correct; delivery failed. I had wrongly attributed the light loads to post-run fatigue.

**Why:** double progression only works if the prescribed load reaches the bar. A correct upload the watch won't render is useless when the athlete trains watch-only. "Verified on read-back" gave false confidence — read-back reads Connect, not what the watch shows.

**How to apply:** put the target load in each step's **name or description text** (e.g. "Incline DB Press — 22 kg/DB"), since the watch surfaces step text even when it hides the structured weight field. Never claim a strength workout is "load-verified" on the basis of read-back alone — that only confirms the data, not on-watch visibility. Alternatively confirm the athlete has the plan on his phone at the gym. See [[feedback-garmin-mcp-over-csv]].

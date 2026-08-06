---
name: feedback-garmin-watch-offsite-reference
description: "Garmin watch is the only offsite reference (gym); embed execution data there, keep nutrition out"
metadata: 
  node_type: memory
  type: feedback
  originSessionId: 7dbf122f-b031-427f-96fe-2e89b59e43ea
---

The Garmin watch is the athlete's **only** reference when away from home — this conversation and the plan files are not accessible at the gym. So everything needed to *execute a session offsite* must live in the uploaded Garmin workout: structured targets, per-step strength loads, reps, exercise identity, HR/pace bands, heat/pacing cues.

**Do not push meal/nutrition notes into Garmin.** Nutrition is always conducted at home, where the plan files and this assistant are consultable — so meal cues on the watch are redundant noise. Don't re-upload a workout just to fix a nutrition cue (e.g. "banana" vs "Nestum" in a run description).

**Why:** this is the reason on-watch strength loads matter (see [[feedback-garmin-onwatch-strength-loads]]) — and it bounds it: the load/structure must be on the watch, the fueling must not.

**How to apply:** `/garmin` run + strength descriptions carry workout-execution cues only (structure, HR/pace targets, loads, reps, RPE, heat/treadmill fallback). Leave pre-run fueling, shakes, sodium, and meal-timing out of Garmin — those belong in the daily plan file's Nutrition section, consulted at home.

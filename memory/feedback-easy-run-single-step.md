---
name: feedback-easy-run-single-step
description: Easy and long runs go to Garmin as ONE step at the plan cap — no warmup/cooldown block; a looser first-km ceiling is backwards
metadata:
  type: feedback
---

Build easy runs and long runs as a **single Garmin step** at the plan's HR cap (110–142, or the long-run drift ceiling). No warmup step, no cooldown step.

**Why:** The athlete flagged it on 2026-09-08 — every easy run was going up as "warmup 1 km @ 110–145, then main @ 110–142", i.e. a warmup block with a *looser* ceiling than the easy set it preceded. That is a quality-session template carried onto easy days unexamined. On an easy run the main set already is the easy effort; the Daily 5 is the warmup; and the first km is exactly where going out too fast happens, so relaxing the watch there protects against nothing and silences the one alert that matters.

**How to apply:** In `/garmin`, an easy or long run is one `ExecutableStepDTO` for the whole distance at the plan cap. Warmup/cooldown steps exist only for quality sessions, where they bracket genuinely harder work. Rule lives in `.claude/commands/garmin.md` § Run workouts. Related: [[feedback-garmin-easy-paces-work]] (keep easy days genuinely easy).

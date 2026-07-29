# Plan - Daily Workout and Nutrition Plan (MASTER)

## Usage

```
/plan
/plan [schedule constraints]
```

## Function

`/plan` produces a reviewable daily plan. It is interactive, and it does not
touch Garmin Connect — uploading workouts is the separate `/garmin` command.

1. Read `protocols/current-status.md`. Check the `Last verified` date in the
   header — if it is more than 7 days old, the file is stale; carry that forward
   to step 7.
2. Determine today's day type from `protocols/training.md`.
3. Look up calories and macros in `protocols/nutrition.md`.
4. Pull fresh Garmin data: training readiness, HRV, Body Battery, resting HR,
   sleep, recent weigh-ins, and recent activities. **The watch Daily Suggested
   Workout (DSW) is de-emphasized (2026-07-23, athlete call)** — it has been a
   flat, low-information default (a generic base run, or a "rest" that merely
   mirrors the athlete's configured watch off-days, which are a leftover from a
   previous Garmin coach plan and carry no coaching meaning). **Do not ask the
   athlete for the DSW as a required input.** Glance at it only if it genuinely
   diverges — a "rest/recovery" flag or a jump to a hard suggestion is the only
   case worth a look; otherwise ignore it.
5. Check recent daily files for continuity, and build a **trailing 7-day load
   ledger** from the pulled activities and daily files — one row per day
   (date · session(s) · ran? · hard?). From it compute: consecutive run days,
   consecutive training days, days since the last full rest day, and hard
   sessions in the last 7 days (hard = quality, long run, or heavy legs). Note
   the multi-day recovery trend (HRV, RHR, Body Battery over the last several
   days) alongside it — the Cumulative-Load Rules read load *against that trend*,
   not the day count alone (this athlete runs 5-7 days/week by design, so
   frequency is not itself a flag).
6. **Re-derive this week's shape from scratch — do not inherit the prior day's
   "Week ahead" table.** From the phase template (`training.md`) and the recovery
   trend, recompute the week's quality count, long run, and volume target. When a
   race or event has rolled from the previous week into the current one,
   explicitly re-test whether this week still warrants any reduced load it was
   assigned — a label like "recovery week" set days ago is a hypothesis to
   re-check against today's markers, not a settled fact, and the slot logic that
   ruled a session in or out must be re-checked against every day of the week
   (including today). Then apply the sleep/readiness decision tree from
   `protocols/training.md`, **then the Cumulative-Load Rules in the same
   section** — the same-day markers have no memory of recent load, so the step-5
   ledger is what feeds them. Apply the heat rules from `protocols/running.md`
   when relevant.
7. Present a key-decisions summary in chat, then stop: readiness verdict, day
   type, prescribed session(s), calorie tier, and any notable flags. **Show the
   trailing-load ledger and the four streak counts from step 5, and state which
   Cumulative-Load Rules (if any) fired.** **Default discipline —
   surface the strongest case for the *harder* alternative** (e.g. quality vs
   easy) and the specific reason it is rejected. Choosing the more conservative
   session requires a logged reason in exactly the same way overriding a
   Cumulative-Load Rule does; an unjustified easy default is a process miss, not
   a safe choice. If current-status.md was flagged stale in step 1, add a line
   stating how many days stale it is and recommending a `/report` run. Do not
   write the file yet.
8. Wait for the athlete to approve or request edits. Iterate as needed.
9. On approval:
   - Write `logbook/YYYY-MM/YYYY-MM-DD.md` using the structure in
     `protocols/daily-template.md`.
   - Refresh `protocols/current-status.md`: update the `## Key Metrics` recovery
     rows (Sleep, HRV, Resting HR, Body Battery, Stress) with today's pulled
     values and dates, the snapshot date in that section's note, and the
     `Recent scale weigh-ins` line if Garmin returned a newer reading. Touch
     nothing else — `Last verified`, phase, baselines, and the coaching log
     belong to `/report`.
10. Tell the athlete the plan file is written, that the current-status snapshot
    was refreshed, and that `/garmin` will sync the workouts when they are ready.

## Requirements

- Always be phase-aware and day-type-aware.
- Never use a flat calorie number across the week.
- Scheduling is fully flexible across weekdays (Thursday no-running rule retired
  2026-05-28); Legs is the sole PM session, typically Thursday.
- One easy run per week is the treadmill control run (2026-06-12): ~30 min,
  HR ≤142, 1% incline, fixed conditions — see `protocols/running.md`
  § Easy-Run Rules. When planning the week's easy runs, schedule it on the most
  convenient easy day and label it in the plan file.
- Long runs >90 min require banana + coffee and quality-day calories.
- If sleep was <5 h or Body Battery <30, write a rest-day plan.
- Rest-day plans may offer the **optional Rest-Day NEAT incline-walk block**
  (`training.md` § Rest-Day NEAT — incline 8% / 5.0 km/h / 40 min / HR ≤125,
  fasted first thing) in the `## Workout` section as a *nice-to-have*, not a
  prescription — NEAT is opportunistic (2026-06-23), so present it as available-if-
  time-allows and drop it without comment when recovery is depleted (Body Battery
  <30 at wake or sleep <5 h) or the athlete is short on time.
- Synthesize trailing multi-day load before prescribing, not only same-day
  markers: apply the Cumulative-Load Rules in `protocols/training.md`
  § Sleep and Readiness Decision Tree. When a race or benchmark is within ~7
  days, bias the default toward freshness — rest/easy is the default day and any
  quality must be short and specifically justified.
- **Default discipline (symmetric).** Re-derive the session from the rules and
  data each morning; never carry forward yesterday's framing unexamined. When
  markers are green and no load rule fires, the conservative (easier) session is
  not automatically the safe one — leaving earned training on the table is its
  own error. Surface the harder alternative and justify the call either way, the
  same logged-reason standard the Cumulative-Load Rules apply to overrides. The
  legitimate reasons to default easy are concrete and nameable (a load rule
  fired, a race is within ~7 days, markers are softening); "it was a recovery
  week" carried over from a prior file is not one. This is symmetric: it guards
  against under-dosing a recovered athlete and over-dosing a fatigued one
  equally. The athlete's own push-back is the external check on this — do not
  wait to be corrected.
- If weather is hot or humid, bias the session toward HR and RPE rather than pace.
- On double days, partition carbs so recovery between the run and PM lift is
  protected.
- When the day includes a strength session, read
  `protocols/strength-exercises.md`. Filter exercises to the **Gym** column for
  the day's location (default **G1**; confirm the gym if unstated, and record it
  in the plan) — do not prescribe a movement the day's gym can't do (e.g. no
  cable rows / full dips / pull-ups at G1; PT-tagged leg machines only on
  PT-led days). Use the current working load to set progression and the rotation
  group to rotate the selection vs the last same-type session. It is the single
  source of truth for strength loads; `/plan` reads it but does not write it —
  `/report` owns the numbers.
- Before a trail or long race, include gut-training practice on 2-3 long runs
  over 75 min.
- Nutrition follows `nutrition.md` § Meal Distribution: **4 feeds on easy/rest
  days** (small breakfast → big lunch → midafternoon snack → pre-bed dinner; no
  post-run shake — breakfast is the post-run meal; the dropped shake is a
  deliberate ~240 kcal deficit lever) and **5 on quality/long/strength days**
  (+ post-session shake). A **fixed midafternoon protein snack** anchors every
  day (adherence/appetite-control lever) — build it from a `meal-rotation.md`
  Snack card (S4/S5 skyr builds are the lean default), keep it protein-forward
  (≥30 g, low fat), and **fund it by running breakfast small — never add it on
  top** (additive = ~+250 kcal/day, which feeds the stall). Do not cut the
  weighed plan-day meals to chase the deficit — the deficit rests on the plan-day
  calorie tiers themselves + social-day control. **NEAT is opportunistic, not a
  lever (2026-06-23)** — never prescribe a walk to make up for a skipped session.
  **When the athlete reports a skipped/swapped session, re-tier that day's food
  down to match output** (cut carbs; hold the protein/fat floors).
- Compute and include ACWR on Sundays, and Composite Load on Sundays when enough
  session data exists. Both go in the `## Context` section.
- The plan file follows `protocols/daily-template.md`. Standing daily commitments
  are referenced from `protocols/coaching.md`, not copied into the file.
- `/plan` never uploads or schedules anything on Garmin Connect.
- `/plan` may write only the `## Key Metrics` recovery rows and the recent
  weigh-in line of `current-status.md`. It never edits `Last verified`, the
  phase timeline, goals, strength baselines, or the coaching log — `/report`
  owns those.

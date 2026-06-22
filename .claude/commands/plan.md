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
   sleep, recent weigh-ins, and recent activities.
5. Check recent daily files for continuity, and build a **trailing 7-day load
   ledger** from the pulled activities and daily files — one row per day
   (date · session(s) · ran? · hard?). From it compute: consecutive run days,
   consecutive training days, days since the last full rest day, and hard
   sessions in the last 7 days (hard = quality, long run, or heavy legs). Note
   the multi-day recovery trend (HRV, RHR, Body Battery over the last several
   days) alongside it — the Cumulative-Load Rules read load *against that trend*,
   not the day count alone (this athlete runs 5-7 days/week by design, so
   frequency is not itself a flag).
6. Apply the sleep/readiness decision tree from `protocols/training.md`, **then
   the Cumulative-Load Rules in the same section** — the same-day markers have no
   memory of recent load, so the step-5 ledger is what feeds them. Apply the heat
   rules from `protocols/running.md` when relevant.
7. Present a key-decisions summary in chat, then stop: readiness verdict, day
   type, prescribed session(s), calorie tier, and any notable flags. **Show the
   trailing-load ledger and the four streak counts from step 5, and state which
   Cumulative-Load Rules (if any) fired.** If current-status.md was flagged stale
   in step 1, add a line stating how many days stale it is and recommending a
   `/report` run. Do not write the file yet.
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
- Rest-day plans include the standing **Rest-Day NEAT incline-walk block**
  (`training.md` § Rest-Day NEAT — incline 8% / 5.0 km/h / 40 min / HR ≤125,
  fasted first thing) in the `## Workout` section —
  unless recovery is genuinely depleted (Body Battery <30 at wake or sleep <5 h),
  in which case it is full rest and the walk is dropped.
- Synthesize trailing multi-day load before prescribing, not only same-day
  markers: apply the Cumulative-Load Rules in `protocols/training.md`
  § Sleep and Readiness Decision Tree. When a race or benchmark is within ~7
  days, bias the default toward freshness — rest/easy is the default day and any
  quality must be short and specifically justified.
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
- Nutrition follows `nutrition.md` § Meal Distribution: **3 protein feeds on
  easy/rest days** (no post-run shake — breakfast is the post-run meal; the
  dropped shake is a deliberate ~240 kcal deficit lever) and **4 on
  quality/long/strength days**. Do not cut the weighed plan-day meals to chase the
  deficit — the levers are NEAT and social-day control, not plan-day food.
- Compute and include ACWR on Sundays, and Composite Load on Sundays when enough
  session data exists. Both go in the `## Context` section.
- The plan file follows `protocols/daily-template.md`. Standing daily commitments
  are referenced from `protocols/coaching.md`, not copied into the file.
- `/plan` never uploads or schedules anything on Garmin Connect.
- `/plan` may write only the `## Key Metrics` recovery rows and the recent
  weigh-in line of `current-status.md`. It never edits `Last verified`, the
  phase timeline, goals, strength baselines, or the coaching log — `/report`
  owns those.

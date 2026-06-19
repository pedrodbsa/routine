# Garmin - Sync the Day's Workouts to Garmin Connect (MASTER)

## Usage

```
/garmin
/garmin [YYYY-MM-DD]
```

## Function

`/garmin` uploads the prescribed workout(s) from a daily plan to Garmin Connect
and schedules them on the calendar. It is user-triggered — run it after `/plan`,
once the plan has been reviewed.

1. Read the plan file for the target date — today's `logbook/YYYY-MM/YYYY-MM-DD.md`, or the
   date passed as an argument.
2. Parse the prescribed session(s) from the `## Workout` section.
3. Replace-on-rerun: look up workouts whose name carries the target date
   (`mcp__garmin__get_workouts` / `mcp__garmin__get_scheduled_workouts`). Delete
   any match with `mcp__garmin__delete_workout` before uploading.
4. For each prescribed session, build and upload the workout:
   - Rest day — create nothing.
   - Strength — `mcp__garmin__upload_workout` with a full DTO. One
     `RepeatGroupDTO` per exercise (`numberOfIterations` = sets; always include
     `endCondition` `{conditionTypeId: 7, conditionTypeKey: "iterations"}`),
     wrapping an exercise `ExecutableStepDTO` + a `rest` step. The exercise step
     carries a **reps** end condition (`conditionTypeId: 10`), the Garmin
     `category` + `exerciseName`, and `weightValue` / `weightUnit` when the plan
     gives a load. **Do not use `mcp__garmin__create_strength_workout`** — it
     encodes every movement as a fixed-time interval with the name in a
     description and no reps or load, which the watch cannot track as sets.
   - Run, custom structured (HR-target easy run, tempo, threshold reps) —
     `mcp__garmin__upload_workout` with a full DTO. Use custom HR ranges
     (`targetType` `heart.rate.zone` with `targetValueOne` low / `targetValueTwo`
     high bpm — not `zoneNumber`).
   - Run, walk/run intervals — `mcp__garmin__create_walk_run_workout` only when
     the session genuinely wants timed walk breaks; it supports zone-based
     intervals only, with no per-step custom HR and no warmup/cooldown targets.
   - Race day — create a workout only if it helps pacing or HR control.
5. Verify before reporting: read each uploaded workout back with
   `mcp__garmin__get_workout_by_id`. Garmin **silently drops** an `exerciseName`
   it does not recognise (the step keeps its category but loses the name).
   Confirm every exercise kept its name, reps/time, and load; fix any that fell
   back, or report them explicitly.
6. Schedule each uploaded workout for the plan date with
   `mcp__garmin__schedule_workout`.
7. Report the created workouts and their IDs in chat, and write the IDs into the
   plan file's `## Context` section.

## Requirements

- Workout name format: `<SessionType> — <Phase/Week> (<YYYY-MM-DD>)`. The trailing
  date is what makes replace detection reliable — always include it.
- A double day (run + strength) produces two workouts; upload and schedule both.
- Never create a workout for a rest day.
- If the plan file for the target date does not exist, stop and tell the athlete
  to run `/plan` first.
- `/garmin` does not modify the plan file except to append workout IDs to the
  `## Context` section.

### Run workouts — every step must have a target

Every step in a run workout — **including warmup and cooldown** — must carry an
explicit pace **or** HR target. A bare "warmup" or "cooldown" step with no target
gives the athlete nothing to aim for on the watch.

- **Athlete HR-band calibration (2026-06-13):** this athlete has a compressed
  running HR range — an easy jog sits ~135–145 bpm and anything **below ~130 bpm
  is a walk, not a jog**. So a *running* step's HR ceiling must never be set at
  walk level. The old "warmup ≤125 / cooldown ≤130 / recovery ≤133" defaults were
  unattainable without walking and tripped constant "too high" alerts on a normal
  jog. Jog-step HR **ceilings stay at jog level (~145–150)**; floors stay low
  (~110) so they never false-alert "too low." This applies to every easy/jog step:
  warmup, cooldown, and recovery jogs between reps.
- **Warmup:** HR **110–150** (a jog band that builds toward the work; ~145 ceiling
  on easy-run days, up to 150 on quality days), or pace 7:00–8:00/km. Override with
  the plan file's specifics if present.
- **Cooldown:** HR **110–145**, or pace 7:00–7:45/km.
- **Easy main set:** HR cap from the plan (`≤142 bpm` per current protocol) or the
  plan-prescribed pace range.
- **Quality steps (intervals, tempo, threshold, 10K-pace):** use the HR or pace
  range from `protocols/running.md` for that session type. Never leave a "hard
  effort" step open.
- **Recovery jogs between reps:** HR **120–150** (post-rep HR is high and falling —
  let it drift down, do not force it to walk level), or pace 7:30+/km.

If the plan file gives explicit numbers, those win. If not, derive from
`protocols/running.md` HR Zones table and the session's purpose.

### Strength workouts — proper exercises, not notes

Build strength with `mcp__garmin__upload_workout`, never
`mcp__garmin__create_strength_workout` (the latter produces fixed-time blocks
with the exercise name in a description — no reps, no load, untrackable as sets).

**Consult `protocols/strength-exercises.md` first.** Its exercise table holds the
verified `category` / `exerciseName` for each movement (status `✓ <date>`), the
`⚠ not …` enum traps (known silent drops), and the `free-entry` movements — use
those instead of re-guessing an enum. After the read-back verification (step 5),
upgrade the status there (a `⚠ guess` that survived becomes `✓ <date>`, or record a
new trap) so the next upload doesn't repeat the guess.

- Every exercise is its own `RepeatGroupDTO` (`numberOfIterations` = number of
  sets) wrapping an exercise step + a `rest` step. The exercise step uses a
  **reps** end condition (`conditionTypeId: 10`, value = target reps; use the low
  end of a rep range), or a **time** end condition for held movements (planks,
  carries).
- **Use the actual Garmin exercise.** Set `category` and `exerciseName` to real
  Garmin library values (e.g. `CURL` / `DUMBBELL_HAMMER_CURL`, `LATERAL_RAISE` /
  `DUMBBELL_LATERAL_RAISE`, `CRUNCH` / `CABLE_CRUNCH`, `PLANK` / `PLANK`). Add
  `weightValue` + `weightUnit` (`{unitId: 8, unitKey: "kilogram", factor: 1000}`)
  when the plan gives a load.
- **Only fall back to a "free" entry when the movement is genuinely not in
  Garmin's library** (e.g. Pallof press). Then set the closest `category`, leave
  `exerciseName` empty, and put the real movement name in the step `description`.
  That note is the only acceptable place a name lives instead of `exerciseName`.
- Substitutions get their own exercise entry with the correct Garmin name — not
  appended as a note on the movement they replaced.
- Garmin **silently drops** an unrecognised `exerciseName` (keeping the category).
  After upload, read the workout back with `mcp__garmin__get_workout_by_id` and
  confirm each name survived; if one dropped, retry with the correct enum or
  record it as a closest-category + note.
- Loads come from the plan file. If the plan only gives a range or "RPE 7", pick
  a starting load from the last logged session in `protocols/strength-exercises.md`
  § Working Loads and use that as the prescribed load.

# Garmin Sync Split — Implementation Plan

> **For agentic workers:** REQUIRED SUB-SKILL: Use superpowers:subagent-driven-development (recommended) or superpowers:executing-plans to implement this plan task-by-task. Steps use checkbox (`- [ ]`) syntax for tracking.

**Goal:** Decouple Garmin workout upload from `/plan`, add a user-triggered `/garmin` command, and restructure the daily plan file so actionable items are skimmable.

**Architecture:** Five Markdown files — four command/protocol docs and one new command doc. `/plan` becomes an interactive generator that writes a restructured `plans/YYYY-MM-DD.md` and never touches Garmin. `/garmin` is the separate, user-triggered step that uploads and schedules workouts, replacing any existing workout for the date.

**Tech Stack:** Markdown command and protocol files. No code, no test harness. Verification is structural (re-read the file) plus an end-to-end check on next real use.

**Git:** Per the athlete's standing rule, all commits are made by the athlete. Do NOT run git commands while executing this plan. After all tasks are done, summarize the changed files so the athlete can review and commit.

**Spec:** `docs/superpowers/specs/2026-05-22-garmin-sync-split-design.md`

---

### Task 1: Restructure the daily file template

This defines the file shape every later task references. Do it first.

**Files:**
- Modify (full rewrite): `protocols/daily-template.md`

- [ ] **Step 1: Overwrite `protocols/daily-template.md` with the new content**

Replace the entire file with:

````markdown
# DAILY FILE TEMPLATE - MASTER

Every `plans/YYYY-MM-DD.md` follows this structure. Athlete-facing content comes
first; tracking context is fenced below the divider.

## Required structure

```
# YYYY-MM-DD (Day) — <session headline>

## Today
## Checklist
## Workout
## Nutrition
## Log

---

## Context — reference only
```

### `## Today`

Four lines, no more:

- Day type — Rest / Easy / Quality / Long Run / Race
- Readiness call — Green / Modified / Rest
- Calorie target — phase and day-type tier
- Shape of day — one line describing how the day runs

### `## Checklist`

Every must-do as a checkbox, in the order the day needs them. The morning
weigh-in is always the first item. Include: weigh-in, the prescribed session(s),
mobility, the protein and hydration floors, and the nightly sleep-tracking line.
Nothing here should require the reader to look elsewhere to know what to do.

### `## Workout`

Concise session detail.

- Running: distance, HR cap, pace guide, RPE. Note any heat or sleep modification.
- Strength: the exercise table — slot, exercise, sets x reps, rest, load note.
- Rest day: state it in one line.

### `## Nutrition`

A meal table (meal, time, target) and a single targets line for calories,
protein, carbs, and fat. No per-meal prose unless a day genuinely needs it.

### `## Log`

Blanks the athlete fills during the day: workout results, calorie and macro
totals, the hydration check, the sleep-tracking line, and the weigh-in value.

### `## Context — reference only`

Sits below a `---` divider. Holds material not needed to act on the day: the
readiness data snapshot, the rationale for the day's calls, the rest-of-week
table, notes and flags, and any Garmin workout IDs written by `/garmin`.

## Rules

- Nothing above `## Context` may exceed what the athlete needs to act today.
- Standing daily commitments are not reproduced in daily files. They live in
  `protocols/coaching.md` under "Operational Floor". A daily file may reference
  that section but must not copy it.
- On Sundays the `## Context` section also carries the weekly check: ACWR,
  Composite Load, 7-day weight average, body-comp trend, and recovery flags.
````

- [ ] **Step 2: Verify the file**

Read `protocols/daily-template.md` back. Confirm: the six section headings appear
in the Required structure block in order (`## Today`, `## Checklist`, `## Workout`,
`## Nutrition`, `## Log`, `## Context — reference only`); the `---` divider sits
above `## Context`; the Rules section names `protocols/coaching.md`.

---

### Task 2: Move standing boilerplate into `protocols/coaching.md`

**Files:**
- Modify (append a section): `protocols/coaching.md`

- [ ] **Step 1: Append the Operational Floor section**

`protocols/coaching.md` currently ends with the line
`- Critical analysis over motivational filler.` under `## Communication Style`.
Append the following after that line (one blank line before the new heading):

````markdown

## Operational Floor (Standing Daily Commitments)

These are the non-negotiable daily and per-session standards. They are constant,
so daily plan files reference this section instead of reproducing it.

- **Every morning before 09:00:** Withings weigh-in, then `/plan`.
- **Every session:** logged with the metrics the protocol requires. Runs —
  distance, duration, avg HR, max HR, RPE. Lifts — working weight, reps, and RPE
  per exercise.
- **Every day:** food logged in Cronometer, protein floor (>=160 g) hit,
  hydration floor (>=3.5 L) hit, 10-minute mobility done, supplements taken.
- **Every night:** the sleep-tracking line filled — bedtime, wake time, caffeine
  count and last-cup time, alcohol, last meal time, perceived stress, and
  wake-ups with their source.
- **Sunday evening:** `/report` with the full week's data.
````

- [ ] **Step 2: Verify the file**

Read `protocols/coaching.md` back. Confirm the new `## Operational Floor` heading
exists at the end of the file and the five bullets are present.

---

### Task 3: Rewrite `/plan` for the interactive, Garmin-free flow

**Files:**
- Modify (full rewrite): `.claude/commands/plan.md`

- [ ] **Step 1: Overwrite `.claude/commands/plan.md` with the new content**

Replace the entire file with:

````markdown
# Plan - Daily Workout and Nutrition Plan (MASTER)

## Usage

```
/plan
/plan [schedule constraints]
```

## Function

`/plan` produces a reviewable daily plan. It is interactive, and it does not
touch Garmin Connect — uploading workouts is the separate `/garmin` command.

1. Read `protocols/current-status.md`.
2. Determine today's day type from `protocols/training.md`.
3. Look up calories and macros in `protocols/nutrition.md`.
4. Pull fresh Garmin data: training readiness, HRV, Body Battery, resting HR,
   sleep, recent weigh-ins, and recent activities.
5. Check recent daily files for continuity.
6. Apply the sleep/readiness decision tree from `protocols/training.md`, and the
   heat rules from `protocols/running.md` when relevant.
7. Present a key-decisions summary in chat, then stop: readiness verdict, day
   type, prescribed session(s), calorie tier, and any notable flags. Do not write
   the file yet.
8. Wait for the athlete to approve or request edits. Iterate as needed.
9. On approval, write `plans/YYYY-MM-DD.md` using the structure in
   `protocols/daily-template.md`.
10. Tell the athlete the file is written and that `/garmin` will sync the
    workouts to the watch when they are ready.

## Requirements

- Always be phase-aware and day-type-aware.
- Never use a flat calorie number across the week.
- Thursday rule: no running on Thursday; legs on Thursday except Phase 6 weeks 6-8.
- Long runs >90 min require banana + coffee and quality-day calories.
- If sleep was <5 h or Body Battery <30, write a rest-day plan.
- If weather is hot or humid, bias the session toward HR and RPE rather than pace.
- On double days, partition carbs so recovery between the run and PM lift is
  protected.
- Before a trail or long race, include gut-training practice on 2-3 long runs
  over 75 min.
- The `## Checklist` section must include the morning weigh-in and 10-minute
  mobility.
- Compute and include ACWR on Sundays, and Composite Load on Sundays when enough
  session data exists. Both go in the `## Context` section.
- The plan file follows `protocols/daily-template.md`. Standing daily commitments
  are referenced from `protocols/coaching.md`, not copied into the file.
- `/plan` never uploads or schedules anything on Garmin Connect.
````

- [ ] **Step 2: Verify the file**

Read `.claude/commands/plan.md` back. Confirm: the Function section has 10
numbered steps; step 7 presents a summary and stops; step 9 writes the file on
approval; the Requirements section contains the line
`/plan never uploads or schedules anything on Garmin Connect.` and references
`protocols/daily-template.md`.

---

### Task 4: Create the `/garmin` command

**Files:**
- Create: `.claude/commands/garmin.md`

- [ ] **Step 1: Create `.claude/commands/garmin.md` with this content**

````markdown
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

1. Read the plan file for the target date — today's `plans/YYYY-MM-DD.md`, or the
   date passed as an argument.
2. Parse the prescribed session(s) from the `## Workout` section.
3. Replace-on-rerun: look up workouts whose name carries the target date
   (`mcp__garmin__get_workouts` / `mcp__garmin__get_scheduled_workouts`). Delete
   any match with `mcp__garmin__delete_workout` before uploading.
4. For each prescribed session, build and upload the workout:
   - Rest day — create nothing.
   - Strength — `mcp__garmin__create_strength_workout` (name, exercises with
     sets/reps/rest_seconds).
   - Run, walk/run intervals — `mcp__garmin__create_walk_run_workout`.
   - Run, custom structured (HR-target easy run, tempo, threshold reps) —
     `mcp__garmin__upload_workout` with a full DTO.
   - Race day — create a workout only if it helps pacing or HR control.
5. Schedule each uploaded workout for the plan date with
   `mcp__garmin__schedule_workout`.
6. Report the created workouts and their IDs in chat, and write the IDs into the
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
````

- [ ] **Step 2: Verify the file**

Read `.claude/commands/garmin.md` back. Confirm: the Function section has 6
numbered steps; step 3 covers replace-on-rerun; step 6 writes IDs into the
`## Context` section; the Requirements section states the name format and the
"run `/plan` first" guard.

---

### Task 5: Update `AGENTS.md`

**Files:**
- Modify: `AGENTS.md` (Protocol Lookup table row, and the Workflow section)

- [ ] **Step 1: Fix the stale command-docs path in the Protocol Lookup table**

In `AGENTS.md`, find this table row:

```
| Command docs        | `protocols/commands/`           | Versioned `/plan`, `/log`, `/report`, `/body` behavior                     |
```

Replace it with:

```
| Command docs        | `.claude/commands/`             | `/plan`, `/garmin`, `/log`, `/report`, `/body` behavior                    |
```

- [ ] **Step 2: Rewrite the Workflow section**

In `AGENTS.md`, find the `## Workflow` section. It currently reads:

```
## Workflow

1. Morning: `/plan` writes `plans/YYYY-MM-DD.md` **and** uploads the day's prescribed sessions to Garmin Connect, then schedules them on the calendar for that date.
   - Strength: `mcp__garmin__create_strength_workout` (name, exercises with sets/reps/rest_seconds)
   - Run (intervals/walk-run): `mcp__garmin__create_walk_run_workout`
   - Run (custom structured — e.g. HR-target easy run, tempo, threshold reps with bpm ranges): `mcp__garmin__upload_workout` with full DTO JSON
   - All uploads are followed by `mcp__garmin__schedule_workout(workout_id, YYYY-MM-DD)` for the plan date
   - Rest days create nothing. Race days create a workout only if helpful for pacing/HR cap
   - Workout name format: `<SessionType> — <Phase/Week> (<YYYY-MM-DD>)`
2. After training: `/log [details]`
3. After meals: `/log meal [details]`
4. Weekly: `/report` updates the active current-status file
5. As needed: `/body` syncs scale data and target deltas
```

Replace that whole section with:

```
## Workflow

1. Morning: `/plan` generates `plans/YYYY-MM-DD.md`. It is interactive — it pulls data, presents the key decisions for review, and writes the file on approval. `/plan` does not touch Garmin.
2. After reviewing the plan: `/garmin` uploads the day's prescribed workouts to Garmin Connect and schedules them for the plan date.
   - Strength: `mcp__garmin__create_strength_workout` (name, exercises with sets/reps/rest_seconds)
   - Run (intervals/walk-run): `mcp__garmin__create_walk_run_workout`
   - Run (custom structured — e.g. HR-target easy run, tempo, threshold reps with bpm ranges): `mcp__garmin__upload_workout` with full DTO JSON
   - Each upload is followed by `mcp__garmin__schedule_workout(workout_id, YYYY-MM-DD)` for the plan date
   - On a re-run, any existing workout carrying that date is deleted and replaced
   - Rest days create nothing. Race days create a workout only if helpful for pacing/HR cap
   - Workout name format: `<SessionType> — <Phase/Week> (<YYYY-MM-DD>)`
3. After training: `/log [details]`
4. After meals: `/log meal [details]`
5. Weekly: `/report` updates the active current-status file
6. As needed: `/body` syncs scale data and target deltas
```

- [ ] **Step 3: Verify the file**

Read `AGENTS.md` back. Confirm: the Protocol Lookup table points command docs to
`.claude/commands/` and lists `/garmin`; the Workflow section has 6 numbered
steps; step 1 says `/plan` does not touch Garmin; step 2 is `/garmin`; no
remaining text claims `/plan` uploads to Garmin.

---

## Final Verification

After all five tasks, run this checklist:

- [ ] `protocols/daily-template.md`, `protocols/coaching.md`,
  `.claude/commands/plan.md`, `.claude/commands/garmin.md`, and `AGENTS.md` all
  reflect their task content.
- [ ] No file still states or implies that `/plan` uploads to Garmin.
- [ ] End-to-end (on next real use): run `/plan` — confirm it pulls data, shows a
  key-decisions summary, pauses for approval, and writes a file in the new
  structure with the weigh-in visible near the top.
- [ ] End-to-end (on next real use): run `/garmin` — confirm the prescribed
  workout(s) upload and schedule, IDs land in `## Context`; re-running replaces
  rather than duplicates.

## Handoff

Summarize the five changed/created files for the athlete to review and commit.
Do not run git commands.

## Spec Coverage Check

- Goal 1 (`/plan` writes file only) — Task 3.
- Goal 2 (`/plan` interactive) — Task 3, Function steps 7-9.
- Goal 3 (`/garmin` command) — Task 4.
- Goal 4 (restructured plan file) — Task 1, with boilerplate relocation in Task 2.
- Doc updates — Task 5 (AGENTS.md), Tasks 1-4 (the command/protocol files).

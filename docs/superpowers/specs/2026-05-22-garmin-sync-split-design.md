# Design: Decouple Garmin sync from `/plan`, add `/garmin`, restructure the daily plan file

Date: 2026-05-22
Status: Approved (pending spec review)

## Problem

`/plan` currently does two unrelated jobs in one pass. It generates the daily plan
file, and — per the `AGENTS.md` Workflow section — it also uploads and schedules
workouts on Garmin Connect. Coupling an irreversible external write to artifact
generation means the plan cannot be reviewed or adjusted before Garmin is touched.

Separately, the daily plan file has grown long enough that load-bearing items get
missed. On the 2026-05-21 plan, the morning weigh-in task sat at line 222; an item
that important should not require scrolling to find.

## Goals

1. `/plan` produces a reviewable plan file only. It never touches Garmin.
2. `/plan` is interactive: it presents the key decisions, waits for the athlete's
   approval or edits, and only then writes the file.
3. A new, user-triggered `/garmin` command uploads and schedules the day's
   prescribed workouts.
4. The daily plan file is restructured so the day's shape, the must-do items, and
   the tasks are immediately visible, with supporting context fenced off below.

## Non-goals

- Retro-converting existing `plans/*.md` files. The new format applies going forward.
- Changes to `/log`, `/report`, or `/body`.
- An automated test suite. Verification is manual (see Verification).

## Design

### 1. Daily plan file structure

`plans/YYYY-MM-DD.md` keeps being a single file, with a fixed, athlete-first
section order:

```
# YYYY-MM-DD (Day) — <session headline>

## Today          day type · readiness call · calorie target · one-line shape of day
## Checklist      every must-do as a checkbox; morning weigh-in is the first item
## Workout        concise session detail — run metrics, or the strength set/rep/rest table
## Nutrition      concise meal table + a single targets line
## Log            blanks filled during the day — workout results, calorie totals, sleep line

---

## Context — reference only
                  readiness data snapshot, rationale for the day's calls,
                  rest-of-week table, notes and flags
```

Rules:

- Nothing above `## Context` may exceed what the athlete needs in order to act.
- The `---` divider and the "reference only" header are the required fence between
  actionable content and tracking context.
- Standing boilerplate is removed from daily files. The "by-the-book operational
  floor" block currently copied verbatim into each file (weigh in every morning,
  log every session, protein floor, nightly sleep-tracking line, etc.) is moved
  once into `protocols/coaching.md` and referenced, not reproduced.

`protocols/daily-template.md` is rewritten to define this structure.

### 2. `/plan` — interactive

New flow for `.claude/commands/plan.md`:

1. Read `protocols/current-status.md` and the relevant protocol files.
2. Pull fresh Garmin data: readiness/HRV/Body Battery/RHR/sleep, recent
   weigh-ins, recent activities.
3. Determine day type, readiness call, calorie tier, and the prescribed
   session(s), applying the sleep/readiness and heat decision trees.
4. Present a **key-decisions summary** in chat — readiness verdict, day type,
   prescribed session(s), calorie tier, and any notable flags — then stop.
   The plan file is not written yet.
5. Wait for the athlete to approve or request edits. Iterate as needed.
6. On approval, write `plans/YYYY-MM-DD.md` in the structure from section 1.

`/plan` never uploads to Garmin. After writing the file it tells the athlete to
run `/garmin` when ready to sync workouts to the watch.

### 3. `/garmin` — new command

New file `.claude/commands/garmin.md`. User-triggered only.

Flow:

1. Read today's `plans/YYYY-MM-DD.md` (or a date passed as an argument).
2. Parse the prescribed session(s) from the `## Workout` section.
3. For each session, build the matching Garmin workout:
   - Rest day — create nothing.
   - Strength — `mcp__garmin__create_strength_workout` (name, exercises with
     sets/reps/rest_seconds).
   - Run, walk/run intervals — `mcp__garmin__create_walk_run_workout`.
   - Run, custom structured (HR-target easy run, tempo, threshold reps) —
     `mcp__garmin__upload_workout` with a full DTO.
   - Race day — create a workout only if it helps pacing/HR control.
4. Replace-on-rerun: before uploading, look up workouts whose name carries
   today's date; if any are found, delete them. This keeps re-syncs after a plan
   edit from leaving duplicates.
5. Upload each workout and `schedule_workout` it for the plan date.
6. Report the created workouts and their IDs in chat, and write those IDs into
   the plan file's `## Context` section for traceability.

Workout name convention is unchanged: `<SessionType> — <Phase/Week> (<YYYY-MM-DD>)`.
The trailing `(YYYY-MM-DD)` is what makes replace detection reliable.

### 4. Documentation updates

- `AGENTS.md` Workflow section: step 1 becomes `/plan` (interactive, writes the
  file only); a new step covers `/garmin` (uploads and schedules workouts). The
  stale `protocols/commands/` reference in the Protocol Lookup table is corrected
  to `.claude/commands/`, where the command files actually live.
- `.claude/commands/plan.md` is rewritten for the interactive flow.
- `protocols/daily-template.md` is rewritten for the new file structure.
- `protocols/coaching.md` gains the standing operational-floor rules, once.

## Files

| Action | Path |
| ------ | ---- |
| Create | `.claude/commands/garmin.md` |
| Modify | `.claude/commands/plan.md` |
| Modify | `protocols/daily-template.md` |
| Modify | `protocols/coaching.md` |
| Modify | `AGENTS.md` |

Existing `plans/*.md` files are left as-is.

## Verification

Manual, since commands are prompt files with no test harness:

1. Run `/plan` for the current date. Confirm it pulls data, presents a
   key-decisions summary, pauses for approval, and only writes the file after
   approval. Confirm the written file follows the new structure and that the
   morning weigh-in is visible without scrolling.
2. Run `/garmin`. Confirm the prescribed workout(s) are created and scheduled,
   and the IDs are written into the plan's Context section.
3. Edit the plan's Workout section, run `/garmin` again. Confirm the prior
   workout for that date is replaced, not duplicated.
4. Confirm `/plan` performs no Garmin writes.

## Notes

- The design document is written but not committed; per the athlete's standing
  rule, git actions are performed by the athlete.

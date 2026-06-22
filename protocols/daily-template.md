# DAILY FILE TEMPLATE - MASTER

Every `logbook/YYYY-MM/YYYY-MM-DD.md` follows this structure. It is a coach's
journal entry, not a worksheet: the athlete reads the plan above the divider, and
the coach records what happened below it. The athlete never writes to the file —
`/plan` and `/log` populate it — so there are no checkboxes and no fill-in blanks.

## Required structure

```
# YYYY-MM-DD (Day) — <session headline>

## Today
## Workout
## Nutrition

---

## Actuals
## Context — reference only
```

### `## Today`

Four lines, no more:

- Day type — Rest / Easy / Quality / Long Run / Race
- Readiness call — Green / Modified / Rest
- Calorie target — phase and day-type tier
- Shape of day — one line describing how the day runs

### `## Workout`

Concise session detail.

- Running: distance, HR cap, pace guide, RPE. Note any heat or sleep modification.
- Strength: the exercise table — slot, exercise, sets x reps, rest, load note.
- Rest day: state it in one line, plus the standing incline-walk NEAT block
  (`training.md` § Rest-Day NEAT) unless recovery is depleted.

### `## Nutrition`

A meal table (meal, time, target, macros) and a single targets line for
calories, protein, carbs, and fat. No per-meal prose unless a day genuinely
needs it.

### `## Actuals`

Coach-written through `/log` after the day runs — a record of what actually
happened, never a worksheet. No checkboxes, no `___` blanks: write only lines
that carry real content, and omit any category with nothing to record. A day
executed exactly to plan collapses to a single line (e.g. "Executed to plan; run
per Garmin `<id>`").

Record, when present:

- Run — distance, pace, average and max HR, RPE (from Garmin), plus any sleep,
  heat, or pain modification.
- Strength — per-exercise working load, reps, and RPE. This is the capture point
  `/report` promotes into `strength-exercises.md`.
- Meals — actuals and modifications against the plan, the running calorie and
  macro total versus the day-type target, and an underfueling flag on quality or
  long-run days when intake drifts low.
- End-of-day data the coach pulls because it informs coaching — daily steps for
  the NEAT and expenditure read, a newer weigh-in if Garmin returned one, and
  that-night sleep only when notable.
- Subjective notes — how the session felt, any pain.

Skin is tracked weekly, not daily — acne evolves on a multi-week cycle, so daily
scoring is noise. The weekly skin assessment lives in `protocols/skin-log.md` and
is captured by `/report`, not in daily files.

### `## Context — reference only`

Sits below the `---` divider. Holds material not needed to act on the day: the
readiness data snapshot, the rationale for the day's calls, the streak counts,
the trailing-7-day load ledger, the rest-of-week table, notes and flags, and any
Garmin workout IDs written by `/garmin`.

## Rules

- Nothing above `## Context` may exceed what the athlete needs to act today.
- The athlete never writes to the daily file. `/plan` writes the plan zone and
  `## Context`; `/log` writes `## Actuals`. No checkboxes, no `___` blanks anywhere.
- Standing daily commitments are not reproduced in daily files. They live in
  `protocols/coaching.md` under "Operational Floor". A daily file may reference
  that section but must not copy it.
- On Sundays the `## Context` section also carries the weekly check: ACWR,
  Composite Load, 7-day weight average, body-comp trend, and recovery flags.

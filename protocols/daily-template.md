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

Skin is tracked weekly, not daily — acne evolves on a multi-week cycle, so daily
scoring is noise. The weekly skin assessment lives in `protocols/skin-log.md` and
is captured by `/report`, not in daily files.

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

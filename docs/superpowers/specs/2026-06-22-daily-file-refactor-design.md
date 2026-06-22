# Daily File Refactor — Read/Record Journal

**Date:** 2026-06-22
**Status:** Approved design, pending implementation plan

## Problem

The daily file (`logbook/YYYY-MM/YYYY-MM-DD.md`) carries dead weight. The same
standing commitments appear in three places — `coaching.md` § Operational Floor,
the `## Checklist` section, and the `## Log` fill-in blanks — and several of those
fields duplicate data the athlete already tracks on Garmin (steps, sleep,
weigh-in, heart rate).

Evidence from the live files confirms the redundancy is structural, not cosmetic.
In both 2026-06-21 and 2026-06-22, the `### Hydration`, `### Sleep behaviors`,
`### Sleep tracking`, daily-steps, and weigh-in fields were left blank. The only
`## Log` sub-sections that carried real content were Movement (especially
manually logged strength loads) and Meals (actuals and modifications).

The root cause: the file was built around checkboxes and `___` blanks — fill-in
affordances for an athlete who never fills them. The athlete only **reads** the
file. He never writes to it; the coach populates everything through `/plan` and
`/log`. The file's real value is as a durable **record** — a snapshot of the day
that survives after the live `/plan` chat output is gone.

## Decision

Reframe the daily file from a worksheet into a coach's journal entry with a clean
two-zone split: an athlete-facing plan the athlete reads, and a coach-written
record below the divider. Delete every checkbox and `___` blank.

## New Structure

```
# YYYY-MM-DD (Day) — <session headline>

## Today          (athlete reads)
## Workout        (athlete reads)
## Nutrition      (athlete reads)

---

## Actuals        (coach record, written by /log)
## Context — reference only
```

### `## Today`

Unchanged. Four lines: day type, readiness call, calorie target, shape of day.

### `## Workout`

Unchanged content rules. Running: distance, HR cap, pace guide, RPE, plus any
heat or sleep modification. Strength: the exercise table. Rest day: one line plus
the standing Rest-Day NEAT incline-walk block (`training.md` § Rest-Day NEAT)
unless recovery is depleted. The rest-day NEAT block now appears **only here**,
not duplicated in a checklist.

### `## Nutrition`

Unchanged. A meal table (meal, time, target, macros) and a single targets line
for calories, protein, carbs, and fat.

### `## Actuals` (replaces `## Log`)

Coach-written through `/log`. This is a record of what actually happened, never a
worksheet.

Rules:

- No checkboxes, no `___` blanks. Write only lines that carry real content; omit
  any category that has nothing to record.
- Capture, when present:
  - **Run** — distance, pace, average and max HR, RPE (from Garmin), plus any
    modification driven by sleep, heat, or pain.
  - **Strength** — per-exercise working load, reps, and RPE. This is the capture
    point that `/report` promotes into `strength-exercises.md`, so it is
    load-bearing and cannot be delegated to Garmin.
  - **Meals** — actuals and modifications against the plan, the running
    calorie and macro total versus the day-type target, and an underfueling flag
    on quality or long-run days when intake drifts low.
  - **End-of-day data the coach pulls because it informs coaching** — daily steps
    for the NEAT and expenditure read, a newer weigh-in if Garmin returned one,
    and that-night sleep only when it is notable.
  - **Subjective notes** — how the session felt, any pain.
- A day executed exactly to plan collapses to a single line (for example,
  "Executed to plan; run per Garmin `<id>`") rather than a scaffold of empty
  fields.

### `## Context — reference only`

Unchanged. Sits below the `---` divider. Holds the readiness data snapshot, the
rationale for the day's calls, the streak counts, the trailing-7-day load ledger,
the week-ahead table, notes, flags, and any Garmin workout IDs written by
`/garmin`. On Sundays it also carries the weekly check: ACWR, Composite Load,
7-day weight average, body-comp trend, and recovery flags.

## Deleted

- `## Checklist` — its items are either standing-floor commitments (which live in
  `coaching.md`) or data Garmin already captures.
- `### Hydration`, `### Sleep behaviors`, `### Sleep tracking` — never filled;
  the relevant sleep numbers already appear in the next-day readiness snapshot.
- All checkboxes and `___` placeholder blanks throughout the file.

## What Stays Where

Standing daily commitments — the protein floor, hydration floor, ~8–10k steps,
10-minute mobility, and supplements — remain in `coaching.md` § Operational Floor
as the single canonical home. They are no longer reproduced per-day. The
~8–10k-step target stays a real standing commitment (it is the cut's primary
deficit lever); the daily file simply stops listing it as a to-do, and the coach
instead pulls actual steps when assessing expenditure.

## Cross-File Edits

1. **`protocols/daily-template.md`** — rewrite to the new structure above.
2. **`.claude/commands/plan.md`** — remove the Checklist requirements: the rule
   requiring the weigh-in, mobility, and daily-steps target in `## Checklist`,
   and the rest-day NEAT instruction to place the block "in both the `## Workout`
   and `## Checklist` sections" (now `## Workout` only). Steps stop being a
   prescribed checklist item. Update the step-9 file-write reference to point at
   the new structure.
3. **`protocols/coaching.md` § Operational Floor** — keep the standing
   commitments as-is, except change the "Every night: the sleep-tracking line
   filled" item to reflect that sleep is captured by Garmin and reviewed by the
   coach, not hand-filled in the daily file.
4. **`.claude/commands/log.md`** — rename the target section from `## Log` to
   `## Actuals`, state the no-checkbox / no-blank convention, and treat steps as a
   pulled coaching input rather than a logged checkbox.

## Out of Scope

- **Existing daily files** are left untouched as historical records. Only files
  written from this change forward use the new structure.
- No change to `/garmin`, `/report`, `/body`, `nutrition.md`, `training.md`,
  `running.md`, or `strength-exercises.md` content beyond what is listed above.
```
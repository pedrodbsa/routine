# Daily File Refactor Implementation Plan

> **For agentic workers:** REQUIRED SUB-SKILL: Use superpowers:subagent-driven-development (recommended) or superpowers:executing-plans to implement this plan task-by-task. Steps use checkbox (`- [ ]`) syntax for tracking.

**Goal:** Reframe the daily file from a checkbox worksheet into a coach's read/record journal, and update the three command/protocol files that reference the deleted sections.

**Architecture:** A documentation-only refactor across four Markdown files. `daily-template.md` is rewritten to the new two-zone structure (athlete-facing plan above a `---` divider, coach-written record below). `plan.md`, `coaching.md`, and `log.md` are edited to stop referencing the deleted `## Checklist` and sleep fill-in sections.

**Tech Stack:** Markdown. No code, no test runner. Each task is verified with `Grep` (deleted section names must not survive in live files) and a read-back.

## Global Constraints

- Source of truth for the design is `docs/superpowers/specs/2026-06-22-daily-file-refactor-design.md`. Do not deviate from it.
- Existing `logbook/**/*.md` files are OUT OF SCOPE — leave them untouched. They will still contain the legacy sections; that is expected.
- Verification greps must be scoped to `protocols/` and `.claude/commands/` (never `logbook/`).
- No checkboxes and no `___` fill-in blanks anywhere in the new daily-file structure.
- Standing daily commitments (protein floor, hydration floor, ~8–10k steps, mobility, supplements) stay canonical in `coaching.md` § Operational Floor and are not reproduced per-day.
- Prose mode applies to all file content (proper English, full sentences). Git commits are allowed in this repo.

---

### Task 1: Rewrite `protocols/daily-template.md`

**Files:**
- Modify (full rewrite): `protocols/daily-template.md`

**Interfaces:**
- Consumes: nothing (first task).
- Produces: the canonical section list every other file references — `## Today`, `## Workout`, `## Nutrition`, `---`, `## Actuals`, `## Context — reference only`. Downstream tasks rely on the exact heading `## Actuals` (replacing `## Log`) and on the absence of `## Checklist`, `### Hydration`, `### Sleep behaviors`, `### Sleep tracking`.

- [ ] **Step 1: Overwrite the file with the new structure**

Write `protocols/daily-template.md` with exactly this content:

````markdown
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

A meal table (meal, time, target) and a single targets line for calories,
protein, carbs, and fat. No per-meal prose unless a day genuinely needs it.

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
````

- [ ] **Step 2: Verify the deleted sections are gone and the new heading is present**

Use Grep on `protocols/daily-template.md`:
- Pattern `## Checklist|### Hydration|### Sleep behaviors|### Sleep tracking|## Log` → Expected: **no matches**.
- Pattern `## Actuals` → Expected: **match** (the heading and its reference in Rules).

- [ ] **Step 3: Commit**

```bash
git add protocols/daily-template.md
git commit -m "Rewrite daily template as read/record journal

Replaces the checkbox/blank worksheet structure with a two-zone journal:
athlete-facing plan above the divider, coach-written Actuals and Context
below. Deletes Checklist, Hydration, Sleep behaviors, and Sleep tracking.

Co-Authored-By: Claude Opus 4.8 <noreply@anthropic.com>"
```

---

### Task 2: Trim Checklist requirements from `.claude/commands/plan.md`

**Files:**
- Modify: `.claude/commands/plan.md`

**Interfaces:**
- Consumes: the new template from Task 1 (the file no longer has a `## Checklist`).
- Produces: a `/plan` spec with no instruction to emit a `## Checklist` section. Step 9's write instruction already defers to `protocols/daily-template.md` generically and needs no edit.

- [ ] **Step 1: Fix the rest-day NEAT placement**

In `.claude/commands/plan.md`, find this passage (around lines 67-70):

```
- Rest-day plans include the standing **Rest-Day NEAT incline-walk block**
  (`training.md` § Rest-Day NEAT — incline 8% / 5.0 km/h / 40 min / HR ≤125,
  fasted first thing) in both the `## Workout` and `## Checklist` sections —
  unless recovery is genuinely depleted (Body Battery <30 at wake or sleep <5 h),
  in which case it is full rest and the walk is dropped.
```

Change `in both the `## Workout` and `## Checklist` sections` to `in the `## Workout` section`. The rest of the bullet is unchanged.

- [ ] **Step 2: Remove the Checklist-contents requirement**

Find and delete this entire bullet (around lines 90-92):

```
- The `## Checklist` section must include the morning weigh-in, 10-minute
  mobility, and the **daily steps target (~8-10k, the cut's primary NEAT deficit
  lever, 2026-06-18)**.
```

Delete the whole bullet. The weigh-in, mobility, and steps target remain standing commitments in `coaching.md` § Operational Floor (Task 3 leaves them in place); they are no longer a per-day checklist item.

- [ ] **Step 3: Verify no `## Checklist` reference survives in the file**

Use Grep on `.claude/commands/plan.md`:
- Pattern `Checklist` → Expected: **no matches**.

- [ ] **Step 4: Commit**

```bash
git add .claude/commands/plan.md
git commit -m "Drop Checklist requirements from /plan command

The daily template no longer has a Checklist section; rest-day NEAT now
lives only in Workout, and the weigh-in/mobility/steps items remain
standing commitments in coaching.md rather than a per-day checklist.

Co-Authored-By: Claude Opus 4.8 <noreply@anthropic.com>"
```

---

### Task 3: Adjust the sleep item in `protocols/coaching.md` § Operational Floor

**Files:**
- Modify: `protocols/coaching.md`

**Interfaces:**
- Consumes: nothing from earlier tasks.
- Produces: an Operational Floor whose nightly item no longer asks for a hand-filled sleep-tracking line. All other standing commitments (protein, hydration, ~8–10k steps, mobility, supplements) are left exactly as-is.

- [ ] **Step 1: Replace the nightly sleep-tracking item**

In `protocols/coaching.md` § Operational Floor, find this item (around lines 43-45):

```
- **Every night:** the sleep-tracking line filled — bedtime, wake time, caffeine
  count and last-cup time, alcohol, last meal time, perceived stress, and
  wake-ups with their source.
```

Replace it with:

```
- **Every night:** sleep is captured by Garmin and reviewed by the coach the next
  morning (it feeds the readiness call) — not hand-logged in the daily file.
```

Do not touch the other Operational Floor bullets.

- [ ] **Step 2: Verify the old fill-in wording is gone**

Use Grep on `protocols/coaching.md`:
- Pattern `sleep-tracking line filled` → Expected: **no matches**.
- Pattern `daily steps ~8-10k` → Expected: **match** (the steps commitment is still present in the floor).

- [ ] **Step 3: Commit**

```bash
git add protocols/coaching.md
git commit -m "Update Operational Floor: sleep is Garmin-captured, not hand-logged

The nightly sleep-tracking line is deleted from the daily file, so the
standing commitment changes to reviewing Garmin sleep rather than filling
a line. Other floor commitments are unchanged.

Co-Authored-By: Claude Opus 4.8 <noreply@anthropic.com>"
```

---

### Task 4: Align `.claude/commands/log.md` with the Actuals section

**Files:**
- Modify: `.claude/commands/log.md`

**Interfaces:**
- Consumes: the `## Actuals` heading from Task 1.
- Produces: a `/log` spec that writes coach-side records into `## Actuals` (or `## Context` notes), with the no-checkbox/no-blank convention stated, and steps treated as a pulled input.

- [ ] **Step 1: Add a Conventions note to the Function section**

In `.claude/commands/log.md`, find the `## Function` block:

```
## Function

1. Find today's daily file
2. Auto-detect the entry type
3. Update the correct section
4. Apply type-specific logic
```

Replace it with:

```
## Function

1. Find today's daily file
2. Auto-detect the entry type
3. Update the correct section — workout, meal, and body actuals go in
   `## Actuals`; notes go in `## Context` (Notes / flags)
4. Apply type-specific logic

`/log` writes coach-side records, never a worksheet: no checkboxes and no `___`
blanks. Write only lines that carry real content, and omit any category with
nothing to record (see `protocols/daily-template.md` § `## Actuals`).
```

- [ ] **Step 2: Note steps as a pulled input under the Workout type**

Find the `### Workout` type block:

```
### Workout

- Parse lifting or running entries
- Prefer Garmin data over manual estimates for runs
- Record if the session was modified by sleep, pain, or heat
```

Replace it with:

```
### Workout

- Parse lifting or running entries
- Prefer Garmin data over manual estimates for runs
- Record if the session was modified by sleep, pain, or heat
- Pull daily steps from Garmin when assessing NEAT / expenditure, and record the
  figure in `## Actuals` — steps are a coaching input, not a checklist item
```

- [ ] **Step 3: Verify the Actuals reference and convention are present**

Use Grep on `.claude/commands/log.md`:
- Pattern `## Actuals` → Expected: **match**.
- Pattern `no `___`|no checkboxes` → Expected: **match**.

- [ ] **Step 4: Commit**

```bash
git add .claude/commands/log.md
git commit -m "Point /log at the Actuals section, drop worksheet conventions

States that workout/meal/body actuals go in Actuals and notes in Context,
adds the no-checkbox/no-blank convention, and treats daily steps as a
pulled coaching input rather than a logged checklist item.

Co-Authored-By: Claude Opus 4.8 <noreply@anthropic.com>"
```

---

### Task 5: Repo-wide cross-reference check

**Files:**
- None modified — verification only.

**Interfaces:**
- Consumes: all prior tasks.
- Produces: confirmation that no live protocol/command file references a deleted section.

- [ ] **Step 1: Confirm deleted sections survive only in historical logbook files**

Use Grep across `protocols/` and `.claude/commands/` (NOT `logbook/`):
- Pattern `## Checklist|### Sleep behaviors|### Sleep tracking|sleep-tracking line filled` → Expected: **no matches** in `protocols/` or `.claude/commands/`.

If any match appears in those directories, fix it in the owning file and amend that file's commit (or add a follow-up commit). Matches inside `logbook/` are expected and must be left alone.

- [ ] **Step 2: Confirm AGENTS.md and other protocol files don't reference the old structure**

Use Grep on `AGENTS.md` and `protocols/`:
- Pattern `## Log\b` → Expected: no matches that refer to the daily-file section (a coaching-log mention is fine; judge in context).

No commit if there are no matches; this task is a gate, not an edit.

---

## Self-Review

**Spec coverage:**
- Rewrite `daily-template.md` → Task 1. ✓
- Trim `plan.md` Checklist requirements (both the rest-day NEAT placement and the Checklist-contents bullet) → Task 2. ✓
- Adjust `coaching.md` § Operational Floor sleep item → Task 3. ✓
- Rename `## Log` → `## Actuals` + conventions in `log.md` → Task 4. ✓
- Steps as a pulled input → Task 4, Step 2. ✓
- Old daily files untouched → Global Constraints; greps scoped away from `logbook/`. ✓
- Repo-wide integrity → Task 5. ✓

**Placeholder scan:** No TBD/TODO; all file content is given verbatim. The `<id>` and `<session headline>` tokens are intentional template placeholders, not plan gaps.

**Type consistency:** The heading `## Actuals` is used identically in Tasks 1, 4, and the verification greps. Deleted-section names (`## Checklist`, `### Hydration`, `### Sleep behaviors`, `### Sleep tracking`, `## Log`) are spelled identically everywhere they are matched.

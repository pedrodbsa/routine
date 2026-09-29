---
model: best
effort: high
# Sets goals every later command inherits. Pin covers the opening turn only; set the session model to match for the rest (/model).
---
# Consult - Full Goals & Protocol Redefinition (MASTER)

## Usage

```
/consult
/consult [focus, e.g. "nutrition only" or "race goals"]
```

## Purpose

`/consult` is the sit-down review in which the athlete and coach redefine the
stack's direction together: objectives, goals, phase timeline, race targets,
nutrition targets, training structure, adherence targets and monitoring. It is the
only command whose job is to **change the goals themselves**. `/report` measures
progress against the goals, `/audit` hunts for false assumptions in the rules, and
`/consult` decides what the goals and rules should be.

Run it when the athlete asks for one, when the goals no longer match reality (for
example, a target that is arithmetically unreachable or a phase built on a premise
that has broken), or roughly once per training block. It is interactive from start
to finish. **Nothing is written to the protocol files until the athlete has
approved the decisions in step 5.**

With a focus argument, run the same steps restricted to the named domains. Still
check that the decisions stay consistent with the domains you did not reopen.

## Steps

### 1. Load context (silent — do not narrate)

1. Read `memory/MEMORY.md` and every memory it links that touches goals,
   nutrition, training structure or preferences. These record corrections the
   athlete has already made, so do not re-propose anything they have rejected.
2. Read `protocols/current-status.md` in full, including the coaching log, which is
   the supersession record. Then read `nutrition.md`, `running.md`, `training.md`
   and `strength-exercises.md`, plus the latest `logbook/YYYY-MM/report.md` and
   any open proposals it carries.
3. Get the actual local date and time, because the phase arithmetic depends on it.

### 2. Pull the evidence (live Garmin MCP; direct-pull fallback per memory)

Cover **at least the last 8 weeks**, and the whole current phase if it is longer:

- Weekly running km, quality sessions delivered and long runs, with ACWR over the
  four preceding weeks
- Strength sessions and their logged loads, plus days since the last loaded
  session of each type
- Fasted-morning weigh-ins (classify every timestamp; post-run readings never
  enter the trend) and body water in kg
- Weekly HRV status, resting HR, sleep duration, sleep onset and sleep score
- Race prediction, the VO2max trend and fitness age
- Threshold and quality-session pace at HR from the splits, because the prediction
  can disagree with the sessions (see `logbook/2026-09/report.md`)
- Weekly average steps (context only)

Compute the **delivery rates** as well as the averages: what fraction of planned
runs, qualities, strength sessions and weigh-ins actually happened. Goals get
redesigned around what the athlete delivers, not around what the plan assumed.

### 3. Present the state brief

Open the consult with a short brief of about one screen, in plain prose with one
table at most:

- **Where the athlete stands** on each live goal: measured value, target, gap, and
  the rate needed against the rate being delivered.
- **What is working and what is not**, with numbers. Name reached, missed and
  unreachable targets plainly.
- **The open decisions already on file**, such as pending proposals in the latest
  report or unconfirmed coaching-log items.
- **Hard constraints that no decision can change**: lab anchors, race dates the
  athlete has entered, medication and injury status.

End the brief with the list of domains the consult will walk through, and let the
athlete reorder or drop any of them.

### 4. Walk the domains, one at a time

For each domain, present the evidence that bears on it, then **two or three
concrete options with their trade-offs** and a recommendation. Then ask. Keep to
**at most three to four questions per turn**, never a wall of questions. Where a
proper decision UI is available (`AskUserQuestion`), use it for option choices.

Default order, since each domain constrains the next:

1. **Objectives and priority order.** What matters most over the next 3–6 months:
   the A-race, body composition, strength or health, and how they rank against each
   other.
2. **Life capacity and motivation.** Sessions per week the athlete can *reliably*
   deliver, time per session, the protected days, and what is driving or draining
   motivation. **Ask what the constraint is, not what caused it.** The athlete may
   keep the cause private, and that is fine. What the plan needs is its effect:
   fewer sessions, shorter sessions, a quieter period, or a date when it ends.
3. **Race goals.** The target time for each race, the role of each race (A, B or
   training effort), and the checkpoint at which each target gets confirmed or
   re-anchored. Tie every time target to the session evidence, not only to the
   Garmin prediction.
4. **Body-composition goals.** The target weight or BF% (Bod Pod-anchored), the
   date, and the rate required. **Do the arithmetic in front of the athlete**: the
   weekly rate, the implied daily deficit, and whether that rate is compatible with
   the race block. Reject any target that needs more than ~0.5 kg/wk, or ~0.7% of
   bodyweight per week, while protecting lean mass.
5. **Phase timeline.** The phase boundaries, cut and maintenance windows, and
   taper, derived from domains 1–4 rather than inherited from the current table.
6. **Nutrition targets.** Maintenance estimate (re-derived from the weight trend
   against intake if the data allows, otherwise stated as an estimate), calories
   per day type, protein and fat floors, meal count and structure, and
   supplements. **Every tier's macros must sum to its calories.** Carbs are
   derived from the tier as (kcal − 4·P − 9·F) ÷ 4.
7. **Training structure.** Volume band, the number of qualities, long-run length,
   strength frequency and split, and what gets dropped first when a week is
   compromised. Size the structure to the delivery rates from step 2, not to the
   ideal week.
8. **Adherence targets and monitoring.** Which weekly non-negotiables to keep, and
   what each checkpoint decides. Every checkpoint needs **a minimum n, a
   no-data default that costs nothing, and an effect larger than its measurement
   noise** (`memory/feedback-checkpoint-must-be-able-to-decide.md`).
9. **Workflow.** How days get recorded when `/plan` is not run. Silent stretches
   are the stack's recurring failure mode (Aug 24–30, Sep 12–27), so agree a
   minimum-record habit the athlete will actually keep.

Coaching standards throughout: push back when an option is unrealistic, name the
cost of every choice, and do not soften arithmetic. Separate **measured fact**,
**assumption** and **preference**. A preference is the athlete's call, and a
physiology claim has to be verified, not recalled.

### 5. Confirm the decision sheet

Before editing anything, present one consolidated **decision sheet** that lists
every decision with its new value, the old value it replaces, and a one-line
rationale. Mark anything the athlete deferred as **OPEN**, with an owner and a
date. Ask for explicit approval, and apply only what is approved.

### 6. Write it everywhere, in the same session

Per `memory/feedback-record-decisions-same-session.md`, a decision that exists only
in conversation is a defect.

1. Write the consult record to `logbook/YYYY-MM/consult-YYYY-MM-DD.md`: the state
   brief, the decision sheet, the rejected alternatives with the reason for each,
   and the open items.
2. Propagate every approved decision to each file that holds that value.
   Single-source files govern: loads in `strength-exercises.md`, calorie tiers in
   `nutrition.md`, HR anchors from the lab section of `current-status.md`. Update
   `current-status.md` (goals, phase table, race table, targets, binding list and
   adherence table), `nutrition.md`, `running.md`, `training.md`,
   `meal-rotation.md` if the portions change, `AGENTS.md` (Purpose and Coaching
   Primer) if the objectives change, and any command doc that restates a changed
   value. Every approved date (race, phase boundary, checkpoint, athlete-owned
   deadline) also goes into `calendar.md`, which owns the dates.
3. Add one coaching-log row per decision cluster to `current-status.md`, pointing
   to the consult record.
4. Move superseded material to `protocols/archive/` and leave a pointer behind.
   `current-status.md` stays operational-only.
5. Save any new standing preference the athlete expressed as a memory under
   `memory/` and add its pointer to `MEMORY.md`.
6. **Run the `/report` step-9 cross-file consistency check** on the changed values:
   race dates and targets, phase boundaries, calorie tiers and floors (the macros
   must sum), HR anchors and volume bands. Fix any disagreement before finishing.
7. Set `Last verified` in `current-status.md` to today, then commit (git is
   permitted in this repo). Do not push; the `git-sync` schedule handles that.

### 7. Close

Reply with a short summary: what changed, what is OPEN and who owns it, and the
first date at which the new plan will be measured. If today's daily file or the
current week's Garmin workouts no longer match the new decisions, say so and offer
to re-run `/plan` or `/garmin`.

## Guardrails

- Never rewrite lab anchors or fabricate data to make a goal fit. If the data
  cannot support a target, the target changes.
- Never silently adopt or silently drop a prior decision. Surface it, and let the
  athlete confirm, amend or retire it.
- Do not re-propose anything a memory records as rejected unless the evidence has
  changed, and say what changed.
- Any goal that depends on a rate or a checkpoint gets its arithmetic written into
  the consult record, so that a later `/report` can check it.

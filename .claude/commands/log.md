---
model: sonnet
effort: medium
# Actuals plus re-tuning the remaining meals' macros.
---
# Log - Track Any Daily Entry (MASTER)

## Usage

```
/log [entry details]
/log activity <garmin activity id>
```

`/log activity <id>` is typed into the coach session by the container's `cron-activity`
schedule for each new Garmin activity of the day (§ Garmin Activity).

## Function

1. Find today's daily file
2. Auto-detect the entry type
3. Update the correct section — workout, meal, and body actuals go in
   `## Actuals`; notes go in `## Context` (Notes / flags)
4. Apply type-specific logic

`/log` writes coach-side records, never a worksheet: no checkboxes and no `___`
blanks. Write only lines that carry real content, and omit any category with
nothing to record (see `protocols/daily-template.md` § `## Actuals`).

## Type-Specific Logic

### Meal

- **A change to a meal not yet eaten** (an ingredient swap, a different portion, a
  meal moved or eaten out) rewrites that meal's row as the new plan, not as eaten,
  then re-tunes the other remaining meals the same way.
- Write the actual into the `## Nutrition` table, **overwriting that meal's row in
  place** (description + actual macros) and marking it eaten. The planned text need
  not be preserved — the macro accounting is what's tracked.
- **Re-tune the remaining (not-yet-eaten) meals' targets** to absorb any macro or
  calorie deviation and hold the day-type tier. Respect the protein-distribution rule
  (≥3 boluses ≥30 g, dinner ≥40 g) and the fat floor when re-tuning.
- Keep the section's macro-tracking summary current: **Expected** (day-type tier) /
  **Actual so far** (eaten meals) / **Projected** (day end).
- `## Actuals` carries **only genuine deviations, swaps, and flags** — not a duplicate
  meal-by-meal record (the table holds that).
- Compare the projection against the active day-type target from
  `protocols/nutrition.md`; flag underfueling if a quality or long-run day projects low.

### Workout

- Parse lifting or running entries
- Prefer Garmin data over manual estimates for runs
- Record if the session was modified by sleep, pain, or heat
- Pull daily steps from Garmin when assessing NEAT / expenditure, and record the
  figure in `## Actuals` — steps are a coaching input, not a checklist item

### Garmin Activity

`/log activity <id>` records one activity that has just synced from the watch.

- Pull it with `get_activity` (and `get_activity_splits` for a run,
  `get_activity_exercise_sets` for a lift). If the day's `## Actuals` already records
  this activity, stop without a message.
- Match it to the day's prescription and write the actuals exactly as `/recap` step 4
  does: run distance, pace, average and max HR, RPE, strength per exercise with
  pre-filled reps flagged. A swap or an extra is recorded as such.
- If it changes the day's output (shorter, easier, swapped, or an extra session),
  re-tune the remaining meals per § Meal and the skipped-session rule in `AGENTS.md`.
- Send the athlete one short message with `util-telegram-send --html`, the text in a
  quoted heredoc (`<<'EOF'`), not the plugin's `reply`: a ✅ line with the key numbers
  against the prescription, and the changed meals with their quantities if any were
  re-tuned. Then end the turn with one line saying it was sent.

### Body

- Log weight with its state in `## Actuals` (scale BF% is BIA, context only)
- Daily weigh-in protocol: morning, post-bathroom, pre-food (state, not clock)
- Decisions need ≥4 fasted readings in the week; compute the rolling 7-day mean whenever ≥4 exist
- Weekly navel waist tape (fasted, Monday by default) goes in `## Actuals` and the current-status Body Composition table
- A social evening is logged with one word; the next day re-tiers to Rest (`nutrition.md` § Social Days)

### Weekly (Sundays)

- Compute ACWR from week km / mean km of the four preceding weeks (`running.md` § ACWR)
- Compute Composite Load from session duration × Garmin session RPE (`workout_rpe` ÷ 10) across all runs and lifts; sessions without an RPE are excluded and counted
- Flag >1.3 or <0.8
- Display 7-day weight average and body-comp trend
- Carry sleep, pain, and heat flags into `/report`

### Daily line

The athlete's one line a day (consult 2026-09-29), usually a Telegram reply to the
evening `/recap`: motivation 1–5 plus a word on anything skipped, e.g. "3, skipped
legs — kid sick".

- Record `Motivation: N/5` (and the athlete's words, if they add anything) under
  the daily-line bullet in `## Actuals`.
- Replace each "not delivered — reason?" with "not delivered — <reason>", and a
  `Plan: none — reason?` line with "Plan: none — <reason>". A reason is whatever the
  athlete gives. Do not judge it here; `/report` weighs the pattern.
- If the line names a skip the file doesn't show as missed, record it as given and
  flag the mismatch against Garmin.
- A reason for a past day goes into that day's file. If it arrives after the next
  morning's breach check, keep the breach mark and append "— reason given late:
  <reason>". It counts as a breach either way.
- A bare number (a tap on the recap's 1–5 buttons) is the motivation alone. If the day
  still has a "not delivered — reason?" or `Plan: none — reason?`, ask for the reason
  in one line.
- Reply with one line confirming what was recorded.

### Reminder / TODO

Any dated or undated item to keep, e.g. "remind me Friday to buy gels" or "todo:
book the derm follow-up".

- Add a row to `calendar.md` under `## Upcoming` (dated) or `## Undated TODO`, with
  Kind `reminder` or `todo`, Owner `athlete` unless the item is the coach's, and
  Source `telegram YYYY-MM-DD`. Resolve relative dates ("Friday") against today's
  local date, and state the resolved date back.
- "done <item>" moves the row to `## Done` with the date.

### Note

- Append to Notes

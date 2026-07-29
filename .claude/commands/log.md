# Log - Track Any Daily Entry (MASTER)

## Usage

```
/log [entry details]
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

## Type-Specific Logic

### Meal

- Write the actual into the `## Nutrition` table, **overwriting that meal's row in
  place** (description + actual macros) and marking it eaten. The planned text need
  not be preserved — the macro accounting is what's tracked.
- **Re-tune the remaining (not-yet-eaten) meals' targets** to absorb any macro or
  calorie deviation and hold the day-type tier. Respect the protein-distribution rule
  (≥3 boluses ≥30 g, pre-bed ≥40 g) and the fat floor when re-tuning.
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

### Body

- Log weight and body-fat data to Status
- Daily weigh-in protocol: morning, post-bathroom, pre-food
- If 7 daily readings exist, compute the rolling average

### Weekly (Sundays)

- Compute ACWR from week km / 4-week average km
- Compute Composite Load from session duration x RPE across all runs and lifts
- Flag >1.3 or <0.8
- Display 7-day weight average and body-comp trend
- Carry sleep, pain, and heat flags into `/report`

### Note

- Append to Notes

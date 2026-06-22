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

- Format as `Meal: description, calories, protein`
- Update running calorie total
- Compare against the active day-type target from `protocols/nutrition.md`
- If intake drifts too low on a quality or long-run day, flag underfueling

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

# Log - Track Any Daily Entry (MASTER)

## Usage

```
/log [entry details]
```

## Function

1. Find today's daily file
2. Auto-detect the entry type
3. Update the correct section
4. Apply type-specific logic

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

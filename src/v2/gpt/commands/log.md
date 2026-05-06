# Log - Track Any Daily Entry (GPT V2)

## Usage

```
/log [entry details]
```

## Function

1. Find today's daily file
2. Auto-detect the entry type
3. Update the correct log section
4. Apply type-specific logic

## Type-Specific Logic

### Meal

- Format as: **[Meal Type]:** description, calories
- Update running calorie total
- Determine today's day type from the daily file header
- Compare against the day-type target from `protocols/v2/gpt/nutrition.md`
- Alert if approaching or exceeding target
- Show remaining calories and macro budget

### Workout

- Parse lifting or running entries
- For runs, prefer Garmin data over manual estimates
- Compare completed work to the planned session if present

### Body

- Log weight and body fat to the Status section
- Daily weigh-in protocol: morning Withings reading, post-bathroom, pre-food
- If 7 daily readings exist, compute the rolling average
- Compare to the previous week's average and flag stalls during cut phases

### Weekly (Sundays)

- Compute ACWR from week km / 4-week average km
- Flag >1.3 or <0.8
- Display 7-day weight average and body-comp trend
- Feed the summary into `/report`

### Note

- Append to Notes

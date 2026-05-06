# Log - Track Any Daily Entry

Log workouts, meals, body metrics, or notes to today's daily file.

## Usage
```
/log [entry details]
```

## Examples
- `/log squat 80kg 3x8,8,7 | bench 60kg 3x10,9,8 | RDL 70kg 3x12`
- `/log 5km easy run 5:45/km 28:15`
- `/log meal lunch "Chicken breast, rice, broccoli" 650`
- `/log meal post-workout "Whey protein shake + banana" 350`
- `/log weight 78.5kg bf 16.2%`
- `/log note "Left knee mild discomfort during squats"`
- `/log supplements creatine, omega-3, vitamin D taken`

## Function
1. Find today's file in `days/YYYY-MM-DD.md`
2. Auto-detect entry type from context:
   - **Workout** — exercises with sets/reps/weights, or running with distance/pace/duration
   - **Meal** — keyword `meal` + meal type + description + calories
   - **Body** — keyword `weight` or `bf` with numeric values
   - **Note** — keyword `note` or anything that doesn't match above
   - **Supplements** — keyword `supplements` with list
3. Update the appropriate Log section
4. Apply type-specific logic (see below)

## Type-Specific Logic

### Workout (strength)
- Parse exercises with sets/reps/weights
- Compare to planned workout if exists
- Track volume and progression vs previous sessions
- Add progression recommendations for next session

### Workout (running)
- **Pull data from Garmin** — never rely on manual input for runs
- Parse distance/pace/duration/notes
- Compare to planned workout if exists

### Meal
- Format as: **[Meal Type]:** description, calories
- Update running calorie total
- **Determine today's day type** from the daily file header (Rest/Easy/Quality/Long Run/Race)
- **Compare to day-type-specific target** from `protocols/nutrition.md` (NOT a flat number)
- Alert if approaching or exceeding the day's calorie target
- Show remaining calories and macro budget

### Body
- Log weight/body fat to daily file Status section
- **Daily weigh-in protocol:** Morning Withings reading (post-bathroom, pre-food)
- If 7 daily readings exist this week, compute and display 7-day rolling average
- Compare rolling average to previous week's average
- Flag if rolling average has stalled (±0.1 kg for 2+ consecutive weeks during cut phases)

### Weekly (Sundays)
- Compute ACWR: this week's total km / 4-week average km
- Flag if ACWR > 1.3 (ramp too fast) or < 0.8 (detraining risk)
- Display 7-day weight average and body comp trend
- Include in the weekly summary for `/report`

### Note
- Append to Notes section of daily file

## Requirements
- Flexible input parsing (various formats accepted)
- Auto-detect entry type from context clues
- If ambiguous, ask for clarification
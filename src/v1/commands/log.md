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
- Compare to daily target
- Alert if approaching or exceeding daily target

### Body
- Log weight/body fat to daily file

### Note
- Append to Notes section of daily file

## Requirements
- Flexible input parsing (various formats accepted)
- Auto-detect entry type from context clues
- If ambiguous, ask for clarification

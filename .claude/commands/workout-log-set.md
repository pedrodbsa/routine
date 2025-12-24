# Log Set - Track Individual Exercise Sets

Track individual sets during workout sessions with weight and reps.

## Usage
```
/workout-log-set [exercise] [weight]kg [reps]
```

## Examples
- `/workout-log-set "Bench Press" 80kg 8`
- `/workout-log-set "Dumbbell Rows" 35kg 10`
- `/workout-log-set "Pull-ups" bodyweight 12`

## Function
1. Find or create today's daily report
2. Add the set to the current workout section
3. Format as: **Exercise Name:** Weight x Sets x Reps
4. If exercise already exists, add to existing sets
5. Track progression vs previous sessions

## Requirements
- Exercise names should match protocol files for consistency
- Weight format: number + "kg" or "bodyweight"
- Reps should be actual completed reps
- Update sets progressively (Set 1, Set 2, etc.)
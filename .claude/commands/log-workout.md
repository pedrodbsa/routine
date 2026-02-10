# Log Workout - Track Completed Workout

Log entire workout after completion with all exercises, sets, reps, and weights.

## Usage
```
/log-workout [workout details]
```

## Examples
- `/log-workout "Squat 80kg 3x8,8,7 | Bench 60kg 3x10,9,8 | RDL 70kg 3x12"`
- `/log-workout "5km easy run 5:45/km 28:15"`
- `/log-workout "Tempo run 8km 4:50/km felt strong"`

## Function
1. Find today's file in `days/YYYY-MM-DD.md`
2. Update Log > Workout section (mark checkbox, add details)
3. For strength: parse exercises with sets/reps/weights
4. For running: parse distance/pace/duration/notes
5. Compare to planned workout if exists
6. Track progression vs previous sessions

## Format Guidelines

**Strength workouts:**
```
Exercise 1: weight x sets x reps,reps,reps
Exercise 2: weight x sets x reps,reps,reps
```

**Running workouts:**
```
distance pace duration [notes]
```

## Output
Updates `days/YYYY-MM-DD.md` Log > Workout section:

```
## Workout - [Type]

**Exercise 1:** 80kg x 3 sets x 8,8,7 reps
**Exercise 2:** 60kg x 3 sets x 10,9,8 reps
**Exercise 3:** 70kg x 3 sets x 12,12,12 reps

**Notes:** [Auto-generated progression notes]
```

## Requirements
- Flexible input parsing (various formats accepted)
- Auto-detect workout type (strength/running)
- Track volume and progression
- Compare to plan if available
- Add progression recommendations for next session

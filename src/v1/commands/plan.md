# Plan - Daily Workout & Nutrition Plan

Get today's personalized workout and nutrition plan based on recent data and goals.

## Usage
```
/plan
/plan [schedule constraints]
```

## Examples
- `/plan`
- `/plan "8am free slot before work"`
- `/plan "only have 45 minutes after lunch"`

## Function
Uses the **coach skill** to:

1. Check recent data from `/data` CSVs and Garmin
2. Analyze current training state and progression
3. Generate today's workout:
   - Running (easy/tempo/intervals/long run)
   - OR Strength (full-body session with exercises/sets/reps/weights)
4. Plan nutrition:
   - Meal timing aligned with workout
   - Macro targets: 2,000 cal | 140g protein | 175g carbs | 50g fat
   - Specific meal suggestions based on training day
5. Consider schedule constraints if provided

## Output Format
```
## Daily Plan - [Date]

### Workout
**Type:** [Running/Strength]
**Timing:** [Recommended time based on schedule]

[Detailed workout with exercises/distances/paces/weights]

### Nutrition
**Post-Workout (12:30):** [meal] - XXX cal
**Lunch (13:00):** [meal] - XXX cal
**Snack (17:00):** [meal] - XXX cal
**Dinner (21:00):** [meal] - XXX cal

**Daily Total:** 2,000 cal | 140g protein | 175g carbs | 50g fat

### Notes
[Any relevant context or adjustments based on recent performance]
```

## Requirements
- Automatically invokes coach skill
- Uses recent performance data for workout planning
- No Garmin Coach workouts - Claude plans everything
- Considers 39yo parent constraints and recovery needs
- Progressive overload based on logged performance
- Meal timing fits eating window (12:30-21:00)
- **ALWAYS save to `days/YYYY-MM-DD.md`** with Plan and empty Log sections

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

1. Read `protocols/current-status.md` for current phase and date
2. Determine today's day type (rest/easy/quality/long run/race) based on phase weekly template
3. Look up phase-specific calorie and macro targets from `protocols/nutrition.md`
4. Check recent data from `/data` CSVs and Garmin (recovery markers, recent activities)
5. Generate today's workout based on phase and weekly template from `protocols/training.md` and `protocols/running.md`
6. Plan nutrition with phase-correct targets
7. Include mobility routine
8. Include daily weigh-in reminder if not yet logged

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

**Daily Total:** [Phase-specific] cal | [Phase-specific] protein | [Phase-specific] carbs | [Phase-specific] fat
**Day Type:** [Rest/Easy/Quality/Long Run/Race]

### Notes
[Any relevant context or adjustments based on recent performance]
```

## Requirements
- **Phase-aware:** Always check current phase in `protocols/current-status.md` before generating
- **Day-type-aware:** Determine today's day type from the weekly template, then use the correct calorie tier
- **Calorie cycling:** Rest/easy days and quality/long-run days have different targets — never use a flat number
- **Thursday rule:** Thursday is always rest from running. Legs on Thursday in all phases except Phase 6 weeks 6-8 (legs dropped, Thursday = pure rest).
- **Long runs >90 min:** Must include pre-run fueling (banana + coffee) and use quality-day calories
- **Daily weigh-in:** Include morning Withings weigh-in in Status section
- **Mobility:** Include 10-min daily mobility routine
- **ACWR:** Compute and include on Sundays
- Automatically invokes coach skill
- No Garmin Coach workouts - Claude plans everything
- Considers 39yo parent constraints and recovery needs
- Progressive overload based on logged performance
- Meal timing fits eating window (12:30-21:00)
- **ALWAYS save to `days/YYYY-MM-DD.md`** with Plan and empty Log sections
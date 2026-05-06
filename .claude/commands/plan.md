# Plan - Daily Workout and Nutrition Plan (MASTER)

## Usage

```
/plan
/plan [schedule constraints]
```

## Function

1. Read `protocols/current-status.md`
2. Determine today's day type from `protocols/training.md`
3. Look up calories and macros in `protocols/nutrition.md`
4. Check recent data from daily files and Garmin CSVs
5. Apply the sleep/readiness decision tree from `protocols/training.md`
6. Apply heat rules from `protocols/running.md` when relevant
7. Generate the workout and meal plan
8. Include mobility and weigh-in reminders

## Requirements

- Always be phase-aware and day-type-aware.
- Never use a flat calorie number across the week.
- Thursday rule: no running on Thursday; legs on Thursday except Phase 6 weeks 6-8.
- Long runs >90 min require banana + coffee and quality-day calories.
- If sleep was <5 h or Body Battery <30, write a rest-day plan.
- If weather is hot or humid, bias the session toward HR and RPE rather than pace.
- On double days, partition carbs so recovery between the run and PM lift is protected.
- In the 3 weeks before the May 24 trail 21K, include gut-training practice on 2-3 long runs over 75 min.
- Include 10-minute mobility.
- Compute and include ACWR on Sundays.
- Compute and include Composite Load on Sundays when enough session data exists.
- Save to `plans/YYYY-MM-DD.md`.

# Plan - Daily Workout and Nutrition Plan (GPT V2)

## Usage

```
/plan
/plan [schedule constraints]
```

## Function

Uses the coach skill to:

1. Read `protocols/v2/gpt/current-status.md` for the current phase and activation date
2. Determine today's day type from the phase template in `protocols/v2/gpt/training.md`
3. Look up phase-specific calories and macros in `protocols/v2/gpt/nutrition.md`
4. Check recent data from `data/` CSVs and daily files
5. Generate today's workout from `protocols/v2/gpt/training.md` and `protocols/v2/gpt/running.md`
6. Plan nutrition with phase-correct targets
7. Include mobility
8. Include daily weigh-in reminder if not yet logged

## Output Format

```
## Daily Plan - [Date]

### Workout
**Type:** [Running/Strength/Rest]
**Timing:** [Recommended time]

[Detailed workout]

### Nutrition
[Meal plan]

**Day Type:** [Rest/Easy/Quality/Long Run/Race]
**Daily Total:** [Phase-specific] cal | [Protein] protein | [Carbs] carbs | [Fat] fat

### Notes
[Context and adjustments]
```

## Requirements

- Phase-aware: always check `current-status.md` first
- Day-type-aware: derive the calorie tier from the weekly template
- Never use a flat calorie number across all days
- Thursday rule: no running on Thursday; legs on Thursday except Phase 6 weeks 6-8
- Long runs >90 min require banana + coffee and quality-day calories
- Include daily weigh-in reminder
- Include 10-minute mobility routine
- Compute and include ACWR on Sundays
- Save to `days/YYYY-MM-DD.md`

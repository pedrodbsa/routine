# Meal Plan - Plan Meals Based on Remaining Macros

Get meal suggestions and plan upcoming meals based on daily targets and schedule.

## Usage
```
/meal-plan [meal-type]
/meal-plan tomorrow
```

## Examples
- `/meal-plan lunch`
- `/meal-plan dinner`
- `/meal-plan snack`
- `/meal-plan tomorrow`

## Function
1. Check today's logged meals and remaining macros
2. Calculate remaining calories and macro needs:
   - Total: 2,000 calories
   - Protein: 140g (28%)
   - Carbs: 175g (35%) 
   - Fat: 50g (23%)
3. Reference nutrition.md meal plans
4. For "tomorrow": plan all 4 meals for next day
5. Consider training schedule and family dinner timing

## Output Format
### Single Meal
```
## [Meal Type] Suggestion

**Remaining Budget:** XXX calories
**Macro Needs:** XXg protein, XXg carbs, XXg fat

**Suggested Meal:**
- [Food items with portions and macros]

**Total:** XXX calories | XXg protein | XXg carbs | XXg fat
```

### Tomorrow's Plan
```
## Tomorrow's Complete Meal Plan - [Date]

**Training Day:** [Type]

**Post-Workout (12:30):** [meal] - XXX calories
**Lunch (13:00):** [meal] - XXX calories  
**Snack (17:00):** [meal] - XXX calories
**Dinner (21:00):** [meal] - XXX calories

**Daily Total:** 2,000 calories | 140g protein | 175g carbs | 50g fat

**Prep Notes:** [Shopping/preparation suggestions]
```

## Requirements
- Base suggestions on nutrition.md meal options
- Prioritize hitting protein targets
- Consider meal timing and family coordination
- Provide prep suggestions for tomorrow planning
- Stay within calorie and macro budgets
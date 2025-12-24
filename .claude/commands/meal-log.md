# Log Meal - Track Daily Nutrition

Add meals to today's nutrition tracking with calories.

## Usage
```
/meal-log [meal-type] [description] [calories]
```

## Examples
- `/meal-log post-workout "Whey protein shake + banana" 350`
- `/meal-log lunch "Chicken breast, rice, broccoli" 650`
- `/meal-log snack "Greek yogurt with berries" 300`
- `/meal-log dinner "Salmon, quinoa, vegetables" 750`

## Function
1. Find or create today's daily report
2. Add to Nutrition > Meals section
3. Format as: **[Meal Type]:** [description, calories]
4. Update total daily calories
5. Compare to daily target (2,000 calories)

## Meal Types
- post-workout
- lunch
- snack
- dinner

## Requirements
- Description should include main food items
- Calories as whole number
- Automatically calculate running total
- Alert if approaching or exceeding daily target
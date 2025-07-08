# Daily Reports

Reports should follow the naming scheme like `reports/2025-07-01.md`:

## Structure

1. **Workout section** with detailed exercise tracking (sets, reps, weights, notes)
2. **Nutrition & Supplements** with timed meals and supplement compliance
3. **Hydration status** and daily water intake
4. **Performance notes** and next session targets

## Creating Daily Reports

```bash
# Create new daily report
touch reports/$(date +%Y-%m-%d).md
```

### Exercise Tracking Standards

-   Include weight, reps, and subjective difficulty notes
-   Record "working weight" and progression targets
-   Track autoregulation adjustments during sessions
-   Note form quality and range of motion

### Nutrition Planning

-   If asked to create a meal plan for the day, ask for the available foods
-   With the available foods, create meals

### Nutrition Tracking

-   Calculate precise macros for each meal
-   Track supplement compliance with checkmarks
-   Include meal timing within eating window
-   Note hydration levels throughout day

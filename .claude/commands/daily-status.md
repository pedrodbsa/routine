# Daily Status - Complete Daily Overview

View comprehensive daily status including nutrition, workout, and supplements.

## Usage
```
/daily-status
```

## Function
1. Read today's daily report
2. Calculate nutrition status (calories + macros vs targets)
3. Show workout progress and next exercises
4. Display supplement schedule status
5. Highlight any schedule conflicts or notes
6. Provide quick weekly trend context

## Output Format
```
## Daily Status - [Date]

### Nutrition Status
**Calories:** XXX/2,000 (XX%) - [XXX remaining]
**Macros:** Protein XX/140g | Carbs XX/175g | Fat XX/50g
**Priority:** [Which macro needs attention]

### Workout Status  
**Today's Training:** [Upper A/Upper B/Lower/Rest/Padel]
**Completed:** [Exercise list with weights/reps]
**Next Exercise:** [Recommendation with target weight]
**Progress:** [Key observations vs last session]

### Activity Status
**Cardio:** [Completed activities with performance notes]
**Target:** [Daily running goal status]

### Supplements Status
**Completed Today:**
✓ Post-Workout: [List]
⏳ Upcoming: [Next due supplements with timing]

### Notes & Schedule
**Today's Notes:** [Any logged notes]
**Schedule:** [On track / Modified / Conflicts]

### Quick Weekly Trends
**Training:** X/Y sessions this week
**Nutrition:** Average XXX calories, XX% protein target
**Cardio:** X/7 days completed
```

## Requirements
- Comprehensive single-view dashboard
- Real-time calculations from logged data
- Reference all protocol files for targets
- Highlight priorities and next actions
- Include weekly context for motivation
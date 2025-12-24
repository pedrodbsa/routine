# Workout Progress - Exercise Progression Analysis

Analyze progression for specific exercises over time.

## Usage
```
/workout-progress [exercise]
```

## Examples
- `/workout-progress "Bench Press"`
- `/workout-progress "Pull-ups"`
- `/workout-progress "Dumbbell Rows"`

## Function
1. Search through reports/ directory for exercise history
2. Extract weight, sets, and reps data
3. Calculate progression trends
4. Identify when to increase weight
5. Show volume progression (sets x reps x weight)

## Output Format
```
## [Exercise] Progression Analysis

**Recent Sessions:**
- 2025-07-08: 80kg x 3 sets x 8,7,6 reps (Total: 1680kg volume)
- 2025-07-05: 77.5kg x 3 sets x 8,8,7 reps (Total: 1782.5kg volume)  
- 2025-07-02: 77.5kg x 3 sets x 8,7,6 reps (Total: 1627.5kg volume)

**Trend:** [Increasing/Decreasing/Plateauing]
**Progression Rate:** +Xkg per week average

**Recommendation:**
[Weight increase suggestion based on rep performance]
[Next session target: weight x sets x reps]
```

## Requirements
- Search reports chronologically
- Calculate total volume (weight x sets x reps)
- Identify progression patterns
- Reference training.md protocols for rep ranges
- Suggest weight increases when hitting upper rep targets
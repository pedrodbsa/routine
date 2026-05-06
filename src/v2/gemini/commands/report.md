# Checkin - Weekly/Monthly Progression Review

Comprehensive review of training, nutrition, and body composition progress.

## Usage

```
/report
/report weekly
/report monthly
```

## Function

Uses the **coach skill** to:

1. Analyze data from recent period:
    - Weight progression on key lifts
    - Running performance (pace/distance/volume)
    - Nutrition adherence and macro targets
    - Body composition changes (Rolling 7-day avg weight and weekly composition)
    - Training consistency and volume

2. Identify trends:
    - Progressive overload success
    - Plateaus or regressions
    - Recovery quality indicators (HRV, Sleep Score, Resting HR, Body Battery)
    - Energy and performance patterns

3. Compare to goals:
    - Body recomp target: 76.8kg @ 29.2% BF (Mar 2026 baseline) → 70-72kg @ 21-23% BF
    - Strength preservation and hypertrophy progression rates
    - Running 10K speed and PR target

4. Recommend adjustments:
    - Training volume/intensity modifications based on triggers
    - Exercise substitutions if needed
    - Nutrition timing or macro tweaks (calorie cycling adjustments based on 7-day weight avg)
    - Recovery protocol changes
    - Deload or diet break timing if indicated

5. Phase-aware weekly checks:
    - Compute ACWR (sweet spot 0.8-1.3)
    - Evaluate 7-day weight average change (Target: 0.3-0.4 kg/wk)
    - Determine upcoming phase transitions automatically.
    - Automate updating `protocols/current-status.md` with new metrics and logs.

## Output Format

```
## [Weekly/Monthly] Report - [Date Range]

### Performance Summary
**Strength:**
- [Key lifts with progression]
- Volume trend: [increasing/stable/decreasing]

**Running:**
- Weekly volume vs Plan: [km]
- ACWR: [value]
- Speed / intervals improvements: [data]

**Body Composition:**
- 7-Day Weight Average: [value]
- Trend: [Delta vs last week]
- Visual/measurement changes: [if available]

### Adherence
**Training:** Strength X/Y, Running X/Y
**Nutrition:** X/7 tracked, Calories hit X/7, Protein >=160g X/7
**Recovery:** Garmin Sleep >=75 X/7, Mobility X/Y

### Analysis
[Detailed assessment of what's working and what isn't]

### Recommendations & Updates
**Training Adjustments:**
- [Specific changes with rationale]

**Nutrition Adjustments:**
- [Specific changes with rationale]

**Protocol Modifications:**
- [Automatically update current-status.md logic to execute changes]

### Next Phase Focus
[Key priorities for next period based on current timeline]
```

## Requirements

- Automatically invokes coach skill
- Reviews reports from specified period
- Evidence-based recommendations only
- Updates `protocols/current-status.md` natively with latest numbers
- Consider phase-aware triggers (e.g. diet breaks, deload weeks)
- **ALWAYS save the reports to `reports/YYYY-MM.md`** (e.g., `reports/2026-03.md`). the same file should be used to store the weekly progression and the final monthly summary
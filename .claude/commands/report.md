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
    - Body composition changes (if logged)
    - Training consistency and volume

2. Identify trends:
    - Progressive overload success
    - Plateaus or regressions
    - Recovery quality indicators
    - Energy and performance patterns

3. Compare to goals:
    - Body recomp target: 80kg@30%BF → 70kg@12-15%BF
    - Strength progression rates
    - Running endurance and pace improvements

4. Recommend adjustments:
    - Training volume/intensity modifications
    - Exercise substitutions if needed
    - Nutrition timing or macro tweaks
    - Recovery protocol changes
    - Deload timing if indicated

## Output Format

```
## [Weekly/Monthly] Report - [Date Range]

### Performance Summary
**Strength:**
- [Key lifts with progression]
- Volume trend: [increasing/stable/decreasing]

**Running:**
- Weekly volume: [km]
- Pace improvements: [data]
- Long run progress: [data]

**Body Composition:**
- Weight trend: [data]
- Visual/measurement changes: [if available]

### Adherence
**Training:** X/Y planned sessions (XX%)
**Nutrition:** [Adherence notes]
**Sleep/Recovery:** [Quality indicators from notes]

### Analysis
[Detailed assessment of what's working and what isn't]

### Recommendations
**Training Adjustments:**
- [Specific changes with rationale]

**Nutrition Adjustments:**
- [Specific changes with rationale]

**Protocol Modifications:**
- [Any schedule/approach changes]

### Next Phase Focus
[Key priorities for next period]
```

## Requirements

- Automatically invokes coach skill
- Reviews reports from specified period
- Evidence-based recommendations only
- Considers 39yo recovery needs and family constraints
- References current research for modifications
- Actionable, specific guidance
- Updates training/nutrition protocols if major changes recommended
-   - **ALWAYS save the reports to `reports/YYYY-MM.md`** (e.g., `reports/2026-02.md`). the same file should be used to store the weekly progression and the final monthly summary

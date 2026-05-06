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
    - Body recomp target: 76.8kg @ 29.2% BF (Mar 2026 baseline) → 70-72kg @ 21-23% BF

4. Recommend adjustments:
    - Training volume/intensity modifications
    - Exercise substitutions if needed
    - Nutrition timing or macro tweaks
    - Recovery protocol changes
    - Deload timing if indicated

5. Phase-aware weekly checks:
    - Compute ACWR (this week km / 4-week avg km). Flag if >1.3 or <0.8.
    - Compute 7-day weight average from daily Withings readings
    - Compare weight trend to previous week — flag stalls (+/-0.1 kg for 2+ weeks during cut)
    - Check current phase in `protocols/current-status.md` and verify calorie targets match
    - Check strength session count — flag if <2 for 2 consecutive weeks
    - Check nutrition tracking days — flag if <5/7

6. Update `protocols/current-status.md`:
    - Training Load section with this week's data
    - Key Metrics section with latest Garmin values
    - Adherence section with this week's scores
    - Body Composition History table if new Withings data available

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
- ACWR: [value] — [status]

**Body Composition:**
- Weight trend: [7-day avg this week vs last week]
- BF% trend: [if available]

### Adherence
**Training:** X/Y planned sessions (XX%)
**Nutrition:** [Adherence notes, tracking days]
**Sleep/Recovery:** [Quality indicators from notes]
**Daily weigh-in:** X/7

### Phase Check
- Current phase: [phase name and dates]
- Days until next phase transition: [N]
- If within 7 days of transition: flag upcoming changes to calorie targets, workout structure, strength programming
- If in a scheduled diet break window: verify maintenance calories are being used

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
- **ALWAYS save the reports to `reports/YYYY-MM.md`** (e.g., `reports/2026-02.md`). The same file should be used to store the weekly progression and the final monthly summary

# Report - Weekly / Monthly Progression Review (MASTER)

## Usage

```
/report
/report weekly
/report monthly
```

## Function

1. Analyze recent strength, running, nutrition, body composition, and recovery data
2. Identify progression, plateaus, and warning signs
3. Compare outcomes to the body-recomp target: 76.8 kg @ 29.2% BF -> 70-72 kg @ 21-23% BF
4. Review compliance with sleep, mobility, weigh-ins, and food tracking
5. Run phase-aware weekly checks:
    - Compute ACWR and flag >1.3 or <0.8
    - Compute Composite Load and compare it to the rolling 4-week average
    - Compute 7-day weight average and compare to prior week
    - Flag stalls during cut phases
    - Check whether heat or sleep modified the week materially
    - Check strength-session count and nutrition-tracking compliance
6. Update `protocols/current-status.md` when this stack is active

## Requirements

- Keep recommendations actionable and specific.
- Mention upcoming phase transitions when within 7 days.
- Mention whether a fallback week is needed.
- Save monthly output to `reports/YYYY-MM.md`.

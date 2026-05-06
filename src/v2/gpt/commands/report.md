# Report - Weekly/Monthly Progression Review (GPT V2)

## Usage

```
/report
/report weekly
/report monthly
```

## Function

Uses the coach skill to:

1. Analyze recent strength, running, nutrition, body composition, and recovery data
2. Identify progression, plateaus, and warning signs
3. Compare outcomes to the body-recomp target: 76.8 kg @ 29.2% BF -> 70-72 kg @ 21-23% BF
4. Recommend training, nutrition, and recovery changes
5. Run phase-aware weekly checks:
    - Compute ACWR and flag >1.3 or <0.8
    - Compute 7-day weight average and compare to prior week
    - Flag stalls during cut phases
    - Verify calorie targets match the current phase
    - Check strength-session count and nutrition tracking compliance
6. Update `protocols/v2/gpt/current-status.md` when this versioned stack is being used as the active source

## Recommendations Template

### Phase Check

- Current phase: [name and dates]
- Days until next phase transition: [N]
- If within 7 days of transition, flag the coming changes to calories, workout structure, and strength volume
- If in a scheduled diet-break window, verify maintenance calories are being used

## Requirements

- Use evidence-based recommendations only
- Keep recommendations actionable and specific
- Save monthly output to `reports/YYYY-MM.md`

# MASTER Protocol Stack

> Read `protocols/current-status.md` first before generating any plan from this stack.

## Purpose

Definitive post-HM protocol stack for a 39-year-old male balancing body recomposition with an October 10K peak.

## Protocol Lookup

| Domain              | File                            | Contains                                                                  |
| ------------------- | ------------------------------- | ------------------------------------------------------------------------- |
| Current state       | `protocols/current-status.md`   | Phase timeline, race calendar, metrics, adherence targets                 |
| Editorial synthesis | `protocols/review-synthesis.md` | Consensus extraction, conflict decisions, gap fill rationale              |
| Coaching rules      | `protocols/coaching.md`         | Quality standards, accountability, communication style                    |
| Running             | `protocols/running.md`          | HR zones, periodization, workout types, heat rules, taper, race execution |
| Strength            | `protocols/training.md`         | Weekly templates, exercise library, progression, sleep fallback rules     |
| Nutrition           | `protocols/nutrition.md`        | Phase-aware calories, macros, fueling, hydration, adjustment rules        |
| Supplements         | `protocols/supplements.md`      | Daily stack, optional items, finasteride compatibility                    |
| Mobility            | `protocols/mobility.md`         | Daily mobility, prehab, pain tracking                                     |
| Daily file format   | `protocols/daily-template.md`   | Required daily fields, day type, ACWR, readiness notes                    |
| Command docs        | `protocols/commands/`           | Versioned `/plan`, `/log`, `/report`, `/body` behavior                    |

## Workflow

1. Morning: `/plan` writes `plans/YYYY-MM-DD.md`
2. After training: `/log [details]`
3. After meals: `/log meal [details]`
4. Weekly: `/report` updates the active current-status file
5. As needed: `/body` syncs scale data and target deltas

## Coaching Primer

- Check the current phase first. Day type, calories, and strength structure all change by phase.
- Calorie cycling is mandatory. Never use one flat calorie target across the week.
- Thursday is always rest from running. Legs stay on Thursday except Phase 6 weeks 6-8, when Thursday becomes pure rest.
- Use objective readiness markers before ego: sleep duration, sleep score, body battery, HRV, resting HR, pain, and ACWR.
- In hot weather, pace becomes secondary to HR and RPE.
- Include the Daily 5 warm-up before every run and pre-run carbs before quality sessions and long runs over 90 minutes.
- If family disruption spikes, use the minimum-effective-dose fallback week instead of forcing the full plan.
- For individual hard days (~4-6/month), use the disrupted-day protocol — a lighter version that preserves structure without requiring full compliance.
- Sleep disruption from a toddler is the baseline, not an exception. Don't over-trigger sleep rules on every mildly short night.

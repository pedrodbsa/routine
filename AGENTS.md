# MASTER Protocol Stack

> Read `protocols/current-status.md` first before generating any plan from this stack.

## Purpose

Definitive post-HM protocol stack for a 40-year-old male balancing body recomposition with an October 10K peak.

## Protocol Lookup

| Domain              | File                            | Contains                                                                  |
| ------------------- | ------------------------------- | ------------------------------------------------------------------------- |
| Current state       | `protocols/current-status.md`   | Phase timeline, race calendar, metrics, adherence targets                 |
| Editorial synthesis | `protocols/review-synthesis.md` | Consensus extraction, conflict decisions, gap fill rationale              |
| Coaching rules      | `protocols/coaching.md`         | Quality standards, accountability, communication style                    |
| Running             | `protocols/running.md`          | HR zones, periodization, workout types, heat rules, taper, race execution |
| Strength            | `protocols/training.md`         | Weekly templates, exercise library, progression, sleep fallback rules     |
| Nutrition           | `protocols/nutrition.md`        | Phase-aware calories, macros, fueling, hydration, adjustment rules        |
| Meal rotation       | `protocols/meal-rotation.md`    | Portion-locked meal cards, carb-tier portions, day-type sample days       |
| Supplements         | `protocols/supplements.md`      | Daily stack, optional items, finasteride compatibility                    |
| Mobility            | `protocols/mobility.md`         | Daily mobility, prehab, pain tracking                                     |
| Skin                | `protocols/skin-log.md`         | Weekly acne assessment, trigger hypotheses, metric correlation            |
| Daily file format   | `protocols/daily-template.md`   | Required daily fields, day type, ACWR, readiness notes                    |
| Command docs        | `.claude/commands/`             | `/plan`, `/garmin`, `/log`, `/report`, `/body` behavior                    |

## Workflow

1. Morning: `/plan` generates `plans/YYYY-MM-DD.md`. It is interactive — it pulls data, presents the key decisions for review, and writes the file on approval. `/plan` does not touch Garmin.
2. After reviewing the plan: `/garmin` uploads the day's prescribed workouts to Garmin Connect and schedules them for the plan date, replacing any existing workout for that date. See `.claude/commands/garmin.md` for the upload behavior.
3. After training: `/log [details]`
4. After meals: `/log meal [details]`
5. Weekly: `/report` updates the active current-status file
6. As needed: `/body` syncs scale data and target deltas

## Coaching Primer

- Check the current phase first. Day type, calories, and strength structure all change by phase.
- Calorie cycling is mandatory. Never use one flat calorie target across the week.
- Scheduling is fully flexible — any run or strength session can land on any day. The phase templates describe weekly volume, day-type distribution, and quality/easy split; they do not pin sessions to specific weekdays.
- Use objective readiness markers before ego: sleep duration, sleep score, body battery, HRV, resting HR, pain, and ACWR.
- In hot weather, pace becomes secondary to HR and RPE.
- Include the Daily 5 warm-up before every run and pre-run carbs before quality sessions and long runs over 90 minutes.
- If family disruption spikes, use the minimum-effective-dose fallback week instead of forcing the full plan.
- For individual hard days (~4-6/month), use the disrupted-day protocol — a lighter version that preserves structure without requiring full compliance.
- Toddler night-waking has largely resolved (2026-05); the athlete now sleeps through but wakes early (~5:30-6:30), so sleep is capped by wake time, not fragmentation. Sleep-onset latency is the live recovery issue. Don't catastrophize one short night, but treat a genuinely short or late-onset night as a real signal — not dismissable toddler noise.

# GPT Protocol Stack

> Read `protocols/v2/gpt/current-status.md` first for current phase, body composition, and recent training data before generating any plan from this versioned stack.

## Repository Purpose

Personal routine management system for a 39-year-old male software engineer focused on post-HM body recomposition and an October 10K peak.

## Protocol Lookup

| Domain            | File                                 | Contains                                                           |
| ----------------- | ------------------------------------ | ------------------------------------------------------------------ |
| Current state     | `protocols/v2/gpt/current-status.md` | Phase timeline, goals, metrics, race calendar, adherence targets   |
| Coaching rules    | `protocols/v2/gpt/coaching.md`       | Quality standards, accountability, communication style             |
| Running           | `protocols/v2/gpt/running.md`        | HR zones, periodization, workout types, race execution             |
| Strength          | `protocols/v2/gpt/training.md`       | Weekly templates, exercise library, progression, recovery triggers |
| Nutrition         | `protocols/v2/gpt/nutrition.md`      | Phase-aware calories, macros, fueling, tracking rules              |
| Supplements       | `protocols/v2/gpt/supplements.md`    | Daily stack and finasteride compatibility                          |
| Mobility          | `protocols/v2/gpt/mobility.md`       | Daily routine, cut-phase recovery emphasis, pain rules             |
| Daily file format | `protocols/v2/gpt/daily-template.md` | Required daily fields, day type, weekly ACWR check                 |

## Directory Structure

- `protocols/v2/gpt/` - Versioned post-HM protocol stack
- `protocols/v2/gpt/commands/` - Versioned command docs for this stack
- `data/` - Garmin CSV exports
- `days/` - Daily files combining plan + log
- `reports/` - Weekly and monthly progression reviews
- `research/` - Evidence base for methodology decisions

## Daily Workflow

1. **Morning:** `/plan` -> generates today's plan in `days/YYYY-MM-DD.md`
2. **After training:** `/log [workout details]` -> updates Log section with completion status
3. **After meals:** `/log meal [details]` -> checks off meals and notes deviations
4. **As needed:** `/log note [text]` -> adds observations to Notes section
5. **Weekly:** `/report` -> progression review, updates `current-status.md`

## Available Commands

**Daily (all update `days/YYYY-MM-DD.md`):**

- `/plan` - Generate today's workout and nutrition plan
- `/log [details]` - Log workouts, meals, body metrics, or notes (auto-detects type)

**Periodic:**

- `/report` - Weekly/monthly progression review and protocol checks
- `/body` - Sync body composition to Garmin

## Coaching Primer

_Full rules in `protocols/v2/gpt/coaching.md`._

- Check the current phase in `protocols/v2/gpt/current-status.md` before generating any plan.
- Calorie cycling is mandatory: rest/easy days and quality/long-run days use different targets.
- Thursday is always rest from running. Legs stay on Thursday except Phase 6 weeks 6-8, where legs are removed and Thursday becomes pure rest.
- Be critical and data-driven: HRV, body battery, resting HR, stress, and sleep are ground truth.
- Do not be passively conservative. A recovered athlete needs stimulus.
- Include the Daily 5 warm-up before every run and pre-run carbs before quality sessions and long runs over 90 minutes.

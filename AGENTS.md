# MASTER Protocol Stack

> Read `protocols/current-status.md` first before generating any plan from this stack.

## Purpose

Definitive post-HM protocol stack for a 40-year-old male balancing body recomposition with a December 12 10K A-race (the Oct 25 hilly 10K is a B-race run as a hard supported effort).

## Protocol Lookup

| Domain              | File                            | Contains                                                                  |
| ------------------- | ------------------------------- | ------------------------------------------------------------------------- |
| Current state       | `protocols/current-status.md`   | Phase timeline, race calendar, metrics, adherence targets                 |
| Coaching rules      | `protocols/coaching.md`         | Quality standards, accountability, communication style                    |
| Running             | `protocols/running.md`          | HR zones, periodization, workout types, heat rules, taper, race execution |
| Strength            | `protocols/training.md`         | Weekly templates, exercise library, progression, sleep fallback rules     |
| Strength DB         | `protocols/strength-exercises.md` | Per-exercise working loads, movement library, rotation groups, verified Garmin enum mappings (single source of truth for loads) |
| Nutrition           | `protocols/nutrition.md`        | Phase-aware calories, macros, fueling, hydration, adjustment rules        |
| Meal rotation       | `protocols/meal-rotation.md`    | Portion-locked meal cards, carb-tier portions, day-type sample days       |
| Supplements         | `protocols/supplements.md`      | Daily stack, optional items, finasteride compatibility                    |
| Mobility            | `protocols/mobility.md`         | Daily mobility, prehab, pain tracking                                     |
| Skin                | `protocols/skin-log.md`         | Weekly acne assessment, trigger hypotheses, metric correlation            |
| Daily file format   | `protocols/daily-template.md`   | Required daily fields, day type, ACWR, readiness notes                    |
| Command docs        | `.claude/commands/`             | `/plan`, `/garmin`, `/log`, `/report`, `/body`, `/skin` behavior            |

## Workflow

1. Morning: `/plan` generates `logbook/YYYY-MM/YYYY-MM-DD.md`. It is interactive — it pulls data, presents the key decisions for review, and writes the file on approval. `/plan` does not touch Garmin.
2. After reviewing the plan: `/garmin` uploads the day's prescribed workouts to Garmin Connect and schedules them for the plan date, replacing any existing workout for that date. See `.claude/commands/garmin.md` for the upload behavior.
3. After training: `/log [details]`
4. After meals: `/log meal [details]`
5. As needed: `/skin [observation]` captures a skin-relevant note for the weekly correlation
6. Weekly: `/report` updates the active current-status file, and drains the week's `/skin` captures into the skin assessment
7. As needed: `/body` syncs scale data and target deltas

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
- Build the cut deficit from the **plan-day calorie tiers themselves + social-day damage control**, plus the small food lever of dropping the easy-day post-run shake — **not** plan-day meal cuts or added hard running. **NEAT (steps / walks) is opportunistic extra, not a counted deficit lever and not an adherence non-negotiable (2026-06-23)** — the athlete is time-constrained and will not reliably add a walk; never prescribe compensatory NEAT to offset a skipped session. **When a planned session is skipped/swapped, re-tier the whole day's food down to match actual output** — cut carbs, hold the protein/fat floors (see [[feedback-adjust-day-on-skipped-session]] and the 2026-06-23 coaching-log entry). Honest consequence: with NEAT downgraded, plan-day cuts off the table, and hard-running capped, the deficit rests almost entirely on the tier deficit + social-day control — if the stall persists, a plan-day food trim becomes the next available lever. The athlete weighs his food and adheres on plan days, and prefers adding activity to eating less (2026-06-18, refined 2026-06-23). Meal structure: **4 feeds on easy/rest days, 5 on quality/long/strength** — a fixed midafternoon protein snack anchors every day (adherence/appetite-control lever, pre-empts evening grazing; funded by a smaller breakfast, never additive — 2026-06-22). The governed variable remains protein distribution (≥3 boluses ≥30 g, pre-bed ≥40 g), not meal count. See `nutrition.md` § Meal Distribution and the 2026-06-18 / 2026-06-22 coaching-log entries.

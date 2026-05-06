# GPT V2 Plan Review

## Scope

This review evaluates the GPT V2 protocol stack in `protocols/v2/gpt/` as an independent sports-science review of the plan's training, nutrition, recovery, and periodization quality.

**Athlete context used for scoring:** 39-year-old male, demanding tech job, newborn-related sleep disruption, goals are running performance plus body recomposition, with **running and weight training only**. Padel is no longer relevant and is not treated as a missing component.

## Verdict

This is the strongest of the three reviewed stacks from an execution and systems perspective. It is coherent, phase-aware, and mostly evidence-aligned. The main weaknesses are not in the overall structure, but in a few important decision areas:

1. Sleep disruption is under-weighted relative to its real effect on endurance performance, recovery, appetite regulation, and training quality.
2. Fueling guidance is good for ordinary training days but too generic for half-marathon duration efforts and for hard sessions performed under cumulative fatigue.
3. Strength prescriptions are solid for hypertrophy retention, but the lower-body work could preserve running-relevant force qualities better with a slightly heavier top end on the main lift.

**Overall score:** `7.9/10`

## Scorecard

| Dimension                     | Score | Review                                                                                                                                                                                                                                                               |
| ----------------------------- | ----: | -------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| Scientific soundness          |  8/10 | Strong overall. Good use of easy/hard separation, sub-threshold work, phased quality progression, workload monitoring, and concurrent-training structure. Main deductions are for overconfidence in some recovery heuristics and incomplete sleep-specific planning. |
| Nutrition quality             |  7/10 | Protein targets, calorie cycling, and pre-session carbohydrate logic are generally sound. The main gaps are half-marathon fueling specificity, hydration/sodium specificity, and overly categorical use of fasted easy runs during deficit phases.                   |
| Recovery and sleep adaptation |  7/10 | Better than average because it uses HRV, RHR, sleep score, and body battery. Still not strong enough for a newborn-parent context because it lacks a true sleep-disruption decision tree and a minimum-effective-dose fallback week.                                 |
| Specificity to goals          |  7/10 | Good fit for the actual long-term goal set of running plus body recomposition with ongoing strength work. Loses points because the stack is primarily a post-HM body-recomp and 10K-performance framework rather than a directly half-marathon-specific build.       |
| Practicality                  |  8/10 | Realistic enough to run in the real world. The weekly structure is demanding, but manageable without padel in the mix. Better balance than the Claude version between detail and usability.                                                                          |
| Completeness                  |  9/10 | The most complete stack reviewed. Running, strength, nutrition, mobility, supplements, current-status logic, and reporting all align well.                                                                                                                           |
| Flexibility and adaptability  |  7/10 | Decent readiness triggers and phase-aware rules. Still too dependent on the athlete inferring how to downgrade hard days, especially after fragmented sleep.                                                                                                         |

## Findings

### 1. Sleep-disruption handling is good, but not good enough for the stated life context

The stack uses sensible triggers such as low sleep score, HRV suppression, elevated resting HR, and low body battery. That is a real strength.

The weakness is that the rules are still framed as generic recovery modifiers rather than a true parent-specific readiness model. In practice, repeated nights of partial sleep restriction impair submaximal endurance performance, increase perceived effort, worsen glucose handling, increase appetite pressure, and reduce recovery quality. For this athlete, sleep should alter training earlier and more aggressively than the current rules imply.

**What is missing:**

- A clear rule set for `<5 h`, `5-6 h`, and `6-7 h` sleep nights
- A rule for `2-3` consecutive poor nights
- A minimum-effective-dose fallback week when family disruption spikes
- More explicit protection of lower-body lifting after poor sleep

### 2. Fueling is broadly good, but not specific enough for long race efforts or hard blocks

The plan gets the big pieces right:

- High protein
- Day-type calorie cycling
- Pre-run carbohydrate before quality work
- Higher carbohydrate on quality and long-run days

The gaps are practical specificity. The half-marathon guidance is too general, and the plan does not define race-day carbohydrate, sodium, and fluid targets tightly enough for a 90-120 minute event.

It also treats fasted easy runs as a default tool. That is acceptable sometimes, but during a deficit and under chronic sleep disruption, fasted training can become a stress multiplier rather than a useful adaptation strategy.

**What is missing:**

- HM carbohydrate-loading range
- Race-morning carbohydrate target in `g/kg`
- In-race carbohydrate target in `g/h`
- Sodium and fluid ranges by hour
- A rule to avoid fasted runs when sleep or recovery is already compromised

### 3. Lower-body strength programming is solid, but slightly too hypertrophy-biased for optimal concurrent training

The stack does a good job of preserving resistance training during running-focused phases. The weekly layout is sensible and the progression rules are clear.

The main limitation is that lower-body work is biased toward `8-12` reps across the board. That is acceptable for hypertrophy retention, but for a runner trying to preserve force production while dieting, the first compound lower-body movement would be better served by spending more time in the `5-8` or `6-8` range, with accessories still living in the `8-15` range.

That would likely improve strength retention, reduce unnecessary metabolic fatigue, and better support running economy.

## Strengths

- Strong phase logic from post-HM recovery through the October 10K peak
- Good use of easy/hard separation and sub-threshold work
- Good calorie cycling structure rather than flat intake
- Protein targets are appropriately high for a deficit phase
- The Thursday no-running rule is useful and practical
- Concurrent training layout is better than average for avoiding obvious interference
- The reporting and current-status structure make the system auditable instead of vague
- Supplement recommendations are conservative and mostly evidence-based

## Weaknesses

- Not truly built around chronic sleep disruption despite acknowledging it
- HM fueling guidance is not sufficiently operational
- Recovery rules are still too generic for real-world family disruption
- Lower-body lifting could preserve strength better with a slightly heavier main-lift bias
- The plan occasionally treats compliance rules too rigidly for a highly variable home-life context

## Most Correct Parts of the Plan

These are the elements I would keep with minimal change:

- `160-165 g` protein floor
- Calorie cycling by day type
- One-quality-day structure in early rebuild phases
- Two-quality-day structure only in later development phases
- Use of objective recovery markers to override ego decisions
- Strength taper in later race-peak phases
- Creatine and caffeine as the primary useful supplements

## Highest-Priority Fixes

### 1. Add a sleep-disruption decision tree

Recommended minimum:

- `>=7 h` and markers normal: execute plan
- `6-7 h`: reduce session volume `10-15%`
- `5-6 h`: replace hard running with easy Z1-Z2 or reduce lifting to upper-only
- `<5 h` or `2` consecutive poor nights: no intensity, no heavy lower body

### 2. Tighten half-marathon fueling guidance

Recommended minimum:

- `36-48 h` pre-race: `6-8 g/kg/day` carbohydrate
- Race breakfast `3-4 h` pre-start: `1-1.5 g/kg` carbohydrate
- In race: `30-45 g/h` carbohydrate
- Sodium: `300-500 mg/h` in moderate conditions
- Fluid: `400-600 mL/h`, adjusted by weather and thirst

### 3. Adjust lower-body lifting structure

Recommended minimum:

- Main squat or hinge pattern: `3-4 x 5-8`
- Secondary lift and single-leg work: `3 x 8-10`
- Accessories: `2-3 x 10-15`

## Final Assessment

If used exactly as written, this is a strong plan and the best of the three reviewed stacks. It is well above average and would likely work reasonably well.

If the three fixes above are implemented, it moves from a good plan to a genuinely robust plan for this athlete.

**Final grade:** `B+`

**Summary sentence:** Best overall stack reviewed; strong structure, good science, and good completeness, but it still underestimates the coaching impact of fragmented sleep and needs more precise fueling and lower-body strength adjustments.

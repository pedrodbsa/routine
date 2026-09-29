# NUTRITION PROTOCOL - MASTER

> Single source of truth for calorie tiers and macro floors. Lean-mass anchor 59.6 kg (Bod Pod 2026-04-28); BMR (Katch-McArdle) 1,657 kcal. Phases 6-10 were set at the 2026-09-29 consult (`logbook/2026-09/consult-2026-09-29.md`). Completed phases: `protocols/archive/nutrition-phases-1-3.md`, `nutrition-phases-4-5.md`, `nutrition-phase-5-checkpoints.md`.

## Daily Targets

- **Protein floor:** 165 g in the reverse, build and maintenance phases (6, 7, 9); 170 g in the cuts (8, 10).
- **Fat floor:** 65 g in phases 6, 7 and 9; 60 g in the cuts.
- **Carbs are derived from the tier:** (kcal − 4·P − 9·F) ÷ 4. The floors never move with a tier adjustment; every adjustment is carbohydrate.

On the lowest-calorie days, protein and fat come first.

## Maintenance

Maintenance is an estimate, not a measurement. Bottom-up: BMR 1,657 × 1.2 ≈ 1,990, plus ~350/day from 35–40 km and ~130/day from three lifts ≈ **~2,450**. The history disagrees with itself: July's trimmed tiers (~1,915 avg) lost weight at a rate implying ~2,500 (part of it glycogen water), while August's restored tiers (~2,015) held flat, implying ~2,100 on plan days once unlogged social and unplanned days are counted. The build's weight band resolves it, and the cut tiers are derived from what the band shows.

## Phases 6-10

### Phase 6 — Reverse (Sep 21 – Oct 11)

Offsets on the Phase 5 tiers (Rest 1,850 / Easy 1,950 / Quality 2,250 / Long 2,450):

| Week | Offset | Rest | Easy / Strength | Quality | Long |
| --- | --- | --- | --- | --- | --- |
| Sep 28 — declared re-entry week | +200 | 2,050 | 2,150 | 2,450 | 2,650 |
| Oct 5 → the Build tiers | +300 | 2,150 | 2,250 | 2,550 | 2,750 |

The Oct 5 step needs no data.

### Phase 7 — Build (Oct 12 – Jan 4)

The tiers sit at +300 rather than +400, as a buffer for 1–2 social evenings a week (athlete's call). The cost is that a small plan-day deficit adds less muscle than full maintenance would; the band floor compensates. P165 / F65 on every tier; carbs = (tier − 1,245) ÷ 4.

| Day type | Calories | Protein | Carbs | Fat |
| --- | --- | --- | --- | --- |
| Rest | 2,150 | 165 g | 226 g | 65 g |
| Easy / Strength (any easy run, any lift, or both) | 2,250 | 165 g | 251 g | 65 g |
| Quality | 2,550 | 165 g | 326 g | 65 g |
| Long | 2,750 | 165 g | 376 g | 65 g |

The reference week (1 rest, 4 easy/strength, 1 quality, 1 long — `training.md` § Phases 6-10) averages **~2,350**. With 1–2 social evenings at roughly +1,500 each, the true weekly average sits ~2,650–2,750 unless § Social Days holds, which is why the band, not the tier, is the governor.

**Build weight band.** Expected 74.5–75.5 kg: the reverse returns ~1.0–1.2 kg of glycogen and water (the athlete's own July 2026 data), so a rise into that band is not fat. **Ceiling 76.0 / floor 73.5**, read on the 7-day fasted mean and acted on only when **two consecutive weeks each carry ≥4 fasted readings**: above 76.0 → take 100 kcal off carbs on every row; below 73.5 → add 100. No data → hold. A single week cannot decide, because 100 kcal/day ≈ 0.09 kg/wk sits under the ~0.11 kg standard error of a two-week difference. First possible read: Oct 26.

Oct 25 (hard effort) is a Quality day and Dec 12 (social) a Long day; pre-race sodium and carbs per § Race Fueling, no carb load. The Nov 4–8 trek runs on the Long tier on hiking days. Christmas week stays on the tiers with § Social Days applied.

### Phase 8 — Cut 3 (Jan 5 – Apr 12): tiers derived on Jan 4

Target **0.3 kg/wk** (~330 kcal/day), landing ~70–71.5 kg (~15% on 59.6–60.6 kg lean). P170 / F60; carbs = (tier − 1,220) ÷ 4. **Rest is never below 1,850** (rest-day carbs never below ~157 g).

    build_tiers = the Build plan tiers, plus or minus any band adjustment that fired
    drift       = 7,700 × the build's fasted-weight slope in kg/wk ÷ 7   (positive if weight rose)
    cut tier    = build_tiers − 330 − drift

The off-plan surplus (social evenings, unplanned days) is already inside the build's weight trend, so the deficit comes off the plan tiers. Do not also subtract a separately estimated social term: it would count twice, and a weight trend cannot isolate it anyway. It enters only if off-plan behaviour is expected to change in the cut.

The slope needs **≥8 readable weeks (≥4 fasted readings each) of the 12**. Below that, drift is zero and the tiers are **Rest 1,850 / Strength 1,920 / Quality 2,220 / Long 2,420**. If drift comes out at ≥300/day, run a 0.2 kg/wk cut with the social protocol enforced rather than a −630 plan day: a plan-day deficit the athlete will not hold is worth less than a smaller one he will.

**Rate read #1 (Feb 1):** the least-squares slope of fasted readings over cut weeks 2–4 (Jan 12 – Feb 1, ≥9 readings; no data → hold), against −0.3 kg/wk. Week 1 is excluded (glycogen water off the carb step), and a mean-versus-mean read cannot be used here because the previous window is a flat build. Slower than −0.15 kg/wk → the off-plan lever, then −100 kcal carbs. Faster than −0.4 → +100 carbs.

**Rate reads #2 and #3 (Mar 1, Mar 29):** the trailing 4-week fasted mean against the previous one (≥12 readings per 4 weeks; no data → hold). Target −1.2 kg per 4 weeks. Slower than −0.6 → the off-plan lever (the social protocol, or planning the unplanned days — whichever the daily files show is leaking), then −100 kcal carbs. Faster than −1.6 → +100 carbs.

In every read: upper loads falling on 2+ lifts across two sessions → +100 carbs regardless of the scale. The weekly waist tape is the fat-specific cross-check: ≥1 cm per 4 weeks confirms fat; a flat waist with a falling scale is water or lean.

### Phase 9 — Maintenance + spring race (Apr 13 – Jun 14)

The Build tiers, re-based on the cut's closing weight (roughly −50 kcal per kg lost), set at the Apr 12 close. The spring 10K is raced at maintenance.

### Phase 10 — Lean-out, optional (Jun 15 – Jul 26)

Only if stage 1 fell short: Phase 9 tiers −250/day, ≤0.25 kg/wk, P170 / F60, the same rest floor. Skip it if the loads and the mirror say the fat is gone.

## Social Days

The athlete has **1–2 social evenings a week, usually with alcohol**. Each runs roughly +1,500 kcal over tier, worth +300–430 kcal/day averaged over the week. Together with unlogged intake on unplanned days, they explain the seven flat weeks at ~2,015 kcal that closed Phase 5. They are a term in every calorie equation, not a moral question.

- **Protein first:** the day's floor is met before the meal out (the afternoon anchor is non-negotiable that day).
- **Drinks capped:** the athlete sets the cap before the evening; 2–3 is the working number.
- **Logged as social** in the daily file (one word). The day's tier is not touched.
- **The next day is re-tiered to Rest**, whatever it was. That is the whole compensation: no further cutting, no added cardio, no skipped feeds.
- **In a cut**, a second social day in the week fires the flex-day flag below; in the build, the band catches it.

### Social Flex Rule (cut phases)

One flex day per week at maintenance calories absorbs social events, family meals and imperfect days. The weekly average is the governing metric; the protein floor still applies; a 7-day average within 5% of the phase target is compliant. Two or more flex days in one week → flag it and consider pulling a diet break forward.

### Consecutive Low-Cal Rule (cut phases)

No more than 2 consecutive Rest-tier days; a 3rd moves up one tier (+100–150 kcal, carbs).

## Meal Distribution

**4 feeds on easy/rest days, 5 on quality/long/strength days. A fixed midafternoon protein snack anchors every day; breakfast every day, run small to fund the snack.**

The governed variable is **protein distribution, not meal count**: ≥3 feeds of ≥30 g protein (each clearing the leucine threshold), with dinner ≥40 g. Meal frequency is fat-loss-neutral at fixed calories. Intermittent fasting was dropped because it compressed protein into two boluses.

**The midafternoon snack is an adherence anchor.** A planned afternoon protein feed blunts the athlete's evening hunger and keeps him off night grazing. It is **funded by a smaller breakfast, never added on top**: a snack on top of three full meals is ~+250 kcal/day.

- **Easy / rest days — 4 feeds:** small breakfast → lunch → midafternoon snack → dinner → small dessert. No post-run shake: breakfast is the post-run meal. The day lands on its tier either way; dropping the shake is structure, not a deficit lever.
- **Quality / long / strength days — 5 feeds:** breakfast (after the run on quality/long days) → post-session shake within 30 min → lunch (largest carb) → midafternoon snack → dinner → small dessert. Keep the snack small and protein-forward so it does not crowd the peri-workout carb.
- **Midafternoon snack:** ~200–280 kcal, ≥30 g protein, low fat, ~15:30–16:30 — a skyr or Greek-yogurt + whey bowl (`meal-rotation.md` § Snacks). Skyr clears 30 g whey-free; the athlete's Greek yogurt is protein-weak (~5.3 g/100 g) and needs ½–1 scoop whey.
- **Late feeds:** dinner finishes ~2–3 h before bed and the small post-dinner dessert ≥60–90 min before bed. Sleep onset is the live constraint, so keep late feeds small.
- **Race days:** breakfast 2–3 h pre-race.

Easy runs under 60 min may be run fasted by preference, with breakfast straight after. Strength, quality, long-run and race sessions are not fasted.

| Feed | Easy / rest | Quality / long / strength |
| --- | --- | --- |
| Breakfast (07:00–09:00) | Small: eggs ± a little oats, ~300 kcal, 25–35 g P | 30–40 g P + carbs; after the run on quality/long days |
| Pre-session | — | Banana + coffee before quality/long |
| Post-session shake | — | Whey + carb, within 30 min |
| Lunch (13:00–14:00) | Larger, ~50–55 g P | Post-workout, largest carb, ~45 g P |
| Midafternoon snack (15:30–16:30) | ~30–40 g P, low fat | ~30 g P, small |
| Dinner (19:30–20:30) | ≥40 g P | ≥40 g P |
| Dessert | Small, ≥60–90 min before bed | Small, ≥60–90 min before bed |

Fat is the binding constraint on the lower tiers: hold whole eggs to ~3 and take the snack's protein from lean skyr + whey. **Dinner ≥40 g protein is non-negotiable on PM lift days.**

### Carbohydrate Partitioning on Double Days

Default training is clustered before lunch; Legs is the sole after-lunch session (`training.md` § Double-Day Guidelines).

- **Pre-lunch double:** post-run shake plus breakfast are the pre-lift fuel (~35–45% of the day's carbs). Lunch is the post-workout meal and carries the largest carb feed. Do not back-load carbs to dinner.
- **Legs day (PM, typically Thursday):** lunch is the pre-lift meal (~35–45% of the day's carbs, 2–3 h before). Dinner is the post-workout meal: a large carb feed plus ≥40 g protein.

### Meals and shakes

Portion-locked cards and the build portions live in `meal-rotation.md`. Shakes use unsweetened almond milk (~30 kcal a cup) unless the day's tier needs the liquid calories trimmed, then water. Creatine is never carried by a shake; it goes in the morning coffee (`supplements.md`).

**Fruit.** At lunch there is no post-lunch fruit: the sweet-craving slot is 0-cal gelatin, so lunch carries the full starch portion. At dinner and other meals, a smaller starch portion plus fruit afterwards is fine, matched by carbohydrate grams (mechanics in `meal-rotation.md` § Fruit Dessert Swap). Fruit in oat breakfasts and the post-dinner dessert is separate. Fruit and rice do not swap one-for-one — rice carrying 22 g C also brings ~2 g protein and ~2 g oil — so state whether calories or carbs give.

## Performance Fueling

| Run Type                           | Pre-Run               | Timing            |
| ---------------------------------- | --------------------- | ----------------- |
| Easy/Base <60 min                  | Fasted or breakfast, by preference | —      |
| Easy/Base <60 min after poor sleep | 1 banana              | 20-30 min before  |
| Easy 60-90 min                     | Optional banana       | 30 min before     |
| Long Run                           | 1 banana + coffee     | 30 min before     |
| Tempo/Intervals                    | 1 banana + coffee     | 30 min before     |
| Race                               | 50-80 g easy carbs    | 2-3 h before      |

Before a **quality or long run**, pre-run is at most banana + coffee and breakfast lands after. Before an **easy run**, breakfast may sit either side. On a pre-lunch double, breakfast is never dropped: it sits between the run and the lift. After a <6 h night, do not run fasted.

## Hydration and Heat Rules

- **Daily guide 3.5–4.5 L fluids, steered by urine colour (pale straw), not by a litre count; avoid compulsive overdrinking.** The lab hydration flag rests on one concentrated spot sample (urine SG 1.021, osmolality 750 mOsm/kg). A urine-SG strip re-test on 3 fasted mornings is pending (`calendar.md`): if ≥2 read >1.020 the guide stands, otherwise it relaxes to ~3.0 L. Heavy salt intake raises the water requirement.
- Quality, long or hot days: +500–1,000 mL.
- **Pre-run sodium** (Quality, Long, or >24 °C): 600–800 mg sodium with 500 mL water, 60–90 min pre-run, to start the session euhydrated. Kept modest because daily salt is already high (1 g+ risks GI distress).
- Runs >60–75 min in warm weather: 400–700 mL fluid/hour and 300–600 mg sodium/hour.
- **Potassium ~3,500–4,000 mg/day from food** (potato ~900 mg, cooked spinach ~840 mg/cup, beans ~700 mg/cup, banana ~400 mg, salmon ~400 mg, Greek yogurt ~250 mg/cup). A multivitamin covers <5%.
- **Magnesium ~400 mg/day** (pumpkin seeds ~150 mg/oz, cooked spinach ~150 mg/cup, almonds ~80 mg/oz, 70%+ dark chocolate ~65 mg/oz). Supplement spec in `supplements.md`.

Under-hydration raises heart rate at a given pace, which contaminates the HR-governed prescriptions.

### Paired Weigh-In and Sweat Rate

On morning-run days the athlete weighs twice: fasted pre-run, and immediately post-run.

- **The fasted pre-run reading is the only trend entry.** Wake, void, naked, scale, then eat or drink.
- **The post-run reading is a hydration metric only** and runs ~0.8–1.0 kg below the fasted one. Ignore its BIA channel entirely.
- For a usable sweat rate: weigh before the post-run shake, nude and towel-dried, and record fluid drunk. **Sweat rate ≈ (pre − post + fluid drunk) ÷ running hours.** Reference: ~1.2–1.4 L/h at threshold in 21 °C / 94% RH.
- **Flag any session finishing >2% of bodyweight down (~1.5 kg):** performance degrades there, and it means the pre-run fluid and sodium were skipped or insufficient.

## Race Fueling

### 10K

- Final 3 days: the day-type tier carbs (no carb load for a 10K), reduced fiber, familiar foods.
- Race morning: 50–80 g easy carbs, 500 mL water, caffeine ~230 mg 30–60 min pre-race.
- No in-race fueling.

### HM / Trail 90-120 min (reference; none planned before June 2027)

- 36–48 h pre-race: 6–8 g/kg/day carbohydrate.
- Breakfast 3–4 h pre-start: 1–1.5 g/kg carbohydrate.
- In-race: 30–45 g carbohydrate/hour; fluids 400–700 mL/hour; sodium 300–600 mg/hour in moderate-to-warm conditions.
- Practise mid-run fueling on 2–3 long runs >75 min beforehand, with race-day products.

## Tracking and Adjustments

**Daily:** eat to the `/plan` meal table or the portion-locked rotation, fasted morning weigh-in, protein floor. There is no digital food logging: the weighed portions are the mechanism and the 7-day fasted trend is the feedback loop. The trend uses fasted morning readings only; check timestamps, because post-run readings run ~0.9 kg low.

**Weekly:** 7-day fasted mean (with its reading count) against the phase band or rate.

| Signal | Action |
| --- | --- |
| 7-day average stalls 2+ weeks (cut phases) | −100 kcal from carbs. In the build the band governs |
| 7-day average drops >0.8 kg/week | +100 kcal, carbs |
| Upper loads fall on 2+ lifts across two sessions | +100 kcal, carbs |
| Strength <2/3 sessions in a week | Cut phases: −75–100 kcal next week, carbs first. Build and maintenance: flag only, fixed by scheduling (athlete's call) |
| Motivation <2 for 3+ days | One refeed day at the day's tier +300, carbs |
| Low motivation 5+ days (cut phases) | Consider pulling a diet break forward |
| Pain severity 3+ (cut phases) | The day's tier +330 (≈ maintenance) that day and the next |
| Sleep <5 h for 2 nights (cut phases) | The day's tier +330 for 1–2 days |
| 3+ days without a daily file in a week | Flag in the weekly report |

## Diet Breaks and Refeeds

Cut 3 has no scheduled break; Phase 9 maintenance follows it. One unplanned refeed per week is available in a cut: use it rather than hold it in reserve, and log it without guilt. Pull a one-week break at the Build tiers forward if upper loads keep falling after the +100, or if quality-session pace-at-HR degrades across two consecutive sessions.

# NUTRITION PROTOCOL - MASTER

> **Recalibrated 2026-05-05** to lab-measured LBM (59.6 kg, Bod Pod 2026-04-28). Prior tables were anchored to BIA-estimated LBM (53.9 kg) which underestimated BMR by ~120 cal/day. Estimated BMR (Katch-McArdle): 1,657 kcal. Weekly average TDEE estimate: **~2,240 kcal** (2026-05-29 recalibration against actual May-block load), rising to **~2,310** at the current 35-42 km/wk; the original ~2,425 estimate assumed a higher training load that did not materialise. Validate against 14-day weight + cal tracking and adjust ±150 cal as the trend dictates.

## Daily Targets

**Macro Minimums (Non-Negotiable):**

- **Protein Floor:** **165 g** in the reverse, build and maintenance phases (6, 7, 9); **170 g** in the cut phases (4, 5, 8, 10). Phase-aware — see the per-phase tables.
- **Fat Floor:** **65 g** in phases 6, 7 and 9; **60 g** in the cut phases (4, 5, 8, 10).

On the lowest-calorie days, protein and fat come first. Carbs flex around training demand.

### Phases 1-3 (completed) — archived

Moved to `protocols/archive/nutrition-phases-1-3.md` (2026-07-31).

### Phase 4 - Cut Block 1 (May 30 - Jul 5)

Target rate: ~0.26-0.3 kg/wk (~325 cal/day average deficit). Slow on purpose — at 21.7% start BF, larger deficits compromise LBM. The tiers below already include the 2026-05-29 TDEE recalibration (−100 kcal/tier vs the original draft) and are the **single source of truth**; `current-status.md` and `meal-rotation.md` defer to this table. **Reconfirm at the ~Jun 11 14-day weigh-in trend:** if loss <0.2 kg/wk, trim a further ~75 kcal; if >0.4 kg/wk or LBM/strength drops, add back.

| Day Type        | Calories | Protein | Carbs | Fat  |
| --------------- | -------- | ------- | ----- | ---- |
| Rest            | 1,750    | 165 g   | 140 g | 60 g |
| Easy / Strength | 1,950    | 165 g   | 190 g | 60 g |
| Quality         | 2,200    | 165 g   | 250 g | 60 g |
| Long Run        | 2,400    | 165 g   | 300 g | 60 g |

Average week: ~2,000 calories. (Original draft averaged ~2,100; recalibrated down after actual May-block load implied a true TDEE ~2,240 rather than the assumed ~2,425. Old pre-2026-05 plan ran ~1,886 — too aggressive for this BF.)

### Phase 5 - Cut Block 2 (Jul 6 - Sep 20, extended 2026-07-31)

Slightly steeper deficit toward end. Target ~0.4 kg/wk (~400 cal/day deficit).

**Extension to Sep 20 (athlete decision 2026-07-31, with the A-race moved to Dec 12):** the original Aug 30 end date existed to fuel a Sep 1 peak block; with the peak now Oct 26 - Dec 12, September is build volume and tolerates ~3 more deficit weeks (~1.0-1.4 kg ≈ 1.5 BF points, landing ~72.5-73 kg / ~17.5-18%). Conditions: the Aug 4 checkpoint and its tripwires stay binding; if the compound-stress guardrail or quality pace-at-HR degradation fires in September, the reversal pulls forward to ~Sep 14. **Sep 20 is a hard stop regardless of the scale** — remaining leanness belongs to the post-Dec cut, not race prep.

**Tiers trimmed −100 kcal (carbs only) effective 2026-07-22, then RESTORED effective 2026-08-04** when the Aug 4 checkpoint fired. The trim's history: the weigh-in-protocol audit of 2026-07-21 established that the apparent mid-July descent was a measurement artifact (post-run readings compared against morning readings) and that morning-to-morning weight had been **flat since ~Jun 24**, firing the standing *7-day average stalls 2+ weeks* rule. Two clean weeks later the loss rate came in at 1.4–1.7× design and the checkpoint returned the 100 kcal. **Rest is deliberately never taken below 1,750:** at the 170 g protein and 60 g fat floors a 1,650 rest day forces carbs to ~107 g, and rest-day carbs below 130 g were explicitly rejected on 2026-05-06.

**Live tiers (restored 2026-08-04):**

| Day Type        | Calories | Protein | Carbs | Fat  |
| --------------- | -------- | ------- | ----- | ---- |
| Rest            | 1,850    | 170 g   | 157 g | 60 g |
| Easy / Strength | 1,950    | 170 g   | 183 g | 60 g |
| Quality         | 2,250    | 170 g   | 258 g | 60 g |
| Long Run        | 2,450    | 170 g   | 308 g | 60 g |

*Superseded trimmed tiers, in force 2026-07-22 → 2026-08-03: Rest 1,750 / C132 · Easy 1,850 / C158 · Quality 2,150 / C235 · Long 2,350 / C285.*

> **Carb columns corrected 2026-07-31** (flagged by `/plan` Jul 27 and Jul 28): the Rest and Easy rows carried carb values whose macros summed to ~1,800 and ~1,900 kcal against their stated tiers — a leftover from raising protein 165 → 170 g without re-deriving carbs. The kcal tier is the governing number, so carbs are derived from it: with P170 (680 kcal) and F60 (540 kcal) fixed, carbs = (tier − 1,220) ÷ 4. The restored rows above follow the same derivation.

Average week: **~2,015 calories**. Protein nudges up to 170 g to extra-insure LBM as BF drops. **The protein and fat floors never scale with a trim or a restore** — the entire movement is carbohydrate.

Target rate rises to ~0.45-0.5 kg/wk. Watch for the cost: if lean mass declines 2+ weeks, quality-session pace-at-HR degrades across two consecutive sessions, or the Phase 5 compound-stress guardrail fires, **restore the 100 kcal to carbs first**.

> **Checkpoint record archived 2026-09-29** — the Aug 4 checkpoint and restore, the Aug 11 hold, the dead Aug 31 and Sep 14 reads, the Jul 29 interim read and the creatine confound now live in `protocols/archive/nutrition-phase-5-checkpoints.md`. Phase 5 closed on the Sep 20 hard stop at 74.31 kg.

### Consecutive Low-Cal Rule

No more than 2 consecutive days at the lowest calorie tier for the active phase. If a 3rd consecutive rest/easy day occurs, bump it to the next tier up (+100-150 cal, mostly carbs). This prevents the compounding fatigue and adherence risk of sequential deep-deficit days.

### Social Flex Rule (cut phases)

During cut phases (4, 5, 8, 10), allow 1 flex day per week at maintenance calories. This absorbs social events, family meals, and imperfect tracking days.

- The weekly calorie average is the real governance metric, not daily perfection.
- A flex day is not a cheat day — protein floor still applies.
- If the 7-day calorie average stays within 5% of the phase target, the week is compliant.
- Log the flex day honestly. The weekly report evaluates average, not individual days.
- If 2+ flex days occur in one week, flag it in the daily log and assess whether a diet break should be pulled forward.

### Social Days (all phases — written 2026-09-29)

The athlete has **1–2 social evenings a week, usually with alcohol** (stated at the 2026-09-29 consult). Each runs roughly +1,500 kcal over tier, so they are worth +300–430 kcal/day averaged over the week — the whole plan-day deficit of the last cut. They are one of two explanations on file for seven flat weeks at ~2,015 kcal; the other is intake on unplanned days, since about half the days in Aug–Sep had no daily file and nothing measured what was eaten on them (audit 2026-09-29). They are assumed in every piece of calorie arithmetic in this file; they are not a moral question, they are a term in the equation.

Protocol on a social day:

- **Protein first** — the day's protein floor is met before the meal out (the afternoon anchor is non-negotiable that day).
- **Drinks capped**: the athlete sets the cap before the evening, not during it; 2–3 is the working number.
- **The day is logged as social** in the daily file (one word is enough). The plan-day tiers are not touched.
- **The next day is re-tiered to Rest** regardless of what it was — that is the whole compensation. No further cutting, no added cardio, no skipped feeds. Chasing a surplus with a deficit the next day is how a 2-day event becomes a 4-day one.
- **In the cut**, a second social day in the same week fires the flex-day flag above; in the build, the weight band catches it.

The build's weight trend at known plan tiers measures the combined cost of social and unplanned days (the "drift" in § Phase 8). If it comes out large, the cut gets slower, not the plan days smaller.

### Phases 6-10 — Reverse, Build, Cut 3, Maintenance, Lean-out (redefined by `/consult` 2026-09-29)

> Supersedes the Phase 6-7 reverse-to-2,500 table and its +400 / +550 / race-week rows. The Dec 12 A-race no longer exists to protect; the build goes into the months the athlete naturally eats more, and the deficit into Jan–Apr. Decision sheet, arithmetic and rejected alternatives: `logbook/2026-09/consult-2026-09-29.md`.

**Maintenance is an estimate, not a measurement.** Bottom-up: BMR 1,657 (Katch-McArdle, 59.6 kg lean) × 1.2 ≈ 1,990, plus ~350/day from 35–40 km and ~130/day from three lifts ≈ **~2,450**. The history disagrees with itself — July's trimmed tiers (~1,915 avg) lost weight at a rate implying ~2,500, August's restored tiers (~2,015) held flat, implying ~2,100 on plan days with unlogged social days as the reconciliation. The build's weight band (below) is the instrument that resolves it; the cut tiers are derived from what it shows, not from this paragraph.

#### Phase 6 — Reverse (Sep 21 – Oct 11)

| Week | Offset on the Phase 5 live tiers | Rest | Easy / Strength | Quality | Long |
| --- | --- | --- | --- | --- | --- |
| 1 (Sep 21) | +100 — historical; execution unknown | — | — | — | — |
| 2 (Sep 28) — declared re-entry week | +200 | 2,050 | 2,150 | 2,450 | 2,650 |
| 3 (Oct 5) → **the Build tiers below** | +300 | 2,150 | 2,250 | 2,550 | 2,750 |

The Oct 5 step goes ahead on schedule and needs no data.

#### Phase 7 — Build (Oct 12 – Jan 4): plan-day tiers at +300

Athlete's call (2026-09-29): the lower of the two candidate tables, as a buffer for 1–2 social days a week with alcohol. Cost named at the time — a build run at a small plan-day deficit adds less muscle than one at full maintenance — and the floor rule below compensates. Protein 165 g (~2.2 g/kg), fat 65 g on every tier; **carbs = (tier − 1,245) ÷ 4**, and every row sums.

| Day type | Calories | Protein | Carbs | Fat |
| --- | --- | --- | --- | --- |
| Rest | 2,150 | 165 g | 226 g | 65 g |
| Easy / Strength (any easy run, any lift, or both) | 2,250 | 165 g | 251 g | 65 g |
| Quality | 2,550 | 165 g | 326 g | 65 g |
| Long | 2,750 | 165 g | 376 g | 65 g |

Week average on the reference week (1 rest, 4 easy/strength, 1 quality, 1 long — `training.md` § Phases 6-10): **~2,350** (~2,340 on a 2-rest week). With 1–2 social evenings at roughly +1,500 each, the true weekly average sits ~2,650–2,750 unless § Social Days holds — which is why the band, not the tier, is the governor.

**Build weight band (pre-committed).** Expected 74.5–75.5 kg: the reverse alone returns ~1.0–1.2 kg of glycogen and water (the athlete's own July 2026 data), so a rise into that band is not fat. **Ceiling 76.0 / floor 73.5**, read on the 7-day fasted mean, and acted on only when **two consecutive weeks each carry ≥4 fasted readings**: above 76.0 → hold the tiers and take 100 kcal off carbs on every row; below 73.5 → add 100 to carbs on every row. No data → hold. A single-week move is noise (100 kcal/day ≈ 0.09 kg/wk against ~0.11 kg of standard error on a two-week difference). First possible read: Oct 26.

Oct 25 (hard effort) and Dec 12 (social) sit inside these tiers as a Quality day and a Long day respectively; pre-race sodium + carbs per § Race and Long-Effort Fueling, no carb load. The Nov 4–8 trek runs on the Long tier on hiking days. Christmas week stays on the tiers with § Social Days applied.

#### Phase 8 — Cut 3 (Jan 5 – Apr 12): tiers derived on Jan 4, not set today

Target rate **0.3 kg/wk** (~330 kcal/day), landing ~70–71.5 kg (~15% on 59.6–60.6 kg lean). Protein rises to **170 g**, fat drops to **60 g**; carbs = (tier − 1,220) ÷ 4. **Rest is never below 1,850** (the standing floor: rest-day carbs never below ~157 g).

**Derivation (pre-committed 2026-09-29; formula corrected by the 2026-09-29 audit):**

    build_tiers = the Build plan tiers, plus or minus any band adjustment that fired
    drift       = 7,700 × the build's fasted-weight slope in kg/wk ÷ 7   (positive if weight rose)
    cut tier    = build_tiers − 330 − drift

The off-plan term (social evenings and unplanned days) is already inside the build's weight trend. If weight held flat at known plan tiers, then plan tiers plus the off-plan surplus equal maintenance, so taking 330 off the plan tiers produces a 330 kcal deficit as long as off-plan behaviour stays the same. The original formula subtracted a separately estimated social term on top of that, which counted it twice: a 300/day term turned a 330 cut into a 630 one. A weight trend also cannot separate the off-plan term from maintenance, so that term was never measurable. It enters the derivation only if off-plan behaviour is expected to change in the cut.

Minimum data: **≥8 readable weeks (≥4 fasted readings each) of the 12** to fit the slope. Below that, drift is taken as zero and the default is the Build tiers −330 with the rest floor binding: **Rest 1,850 / Strength 1,920 / Quality 2,220 / Long 2,420**. If drift comes out at ≥300/day (the build rose ≥0.27 kg/wk despite the band), the honest choice is a 0.2 kg/wk cut with the social protocol enforced, not a −630 plan day — a plan-day deficit the athlete will not hold is worth less than a smaller one he will.

**Rate read #1 (Feb 1)** uses the least-squares slope of the fasted readings over cut weeks 2–4 (Jan 12 – Feb 1, ≥9 readings; no data → hold), against a target of −0.3 kg/wk. Slower than −0.15 kg/wk → the off-plan lever first, then −100 kcal carbs. Faster than −0.4 kg/wk → +100 carbs. Week 1 is excluded because the carb step drops glycogen water, and a mean-versus-mean read is wrong here: the previous four weeks are a flat build, so at the design rate the difference would be only ~−0.6 kg and would sit exactly on the trigger (audit 2026-09-29).

**Rate reads #2 and #3 (Mar 1, Mar 29)** compare the trailing 4-week fasted mean with the previous one; both windows are inside the cut (≥12 readings per 4 weeks; no data → hold). Target −1.2 kg per 4 weeks. Slower than −0.6 → the off-plan lever first (the social protocol, or planning the unplanned days — whichever the daily files show is leaking), then −100 kcal carbs. Faster than −1.6 → +100 carbs. Strength loads falling on 2+ upper lifts across two sessions → +100 carbs regardless of the scale. The weekly waist tape is the fat-specific cross-check: ≥1 cm per 4 weeks confirms fat; a flat waist with a falling scale is water or lean.

#### Phase 9 — Maintenance + spring race (Apr 13 – Jun 14)

The Build tiers, re-based on the cut's closing weight (roughly −50 kcal per kg lost) — set at the Apr 12 close. The spring 10K is raced at maintenance; race-week fueling per § Race and Long-Effort Fueling.

#### Phase 10 — Lean-out, optional (Jun 15 – Jul 26)

Only if stage 1 fell short: Phase 9 tiers −250/day, ≤0.25 kg/wk, P170 / F60, the same rest floor. Skip it if the loads and the mirror say the fat is gone.

#### Meal structure across all phases

Unchanged: 4 feeds on rest/easy days, 5 on strength/quality/long days, the fixed midafternoon protein anchor funded by a small breakfast, iso with dinner, creatine 5 g in the morning coffee. See § Meal Distribution.

## Performance Fueling

| Run Type                           | Pre-Run               | Timing            |
| ---------------------------------- | --------------------- | ----------------- |
| Easy/Base <60 min                  | FASTED if well-rested | Water/coffee only |
| Easy/Base <60 min after poor sleep | 1 banana              | 20-30 min before  |
| Easy 60-90 min                     | Optional banana       | 30 min before     |
| Long Run >90 min                   | 1 banana + coffee     | 30 min before     |
| Tempo/Intervals                    | 1 banana + coffee     | 30 min before     |
| Race                               | 50-80 g easy carbs    | 2-3 h before      |

If sleep was <6 h, do not force fasted running.

**Breakfast and running depend on intensity (athlete-corrected 2026-07-31, refined 2026-08-03):** before a **quality or long run**, pre-run is at most banana + coffee and breakfast lands after the run. Before an **easy run**, breakfast may sit either side — the athlete runs easy on breakfast fine (`[[feedback-no-breakfast-before-run]]`). On pre-lunch double days breakfast is never dropped: it sits between the run and the lift and is the lift's fuel (a whey shake can bridge if the lift is close).

## Meal Distribution

**Eating structure: 4 feedings on easy/rest days, 5 on quality/long/strength days (revised 2026-06-22). A fixed midafternoon protein snack anchors every day. Breakfast every day, run small to fund the snack.**

The governed variable is **protein distribution, not meal count.** Meal frequency and timing are irrelevant to fat loss — total daily calories and protein drive that. What protects lean mass during the cut is hitting **≥3 protein feedings of ≥30 g each** (each clearing the leucine threshold), with the pre-bed feed ≥40 g. The 4-5 feed structure clears that comfortably. (This is why IF was dropped in May — it compressed protein into *2* boluses in an 8-hour window; the spread feeds do not have that problem.)

**The midafternoon snack is an adherence anchor, not a macro requirement (2026-06-22).** The athlete reports that a planned afternoon protein feed blunts evening hunger and keeps him off a night-grazing pattern — a real compliance lever for *him*. Because meal count is fat-loss-neutral, the snack costs nothing on macros and the extra protein bolus is marginally LBM-positive, so it is adopted on every day. **Critical constraint: the snack is funded by a smaller breakfast, never added on top.** A snack treated as a freebie alongside three full meals is ~+250 kcal/day and feeds the stall directly — so breakfast runs small (eggs ± a little oats, ~300 kcal) and the snack carries the calories that left it. The day stays on its tier; only the distribution changes. This revises the 2026-06-18 "fewer, larger meals" structure: the athlete now prefers *less in the morning plus a guaranteed afternoon feed*, which costs nothing and improves adherence.

- **Easy / rest days — 4 feeds:** small breakfast → big lunch → **midafternoon protein snack** → pre-bed dinner. **No separate post-run shake** — breakfast is the post-run meal (an easy/short run does not need pre-run carbs *and* a shake *and* breakfast). Dropping the shake is a structural choice, not a deficit lever: the day lands on its tier either way (the "~240 kcal lever" claim was retired by the 2026-09-29 audit). Breakfast runs small to fund the afternoon snack; lunch and dinner stay the anchors.
- **Quality / long / strength days — 5 feeds:** breakfast → post-workout shake (within 30 min; the session earns it) → lunch (post-workout, largest carb) → **midafternoon protein snack** → dinner ≥40 g. On these days the snack is the least necessary feed — the morning shake already spreads protein — but is kept for habit consistency; keep it small and protein-forward so it does not crowd the peri-workout carb.
- **Midafternoon snack (all days):** ~200-280 kcal, protein-forward (≥30 g, low fat) — a skyr or Greek-yogurt + whey bowl is the default (see `meal-rotation.md` § Snacks). Timed ~15:30-16:30 to bridge lunch → dinner and pre-empt evening appetite. Skyr (high-protein) clears the 30 g bolus whey-free; the athlete's staple Greek yogurt is protein-weak (~5.3 g/100 g) and needs ½-1 scoop whey to clear it.
- **Late-feed timing:** dinner finishes ~2–3 h before bed, and the small post-dinner dessert (`[[feedback-post-dinner-snack-hunger]]`) lands **≥60–90 min before bed**. Sleep onset is the live constraint, so keep late feeds small and away from bedtime. (The former "stop eating ~3 h before bed" window contradicted the dessert every build day carries and was relaxed by the 2026-09-29 audit.)
- **Race days:** breakfast 2-3 h pre-race regardless.

Easy short runs (<60 min, well-rested) may still be done fasted by preference — breakfast then comes immediately after the run, not skipped. Strength, quality, long-run, and race-day sessions are not fasted.

### Rest / Easy Day — 4 feeds (~1,750-1,950 cal Phase 4)

| Meal               | Time        | Notes                                                          |
| ------------------ | ----------- | -------------------------------------------------------------- |
| Breakfast (small)  | 07:00-09:00 | Protein-forward but **run small** — eggs ± a little oats (~300 kcal, ~25-35 g protein), held down to fund the afternoon snack |
| Lunch              | 13:00-14:00 | **Larger** — protein + carb + veg + fat (~50-55 g protein)     |
| Midafternoon snack | 15:30-16:30 | Skyr / Greek-yogurt + whey bowl (~30-40 g protein, low fat). The adherence anchor — blunts evening appetite |
| Dinner             | 19:30-20:30 | **Larger** — protein + carb + veg, ≥40 g protein. Finish ~2–3 h before bed; the small dessert follows it. |

Four feeds keep protein in ≥3 boluses ≥30 g (lunch, snack, dinner clear it; the small breakfast may run under and is the lighter fourth). Fat is the binding constraint at the easy/rest tier — hold whole eggs to ~3 and take the snack's protein from lean skyr + whey so fat lands at the ~60 g floor, not over it. The snack is **funded by the smaller breakfast, not added on top** — the day stays on tier.

### Quality / Long / Strength Day — 5 feeds (~2,050-2,750 cal depending on phase + session)

| Meal               | Time             | Notes                                                            |
| ------------------ | ---------------- | ---------------------------------------------------------------- |
| Breakfast          | 07:00-09:00      | 35-50 g protein + carbs (B1-B4 from meal rotation).              |
| Pre-session snack  | 30-45 min pre    | Optional if breakfast was recent. Banana + whey on quality/long. |
| Post-session shake | within 30 min    | 35-45 g whey + carb (no creatine — the daily dose rides the morning coffee, `supplements.md`). **This is the feed dropped on easy days.** |
| Lunch              | 13:00-14:00      | Protein + carb + veg + fat (post-workout, largest carb)          |
| Midafternoon snack | 15:30-16:30      | Small, protein-forward — kept for habit consistency; do not let it crowd the peri-workout carb |
| Dinner             | 19:30-20:30      | Protein + carb + veg, ≥40 g protein. Finish ~2–3 h before bed; the small dessert follows it. |

Protein and fat stay mostly constant; carbs move up or down with day type and session. **An easy run is not a 5-feed day** — it follows the 4-feed easy/rest structure above (no separate post-run shake; breakfast is the post-run meal). Reserve the shake for quality, long, and strength sessions, which need the recovery fuel.

### Protein Distribution Rule

Aim for **≥3 protein feedings that each clear the leucine threshold (~30 g+)**, with the last (pre-bed) feed ≥40 g. The 4-feed easy/rest and 5-feed quality/long structures both clear this; the small breakfast may run below 30 g without breaking the rule, since lunch, snack, and dinner carry it.

- **Easy / rest (4 feeds):** breakfast ~25-35 / lunch ~50-55 / snack ~30-40 / dinner ~45-55 g
- **Quality / long / strength (5 feeds):** breakfast ~30-40 / shake ~35 / lunch ~45 / snack ~30 / dinner ~45-55 g

Breakfast is Feed 1 every day, even when small.

### Quality / Long Run Day

Layered on the training-day template, add roughly 300 calories, mostly carbs:

- Pre-run banana: +100 cal
- Post-run shake: add 40 g oats, +120 cal
- Lunch: extra 30 g rice or equivalent, +75 cal

### Carbohydrate Partitioning on Double Days

Default training is clustered before lunch (run before breakfast, upper lift before lunch). Legs is the sole after-lunch session — see `training.md` § Double-Day Guidelines.

**Default (pre-lunch double — run before breakfast, upper lift before lunch):**

- Post-run shake plus breakfast are the pre-lift fuel — land roughly 35-45% of the day's carbs there so the lift is fed.
- **Lunch is the post-workout meal** — place the largest single carb feed here, right after the lift.
- Snack and dinner carry the remainder; do not back-load most of the day's carbs to dinner.

**Legs day (PM, after lunch — typically Thursday):**

- Lunch is the pre-lift meal — ~35-45% of the day's carbs in the 2-3 h before the session.
- Dinner is the post-workout + pre-bed protein meal — a large carb feed plus ≥40 g slow protein.

## Meal Options

### Post-Workout Shake

- 35 g whey + 1 banana + ~250 mL unsweetened almond milk (creatine is not carried here — morning coffee, `supplements.md`)

> Athlete default liquid for shakes: unsweetened almond milk (~30 kcal / cup, +1 g P / +1 g C / +2.5 g F vs water). Substitute water only when the calorie tier is the lowest of the active phase and the liquid kcal need to be trimmed.

### Lunch

- Chicken and rice
- Salmon and potatoes
- Lean beef bowl
- Eggs and toast

### Snack

- Greek yogurt (250 g) + whey (15 g) + almonds + berries
- Full protein shake + apple + almond butter
- Cottage cheese + whey or skyr + fruit

### Dinner

- Steak and veg
- Chicken stir-fry
- Fish and quinoa
- Turkey meatballs and pasta

### Fruit Dessert Swap (athlete preference)

The athlete prefers a smaller starch portion at lunch and dinner with a piece of fruit afterwards as dessert, rather than a large serving of rice or potato. Cap the starch at a comfortable portion and take the remaining day-type carbs as fruit, matched by carbohydrate grams so the day's calorie and carb totals are unchanged. Mechanics, carb equivalences, and the quality/long-day guardrail live in `meal-rotation.md` § Fruit Dessert Swap.

> **Post-lunch slot: reversed 2026-08-06 (athlete decision).** The post-lunch fruit is retired — the athlete now uses **0-cal gelatin** for the sweet-craving role, so that slot's carbohydrate is **folded back into lunch** rather than taken as fruit. For lunch the swap therefore runs the other way: **spec the larger starch portion.** The mechanic above stays live for **dinner** and for the general "smaller starch, fruit after" preference at any other meal. Scope this narrowly — fruit stirred into oat breakfasts (mango / strawberries, for palatability) and the post-dinner skyr + berries dessert are **unaffected**; this is not a "no fruit" rule.
>
> **The fold is not one-for-one.** Fruit is near-pure carbohydrate (~95 kcal per 22 g C); rice carrying the same carbs also brings ~2 g protein and ~2 g of batch cooking oil (~113 kcal). The swap cannot be simultaneously calorie-neutral and carb-neutral — choose which one gives, and say so in the plan rather than absorbing the difference silently.

## Hydration and Heat Rules

- Daily guide: **3.5-4.5 L fluids, governed by urine colour (pale straw), not a litre count.** The lab measured one concentrated spot sample (urine SG 1.021, osmolality 750 mOsm/kg, 2026-04-28). That is a measured fact, but one sample cannot show a chronic deficit, so the "chronic" label is an assumption until the urine-SG strip re-test (`calendar.md`): if ≥2 of 3 fasted mornings read >1.020, the guide stands; if not, it relaxes to ~3.0 L. Heavy daily salt intake increases the water requirement; it does not substitute for it.
- Quality, long, or hot-weather days: add 500-1000 mL above baseline
- **Pre-run sodium loading** (Quality, Long Run, or temps >24 C): 600-800 mg sodium with 500 mL water 60-90 min pre-run. The aim is to start the session euhydrated; this dose is far too small to expand plasma volume meaningfully (sodium-loading protocols use several grams), so do not claim that for it. It is not additive to daily intake. `running.md` § Heat defers to this line. Dose kept modest because daily salt is already high — 1 g+ pre-run risks GI distress at this baseline
- For runs >60-75 min in warm weather: 400-700 mL fluid/hour and 300-600 mg sodium/hour
- **Daily potassium target ~3,500-4,000 mg from food.** Sources: potato (~900 mg), banana (~400 mg), cooked spinach (~840 mg/cup), Greek yogurt (~250 mg/cup), salmon (~400 mg/serving), beans (~700 mg/cup). A standard multivitamin covers <5% of this — must come from food
- **Daily magnesium target ~400 mg.** Food sources: pumpkin seeds (~150 mg/oz), almonds (~80 mg/oz), cooked spinach (~150 mg/cup), dark chocolate 70%+ (~65 mg/oz). Multis typically cover only 12-25%; supplemental Mg glycinate **200-350 mg** pre-bed is acceptable (kept at or below the 350 mg supplemental UL, since the food target already supplies ~400 mg). Benefit for sleep onset is modest and evidence-light — keep it because Mg is well-tolerated and corrects a common dietary shortfall, not as a primary sleep lever. (Single supplement spec lives in `supplements.md`.)
- Use normal thirst plus urine color as a simple check. Avoid compulsive overdrinking.

### Paired Weigh-In and Sweat-Rate Tracking (from 2026-07-21)

On days with a **morning run**, the athlete weighs **twice**: fasted pre-run, and again immediately post-run. The two readings serve different purposes and must never be mixed.

- **The fasted pre-run reading is the sole weight-trend entry.** Wake, void, naked, scale, then eat or drink. Same scale, same spot.
- **The post-run reading is a hydration metric only.** It never enters the weight trend, the 7-day average, or any body-composition claim. A post-run reading runs roughly **0.8-1.0 kg below** the same morning's fasted reading (measured pairs: 0.84 kg on 2026-07-15, 1.04 kg on 2026-07-21).
- **Ignore the BIA channel on post-run readings entirely.** Peripheral blood flow and skin sweat corrupt it — two readings 76 seconds apart on 2026-07-21 disagreed by 1.1 points of body water and 1.0 point of body fat.

For the sweat number to be usable: weigh **before the post-run shake**, nude and towel-dried, and **record fluid drunk during the run**.

**Sweat rate ≈ (pre-weight − post-weight + fluid drunk) ÷ running hours.** Reference: ~1.2-1.4 L/h at threshold effort in 21 °C / 94 % RH (2026-07-21).

**Flag any session finishing more than 2% of bodyweight down** — about **1.5 kg** at current weight. That is the level at which performance measurably degrades, and it indicates the pre-run 500 mL and sodium load were skipped or were insufficient for the conditions.

> Why this matters here: the athlete carries a standing lab flag for chronic under-hydration (urine SG 1.021, osmolality 750 mOsm/kg, 2026-04-28). Under-hydration raises heart rate at any given pace through plasma-volume loss, which contaminates the HR-governed prescriptions this stack runs on.

## Race and Long-Effort Fueling

### 10K

- Final 3 days: the day-type tier carbs (no separate carb load for a 10K — § Phase 7), reduce fiber, use familiar foods
- Race morning: 50-80 g easy carbs, 500 mL water, caffeine ~230 mg 30-60 min pre-race
- No in-race fueling needed

### HM / Trail 21K Reference

- 36-48 h pre-race: 6-8 g/kg/day carbohydrate
- Breakfast 3-4 h pre-start: 1-1.5 g/kg carbohydrate
- In-race: 30-45 g carbohydrate/hour
- Fluids: 400-700 mL/hour depending on heat
- Sodium: 300-600 mg/hour in moderate-to-warm conditions

## Tracking and Adjustments

**Daily:** eat to the portion-locked rotation (`meal-rotation.md`) or the `/plan` meal table, **fasted morning weigh-in** (plus the post-run hydration reading on morning-run days — see § Paired Weigh-In and Sweat-Rate Tracking), confirm the protein floor. Digital food-logging is not used — the weighed portion plan is the mechanism and the 7-day weight trend is the feedback loop.

> **The trend is built from fasted morning readings only.** Mixing post-run readings into it produced a false ~0.9 kg descent across Jul 12-21 and a `/report` conclusion that had to be retracted. Timestamps, not just values, must be checked when auditing the series.

**Weekly:** compute 7-day weight average, 7-day calorie average, and Sunday body-comp trend.

| Signal                                  | Action                                               |
| --------------------------------------- | ---------------------------------------------------- |
| 7-day weight average stalls 2+ weeks    | **Cut phases only (4, 5, 8, 10 — scoped 2026-09-29 audit).** Reduce daily target by 100 cal from carbs. In the build a flat weight is the design; the § Phase 7 band governs there |
| 7-day weight average drops >0.8 kg/week | Add 100 cal, carbs first                             |
| Motivation <2 for 3+ days               | Insert an unplanned refeed day at the day's tier +300 (carbs). The old fixed 2,300 sat below the build's Quality and Long tiers |
| Upper loads fall on 2+ lifts across two sessions | Raise calories 100, carbs first (§ Phase 8). Replaces "lean mass declines 2+ weeks": BIA lean mass is creatine- and hydration-sensitive and no Bod Pod re-test is planned, so loads are the only lean-mass instrument (2026-09-29 audit) |
| 3+ untracked days in a week             | Flag in weekly report and audit honestly             |
| Strength compliance <2/3 sessions in a week | **Cut phases only (4, 5, 8, 10 — scoped 2026-09-29).** Reduce next week's daily targets by 75-100 cal (carbs first); flag in weekly report. Calories are "earned" by stimulus — but at the weekly level, not punitively same-day. In the reverse, build and maintenance phases (6, 7, 9) missed strength is **flagged only** and fixed by scheduling, never by calories (athlete's call at the 2026-09-29 consult: no automatic structural downshift either) |
| Low motivation 5+ days                  | Consider moving diet break earlier                   |
| Pain severity 3+ in cut phase           | The day's tier +330 (≈ maintenance) for that day plus the next day (matches `mobility.md`) |
| Sleep <5 h for 2 nights                 | Use maintenance calories for 1-2 days                |

### Phase 5 Guardrail Against Compound Stress

If 3 or more of the following occur in the same week during Cut Block 2:

- Sleep Score <65 average
- Easy-run HR elevated >3 bpm
- Strength regression on 2+ exercises
- Motivation <3 for 3 days

**Action (corrected 2026-09-07 — the old text said "raise rest-day targets to 1,750," written when Rest was 1,650; against the restored 1,850 tier that sentence would have *cut* the athlete):** add **+100 kcal (to carbs) to the Rest tier** until the next deload week or diet break. **In September, firing this guardrail additionally pulls the Phase 5 reversal forward to ~Sep 14** (§ Extension above).

### Reverse Diet Monitoring Note

> Superseded 2026-09-29 by the § Phase 7 build weight band (ceiling 76.0 / floor 73.5 on two consecutive ≥4-reading weeks). The reverse now ends at the +300 tiers on Oct 5 with no further step, so there is nothing left for this note to gate; the principle — a jump beyond the glycogen/water rebound is a hold, not a signal to rise — lives on in the band.

### Dinner Protein Rule (renamed from "Pre-Bed Protein Rule", 2026-09-29 audit)

Dinner contains **≥40 g of protein** (mixed dinner protein; casein-rich dairy counts). Non-negotiable on PM lift days. It is the last of the ≥3 boluses the distribution rule needs. The overnight-MPS rationale that used to be attached here belongs to a feed eaten ~30 min before sleep; it does not transfer to a dinner eaten 2–3 h before bed, so it is no longer claimed.

## Diet Breaks

| When           | Duration        | Calories                | Notes                                   |
| -------------- | --------------- | ----------------------- | --------------------------------------- |
| May 5-25       | 3 weeks         | ~2,400 avg              | Re-entry + race block, no deficit       |
| ~~Jul 27 - Aug 2~~ | ~~1 week~~  | ~~2,400~~               | **CANCELLED 2026-07-21** — see below    |
| Sep 21 - Oct 11 | 3 weeks gradual | 2,150 -> ~2,290 -> ~2,340 | Reverse diet into the build (cut hard stop Sep 20). **Final step re-set 2026-09-29 to the +300 Build tiers**, not +400 — see § Phases 6-10 |
| Apr 13 - Jun 14 2027 | 9 weeks | Build tiers re-based | Maintenance between Cut 3 and the optional lean-out; spring 10K inside it |

**Jul 27 - Aug 2 break cancelled (athlete decision, 2026-07-21).** The Jul 6-12 holiday functioned as the break — travel and restaurant eating at or above maintenance, three weeks ahead of schedule. A second break so soon after is redundant, and the athlete's priority is maximum leanness entering the September peak block.

The accepted cost is an **unbroken deficit from Jul 13 to Aug 30 (~7 weeks)**, now at the trimmed tiers. **Reinstate a break or a refeed week immediately if any of these fire:**

- the Phase 5 compound-stress guardrail (see above)
- lean mass declining 2+ weeks
- quality-session pace-at-HR degrading across two consecutive sessions

The standing allowance of one unplanned refeed per week remains available and should be used rather than held in reserve.

Unplanned refeed days: maximum 1/week during cut blocks. Log them without guilt.

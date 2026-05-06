# Independent Review: Three AI Training Plans

> **Reviewer:** GitHub Copilot (Claude Opus 4.6), acting as independent sports scientist
> **Date:** 2026-03-26
> **Athlete:** 39M, 172cm, 76.8kg/29.2% BF, 10K PR 49:57
> **Goals:** Body recomp → 70-72kg/21-23% BF by Aug-Sep 2026 + 10K sub-46:00 by Oct 25
> **Plans reviewed:** Claude v2, GPT v2, Gemini v2

---

## Context Note

All three plans were generated from the same design spec (`docs/superpowers/specs/2026-03-26-post-hm-holistic-plan-design.md`), so they share identical goals, phase structures, and athlete profiles. The differences lie in how each agent translated the spec into executable protocol files — depth of decision rules, edge cases, internal consistency, and actionability.

---

# Step 1: Individual Plan Analysis

## Claude Plan

| Dimension                      | Score | Justification                                                                                                                                                                                                                                                                                                                                                                            |
| ------------------------------ | ----- | ---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| **Scientific soundness**       | 8     | Correct use of MAF-based HR zones, Norwegian sub-threshold model, polarized distribution. Phase-specific volume ceilings reasonable (15-55 km/wk). ACWR monitoring included. Deload every 4th week in strength aligns with Helms et al. (2014) for trained lifters in deficit. Minor: zone table has labeling inconsistency (Zone 2 mislabeled as "Sub-Threshold" in one spot).          |
| **Nutrition quality**          | 8     | Calorie cycling well-implemented (1,600-2,300 range across phases). Protein floor of 160-165g (2.0-2.3 g/kg) aligns with Helms et al. (2014) and Hector & Phillips (2018) for lean mass preservation during deficit. Fat floor of 55g (~0.7 g/kg) preserves hormonal function. Phase 5 deepest deficit (1,600 rest days) is aggressive but includes mandatory diet breaks.               |
| **Recovery & sleep**           | 6     | Recovery triggers are present (BB <30 = rest, Sleep Score <60 = skip quality, HRV drop >15% = optional rest). However, no systematic sleep-disruption decision tree. The "family priorities" constraint is acknowledged in coaching.md but never operationalized into if/then rules. Deload weeks present in training (every 4th week) and diet breaks scheduled for metabolic recovery. |
| **Specificity to goals**       | 8     | Addresses both body recomp and 10K performance with clear priority hierarchy that shifts by phase. 10K-pace intervals introduced in Cut Block 1 (May 26), VO2max reserved for Phase 6 when maintenance calories support recovery. Race calendar correctly integrated.                                                                                                                    |
| **Practicality**               | 7     | Double-day structure (AM run, PM lift) realistic for WFH. 6-8h gap reasonable. Eating window (12:30-21:00) maintained. However, 6-7 training sessions per week in Phase 4-5 is very demanding during a 400-500 cal deficit for a 39yo with fragmented sleep. The total training time commitment (~8-10h/week) is high.                                                                   |
| **Completeness**               | 9     | Most complete of the three. Has dedicated files for: coaching, nutrition, running, training, mobility, supplements (with finasteride compatibility), body composition tracking, logging, planning, and reporting. Exercise rotation rules are excellent. Only gap: no explicit sleep-disruption decision tree.                                                                           |
| **Flexibility & adaptability** | 7     | Has numeric back-off triggers (BB <30, RHR +5, Sleep <60) and nutrition adjustment triggers (weight stall 2 weeks, lean mass decline 2 weeks). Missing: no graduated response to poor sleep (e.g., "4h sleep → do X" vs "6h sleep → do Y"). The "if energy is low for PM lift, reduce volume by one set" is good but not granular enough.                                                |

**Overall: 7.6/10**

---

## GPT Plan

| Dimension                      | Score | Justification                                                                                                                                                                                                                                                                                                                                                                                                                    |
| ------------------------------ | ----- | -------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| **Scientific soundness**       | 8     | Identical HR zone framework and periodization structure. Adds specific 10K pacing strategy (4:45/km start → 4:36-4:39 settle → kick km 9-10) which shows race-execution depth. Correctly limits VO2max to "late Cut Block 1 and Phase 6 when calories support it." Strength taper in Phase 6 (3→2→1x/wk) well-structured.                                                                                                        |
| **Nutrition quality**          | 8.5   | Most detailed nutrition protocol. Phase 3 race-block nutrition has day-by-day calorie targets (not just day-type buckets). Race week nutrition (10K) includes carb-loading specifics: "300g+ carbs final 3 days, reduce fiber." The 10K race-morning protocol (50-80g easy carbs + 230mg caffeine) is actionable. Includes numerical adjustment triggers (weight stall → -100 cal from carbs, lean mass decline → +100-200 cal). |
| **Recovery & sleep**           | 7     | Has the most specific warning-sign thresholds of all three plans: BB <30 = full rest; Sleep <60 for 2 nights = skip quality; HRV drop >15% = optional rest; RHR +5 = reduce volume 20%. Also adds "fewer than 2 strength sessions for 2 consecutive weeks → mandatory 2x20 min full-body" which is a smart failsafe against session-skipping during deficit fatigue. Still no formal sleep-duration decision tree.               |
| **Specificity to goals**       | 8     | Same dual-goal structure as Claude. Unique addition: actual logged strength baselines (bench 40kg, squat 60kg, OHP 30kg, barbell row 40kg) — this means the plan is anchored to real numbers, not theoretical. Includes right-knee pain history tracking as mandatory constraint.                                                                                                                                                |
| **Practicality**               | 7     | Same double-day demands as Claude. Adds a useful "do not skip by default — reduced stimulus beats no stimulus" philosophy for low-energy PM sessions. But total load remains high for a cutting 39yo.                                                                                                                                                                                                                            |
| **Completeness**               | 8.5   | Standalone supplements.md file with full schedule and finasteride verification. Missing the exercise rotation rules that Claude has (explicit "never repeat same selection 2 weeks in a row"). Training template covers exercises but relies on the coach to rotate rather than encoding it. Commands are well-structured.                                                                                                       |
| **Flexibility & adaptability** | 7.5   | Has more nutrition-adjustment triggers than Claude (5+ specific signals with actions). Cut-phase pain escalation rule (severity 3+ → immediate bump to 2,300 for 2 days) is excellent and unique. The "low motivation 5+ consecutive days → consider pulling diet break forward" is a practical safety valve.                                                                                                                    |

**Overall: 7.8/10**

---

## Gemini Plan

| Dimension                      | Score | Justification                                                                                                                                                                                                                                                                                                                                                 |
| ------------------------------ | ----- | ------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| **Scientific soundness**       | 7.5   | Same framework, but has a duplicate Zone 2 row in the HR zones table (Aerobic Base listed twice, Sub-Threshold missing its own zone number). This is a copy-paste error that could cause confusion during execution. Periodization structure correct. Phase overview table uniquely includes projected BF% column — useful for progress benchmarking.         |
| **Nutrition quality**          | 8     | Identical nutrition protocol to GPT. Phase 3 day-by-day targets present. Diet break structure sound. Same macro floors and adjustment triggers. Well-organized. One concern: meal options section says "keep in mind macro minimums and adapt portion sizes" without the specific gram-level meal templates that Claude provides (which are more actionable). |
| **Recovery & sleep**           | 6.5   | Same warning-sign triggers as the other plans. Cut-phase pain escalation rule present. However, key metrics section in current-status.md is populated with vague qualifiers ("Balanced," "Good," "Low") rather than actual numbers, whereas GPT's has real values (HRV 57ms, RHR ~54, Sleep 82). This reduces the precision of daily decision-making.         |
| **Specificity to goals**       | 7.5   | Goals correctly stated. Phase timeline table is the most informative (includes avg cal, running km/wk, strength sessions, projected BF% in one view). But lacks the actual 10K race pacing protocol — running.md has "sub-46:00 realistic, sub-45:00 stretch" but no km-by-km pacing plan.                                                                    |
| **Practicality**               | 7     | Same fundamental demands as the other two. No unique adaptation for reduced capacity.                                                                                                                                                                                                                                                                         |
| **Completeness**               | 7     | No standalone supplements.md — references coaching.md for supplement guidance, which only mentions "check finasteride interactions" as a rule rather than providing a dosing schedule. Strength baselines are empty (no logged weights). No exercise rotation rules encoded. Commands are well-structured but in a subdirectory rather than inline.           |
| **Flexibility & adaptability** | 7     | Same triggers as GPT's training.md. Includes deload every 3rd week in Cut Block 2 (vs Claude's every 4th) — this is actually more defensible given the accumulated fatigue at 14+ weeks of cutting. Diet break pull-forward option present.                                                                                                                   |

**Overall: 7.2/10**

---

# Step 2: Comparative Analysis

## 1. Strengths Unique to Each Plan

| Plan       | Unique Strengths                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                      |
| ---------- | --------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| **Claude** | **Exercise rotation rules** — explicitly encodes "never repeat the same exercise selection two weeks in a row" with a swap-at-least-2-3 rule. This is absent from both GPT and Gemini and is critical for hypertrophy stimulus in a trained lifter. Also has the most detailed **core programming guidance** (5 movement categories, 18+ sets/week minimum across 3 sessions). Most **complete file coverage** — every protocol domain has its own dedicated file.                                                                                                    |
| **GPT**    | **Real logged baselines** — the only plan with actual strength numbers (bench 40kg, squat 60kg, OHP 30kg). This matters for progressive overload decisions. Has the most **detailed race-day pacing** for the 10K A-race (4:45 start → 4:36-4:39 settle → hold → kick). Includes the **mandatory minimum strength failsafe** (2x20 min full-body if <2 sessions for 2 weeks). Best **nutrition adjustment table** — 8 specific signal→action pairs covering weight stalls, energy crashes, lean mass decline, motivation drop, HR elevation, and tracking compliance. |
| **Gemini** | **Phase overview table** is the most information-dense — includes avg cal, running km/wk, strength sessions/wk, AND projected BF% in a single view. More **aggressive deloading in Cut Block 2** (every 3rd week vs every 4th/6th), which is more appropriate for accumulated fatigue at 14+ weeks of cutting. Also the only plan that explicitly duplicates coach-primer rules in the AGENTS.md in a way that references pre-run carb fueling for all runs >90 min "directly into plan" (not just as a nutrition.md reference).                                      |

## 2. Weaknesses Unique to Each Plan

| Plan       | Unique Weaknesses                                                                                                                                                                                                                                                                                                                                                                                                                                                       |
| ---------- | ----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| **Claude** | Deload frequency in strength is every 4th week, which may be overly aggressive for the early phases (Phase 2) where training load is moderate, and potentially too infrequent for Phase 5 where deficit + fatigue accumulate. A fixed 1:3 work:deload ratio isn't optimally responsive to actual recovery status.                                                                                                                                                       |
| **GPT**    | No exercise rotation rules — depends entirely on the AI "remembering" to rotate exercises, which is a fragile implementation. Also, the rep ranges in the training templates shift between "4x8-10" (training.md for legs) and "4x8-12" (matching Claude's hypertrophy spec). The inconsistency between 6-8 reps (spec squat) and 8-10 reps (training template leg day) suggests the training.md was not fully harmonized with the spec.                                |
| **Gemini** | Missing supplements.md — the most critical gap. A 39yo male on finasteride running 35-50 km/week during a caloric deficit absolutely needs a documented supplement stack with interaction checks. Relying on "check finasteride interactions" as a coaching rule is insufficient. Also has a zone table error (Zone 2 listed twice, Zone 3 missing its number). Empty strength baselines — without actual logged weights, progressive overload tracking can't function. |

## 3. Points of Consensus (High-Confidence Recommendations)

All three plans agree on these elements — these are likely correct:

| Area                               | Consensus                                                                                                                                         |
| ---------------------------------- | ------------------------------------------------------------------------------------------------------------------------------------------------- |
| **6-phase structure**              | Post-HM Recovery (2 wk) → Base Rebuild + Cut (4 wk) → May Race Block (2 wk) → Cut Block 1 (6 wk) → Cut Block 2 (8 wk) → Reverse + 10K Peak (8 wk) |
| **HR zones**                       | MAF-based. Easy: <142 treadmill / <148 outdoor. Sub-threshold: 148-168 outdoor. Threshold: 168-175. VO2max: 175-185.                              |
| **Protein floor**                  | 160g minimum (Phases 1-4), 165g (Phases 5-6). Approximately 2.0-2.3 g/kg.                                                                         |
| **Fat floor**                      | 55g minimum (~0.7 g/kg) for hormonal health.                                                                                                      |
| **Calorie cycling**                | Rest/easy days lower (1,600-1,750), quality/long-run days higher (2,050-2,100). Not flat.                                                         |
| **Thursday rule**                  | Always rest from running. Legs on Thursday.                                                                                                       |
| **Double-day structure**           | AM run, PM lift. 6-8h gap. Run first, lift second. Reduce lift volume if fatigued.                                                                |
| **Diet breaks**                    | May 12-25 (race block), Jul 27 – Aug 2 (mid-cut), Sep 1-21 (reverse diet).                                                                        |
| **Fasted easy runs**               | OK for <60 min. Pre-run carbs mandatory for quality sessions and long runs >90 min.                                                               |
| **Daily mobility**                 | 10 min, hip flexor / thoracic / ankle / posterior chain. Non-negotiable.                                                                          |
| **Pain escalation during deficit** | Severity 3+ during cut phases → immediate bump to maintenance (2,300 cal) for 2 days.                                                             |
| **BB <30 at wake**                 | Full rest day.                                                                                                                                    |
| **Phase 1 maintenance calories**   | 2,300 flat. No deficit. Recover from HM.                                                                                                          |

## 4. Points of Conflict

### Conflict 1: Deload Frequency in Cut Block 2

| Plan   | Approach                                                          |
| ------ | ----------------------------------------------------------------- |
| Claude | Every 4th week (strength deload: -40% volume)                     |
| GPT    | Every 3rd week (running: mini-deload to 35 km, 1 quality session) |
| Gemini | Every 3rd week (same as GPT for running)                          |

**Verdict: GPT/Gemini are correct.** By Phase 5 (week 16+ of training, week 10+ of deficit), accumulated fatigue is significant. A 1:2 work:deload ratio is better supported by Issurin (2010) for athletes in caloric restriction. Claude's Phase 5 also uses mini-deloads every 3rd week for running, but its strength deload cadence (every 4th week) doesn't match. Strength and running deloads should be synchronized.

### Conflict 2: Strength Rep Ranges

| Plan               | Leg Day Squat | General Hypertrophy |
| ------------------ | ------------- | ------------------- |
| Claude             | 4x8-12        | 3-4x8-12            |
| GPT (training.md)  | 4x8-10        | 4x8-12              |
| GPT (spec-derived) | 4x6-8         | —                   |
| Gemini             | 4x6-8         | 3-4x8-12            |

**Verdict: Claude's 4x8-12 is most appropriate.** For a deficit-phase hypertrophy program at maintenance-level strength ambition, the 8-12 rep range maximizes mechanical tension without the CNS fatigue of heavy 6-8 rep work. Schoenfeld (2021) meta-analysis shows equivalent hypertrophy across 6-30 reps when taken close to failure — but the 8-12 range offers the best fatigue management during energy restriction. The 6-8 rep range from the spec is better suited for a strength-priority program, not a body-recomp-during-cut program.

### Conflict 3: Supplements Documentation

| Plan   | Approach                                                                                                 |
| ------ | -------------------------------------------------------------------------------------------------------- |
| Claude | Full schedule in supplements.md, includes "recently removed" section with rationale and revisit triggers |
| GPT    | Standalone supplements.md with schedule and finasteride compatibility                                    |
| Gemini | No supplements file. References coaching.md rule only.                                                   |

**Verdict: Claude's approach is best.** The "recently removed" section prevents re-adding supplements that were dropped for good reason (B12 elevated on bloodwork, ashwagandha/L-theanine not being taken). The finasteride compatibility table (which supplements have 5AR properties, which are neutral) is clinically relevant. GPT's version is adequate but less informative. Gemini's omission is a clear gap.

### Conflict 4: Current-Status Metric Precision

| Plan   | Key Metrics Populated?                                      |
| ------ | ----------------------------------------------------------- |
| Claude | Mostly blank ("—") with instructions to update via /report  |
| GPT    | Real values (HRV 57ms, Sleep 82, RHR ~54, BB 48, Stress 20) |
| Gemini | Qualitative only ("Balanced," "Good," "Low")                |

**Verdict: GPT is correct.** The current-status file should contain the most recent actual values because the `/plan` command reads it to make training decisions. Claude's blank fields with "update via /report" instructions create a chicken-and-egg problem on first use. Gemini's qualitative labels are vague and defeat the purpose of data-driven coaching. Numeric values with dates are the standard.

### Conflict 5: Exercise Rotation Encoding

| Plan            | Approach                                                                               |
| --------------- | -------------------------------------------------------------------------------------- |
| Claude + Gemini | Explicit rotation rules: "never repeat exact same exercise selection 2 weeks in a row" |
| GPT             | No rotation rules. Relies on AI memory.                                                |

**Verdict: Claude/Gemini are correct.** Encoding the rule in the protocol file is essential because LLM context windows are limited. Without an explicit rule, the AI coach will default to the same exercises repeatedly. The rule should be in training.md, not dependent on institutional memory.

---

# Step 3: Master Plan Synthesis

This unified plan takes the best elements from all three agents, resolves conflicts using the verdicts from Step 2, and fills the gaps none of them covered (sleep-disruption decision tree, adaptation triggers).

## 1. Weekly Training Structure

### Template by Phase

**Phase 1: Post-HM Recovery (Mar 30 – Apr 12)**

| Day | Running                       | Strength                             | Day Type | Cal   |
| --- | ----------------------------- | ------------------------------------ | -------- | ----- |
| Mon | Rest (wk1) / Easy 5km (wk2)   | —                                    | Rest     | 2,300 |
| Tue | Easy 4-5km                    | Light full-body wk1 / Upper Push wk2 | Easy     | 2,300 |
| Wed | Easy 4-5km                    | —                                    | Easy     | 2,300 |
| Thu | **REST from running**         | Legs (light, RPE 5-6) wk2 only       | Rest     | 2,300 |
| Fri | Rest (wk1) / Easy 5-6km (wk2) | Upper Pull wk2 only                  | Easy     | 2,300 |
| Sat | Rest                          | —                                    | Rest     | 2,300 |
| Sun | Easy 6-7km                    | —                                    | Easy     | 2,300 |

**Phase 2: Base Rebuild + Cut (Apr 13 – May 11)**

| Day     | Running               | Strength              | Day Type    | Cal       |
| ------- | --------------------- | --------------------- | ----------- | --------- |
| Mon     | Easy 5-6km            | Upper Push (PM)       | Easy        | 1,750     |
| **Tue** | **Quality session**   | —                     | **Quality** | **2,100** |
| Wed     | Easy 5-6km            | Upper Pull (PM)       | Easy        | 1,750     |
| **Thu** | **REST from running** | **Legs (PT or self)** | Rest        | 1,750     |
| Fri     | Easy 5-6km            | —                     | Easy        | 1,750     |
| Sat     | Rest                  | —                     | Rest        | 1,750     |
| Sun     | Long run 12-14km      | —                     | Long Run    | 2,100     |

**Phases 4-5: Cut Blocks (May 26 – Aug 30)**

| Day     | AM                    | PM                    | Day Type    | Cal (Ph4 / Ph5)   |
| ------- | --------------------- | --------------------- | ----------- | ----------------- |
| Mon     | Easy 6-7km            | Upper Push            | Easy        | 1,750 / 1,700     |
| **Tue** | **Quality 1**         | —                     | **Quality** | **2,100 / 2,050** |
| Wed     | Easy 5-6km            | Upper Pull            | Easy        | 1,750 / 1,700     |
| **Thu** | **REST from running** | **Legs**              | Rest        | 1,650 / 1,600     |
| **Fri** | **Quality 2**         | —                     | **Quality** | **2,100 / 2,050** |
| Sat     | Easy 5-6km            | Optional arms (30min) | Easy        | 1,750 / 1,700     |
| Sun     | Long run 14-16km      | —                     | Long Run    | 2,100 / 2,050     |

**Phase 6: Reverse + 10K Peak (Sep 1 – Oct 25)**

Same running template (Tue/Fri quality, Sun long). Strength tapers:

- Weeks 1-5: Push Mon, Pull Wed, Legs Thu (3x/wk)
- Weeks 6-7: Push Mon, Pull Wed only (2x/wk). Thursday = pure rest.
- Week 8 (race week): 1x light upper Mon/Tue, RPE 5

### HR Zone Targets by Session Type

| Session                   | HR Target (Outdoor) | RPE  |
| ------------------------- | ------------------- | ---- |
| Easy/Base                 | <148 bpm            | 3-4  |
| Long Run                  | <148, drift max 150 | 4-5  |
| Sub-Threshold (Norwegian) | 148-168             | 7-8  |
| 10K-Pace Intervals        | 160-172             | 8-9  |
| VO2max                    | 175-185             | 9-10 |

### Pre-Run: Daily 5 Warm-Up (every run)

1. Pogo Hops — 30s
2. A-Skips — 30s
3. Leg Swings (Front/Back) — 30s/side
4. Leg Swings (Lateral) — 30s/side
5. Walking Lunges — 30s

---

## 2. Periodization Overview (30-Week Macro View)

| Wk    | Dates           | Phase              | Run km/wk | Quality               | Long Run  | Strength     | Avg Cal     | Notes                          |
| ----- | --------------- | ------------------ | --------- | --------------------- | --------- | ------------ | ----------- | ------------------------------ |
| 1-2   | Mar 30 – Apr 12 | Post-HM Recovery   | 15→25     | 0                     | 7km easy  | 1→3x/wk      | 2,300       | Habit building, daily weigh-in |
| 3     | Apr 13-19       | Base Rebuild + Cut | 35        | 0                     | 12km      | 3x/wk        | 1,850       | First deficit week             |
| 4     | Apr 20-26       | Base Rebuild + Cut | 38        | 1x sub-T              | 13km      | 3x/wk        | 1,850       | Quality reintro                |
| 5     | Apr 27 – May 3  | Base Rebuild + Cut | 42        | 1x sub-T              | 14km      | 3x/wk        | 1,850       |                                |
| 6     | May 4-10        | Base Rebuild + Cut | 40        | 1x tempo              | 12km      | 3x/wk        | 1,850       | Mini-deload                    |
| 7     | May 11-17       | May Race Block     | Race week | Sharpener             | 10K Race  | 2x/wk        | 2,200       | **10K race May 17**            |
| 8     | May 18-24       | May Race Block     | Race week | —                     | Trail 21K | 2x/wk        | 2,200       | **Trail 21K May 24**           |
| 9     | May 26 – Jun 1  | Cut Block 1        | 40        | 2x (sub-T + 10K pace) | 14km      | 3-4x/wk      | 1,886       | Double days begin              |
| 10    | Jun 2-8         | Cut Block 1        | 43        | 2x                    | 15km      | 3-4x/wk      | 1,886       |                                |
| 11    | Jun 9-15        | Cut Block 1        | 45        | 2x                    | 15km      | 3-4x/wk      | 1,886       |                                |
| 12    | Jun 16-22       | Cut Block 1        | 35        | 1x easy tempo         | —         | 3x/wk        | 2,300       | **DELOAD + Jun 20 10K race**   |
| 13    | Jun 23-29       | Cut Block 1        | 45        | 2x                    | 16km      | 3-4x/wk      | 1,886       |                                |
| 14    | Jun 30 – Jul 5  | Cut Block 1        | 48        | 2x (VO2max intro)     | 16km      | 3-4x/wk      | 1,886       |                                |
| 15-16 | Jul 6-19        | Cut Block 2        | 40-45     | 2x/wk                 | 15km      | 3-4x/wk      | 1,836       | Deeper deficit                 |
| 17    | Jul 20-26       | Cut Block 2        | 35        | 1x                    | 12km      | 3x/wk        | 1,836       | **Mini-deload**                |
| 18    | Jul 27 – Aug 2  | Cut Block 2        | 40        | 2x                    | 14km      | 3x/wk        | **2,300**   | **DIET BREAK**                 |
| 19-20 | Aug 3-16        | Cut Block 2        | 40-45     | 2x/wk                 | 15km      | 3-4x/wk      | 1,836       |                                |
| 21    | Aug 17-23       | Cut Block 2        | 35        | 1x                    | 12km      | 3x/wk        | 1,836       | **Mini-deload**                |
| 22    | Aug 24-30       | Cut Block 2        | 40        | 2x                    | 14km      | 3-4x/wk      | 1,836       | Final cut week                 |
| 23    | Sep 1-7         | Reverse + Peak     | 42        | 2x sub-T              | 14km      | 3x/wk        | 1,950       | Reverse begins                 |
| 24    | Sep 8-14        | Reverse + Peak     | 45        | 2x (sub-T + 10K)      | 15km      | 3x/wk        | 2,100       |                                |
| 25    | Sep 15-21       | Reverse + Peak     | 48        | 2x (10K pace focus)   | 16km      | 3x/wk        | 2,300       | Maintenance reached            |
| 26-27 | Sep 22 – Oct 5  | Peak               | 50-55     | 2x (10K + VO2max)     | 16-17km   | 3x/wk        | 2,300-2,400 | Peak volume                    |
| 28    | Oct 6-12        | Peak               | 50        | 2x                    | 15km      | 3x/wk        | 2,300-2,400 |                                |
| 29    | Oct 13-19       | Taper              | 40        | 2x (shorter)          | 12km      | 2x/wk        | 2,400       | Volume -20%                    |
| 30    | Oct 20-25       | Race Week          | 15        | 2-3x1km Tue           | —         | 1x light Mon | 2,500       | **10K A-RACE Oct 25**          |

---

## 3. Daily Nutrition Framework

### Macro Targets by Phase and Day Type

| Phase            | Day Type     | Cal         | Protein | Carbs    | Fat |
| ---------------- | ------------ | ----------- | ------- | -------- | --- |
| **1** (Recovery) | All          | 2,300       | 160g    | 230g     | 70g |
| **2** (Base+Cut) | Rest/Easy    | 1,750       | 160g    | 150g     | 60g |
| **2**            | Quality/Long | 2,100       | 160g    | 220g     | 60g |
| **4** (Cut 1)    | Rest (Thu)   | 1,650       | 160g    | 120g     | 58g |
| **4**            | Easy         | 1,750       | 160g    | 150g     | 58g |
| **4**            | Quality/Long | 2,100       | 160g    | 220g     | 60g |
| **5** (Cut 2)    | Rest (Thu)   | 1,600       | 165g    | 100g     | 58g |
| **5**            | Easy         | 1,700       | 165g    | 135g     | 58g |
| **5**            | Quality/Long | 2,050       | 165g    | 200g     | 60g |
| **6** (Peak)     | Wk1          | 1,950       | 165g    | 170g     | 60g |
| **6**            | Wk2          | 2,100       | 165g    | 205g     | 60g |
| **6**            | Wk3+         | 2,300-2,400 | 165g    | 245-260g | 65g |
| **6**            | Race week    | 2,400-2,500 | 160g    | 300g+    | 60g |

### Meal Timing (Eating Window 12:30-21:00)

| Meal               | Time          | Standard Day (~1,750)                                      | Quality/Long Day (~2,100)   |
| ------------------ | ------------- | ---------------------------------------------------------- | --------------------------- |
| Pre-run            | 30 min before | FASTED (<60 min easy)                                      | Banana + coffee (mandatory) |
| Post-workout shake | 12:30         | 35g whey + banana + 5g creatine (280 cal)                  | + 40g oats (+120 cal)       |
| Lunch              | 13:00         | 180g protein + 100g carb + 200g veg + 1 tsp oil (~525 cal) | + 30g rice (+75 cal)        |
| Snack              | 17:00         | 200g Greek yogurt + 15g almonds + berries (~245 cal)       | Same                        |
| Dinner             | 21:00         | 180g protein + 120g carb + 250g veg + 1 tsp oil (~600 cal) | Same                        |

### Hydration

3.5-4L daily. 500ml pre-workout, 400-500ml with each meal, 500ml post-workout.

### Caffeine

- 2-4 cups/day, **hard cutoff 15:00** (13:00 if sleep scores drop)
- Race day: 3mg/kg (~230mg) 30-60 min pre-race

---

## 4. Race-Day Protocol (10K A-Race — October 25)

### 72h Out

| Timing         | Action                                                                                            |
| -------------- | ------------------------------------------------------------------------------------------------- |
| **Wed Oct 22** | Begin carb loading: 300g+ carbs/day. Reduce fiber. Familiar foods only. 2,400-2,500 cal.          |
| **Thu Oct 23** | Rest day. 300g+ carbs. Low fiber. Final easy walk if desired.                                     |
| **Fri Oct 24** | No running. Light 15min walk max. Low-fiber dinner by 19:00. Normal hydration (no overhydration). |

### Morning Of (Oct 25)

| Timing               | Action                                                                             |
| -------------------- | ---------------------------------------------------------------------------------- |
| **Race minus 3h**    | Breakfast: 50-80g easy carbs — 2 slices white toast + banana + honey + 500ml water |
| **Race minus 60min** | Caffeine: 230mg (2 espresso or 1 caffeine pill)                                    |
| **Race minus 30min** | Arrive at start area. Sip 200ml water.                                             |
| **Race minus 15min** | Warm-up: 15-20 min easy jog + 4-6 strides (20s accelerations, walk back)           |
| **Race minus 2min**  | At start corral. 1 deep breath set (4s in, 6s out, x3).                            |

### Race Execution

| Segment | Pace         | HR      | Strategy                                          |
| ------- | ------------ | ------- | ------------------------------------------------- |
| Km 1-2  | 4:45/km      | <165    | **Conservative**. Resist the urge to go out fast. |
| Km 3-5  | 4:36-4:39/km | 165-172 | Settle into goal pace. Lock in rhythm.            |
| Km 6-8  | 4:36-4:39/km | 170-175 | Hold. This is where the race is won or lost.      |
| Km 9    | 4:30-4:36/km | 175-180 | Begin push if legs feel good.                     |
| Km 10   | Max effort   | 180-190 | Empty the tank.                                   |

**Target:** Sub-46:00 realistic. Sub-45:00 stretch.
**No in-race fueling needed** (<50 min).

### Post-Race

- 500ml water + electrolytes immediately
- Post-race shake (whey + banana + creatine) within 30 min
- Full meal within 2h (maintenance calories)
- No running for 3 days minimum

---

## 5. Sleep-Disruption Decision Tree

This is the gap all three plans failed to address. These rules apply every day.

### Morning Assessment Protocol

Upon waking, check three signals: total sleep duration, Garmin Sleep Score, and Body Battery at wake.

```
IF total sleep < 4 hours:
  → FULL REST DAY. No running, no lifting.
  → Eat at maintenance (2,300 cal) regardless of phase.
  → 10-min mobility only.
  → Nap 20-30 min if possible (before 14:00).

IF total sleep 4-5 hours:
  → DOWNGRADE quality session to easy run (cap HR at 142/148).
  → DOWNGRADE double day to single session (drop PM lift).
  → Keep calories at day-type target (do not cut further).
  → Nap if possible.

IF total sleep 5-6 hours:
  → RUN AS PLANNED but reduce quality session volume by 1 rep per set.
  → KEEP PM lift but drop 1 set per exercise.
  → Monitor RPE — if RPE exceeds plan by 2+ points, stop and walk home.

IF total sleep 6-7 hours:
  → TRAIN AS PLANNED.
  → Add 30g carbs to pre-workout meal (extra energy buffer).

IF total sleep >= 7 hours:
  → TRAIN AS PLANNED. Full green light.
```

### Garmin Override Rules (override sleep duration if applicable)

```
IF Body Battery < 30 at wake (regardless of sleep duration):
  → FULL REST DAY.

IF Body Battery 30-50 AND Sleep Score < 60:
  → Apply the "4-5 hours" protocol above even if you slept 6+.

IF Sleep Score < 60 for 2 consecutive nights:
  → Skip quality session. Replace with easy run or rest.
  → Move caffeine cutoff to 13:00 for 5 days.

IF HRV drops > 15% below 7-day average:
  → Optional rest day. If you do run, easy only.
  → If HRV stays depressed for 3+ days, take 2 consecutive rest days.
```

### Consecutive Poor Sleep Escalation

```
2 nights < 5 hours in a row:
  → Skip the next quality session entirely.
  → Eat at maintenance (2,300) for 2 days.

3+ nights < 5 hours:
  → Emergency deload: easy runs only for remainder of week.
  → Eat at maintenance until sleep normalizes (2 nights >= 6h).
  → Do not resume quality until BB > 50 and Sleep Score > 65.
```

---

## 6. Adaptation Triggers

### When to Progress

| Signal                                                         | Threshold                                       | Action                                             |
| -------------------------------------------------------------- | ----------------------------------------------- | -------------------------------------------------- |
| Sub-T intervals feel easy (RPE <6) for 2 sessions              | HR at target but perceived effort drops         | Increase interval duration by 1-2 min or add 1 rep |
| Easy-run pace improves at same HR                              | >10s/km faster at <148 bpm over 4-week MAF test | Aerobic fitness improving. Maintain current plan.  |
| All strength sets at top of rep range (12 reps) for 2 sessions | Double progression trigger                      | Add +2.5 kg, reset to 8 reps                       |
| 7-day weight average dropping 0.3-0.5 kg/wk                    | On-track fat loss                               | Continue current plan                              |
| 10K race result improves                                       | PR at benchmark race                            | Validates training direction                       |

### When to Maintain

| Signal                                      | Threshold               | Action                    |
| ------------------------------------------- | ----------------------- | ------------------------- |
| 7-day weight average dropping 0.3-0.4 kg/wk | On target               | No changes needed         |
| Strength stable (±5% on key lifts)          | Expected during deficit | Hold weights, hold volume |
| Sleep Score averaging 70-80                 | Adequate                | Continue current plan     |
| ACWR 0.8-1.3                                | Sweet spot              | Stay the course           |

### When to Back Off

| Signal                                              | Threshold                                 | Action                                                                                               |
| --------------------------------------------------- | ----------------------------------------- | ---------------------------------------------------------------------------------------------------- |
| RHR elevated >5 bpm for 3+ days                     | Accumulated fatigue or illness            | Reduce weekly volume 20%. Easy only for 3 days.                                                      |
| Easy-run HR elevated 5+ bpm at same pace for 3 runs | Cardiac drift / overreaching              | Add extra rest day. If persists 1 week, take 3-day block off.                                        |
| Strength regresses >10% for 2 sessions              | Deficit too deep or recovery insufficient | Drop from 4 sets to 3, keep weight. If persists, raise easy-day cals +100.                           |
| 7-day weight avg drops >0.8 kg/wk                   | Losing too fast (muscle risk)             | Add 100 cal (carbs first)                                                                            |
| 7-day weight avg stalls for 2+ weeks                | Metabolic adaptation or tracking error    | Audit tracking. If honest, reduce rest-day cals by 100.                                              |
| Lean mass declining on scale for 2+ weeks           | Muscle loss                               | Raise calories 100-200 (carbs first). Check protein adherence.                                       |
| Motivation <2 for 3+ days                           | Psychological fatigue from deficit        | Insert unplanned refeed day (2,300 cal, extra carbs).                                                |
| Motivation <2 for 5+ days                           | Diet burnout                              | Pull scheduled diet break forward.                                                                   |
| ACWR > 1.3                                          | Training ramp too fast                    | Cap next week's volume at this week's level.                                                         |
| ACWR > 1.5                                          | Injury risk                               | Immediate 20% volume cut.                                                                            |
| ACWR < 0.8                                          | Detraining                                | Increase volume gradually (+10% per week max).                                                       |
| Pain severity 3+ during cut phase                   | Injury risk amplified by deficit          | Bump calories to 2,300 for 2 days. Reduce aggravating volume 30%. If 3 consecutive days, see physio. |

---

## 7. Supplement Recommendations

All verified safe with finasteride 1mg/day.

| Supplement                   | Dose                                 | Timing                                                     | Evidence                                                                                                       | Finasteride Notes                                         |
| ---------------------------- | ------------------------------------ | ---------------------------------------------------------- | -------------------------------------------------------------------------------------------------------------- | --------------------------------------------------------- |
| **Creatine Monohydrate**     | 5g/day                               | Post-workout shake (12:30) or with first meal on rest days | Buford et al. (2007): +8% lean mass, +14% strength. Also supports cognitive function during sleep deprivation. | Safe. No interaction.                                     |
| **Vitamin D3 + K2**          | 4,000-6,000 IU D3 / 100-120mcg K2    | Post-workout (12:30)                                       | Supports testosterone, bone health, immune function. Most adults deficient. K2 directs calcium to bones.       | D3 supports testosterone without DHT risk. Safe.          |
| **Omega-3 Fish Oil**         | 2g EPA/DHA                           | With lunch (13:00). Refrigerate.                           | Anti-inflammatory, cardiovascular health, joint support. Calder (2017).                                        | Neutral re: 5-alpha reductase. Safe.                      |
| **Magnesium**                | 400mg elemental (taurate or citrate) | Before bed (22:00)                                         | Sleep quality, muscle recovery, cramp prevention. Avoid glycinate if it causes insomnia.                       | Safe. No interaction.                                     |
| **Zinc**                     | 20mg bisglycinate                    | With lunch (13:00). Total w/ multi stays <40mg UL.         | Supports testosterone, immune function.                                                                        | Supports free testosterone. Complementary to finasteride. |
| **Multivitamin**             | 1 tablet                             | Post-workout (12:30)                                       | Baseline micronutrient insurance during deficit.                                                               | Safe.                                                     |
| **Caffeine** (race day only) | 230mg (~3mg/kg)                      | 30-60 min pre-race                                         | Ergogenic: 2-4% endurance performance improvement. Ganio et al. (2009).                                        | Safe. No interaction.                                     |

### As-Needed Only

| Supplement              | Dose    | When                                   | Caution                                                                                                                                             |
| ----------------------- | ------- | -------------------------------------- | --------------------------------------------------------------------------------------------------------------------------------------------------- |
| **Curcumin + Piperine** | 1,000mg | Persistent pain/inflammation >48h only | Do NOT take daily during training — suppresses inflammatory signaling needed for adaptation (Trappe 2013). Mild 5AR properties (additive for hair). |

### Removed (Do Not Readd)

| Supplement         | Reason                                               | Revisit                              |
| ------------------ | ---------------------------------------------------- | ------------------------------------ |
| B12 + Folate       | Bloodwork showed B12 elevated; multi covers baseline | Next bloodwork                       |
| Ashwagandha KSM-66 | Not being taken consistently                         | If cortisol/stress becomes a problem |
| L-Theanine         | Not being taken consistently                         | If sleep onset becomes an issue      |

---

## Source Attribution

| Source               | Elements Taken                                                                                                                                                                                                                            |
| -------------------- | ----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| **Claude**           | Exercise rotation rules, core programming categories, detailed exercise templates, supplements "recently removed" tracking, 4x8-12 rep ranges for deficit hypertrophy, deload every 4th week in strength                                  |
| **GPT**              | Real logged baselines, 10K race pacing protocol, nutrition signal→action table (8 triggers), mandatory minimum strength failsafe, actual metric values in current-status, right-knee pain tracking, supplements.md with finasteride table |
| **Gemini**           | Phase overview table with projected BF%, deload every 3rd week in Cut Block 2, cut-phase pain→calorie escalation rule, pre-run carb mandate "directly into plan"                                                                          |
| **Novel (reviewer)** | Sleep-disruption decision tree (all plans missed this), consecutive poor sleep escalation protocol, Garmin override rules for BB/Sleep Score combinations, post-race recovery protocol                                                    |

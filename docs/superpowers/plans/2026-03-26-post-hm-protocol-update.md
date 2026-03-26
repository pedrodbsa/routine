# Post-HM Protocol Update — Implementation Plan

> **For agentic workers:** REQUIRED SUB-SKILL: Use superpowers:subagent-driven-development (recommended) or superpowers:executing-plans to implement this plan task-by-task. Steps use checkbox (`- [ ]`) syntax for tracking.

**Goal:** Update all protocol files so the `/plan` command generates correct daily plans for each phase of the 30-week post-HM holistic plan (beach body + 10K peak).

**Architecture:** The daily plan generation reads `protocols/current-status.md` for the current phase, then consults domain-specific protocol files for phase-appropriate targets. Each protocol file needs a phase-aware section so the correct calories, volumes, and structures are used depending on the current date. The `/plan` and `/body` commands also reference hardcoded targets that need updating.

**Spec:** `docs/superpowers/specs/2026-03-26-post-hm-holistic-plan-design.md`

---

## File Map

| File | Action | Responsibility |
|---|---|---|
| `protocols/current-status.md` | Modify | Phase timeline, goals, race calendar, body comp targets |
| `protocols/running.md` | Modify | Periodization table, race schedule, 10K-specific workout types |
| `protocols/training.md` | Modify | Weekly structure, hypertrophy shift, double-day template, progression rules |
| `protocols/nutrition.md` | Modify | Phase-aware calorie cycling tables, long-run fueling, daily weigh-in protocol |
| `protocols/mobility.md` | Modify | Add pain back-off rule with severity thresholds, cut-phase recovery emphasis |
| `protocols/daily-template.md` | Modify | Add ACWR field, daily weigh-in field, day type field |
| `protocols/coaching.md` | Verify | Confirm coaching rules still apply post-HM; no changes expected |
| `protocols/supplements.md` | No change | Already current |
| `.claude/commands/plan.md` | Modify | Update macro targets, add phase-awareness |
| `.claude/commands/log.md` | Modify | Add day-type awareness, daily weigh-in support |
| `.claude/commands/body.md` | Modify | Update body comp targets |
| `.claude/commands/report.md` | Modify | Update body comp targets, add ACWR/weekly-weight checks, phase transitions |
| `AGENTS.md` | Modify | Update coaching primer, reconcile command naming |

---

### Task 1: Update `protocols/current-status.md`

**Files:**
- Modify: `protocols/current-status.md`

This is the file every plan generation reads first. It must reflect the new phase, goals, and timeline.

- [ ] **Step 1: Update Goals & Priorities section**

Replace the current goals block with:

```markdown
## Goals & Priorities

**Primary:** Body recomposition — 76.8kg/29.2% BF → 70-72kg/21-23% BF by August-September 2026
**Secondary:** 10K PR — sub-46:00 at October 25 A-race (current PR: 49:57)

**Priority order (cut phases):** Fat loss = Muscle retention > Running performance > Recovery optimization
**Priority order (peak phase, Sep-Oct):** Running performance > Muscle retention > Body maintenance > Recovery

**Success metrics:** Body composition (weekly 7-day avg) → Strength maintenance → Running performance → Energy & mood
```

- [ ] **Step 2: Update Phase & Timeline section**

Replace with the 6-phase timeline from the spec (Phase Overview table, spec lines 48-57). Include current phase marker. Set `Current Phase` to whichever phase is active based on the current date.

- [ ] **Step 3: Update Race Schedule**

Replace the old race schedule with the post-HM calendar:

```markdown
## Race Schedule

| Date | Distance | Race | Priority | Target |
|---|---|---|---|---|
| ~~Mar 29~~ | ~~HM~~ | ~~Meia Maratona de Fátima~~ | ~~A-Race~~ | ~~Sub-1:48~~ |
| May 17 (Sun) | 10K | TBD | Fun/benchmark | Run on feel, sub-49 |
| May 24 (Sun) | 21K Trail | TBD | Fun/adventure | Easy-moderate, HR cap 155 |
| Jun 20 (Sat) | 10K | TBD | Benchmark | Fitness check mid-cut |
| **Oct 25 (Sun)** | **10K** | **TBD** | **A-Race** | **Sub-46:00** |
```

- [ ] **Step 4: Update Body Composition section**

The body comp history table was already added during brainstorming. Verify it's present and update targets to match the spec (target outcome table, spec lines 24-32).

- [ ] **Step 5: Update Training Load section**

Clear the old Feb 9-15 training load. Replace with a note that training load is tracked weekly in daily files and ACWR is computed in the weekly report.

- [ ] **Step 6: Update Key Metrics section**

Clear old Feb 15 metrics. Replace with current values from Garmin (Mar 26 data). Add a note that these are updated via `/report` weekly (per `AGENTS.md` workflow — `/plan` writes to the daily file, `/report` updates `current-status.md`).

- [ ] **Step 7: Update Adherence section**

Update targets to match the new plan's non-negotiables:
- Nutrition days tracked: 7/7 (was already 7/7)
- Protein >= 160g: 7/7
- Calories within day-type target +/- 10%: 7/7
- Garmin Sleep Score >= 75: 5/7
- Strength sessions: 3/3
- Daily weigh-in: 7/7 (NEW)
- Mobility: 7/7 (NEW)

- [ ] **Step 8: Update Coaching Log**

Add entry for Mar 26 decision: "Approved 30-week concurrent cut + 10K peak plan (Approach B). Spec at `docs/superpowers/specs/2026-03-26-post-hm-holistic-plan-design.md`."

- [ ] **Step 9: Remove stale sections**

Remove or update:
- "Upcoming Week Plan (Feb 16-22)" — stale
- "MAF Compliance" table — keep the concept but clear old data
- "Strength Baselines" — keep structure, update with most recent logged weights from daily files
- "Fitness Age & Race Prediction Regression" — move to coaching log as historical context

- [ ] **Step 10: Verify and read back**

Read the full file to confirm internal consistency. Verify the `Last verified` date is updated to today.

---

### Task 2: Update `protocols/running.md`

**Files:**
- Modify: `protocols/running.md`

The running protocol must shift from HM-specific to 10K-focused periodization.

- [ ] **Step 1: Update Key Context**

No changes needed — the cardiovascular limiter, post-smoking context, and observed LT are still valid.

- [ ] **Step 2: Update Current Periodization table**

Replace the old periodization (Base → Quality Reintro → HM-Specific → Taper) with the 6-phase table from the spec. Mark the **CURRENT** phase based on the execution date — do NOT hardcode a phase as current. Use date comparison: if today falls within a phase's date range, mark it `(CURRENT)`. All phases whose end date has passed get `(COMPLETE)`. Future phases get no marker.

```markdown
### Current Periodization

| Phase | Dates | Focus | Volume |
|---|---|---|---|
| Base (COMPLETE) | Dec 2025 – Feb 16 | All <142 bpm | 35-45 km/wk |
| Quality Reintro (COMPLETE) | Feb 17-22 | 2 quality sessions/wk | 35 km/wk |
| HM-Specific (COMPLETE) | Feb 23 – Mar 22 | 2-3 sub-T sessions/wk | 45-55 km/wk |
| Taper + HM Race | Mar 23-29 | Volume -70%, maintain intensity | 15 km/wk |
| Post-HM Recovery | Mar 30 – Apr 12 | Easy only, habit building | 15-25 km/wk |
| Base Rebuild + Cut | Apr 13 – May 11 | 1 quality/wk, aerobic rebuild | 35-45 km/wk |
| May Races | May 12-25 | 10K + Trail 21K (fun) | Race weeks |
| Cut Block 1 (10K speed) | May 26 – Jul 5 | 2 quality/wk, double days | 40-50 km/wk |
| Cut Block 2 | Jul 6 – Aug 30 | 2 quality/wk, deload every 3rd wk | 35-45 km/wk |
| 10K Peak | Sep 1 – Oct 25 | 2 quality/wk + VO2max, peak + taper | 45-55 km/wk |

> **Implementer:** Mark the correct phase as `(CURRENT)` based on the date you execute this task. As of Mar 26, Taper is current. After Mar 30, Post-HM Recovery is current.
```

- [ ] **Step 3: Update Race Schedule table**

Replace with the new race calendar (same as current-status.md, Task 1 Step 3).

- [ ] **Step 4: Update Workout Types section**

Add 10K-specific workout variants that are referenced in the spec but not in the current protocol:

```markdown
### 10K-Pace Intervals
- **HR:** 160-172 | **Pace:** 4:36-4:50/km (based on sub-46 target)
- **Structure:** 6-8×1km or 4-5×1.5km at goal 10K pace, 60s jog recovery
- **RPE:** 8-9
- Introduce from Cut Block 1 (May 26). Core 10K-specific session.
```

Keep all existing workout types (easy/base, long runs, sub-threshold, tempo, VO2max, X-element). They're all still used.

- [ ] **Step 5: Update Race Day section**

The Half Marathon section can stay as historical reference. Add/update the 10K race day section:

```markdown
### 10K (October 25 A-Race)
- Warm-up: 15-20 min jog + 4-6 strides
- Pacing: Start at 4:45/km (conservative), settle to 4:36-4:39 by km 3, hold through km 8, kick km 9-10
- No in-race fueling needed (<50 min)
- Caffeine: ~230mg 30-60 min pre-race
- Target: Sub-46:00 (realistic) | Sub-45:00 (stretch)
```

- [ ] **Step 6: Update Data Files reference**

No changes needed — the data file list is still accurate.

- [ ] **Step 7: Verify and read back**

Read full file. Confirm no references to "current HM build" or "Mar 29 A-race" remain in active (non-COMPLETE) sections.

---

### Task 3: Update `protocols/training.md`

**Files:**
- Modify: `protocols/training.md`

The training protocol must shift from race-prep maintenance to hypertrophy-focused cut support.

- [ ] **Step 1: Update Weekly Structure section**

Replace the current weekly integration example with a phase-aware structure. The spec defines three distinct weekly templates:

**Phase 2 template** (1 quality, Tue-only):
Reference spec lines 106-114.

**Cut Blocks 1 & 2 template** (2 quality, Tue/Fri, double days):
Reference spec lines 188-196.

**Phase 6 template** (strength tapers across 8 weeks):
Reference spec lines 327-330. The weekly running template is the same as Cut Blocks (Tue/Fri quality, Sun long run), but strength changes by week:
- **Weeks 1-5:** 3x/week (Push Mon, Pull Wed, Legs Thu) — same as Cut Blocks
- **Weeks 6-7:** 2x/week (Push Mon, Pull Wed only) — **drop Legs entirely from Thursday. Thursday becomes pure rest (no running, no strength).**
- **Week 8 (race week):** 1x light upper (Mon or Tue), RPE 5, pump session only

Write all three templates with clear phase labels so `/plan` picks the right one based on the current phase in `current-status.md`.

- [ ] **Step 2: Update Progression Guidelines**

Replace the two-mode system (Race Prep / Post-Race) with a three-mode system:

```markdown
### Cut Phases (Apr 13 – Aug 30)
- Hypertrophy focus: 3-4×8-12 reps
- Double progression: hit top of rep range → +2.5 kg → reset to bottom
- RPE 7-8 max
- If lift regresses >10% for 2 sessions → drop from 4 sets to 3, keep weight
- If RPE consistently 9+ → reduce weight 5%, reassess deficit

### Peak Phase (Sep 1 – Oct 25)
- Weeks 1-5: Full hypertrophy, progressive overload (strength rebounds on maintenance cals)
- Weeks 6-7: Drop legs session, upper push + pull only (2x/week)
- Week 8 (race week): 1× light upper (Mon/Tue), RPE 5, pump session only
```

- [ ] **Step 3: Update Recovery & Monitoring section**

Add the **training-facing** adjustment triggers from the spec (spec lines 364-380). The current section has basic back-off rules — expand with:

- Strength drops >10% for 2 sessions → drop from 4 sets to 3, keep weight
- Easy run HR elevated 5+ bpm over baseline for 3+ runs → extra rest day
- Garmin Sleep Score <60 for 2+ nights → skip quality session, replace with easy run
- RHR elevated 5+ bpm over baseline → reduce volume 20%
- HRV drops >15% from 7-day avg → optional rest day
- Body Battery <30 at wake → full rest day
- Fewer than 2 strength sessions for 2 consecutive weeks → mandatory reduced-volume 2×20min full-body

Nutrition-facing triggers go in `nutrition.md` (Task 4 Step 4).

- [ ] **Step 4: Add Double-Day Guidelines**

This is new content not in the current protocol. Add a section:

```markdown
## DOUBLE-DAY GUIDELINES

When running and strength are on the same day (Mon, Wed, Sat in Cut Blocks):

- **Minimum 6-8 hours gap** between sessions (AM run, PM strength)
- **Run first, lift second.** Running quality degrades more from prior fatigue than lifting does.
- **Post-run shake immediately** — MPS window is most responsive 0-2h. Then full meal before PM lift.
- **If energy is low for PM lift:** Reduce volume (drop 1 set per exercise). Do not skip the session entirely — reduced stimulus beats no stimulus.
- **Thursday is always REST from running.** Legs (PT or self-directed) are scheduled on Thursday in all phases except Phase 6 weeks 6-8, when legs are dropped entirely and Thursday becomes pure rest.
```

- [ ] **Step 5: Add Optional 4th Session section**

The spec allows an optional Saturday arms/shoulders session during Cut Blocks:

```markdown
## OPTIONAL: ARMS & SHOULDERS (4th session, Sat PM)

**When:** Cut Blocks 1 & 2 only. Drop if BB <60 at wake or lingering soreness.
**Duration:** 30 min max. RPE 6-7. This is vanity work — it doesn't override recovery.

1. Lateral Raises — 3×15
2. Rear Delt Flyes — 3×15
3. Barbell Curls — 3×10-12
4. Tricep Pushdowns — 3×12-15
5. Hammer Curls — 2×12

**Total: ~13 sets, 25-30 min.**
```

- [ ] **Step 6: Verify and read back**

Read full file. Confirm the Thursday rule, double-day guidelines, and progression rules are all internally consistent.

---

### Task 4: Update `protocols/nutrition.md`

**Files:**
- Modify: `protocols/nutrition.md`

The nutrition protocol must become phase-aware with calorie cycling.

- [ ] **Step 1: Replace Daily Targets section**

Replace the single flat 1,900 cal target with a phase-aware table. Include all 6 phases with their day-type calorie targets. Reference the spec's calorie tables.

Before the phase tables, add:

```markdown
**Macro Minimums (Non-Negotiable):**
- **Protein Floor:** 160g (to preserve lean mass)
- **Fat Floor:** 55g (to maintain hormonal health and testosterone, ~0.7g/kg)

*Note: On 1,600-1,750 cal days, hitting both floors leaves very little room for carbs. Prioritize protein and fat first on rest days.*
```

Phase calorie tables:

- Phase 1: Maintenance 2,300 flat
- Phase 2: Rest/easy 1,750 | Quality/long 2,100 | Avg ~1,850
- Phase 3 (May Race Block): Two race weeks with explicit per-day targets. These do NOT follow the standard rest/easy/quality pattern — copy the exact day-by-day tables from spec lines 149-171:

  **Week 1 (May 11-17):** Mon easy+Push 2,100 | Tue 4x1km quality 2,100 | Wed rest+Pull 1,750 | Thu rest 1,750 | Fri easy+strides 1,750 | Sat rest+carb-up 2,100 | **Sun 10K race 2,300**.
  **Week 2 (May 18-24):** Mon easy recovery 2,100 | Tue easy+Legs(light) 2,100 | Wed rest 1,750 | Thu rest 1,750 | Fri easy trails 2,100 | Sat rest+carb-up 2,100 | **Sun trail 21K 2,300**.

- Phase 4: Rest 1,650 | Easy 1,750 | Quality/long 2,100 | Avg ~1,886
- Phase 5: Rest 1,600 | Easy 1,700 | Quality/long 2,050 | Avg ~1,836
- Phase 6 (Reverse Diet): Copy the exact week-by-week table from spec lines 295-301 with full macro breakdown:

  | Week | Calories | Protein | Carbs | Fat |
  |---|---|---|---|---|
  | 1 (Sep 1) | 1,950 | 165g | 170g | 60g |
  | 2 (Sep 8) | 2,100 | 165g | 205g | 60g |
  | 3 (Sep 15) | 2,300 | 165g | 245g | 65g |
  | 4-7 (Sep 22 – Oct 18) | 2,300-2,400 | 165g | 245-260g | 65g |
  | 8 – Race week (Oct 20-25) | 2,400-2,500 | 160g | 300g+ | 60g |

Each phase should have its own subsection with the day-type breakdown.

- [ ] **Step 2: Update Performance Fueling section**

Add the long-run fueling rule explicitly:

```markdown
| Run Type | Pre-Run | Timing |
|---|---|---|
| Easy/Base <60min | **FASTED** | Water/coffee only |
| Easy 60-90min | Optional: banana | 30 min before |
| **Long Run >90min** | **1 banana + coffee** | **30 min before (mandatory)** |
| Tempo/Intervals | 1 banana + coffee | 30 min before (mandatory) |
| Race | 50-80g easy carbs | 2-3h before |
```

The current protocol already has most of this, but the long-run >90min rule needs to be explicit because it's now a separate day type for calorie purposes.

- [ ] **Step 3: Update Meal Distribution section**

The current meal distribution assumes a flat 1,900 cal day. Replace with a template that scales per day type:

```markdown
## MEAL DISTRIBUTION

**Eating window:** 12:30-21:00 (IF). Adjust if adherence suffers.

### Standard Day (Rest / Easy Run) — varies by phase

| Meal | Time | Notes |
|---|---|---|
| Post-workout shake | 12:30 | 35g whey + 1 banana + creatine 5g |
| Lunch | 13:00 | Protein + carb + veg + fat |
| Snack | 17:00 | Protein + small carb/fat |
| Dinner | 21:00 | Protein + carb + veg |

**Portion scaling:** Adjust carb portions (rice, potatoes, pasta) up or down to hit the day's calorie target. Protein and fat stay roughly constant. See phase-specific targets above.

### Quality / Long Run Day — add ~300 cal (mostly carbs)

Additions:
- Pre-run: 1 banana (+100 cal)
- Post-run shake: add 40g oats (+120 cal)
- Lunch: extra 30g rice (+75 cal)
```

Keep the existing meal options (they're still valid).

- [ ] **Step 4: Update Tracking & Adjustments section**

Replace the current adjustment table with the **nutrition-facing** adjustment triggers from the spec (spec lines 364-380):

- 7-day weight avg stalls for 2+ weeks → reduce daily target by 100 cal (drop from carbs)
- 7-day weight avg drops >0.8 kg/week → add 100 cal (carbs first)
- Energy crashes (motivation <2 for 3+ days) → unplanned refeed day at 2,300 cal
- Lean mass declining on Withings for 2+ consecutive weeks → raise calories 100-200 (carbs first)
- 3+ untracked days in a week → flag in weekly report, ask for honest assessment
- Low motivation for 5+ consecutive days → consider scheduled diet break pull-forward

Training-facing triggers go in `training.md` (Task 3 Step 3).

Also update the monitoring expectations:

```markdown
## TRACKING & ADJUSTMENTS

**Daily:** Log food in Cronometer, morning Withings weigh-in (post-bathroom, pre-food), confirm protein floor hit.

**Weekly (Sunday):** 7-day weight average, 7-day calorie average, compare to prior week. Full body comp scan (Withings does this automatically — use Sunday's reading for trend tracking).
```

- [ ] **Step 5: Update Race Week Nutrition section**

Update for the October 10K A-race:

```markdown
## RACE WEEK NUTRITION

### 10K (Oct 25 — A-Race)
- **Week before:** Maintenance 2,300-2,400 cal, carbs 250g+
- **Final 3 days:** Carb load — 300g+ carbs, reduce fiber, familiar foods only
- **Night before:** Moderate carbs, low fiber, early dinner (19-20h)
- **Race morning:** Light breakfast 2-3h before — 50-80g easy carbs (toast + banana + honey), 500ml water, caffeine 230mg 30-60 min pre-race
- **No in-race fueling needed** (<50 min)
```

Keep the HM section as reference for future races.

- [ ] **Step 6: Add Diet Break Protocol**

This is new content:

```markdown
## DIET BREAKS

Scheduled breaks at maintenance calories (2,300) to reset metabolic adaptation and hunger hormones.

| When | Duration | Calories | Notes |
|---|---|---|---|
| May 12-25 | 2 weeks | ~2,200 avg | Around May races |
| Jul 27 – Aug 2 | 1 week | 2,300 | Midpoint of Cut Block 2 |
| Sep 1-21 | 3 weeks (gradual) | 1,950 → 2,100 → 2,300 | Reverse diet into peak phase |

**Unplanned refeed days:** Max 1/week during cut blocks. 2,300 cal, extra carbs. Log it. No guilt. Better than an unplanned binge.
```

- [ ] **Step 7: Verify and read back**

Read full file. Confirm calorie numbers match spec, long-run fueling is explicit, and no stale references to the old flat 1,900 cal target remain.

---

### Task 5: Update `protocols/daily-template.md`

**Files:**
- Modify: `protocols/daily-template.md`

- [ ] **Step 1: Add daily weigh-in and ACWR fields**

Update the Status section required fields:

```markdown
| Field          | Description                             |
|---|---|
| Weight         | Morning Withings reading (kg)           |
| Sleep          | Duration + score + qualifier            |
| HRV            | Value in ms                             |
| Body Battery   | Current (and peak at wake if available) |
| Resting HR     | bpm                                     |
| Stress         | Average level                           |
| Pain/Tightness | None / [location] [severity 1-5]        |
| Motivation     | 1-5 scale                               |
| Caffeine       | Cups + cutoff time                      |
```

- [ ] **Step 2: Add Day Type field**

Add a field for the coach to set at plan generation time:

```markdown
## Day Type (set by /plan)

| Field | Description |
|---|---|
| Day Type | Rest / Easy / Quality / Long Run / Race |
| Calorie Target | Phase-specific target for this day type |
```

- [ ] **Step 3: Add weekly ACWR note**

Add to the template:

```markdown
## Weekly Check (Sundays only)

| Field | Description |
|---|---|
| ACWR | Acute (this week km) / Chronic (4-week avg km) |
| 7-day weight avg | Average of daily Withings readings |
| Body comp trend | BF%, lean mass from Sunday Withings |
```

- [ ] **Step 4: Verify and read back**

Read full file. Confirm all required fields are present.

---

### Task 6: Update `.claude/commands/plan.md`

**Files:**
- Modify: `.claude/commands/plan.md`

- [ ] **Step 1: Update macro targets**

The current file hardcodes `2,000 cal | 140g protein | 175g carbs | 50g fat`. Replace with phase-aware logic:

```markdown
## Function
Uses the **coach skill** to:

1. Read `protocols/current-status.md` for current phase and date
2. Determine today's day type (rest/easy/quality/long run/race) based on phase weekly template
3. Look up phase-specific calorie and macro targets from `protocols/nutrition.md`
4. Check recent data from `/data` CSVs and Garmin (recovery markers, recent activities)
5. Generate today's workout based on phase and weekly template from `protocols/training.md` and `protocols/running.md`
6. Plan nutrition with phase-correct targets
7. Include mobility routine
8. Include daily weigh-in reminder if not yet logged
```

- [ ] **Step 2: Update output format**

Replace the hardcoded macro line with:

```markdown
**Daily Total:** [Phase-specific] cal | [Phase-specific] protein | [Phase-specific] carbs | [Phase-specific] fat
**Day Type:** [Rest/Easy/Quality/Long Run/Race]
```

- [ ] **Step 3: Add phase-awareness requirement**

Add to Requirements:

```markdown
- **Phase-aware:** Always check current phase in `protocols/current-status.md` before generating
- **Day-type-aware:** Determine today's day type from the weekly template, then use the correct calorie tier
- **Calorie cycling:** Rest/easy days and quality/long-run days have different targets — never use a flat number
- **Thursday rule:** Thursday is always rest from running. Legs on Thursday in all phases except Phase 6 weeks 6-8 (legs dropped, Thursday = pure rest).
- **Long runs >90 min:** Must include pre-run fueling (banana + coffee) and use quality-day calories
- **Daily weigh-in:** Include morning Withings weigh-in in Status section
- **Mobility:** Include 10-min daily mobility routine
- **ACWR:** Compute and include on Sundays
```

- [ ] **Step 4: Verify and read back**

Read full file. Confirm no hardcoded calorie targets remain.

---

### Task 7: Update `.claude/commands/body.md`

**Files:**
- Modify: `.claude/commands/body.md`

- [ ] **Step 1: Update body comp targets**

Replace the old targets (70kg, 12-15% BF) with the spec targets:

```markdown
- Compare to baseline (76.8kg, 29.2% BF — March 2026) and target (70-72kg, 21-23% BF)
```

Update the progress table format:

```markdown
| Metric | Current | Baseline (Mar) | Target | Delta from baseline |
|---|---|---|---|---|
| Weight | XX kg | 76.8 kg | 70-72 kg | -X kg |
| Body Fat | XX% | 29.2% | 21-23% | -X% |
| Fat Mass | XX kg | 22.4 kg | ~15 kg | -X kg |
| Lean Mass | XX kg | 54.4 kg | Maintain | +/-X kg |
```

- [ ] **Step 2: Fix command name**

The file currently documents the command as `/body-log` (line 8). Rename to `/body` for consistency with `AGENTS.md`. Update the Usage section:

```markdown
## Usage

```
/body
```
```

Also update the heading from "Body Log" to "Body - Sync Smart Scale to Garmin" (drop "Log" from the title to match the command name).

- [ ] **Step 3: Verify and read back**

Read full file. Confirm targets match spec and command name is `/body`.

---

### Task 8: Update `AGENTS.md`

**Files:**
- Modify: `AGENTS.md`

- [ ] **Step 1: Update Repository Purpose**

Change from "focused on concurrent running performance and body recomposition" to reflect the current phase more specifically. The purpose is still accurate — just verify it doesn't reference the HM as the primary goal.

- [ ] **Step 2: Update Protocol Lookup table**

Verify all protocol file descriptions still match their updated content. The table should be accurate after Tasks 1-7.

- [ ] **Step 3: Update Coaching Primer**

Add phase-awareness reminder:

```markdown
- Check current phase in `protocols/current-status.md` before generating any plan — calorie targets, workout structure, and strength programming all vary by phase
- Calorie cycling is mandatory: rest/easy days and quality/long-run days have different targets
- Thursday is always rest from running. Legs on Thursday except Phase 6 weeks 6-8 (legs dropped, pure rest)
```

- [ ] **Step 4: Verify and read back**

Read full file. Confirm consistency with updated protocols.

---

### Task 9: Update `protocols/mobility.md`

**Files:**
- Modify: `protocols/mobility.md`

The mobility protocol already has a severity scale and back-off rules. Add a cut-phase emphasis note and ensure the pain back-off rule integrates with the training protocol's adjustment triggers.

- [ ] **Step 1: Add Cut-Phase Recovery Emphasis**

After the `## POST-RUN COOL-DOWN` section, add:

```markdown
## CUT-PHASE RECOVERY EMPHASIS (Apr 13 – Aug 30)

During caloric deficit, connective tissue recovery is slower. Compliance with daily mobility is even more critical.

- **Foam rolling:** Mandatory post-run (not just Sundays) during cut phases
- **Extra hip work:** Add 2 min of 90/90 switches after any double-day (AM run + PM strength)
- **Sleep:** Stretching before bed improves sleep quality during deficit — do the hip flexor + hamstring sequence as a nighttime routine if morning mobility was skipped
```

- [ ] **Step 2: Integrate Pain Back-Off with Training Adjustments**

After the existing `**Rules:**` section, add:

```markdown
**Cut-phase pain escalation:** During deficit phases (Phases 2, 4, 5), any severity 3+ triggers an immediate calorie bump to maintenance (2,300) for that day plus the following day. Deficit-related recovery impairment can mask injury onset. Report to weekly review.
```

- [ ] **Step 3: Verify and read back**

Read full file. Confirm pain severity rules are complete and cut-phase additions don't contradict existing content.

---

### Task 10: Update `.claude/commands/log.md`

**Files:**
- Modify: `.claude/commands/log.md`

The log command needs day-type awareness for calorie comparisons and daily weigh-in support.

- [ ] **Step 1: Add Day-Type Awareness to Meal Logging**

In the `### Meal` section, replace the calorie comparison logic with:

```markdown
### Meal
- Format as: **[Meal Type]:** description, calories
- Update running calorie total
- **Determine today's day type** from the daily file header (Rest/Easy/Quality/Long Run/Race)
- **Compare to day-type-specific target** from `protocols/nutrition.md` (NOT a flat number)
- Alert if approaching or exceeding the day's calorie target
- Show remaining calories and macro budget
```

- [ ] **Step 2: Update Body Logging for Daily Weigh-In**

Replace the `### Body` section with:

```markdown
### Body
- Log weight/body fat to daily file Status section
- **Daily weigh-in protocol:** Morning Withings reading (post-bathroom, pre-food)
- If 7 daily readings exist this week, compute and display 7-day rolling average
- Compare rolling average to previous week's average
- Flag if rolling average has stalled (±0.1 kg for 2+ consecutive weeks during cut phases)
```

- [ ] **Step 3: Add ACWR Logging on Sundays**

Add a new type-specific section:

```markdown
### Weekly (Sundays)
- Compute ACWR: this week's total km / 4-week average km
- Flag if ACWR > 1.3 (ramp too fast) or < 0.8 (detraining risk)
- Display 7-day weight average and body comp trend
- Include in the weekly summary for `/report`
```

- [ ] **Step 4: Verify and read back**

Read full file. Confirm day-type logic is referenced and weigh-in protocol is explicit.

---

### Task 11: Update `.claude/commands/report.md`

**Files:**
- Modify: `.claude/commands/report.md`

The report command has stale body comp targets and no awareness of the new plan structure. It is the canonical place for ACWR, weekly weight trends, and `current-status.md` updates (per `AGENTS.md` workflow).

- [ ] **Step 1: Update body comp targets**

Replace the stale target at line 31 (`80kg@30%BF → 70kg@12-15%BF`) with:

```markdown
- Body recomp target: 76.8kg @ 29.2% BF (Mar 2026 baseline) → 70-72kg @ 21-23% BF
```

- [ ] **Step 2: Add phase-aware weekly checks**

Add to the Function section:

```markdown
5. Phase-aware weekly checks:
    - Compute ACWR (this week km / 4-week avg km). Flag if >1.3 or <0.8.
    - Compute 7-day weight average from daily Withings readings
    - Compare weight trend to previous week — flag stalls (±0.1 kg for 2+ weeks during cut)
    - Check current phase in `protocols/current-status.md` and verify calorie targets match
    - Check strength session count — flag if <2 for 2 consecutive weeks
    - Check nutrition tracking days — flag if <5/7

6. Update `protocols/current-status.md`:
    - Training Load section with this week's data
    - Key Metrics section with latest Garmin values
    - Adherence section with this week's scores
    - Body Composition History table if new Withings data available
```

- [ ] **Step 3: Add diet break and phase transition checks**

Add to the Recommendations section template:

```markdown
### Phase Check
- Current phase: [phase name and dates]
- Days until next phase transition: [N]
- If within 7 days of transition: flag upcoming changes to calorie targets, workout structure, strength programming
- If in a scheduled diet break window: verify maintenance calories are being used
```

- [ ] **Step 4: Verify and read back**

Read full file. Confirm stale targets are gone and ACWR/weekly-weight logic is present.

---

### Task 12: Reconcile Command Naming in `AGENTS.md`

**Files:**
- Modify: `AGENTS.md`

`AGENTS.md` advertises `/log-workout`, `/log-meal`, `/note`, and `/body` as separate commands, but the actual command files are `log.md` (unified) and `body.md`. Reconcile.

- [ ] **Step 1: Update Daily Workflow section**

Replace the old workflow with:

```markdown
## Daily Workflow

1. **Morning:** `/plan` → generates today's plan in `days/YYYY-MM-DD.md`
2. **After training:** `/log [workout details]` → updates Log section with completion status
3. **After meals:** `/log meal [details]` → checks off meals, notes deviations
4. **As needed:** `/log note [text]` → adds observations to Notes section
5. **Weekly:** `/report` → progression review, updates `current-status.md`
```

- [ ] **Step 2: Update Available Commands section**

Replace with:

```markdown
## Available Commands

**Daily (all update `days/YYYY-MM-DD.md`):**

- `/plan` — Generate today's workout + nutrition plan
- `/log [details]` — Log workouts, meals, body metrics, or notes (auto-detects type)

**Periodic:**

- `/report` — Weekly/monthly progression review (also updates `current-status.md`)
- `/body` — Sync body composition to Garmin
```

- [ ] **Step 3: Verify and read back**

Read full file. Confirm no references to `/log-workout`, `/log-meal`, or `/note` as separate commands remain.

---

### Task 13: Final Cross-File Verification

**Files:**
- Read all modified files

- [ ] **Step 1: Verify calorie numbers are consistent**

Check that the calorie targets in `nutrition.md`, `current-status.md`, `plan.md`, and the spec all match for each phase and day type.

- [ ] **Step 2: Verify weekly templates are consistent**

Check that the weekly structure in `training.md`, `running.md`, and the spec all describe the same day-by-day layout for each phase.

- [ ] **Step 3: Verify race calendar is consistent**

Check that the race dates and priorities match across `current-status.md`, `running.md`, and the spec.

- [ ] **Step 4: Verify body comp targets are consistent**

Check that targets match across `current-status.md`, `body.md`, `nutrition.md`, and the spec.

- [ ] **Step 5: Verify non-negotiables are represented**

Check that every item in the spec's Non-Negotiables section (spec lines 342-404) is reflected in at least one protocol file:
- Daily Cronometer tracking → `nutrition.md`
- Protein floor → `nutrition.md`
- Pre-quality carbs → `nutrition.md`
- 3x/week strength → `training.md`
- Weight logging → `training.md`
- Daily weigh-in → `nutrition.md` + `daily-template.md`
- 7-day rolling average → `nutrition.md`
- ACWR → `running.md` + `daily-template.md` + `report.md` (Task 11)
- Mobility → `mobility.md` + cut-phase emphasis (Task 9)
- Pain back-off during deficit → `mobility.md` (Task 9)
- Pain tracking → `daily-template.md`
- Adjustment triggers → `nutrition.md` + `training.md`
- Diet breaks → `nutrition.md`
- Warm-up → `running.md` (already there, no changes needed)
- Supplements → `supplements.md` (no changes needed)

- [ ] **Step 6: Smoke test — Phase 1, Apr 1 (Wednesday)**

Walk through:
1. Read `current-status.md` → Phase 1: Post-HM Recovery, Week 1
2. Date is Wednesday, Week 1 → Phase 1 template → Spec shows Week 1 Mon-Wed as rest days
3. Day type = Rest → check `nutrition.md` Phase 1 → 2,300 cal (maintenance, flat)
4. Running: **None.** Week 1 has 3 rest days to start.
5. Strength: **None.** Phase 1 focuses on habit building, not load.
6. Include: Mobility routine, weigh-in, meal plan at 2,300 cal

Confirm that Phase 1 correctly generates rest/maintenance days with no training in Week 1.

- [ ] **Step 7: Smoke test — mentally run /plan for Apr 14 (Phase 2, Monday)**

Walk through the plan generation logic:
1. Read `current-status.md` → Phase 2: Base Rebuild + Cut, started Apr 13
2. Date is Monday → check Phase 2 weekly template in `training.md` → Mon = Easy run AM + Upper Push PM
3. Day type = Easy run → check `nutrition.md` Phase 2 → 1,750 cal, 160g protein, 150g carbs, 60g fat
4. Running: Easy 5-6 km, <148 outdoor / <142 treadmill
5. Strength: Upper Push, hypertrophy (4×8-12), double progression
6. Include: Daily 5 warm-up, mobility routine, weigh-in reminder, meal plan at 1,750 cal

Confirm this path through the protocol files produces the correct plan.

- [ ] **Step 8: Smoke test — mentally run /plan for Jun 3 (Phase 4 Cut Block 1, Tuesday)**

Walk through:
1. Read `current-status.md` → Phase 4: Cut Block 1, week 2
2. Date is Tuesday → Phase 4 template → Tue = Quality session 1
3. Day type = Quality → check `nutrition.md` Phase 4 → 2,100 cal, 160g protein, 220g carbs, 60g fat
4. Running: Quality session — week 2 rotation from spec → Cruise intervals: 5×1km sub-T
5. No strength on quality days
6. Include: Pre-run banana + coffee (mandatory), Daily 5 warm-up, mobility, weigh-in, meal plan at 2,100 cal

Confirm correctness.

- [ ] **Step 9: Smoke test — Thursday rule (Phase 4, Jun 4)**

Walk through:
1. Read `current-status.md` → Phase 4: Cut Block 1
2. Date is Thursday → Phase 4 template → Thu = REST from running + Legs (PT or self-directed)
3. Day type = Rest → check `nutrition.md` Phase 4 → 1,650 cal
4. Running: **None.** Thursday is always rest from running.
5. Strength: Legs session (PT or self-directed), hypertrophy focus
6. Include: Mobility routine, weigh-in, meal plan at 1,650 cal

Confirm that running is explicitly absent and the Thursday rule is enforced.

- [ ] **Step 10: Smoke test — Sunday long run (Phase 4, Jun 7)**

Walk through:
1. Read `current-status.md` → Phase 4: Cut Block 1
2. Date is Sunday → Phase 4 template → Sun = Long run 14-16 km
3. Day type = Long Run → check `nutrition.md` Phase 4 → **2,100 cal** (same as quality day, separate tier)
4. Running: Long run, MAF <148, progressive to 150 drift
5. Pre-run fueling: **Mandatory** — 1 banana + coffee (>90 min run)
6. Include: Daily 5 warm-up, post-run foam rolling (cut-phase mandatory), mobility, weigh-in, meal plan at 2,100 cal

Confirm that long-run day gets quality-day calories (not easy-day) and pre-run fueling is mandatory.

- [ ] **Step 11: Smoke test — race week (May 11-17, Phase 3)**

Walk through:
1. Read `current-status.md` → Phase 3: May Race Block, diet break ~2,200 avg
2. May 17 (Sunday) is a 10K race, fun/benchmark priority
3. Week leading up: Reduced volume, maintain 1-2 sharpeners, no heavy legs Thu before race
4. Day type for race day = Race → check nutrition → race-day fueling protocol
5. Calories at ~2,200 (diet break), not deficit

Confirm that race week plans correctly use diet-break calories and include race-day fueling.

- [ ] **Step 12: Smoke test — diet break (Jul 27, Phase 5)**

Walk through:
1. Read `current-status.md` → Phase 5: Cut Block 2, but Jul 27 – Aug 2 is a scheduled diet break
2. Calories bump to maintenance 2,300 for the week
3. Training continues normally (not a deload unless scheduled)
4. `nutrition.md` diet break table lists this exact window

Confirm that the plan generates maintenance calories during the diet break window, not cut-phase calories.

- [ ] **Step 13: Smoke test — Phase 6 reverse diet (Sep 3, Wednesday)**

Walk through:
1. Read `current-status.md` → Phase 6: Reverse + 10K Peak, Week 1
2. Date is Wednesday → Phase 6 template → Wed = Easy run AM + Upper Pull PM
3. Day type = Easy → check `nutrition.md` Phase 6 Week 1 → **1,950 cal** (NOT 2,300 maintenance yet)
4. Running: Easy 5-6 km
5. Strength: Upper Pull, 3x/week still active (weeks 1-5)

Confirm that the reverse diet generates week-specific calories (1,950 in week 1), not a flat maintenance number.

- [ ] **Step 14: Smoke test — Phase 6 strength taper (Oct 13, Monday)**

Walk through:
1. Read `current-status.md` → Phase 6: Reverse + 10K Peak, Week 7
2. Date is Monday → Phase 6 template → Mon would normally be Easy run AM + Upper Push PM
3. But Week 6-7 rule: **Drop legs session, upper push + pull only (2x/week)**
4. So Monday = Easy run + Upper Push (still valid, as this is upper push)
5. Thursday: **No legs session** — rest only
6. Calories: 2,300-2,400 (week 7 reverse diet)

Confirm that legs are dropped from the weekly template in weeks 6-7 and the strength taper is reflected.

- [ ] **Step 15: Verify coaching.md still applies**

Read `protocols/coaching.md`. Confirm that the coaching philosophy, push-back expectations, and communication style still apply post-HM. No changes expected — this is a verification step only.

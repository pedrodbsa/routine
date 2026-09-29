# RUNNING PROTOCOL - MASTER

## Key Context

Primary limiter remains cardiovascular, not muscular. Post-smoking aerobic development still matters. Pace discipline stays secondary to HR and RPE on easy days and in hot weather. Lactate-tested 2026-04-28 (FCDEFUC): LT1 145 bpm @ 5:52/km, LT2 172 bpm @ 5:00/km, lab-prescribed individual threshold 142 bpm @ 6:00/km. The 10K PR pace (5:00/km) sits exactly at LT2 — current 10K racing is a threshold effort.

## HR Zones (lactate-anchored, 2026-04-28)

| Zone | Name          | HR Range  | % of LT2 | Purpose                                            |
| ---- | ------------- | --------- | -------- | -------------------------------------------------- |
| 1    | Recovery      | <125      | <73%     | Walking only — walk breaks and interval walk-recoveries (no jog exists down here for this athlete) |
| 2    | Aerobic Base  | 125-142   | 73-83%   | Easy runs, long runs, base building (cap = lab IT) |
| 3    | Aerobic Dev   | 143-151   | 83-88%   | Steady aerobic, marathon-pace work                 |
| 4    | Sub-Threshold | 152-168   | 88-98%   | Norwegian / cruise intervals: work band 152-165, hard ceiling 168 (just under LT2) |
| 5    | Threshold     | 169-175   | 98-102%  | Tempo, threshold reps, 10K race effort             |
| 6    | VO2max        | 176-185   | 102-108% | Hard intervals, late-race surge                    |
| 7    | Anaerobic     | >185      | >108%    | Sprints, final kick                                |

Anchors: LT1 = 145, LT2 = 172, max ~190 (race-observed). The HR zones apply in every environment, but pace-at-HR does not transfer between them. In September 2026 outdoor easy pace ran ~6% faster than the control belt at the same HR (6:33–6:39/km @138 outdoors on Sep 6 and Sep 20, against 8.6 km/h = 6:59/km @136–137 on the treadmill). The 1% incline and the belt calibration are confounds. Compare pace-at-HR within one environment only (2026-09-29 audit; zone 3/4 boundary moved 155/156 → 151/152 to match the sub-T sessions the stack actually prescribes).

**Athlete compressed-range note (2026-06-13):** this athlete cannot run below ~130 bpm — below that is a walk, not a jog. Two consequences for the zone table: (1) **Zone 1 (<125) is walk-only** — "recovery jogs" do not exist down there; a real recovery jog runs ~135–145. (2) The **functional easy-running band is ~135–142**, not the full 125–142 — a ~7 bpm window pinned just under the cap. Easy runs intrinsically sit near the 142 ceiling (logged easy runs average ~138–142); brief drift to 143–145 is this athlete's natural easy ceiling, governed by RPE/conversation, not a discipline failure. The easy–to–sub-T gap is only ~10 bpm (142 → 152), so easy and sub-T cannot be separated by HR alone — RPE and pace must do that work. This is also why outdoor easy pace-at-HR is a noisy fitness signal (always at the rail) and the treadmill control run is the cleaner read.

### Garmin Device Calibration (2026-06-11)

The Garmin watch only offers a 5-zone HR model (no native lactate-threshold anchor), so zones are entered in **BPM** to honor the lab. Mapping to Garmin's 5 zones: Warm Up ≥95, Easy ≥120, Aerobic ≥143, Threshold ≥158, **Maximum ≥172 (= LT2)**. This is a coarse on-watch display only; real training stays governed by the 7-zone table above and per-session HR targets.

**Running power:** Garmin auto-detected FTP (403 W) was inflated — above the athlete's hardest recorded effort. Threshold Power was set manually to **360 W**, derived from the Ansião 10K (May 17) normalized power of 371 W (52-min effort at avg HR 176, slightly above LT2). Garmin's default power-zone percentages are kept (threshold = 100% at the Z3/Z4 boundary). Power is not lab-measured and is not a training governor here — it exists only so the watch's power gauge and power-based Training Effect are not wrong.

### Easy-Run Rules

| Environment | Ceiling | Spike Max | Typical Pace            |
| ----------- | ------- | --------- | ----------------------- |
| All         | 142 bpm | 145 bpm   | 6:40-7:30/km treadmill, 6:30-7:30/km outdoor |

- Easy = RPE 3-4 and full conversation.
- If RPE exceeds 5, slow down even if HR looks acceptable.
- Recovery jogs run **~135–145 bpm** — this athlete can't jog below ~130 (Zone 1 is walk-only), so don't chase a sub-133 "recovery jog" that doesn't exist for this physiology. Govern recovery by easing effort and letting HR fall, not by a walk-level number.
- **Between interval reps the recovery is a walk** (or jog → walk), never a jog. In ~90 s HR won't fall into any jog band. Walk recovery also lowers rep-entry HR, so judge a rep by its end-of-rep max HR, not the rep average (`[[feedback-walk-recovery-intervals]]`; tables below corrected 2026-09-29 audit).
- **Treadmill control run (2026-06-12; protocol ratified 2026-09-07; cadence set to fortnightly 2026-09-29):** every other week, one of the week's easy runs is done on the treadmill under fixed conditions — **5.0 km at a locked belt speed of 8.6 km/h, 1% incline, treadmill mode, COROS armband always** (an entry on any other sensor is void). The tracked number is **avg HR**, not pace — the belt fixes pace, so avg HR at fixed work is the heat-independent fitness signal. Do not raise the belt speed (it restarts the series). The original "~30 min" wording is retired: every valid entry ran ~5.0 km / ~35 min, and since avg HR accumulates drift, only fixed-distance entries are comparable. Valid series: Jul 13 **137** · Jul 27 **136**. Log it as a normal easy run; `/report` reads the avg-HR trend.
- **Weekly strides slot — standing, from 2026-08-08.** One easy run per week finishes with **6 × 20 s strides**, relaxed-fast at ~5K/mile turnover, RPE 7–8, **full walk-back recovery** between each. By feel, not by HR — 20 s is far too short for HR to mean anything. Stop the set early if form fades; this is a coordination stimulus, not a conditioning one.
  - **Why it is a standing slot and not a menu item.** Stride length at a given cadence is an *output* of force production and elastic return, not something the athlete can choose — and the spring 2027 sub-47 target needs it. Sub-47 (4:42/km = 3.55 m/s) requires roughly **cadence 180 × stride 118 cm**, against the Mar 8 race's **175.9 × 113.5**. Strides move that by letting the mechanics self-organise at speed. **Do not prescribe conscious form cueing to chase the same number** — deliberately lengthening the stride means landing ahead of the centre of mass, which is a braking force. See § Running Mechanics below.
  - Cost is near zero (~4 min, negligible recovery), which is exactly why it kept getting dropped: nothing that cheap ever wins an argument against time pressure. It was programmed on 2026-06-23 and then vanished from every subsequent week.
  - **Do not stack it on a quality day or the day before one.** Its natural home is the easy run furthest from either quality session.
  - This is *not* the same thing as the Q2 survivability conversion (§ Weekly Rules) — that one replaces a missed quality session. This slot runs in a normal, fully-delivered week as well.

## Pre-Run Warm-Up (Daily 5)

1. Pogo Hops - 30s
2. A-Skips - 30s
3. Leg Swings (Front/Back) - 30s/side
4. Leg Swings (Lateral) - 30s/side
5. Walking Lunges - 30s

## Current Periodization

Everything through the May race block is complete (Base → Quality Reintro → HM-Specific → HM taper + race Mar 29 → Post-HM Recovery → Base Rebuild → May races: Ansião 10K May 17, Anadia 14.7 km trail May 24). Live and upcoming:

| Phase                  | Dates           | Focus                                                   | Volume      |
| ---------------------- | --------------- | ------------------------------------------------------- | ----------- |
| Cut Block 1            | May 30 - Jul 5  | 2 quality/wk (1 harder + 1 lighter), 10K pace from wk 4 | 35-42 km/wk |
| Cut Block 2 — extended (DONE)    | Jul 6 - Sep 20  | 2 quality/wk, synchronized deload every 3rd wk. Cut hard stop Sep 20 | 35-40 km/wk |
| Reverse (CURRENT) | Sep 21 - Oct 11 | Reverse to the Build tiers; strength restarts; Sep 28 – Oct 4 declared a re-entry week (≥30 km, not scored) | ≥30 km/wk |
| Build | Oct 12 - Jan 4 | **Strength-led build** (redefined 2026-09-29): 4 core runs + bonus 5th, one quality on the ladder + strides + a planned progression finish ≤ every other week; **Oct 25 B-race hard effort** (that week's quality, 2-3 easy days before, no taper); Nov 2–8 trekking exempt; Dec 12 social | 32-42 km/wk |
| Cut 3 | Jan 5 - Apr 12 | Same running shape at 0.3 kg/wk; quality held to one; long run ≤14 km | 32-42 km/wk |
| Maintenance + spring race | Apr 13 - Jun 14 | **Spring 10K A-race, sub-47** (race TBD by Feb 1); 3-4 week sharpen with 10K-pace work, short taper | 35-45 km/wk |
| Lean-out (optional) | Jun 15 - Jul 26 | Running held; autumn 2027 10K (45:00 stretch) is built after Aug 1 | 32-42 km/wk |

## Race Schedule

| Date             | Distance        | Race         | Priority   | Result / Target                          |
| ---------------- | --------------- | ------------ | ---------- | ---------------------------------------- |
| May 17 (Sun)     | 10K (road)      | Ansião 10K   | Done       | 52:16 / 5:13/km, avg HR 176 (raced hard) |
| May 24 (Sun)     | 14.7 km (trail) | Anadia trail | Done       | 2:07:42, avg HR 172, 413 m climb         |
| **Oct 25 (Sun)** | **10K (hilly)** | entered, name TBD | **B-race** | **Hard supported effort inside the build** — even effort at ~172–176 avg HR, no blow-up on the climbs; counts as that week's quality; no taper, no heavy Legs in the 3 days before. Recorded as a fitness read, not scored against a time |
| **Dec 12 (Sat)** | **10K**         | S. Silvestre Coimbra, 18:30 | **Social (C)** | Leisure run with friends (athlete, 2026-09-29). **Mode decided by Dec 5:** group pace (= that week's long run) or a solo hard effort (3-day easy lead, recorded as a read; evening-race logistics in `protocols/archive/running-dec12-arace-plan.md`). No taper, no target |
| **Spring 2027** (late Apr / May) | **10K** | **TBD by Feb 1** | **A-race** | **Sub-47:00** (4:42/km) at ~70–71.5 kg, raced at maintenance after Cut 3. Checkpoint ~Apr 12: confirm sub-47 or re-anchor to sub-48 on session evidence |
| Autumn 2027 | 10K | TBD | A-race | **45:00 stretch** (4:30/km) — needs LT2 pace ~5:00 → ~4:35 and a year of consistent 40+ km weeks; the spring result decides |

**Garmin 10K prediction milestones — a motivation line, never a governor (2026-09-29):** ≤50:30 by Oct 18 · ≤49:30 by Dec 1 · ≤48:30 by Apr 1. A miss triggers a look at volume in the report and nothing else. The predictor undershoots the sessions by ~1–2 min (Sep 2026: prediction 51:00 against threshold work reading ~48:00–49:30).

## Workout Types

### Easy/Base Runs

- **HR:** functional band **~135-142** (cap = lab individual threshold 142 bpm; the old 148 outdoor ceiling is retired). The athlete's easy gait sits near the cap — below ~130 is a walk, so the usable easy window is the top ~7 bpm of Zone 2, not the full 125–142.
- **Pace:** 6:30-7:30/km outdoor, 6:40-7:30/km treadmill
- **Duration:** 30-60 min
- **RPE:** 3-4

### Long Runs

- **HR:** ~135-142, drift ceiling 145 (LT1) when prescribed
- **Duration:** 75-120 min depending on phase
- **RPE:** 4-5
- Long runs over 90 min use quality-day fueling.

### Sub-Threshold Intervals

| Session          | Structure        | HR Target      | Recovery      |
| ---------------- | ---------------- | -------------- | ------------- |
| Norwegian Long   | 3x10 to 4x10 min | 152-165        | 60-90 sec walk |
| Norwegian Short  | 8-10x3 min       | 152-165        | 45-60 sec walk |
| Cruise Intervals | 5-6x1 km         | 152-165        | 60-90 sec walk |
| HM-pace          | 4-6x2 km         | Goal HM effort | 60 sec walk    |

All sub-T sessions target **152–165 bpm**, between LT1 145 and LT2 172. The "≈2.5–3.5 mmol/L" mapping once written here assumed lactate rises linearly between the two thresholds; it rises convexly, so the bottom of the band is likely nearer ~2.2 mmol. It is unverified until the raw ramp steps are on file (2026-09-29 audit). Longer reps (Norwegian Long) sit toward the low end (~152–160); shorter reps (Cruise/Short) can reach ~165. **Hard ceiling 168** — past that you've drifted into threshold (athlete tendency: Jun 2 reps spiked to 179, over-cooked). HR is lactate-anchored and environment-independent — the same numbers apply on the treadmill.

### Tempo (threshold)

- **HR:** 165-172 — at or just under LT2 (172). This is the distinct **threshold** stimulus: it sits at the top of Zone 4 into Zone 5, deliberately higher than the sub-T working band (152–165) — a continuous tempo ramps up to LT2 and holds just under it, while the sub-T sessions stay below.
- **Structure:** 20-30 min continuous
- **RPE:** 7-8
- Hold at/just under LT2. If HR climbs past 172 you're racing the tempo, not running it — back off; that turns a steady threshold piece into a threshold-rep/VO2 effort.

### 10K-Pace Intervals

- **Governor:** HR/effort, not pace. Run reps at 168-174 bpm (around LT2 172) at RPE 8-9.
- **Pace:** currently ~4:55-5:05/km — current 10K race pace (≈5:00/km) sits right at LT2. Goal pace 4:42/km (sub-47, spring 2027) is a **convergence target**: the pace earned at the same HR as fitness rises, not a number to force from day one. Forcing 4:42 now drives HR into the VO2 zone (176+) and turns this into a VO2 session rather than threshold work.
- **Structure:** 6-8x1 km or 4-5x1.5 km with 60-90 sec walk
- **RPE:** 8-9
- In the build from week 7 (§ Build Quality Ladder). This is the core 10K-specific session.

### VO2max Intervals

- **HR:** 175-185 by end of rep
- **Pace:** faster than 10K pace, usually 400-1000 m reps
- **RPE:** 9-10
- One touch in build week 11 (§ Build Quality Ladder), then the Phase 9 sharpen; only when recovery supports it.

### X-Element

- Hill sprints: 6-8x10-15 sec
- Strides: 4-8x20 sec after easy runs
- Short reps: 6-8x200 m at mile effort

## Quality Session Selection (derive before prescribing)

Before naming the week's harder quality run, do not reach for the session in the athlete's words ("speed work") or the prior day's frame — derive it. Answer these, and surface the derivation in one or two lines in the `/plan` summary:

1. **Recent quality history** — the last 2–3 quality session types (read the daily files). Don't repeat a stimulus blindly or skip a rung.
2. **Ladder + phase week** — the current rung on sub-T → threshold → 10K-pace → VO2, and what the phase/week schedules (§ Build Quality Ladder below; the Phase 9 sharpen in § Weekly Rules). The default session is the **next correct rung**.
3. **Block gap** — the under-trained stimulus this block; bias toward closing it.
4. **Recovery + trailing load** — can today carry the intended intensity, or does it down-dose one rung?
5. **Goal relevance** — what the next hard effort actually needs *now* (the Oct 25 B-race, then the spring 2027 10K): threshold base before speed sharpening.

Pick the session this produces. If it deviates from the next rung — pulled forward or held back — log the explicit reason in the daily file. Garmin's Daily Suggested Workout is a useful independent cross-check, not an authority (its pace targets are heat-blind; govern by HR). A 22-min threshold tempo, not 10K-pace intervals, is the wk3 default after a sub-T-only block (2026-06-16 lesson).

### Build Quality Ladder (Oct 12 2026 – Jan 3 2027; written 2026-09-29 audit)

The default rung for the week's one quality session. § Quality Session Selection may hold or drop a rung with a logged reason, but never pulls one forward on the athlete's phrasing.

| Build week | Dates | Default quality |
| --- | --- | --- |
| 1 | Oct 12–18 | Sub-T (cruise or Norwegian) |
| 2 | Oct 19–25 | **Oct 25 B-race replaces it** (2-3 easy days before) |
| 3 | Oct 26 – Nov 1 | Sub-T (after 48-72 h easy) |
| 4 | Nov 2–8 | Trekking — exempt, no quality |
| 5–6 | Nov 9–22 | Threshold (tempo 20-30 min or 3×7-8 min) |
| 7–10 | Nov 23 – Dec 20 | 10K-pace reps (Dec 12 social sits in week 9; if run hard, it is that week's quality) |
| 11 | Dec 21–27 | One short VO2 touch |
| 12 | Dec 28 – Jan 3 | Back down a rung (threshold) into Cut 3 |

Cut 3 holds one quality a week, cycling threshold and 10K-pace. Phase 9 runs the sharpen in § Weekly Rules.

## Weekly Rules by Phase

Scheduling is fully flexible across the week (Thursday no-running rule retired 2026-05-28). The rules below describe **session counts and spacing**, not weekday assignment.

- **Phase 1:** easy-only running. No quality work.
- **Phase 2:** one quality session per week. Long run on the weekend.
- **Phase 3:** sharpen, race, recover. No heavy taper and no hard legs in the last 3 days before a race.
- **Phases 4-5:** two quality sessions per week (one harder, one lighter) with ≥72 h between them; long run on the weekend; legs needs ≥36 h before the next quality run and never stacks with a hard run on the same day.
- **Phase 4 volume note (~35-42 km/wk, ceiling relaxed 2026-06-03):** the original 30-35 cap was lifted because the two quality sessions are a deliberate, athlete-chosen motivation / 10K-specificity priority, and with the quality + long-run trio already near ~30 km only one easy run fit under the old ceiling. The athlete chose to raise the cap rather than cut easy runs. The added load is **easy** km, which moves the week back toward 80/20 rather than degrading it. The long run stays **12-14 km** (≤~35-40% of the week); the lighter quality session stays genuinely short (~5-6 km of work). The band is a guide, not a hard cap: **recovery markers govern** — if flags stack, the lighter quality session is the first thing to downgrade to easy. The higher mileage raises TDEE modestly (~+70 kcal/day at the top of the band); the ~Jun 11 14-day weigh-in read absorbs it (add carbs back if loss runs >0.4 kg/wk or strength/LBM dips).
- **Volume floor — all phases. See § Volume Floor and Delivery Tripwire under Monitoring.** The original Phase 4 floor (30 km/wk, 2026-06-12) is superseded there: it was written for one phase only, and it had no moment at which anything actually computed it. Consistency at the phase band matters more than any single session's design.
- **Phase 4-5 running success metrics (2026-06-12):** easy-run pace is **off the scoreboard until the Sep 21 reversal** — it is sacrificed to the deficit and the season by design, and is not a failure signal. The cut-phase running scoreboard is: (1) heat-adjusted efficiency (treadmill control run pace-at-HR) stable within ~2%, (2) both weekly quality sessions completed at target HR, (3) VO2max estimate holds ≥47 — read via the Garmin race-time prediction as proxy (10K not slower than ~50:00-50:30), since the direct VO2max endpoint is unreliable, (4) weekly volume ≥30 km. Pace-at-HR improvement is a Phase 6-7 deliverable (post-reversal), not a Phase 4-5 one.
- **Phase 4 weeks 1-3:** the harder quality session is the sub-T / Norwegian work; the lighter one is aerobic-development or short sub-T. 10K-pace work enters from week 4.
- **Q2 survivability rule (2026-06-12):** the second quality session has structural attrition — when a session is missed every week, the schedule is wrong, not the athlete. On any compromised week (readiness flags, family disruption, time pressure), Q2 converts to **6×20 s strides or 6×10-15 s hill sprints appended to an easy run** instead of being skipped. A 10-minute quality touch that happens beats a 40-minute session that doesn't. This conversion counts as Q2 completed for compliance.
- **Phase 5:** cap volume at 40 km/week. If 7-day HRV average drops >10% below baseline, downgrade the lighter quality session of the week to an easy aerobic run. **"Baseline" defined 2026-09-07:** Garmin's **balanced-low bound** of the athlete's live HRV band (e.g. 65 on a 65–93 band) — the reading the stack has used consistently since Aug 12. Not the band midpoint. The bound moves as Garmin recalibrates; read it live each morning.
- **Phase 5 deload weeks:** every 3rd week reduce run volume 15-20% and keep only one quality session.
- **Phases 6-10 (from Sep 21; redefined 2026-09-29 — body comp > run fitness > racing):** the week is **four core runs plus a bonus fifth**, sized to the athlete's stated capacity (4–5 runs + 3 lifts), not to an ideal template:
  1. **One quality session** on the sub-T → threshold → 10K-pace ladder (§ Quality Session Selection). The Oct 25 B-race replaces it that week — 2-3 easy days before, normal week after 48-72 h easy.
  2. **One long run, 12-16 km** (≤14 km in Cut 3), cap 142, drift ceiling 145. A **progression finish only when planned**, at most every other week; it counts as the week's second quality. An unplanned fast finish is a breach of the easy contract, not a bonus.
  3. **One easy run with the standing strides slot** (outdoor).
  4. **One easy run = the treadmill control run, fortnightly** (5.0 km at 8.6 km/h, 1% incline, COROS armband), alternating with a second outdoor easy + strides on the other weeks. Three entries before any read.
  5. **Bonus fifth easy run** (5-7 km) when the week has room. It is the first thing dropped.
  Volume **floor 30 km, band 32-42**. Heavy rain: the treadmill is the fallback, not the plan — a rain-shortened week that still hits 30 km is fine. **No second full quality session** while body composition ranks first; the strides and the planned progression finish are the second stimulus. The 72 h quality-spacing and ≥36 h Legs-before-quality rules stand. **Drop order on a compromised week** (athlete's call: run over Legs): bonus run → strides → Legs → quality (to easy) → long run shortened to 10 km → Push and Pull merged into one upper session.
- **Phase 9 (Maintenance + spring race, Apr 13 - Jun 14 2027):** the same shape, with a 3-4 week sharpen (10K-pace reps weekly, one short VO2 touch) and the § Race-Week Running Pattern into the spring 10K. No taper longer than 7 days.
- **Scoreboard from Phase 6 onward (replaces the Phase 4-5 running success metrics):** (1) weekly volume ≥30 km and ≥4 runs, (2) the quality session completed at target HR, (3) the control-run avg-HR trend (fortnightly, ≥3 bpm across three entries is real), (4) long-run pace-at-HR on matched routes, (5) the Garmin prediction milestone line (§ Race Schedule). Easy pace-at-HR is back on the scoreboard from Sep 21.

## Heat and Weather Adaptation

Portugal summer conditions change the session.

- If temperature is `>=18 C` or dew point is `>=16 C`, anchor the run to HR and RPE, not pace.
- Expect roughly 3-5 sec/km pace loss at the same effort in warm conditions. Do not chase normal splits.
- If temperature is `>=24 C`, shorten quality-session volume 10-20% unless the workout is done very early or late.
- If temperature is `>=24 C`, take the pre-run sodium and fluid dose in `nutrition.md` § Hydration and Heat Rules (600-800 mg sodium with 500 mL water, 60-90 min pre-run) for quality sessions and long runs.
- Prefer outdoor quality before 09:00 or after 19:30 in summer.
- For easy runs in heat, walk 20-30 sec if HR drifts above target instead of forcing shuffle pace.
- For trail or long runs >75 min in heat, carry fluids.

## Monitoring

### Volume Floor and Delivery Tripwire

> Written 2026-09-07 — this section was referenced from § Weekly Rules since ~July but never existed (a dangling pointer), which left the floor specified nowhere while two August weeks breached it unscored.

- **Floor: 30 km/week, all phases** (generalised from the 2026-06-12 Phase 4 rule). It is a floor on *delivered* running, checked weekly by `/report` against the live Garmin pull — the moment at which it actually gets computed.
- **A week below the floor, or an ACWR <0.8, is not advisory** (2026-06-12): it requires a logged corrective action in the `current-status.md` coaching log, same as ACWR >1.5.
- **Exemptions must be declared in advance** — a deload, taper, illness week or travel week named before or during the week is exempt (logged, not breached). A week that simply ends low is a breach even if the cause was benign; the point of the rule is that silences get investigated.
- **Delivery tripwire:** when the same planned session type is missed in two consecutive weeks, the schedule is wrong, not the athlete — restructure the week (the Q2-survivability logic, applied generally).

### ACWR

Acute km this week / mean of the **four preceding weeks** (the acute week is not in its own denominator — pinned 2026-09-29 after the Sep 7 report and the Sep 28 daily file used different conventions and produced 0.61 vs 0.57 for the same week).

| ACWR    | Status          | Action                 |
| ------- | --------------- | ---------------------- |
| 0.8-1.3 | Sweet spot      | Continue               |
| 1.3-1.5 | Caution         | Hold or trim next week |
| >1.5    | Danger          | Reduce volume          |
| <0.8    | Detraining risk | **Enforced (2026-06-12):** log a corrective action in the coaching log and rebuild toward the 30 km floor next week. This flag fired silently through the Apr-May trough; it is no longer advisory. |

### Warning Signs

- Easy runs slowing at the capped HR for 3 runs on matched routes -> extra rest day. With easy HR held at ≤142, the signal shows up as pace-at-HR, not as HR (the old "easy HR +5 bpm" trigger could not fire under the cap — 2026-09-29 audit)
- Sleep score <60 for 2 nights -> replace quality with easy
- RHR +5 bpm above baseline for 3 days -> reduce weekly volume 20% (same trigger as `training.md` § Override Rules)
- HRV >15% below the 7-day average for 3 days -> 2 easy or rest days (same trigger as `training.md` § Override Rules; a single-night drop is noise)
- ~~In Phase 5, tighten the HRV rule~~ — expired with Phase 5 (Sep 20)
- Body Battery <30 at wake -> full rest day
- Heat + poor sleep on the same day -> no intensity

## Taper and Race Execution

### 10K races under the 2026-09-29 stack

- **Oct 25 (B, hard effort):** even effort at ~172–176 avg HR; the climbs are run by effort, not pace; 2-3 easy days before, no taper; no heavy Legs in the 3 days before. Pre-race sodium + carbs per `nutrition.md` § Race and Long-Effort Fueling. Recorded as a fitness read.
- **Dec 12 (social):** no taper, no target. If the athlete chooses a solo hard effort (decision due Dec 5), the evening-start logistics in `protocols/archive/running-dec12-arace-plan.md` apply verbatim — they are the only part of the retired A-race plan that is reusable.
- **Spring 2027 (A, sub-47):** pacing template — even at 4:42/km: km 1 no faster than 4:40 and no slower than 4:45, hold 4:40-4:43 to km 8, then whatever is left over km 9-10. (The earlier "start 4:50, settle 4:42-4:46" template could not average 4:42 without a ~4:20 kick — 2026-09-29 audit.) Set the final pacing from the sharpen block's 10K-pace reps, not from this line. Race-week pattern below.

### Quality-Day Warm-Up Upgrade (from Phase 6)

On the weekly quality session from Phase 6 (Sep 21) onward, extend the Daily 5 with one short power-focused drill after the jog warm-up:

- Broad Jumps - 3x5, or
- Power A-Skips - 3x20 m

Keep the contacts crisp and low-fatigue. This is for stiffness and elastic return, not conditioning.

### Race-Week Running Pattern

- **10 days out:** last substantial long run
- **7 days out:** last real threshold session, reduced total volume
- **4-5 days out:** short 10K-pace sharpening only
- **2 days out:** 20-30 min easy + 4 strides or full rest if warm conditions and fatigue demand it
- **1 day out:** rest or 15 min shakeout only

## Post-Race Recovery Rules

### After benchmark 10K races

- 48 hours: easy walking, mobility, no lower-body lifting
- 72 hours: easy run only if legs feel normal and no pain >2/5
- Resume full week only if sleep, HR, and soreness normalize

### After trail 21K or HM

- 3 days minimum without quality work
- 5-7 days before hard lower-body lifting returns
- Keep calories at maintenance for 2 days post-race

## Longer-Race Fueling Reference

Generic reference for any future HM or trail race around 90-120 minutes. None is currently on the calendar — every planned race is a 10K, which needs no in-race fuel — and an HM before June 2027 was explicitly deferred at the 2026-09-29 consult ("likely to change"; revisit at the Jan 4 checkpoint, since it would change the volume band and tiers inside the cut).

- Carb load 36-48 h pre-race: 6-8 g/kg/day carbohydrate
- Race breakfast 3-4 h pre-start: 1-1.5 g/kg carbohydrate
- In-race: 30-45 g carbohydrate/hour
- Fluids: 400-700 mL/hour adjusted by weather and thirst
- Sodium: 300-600 mg/hour in moderate-to-warm conditions
- Practice mid-run fueling on 2-3 long runs >75 min in the weeks before any such race, using race-day products.

## Data Source

Live Garmin MCP only (fallback: direct `garminconnect` pull via the token cache).

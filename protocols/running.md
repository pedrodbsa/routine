# RUNNING PROTOCOL - MASTER

> HR zones, workouts, weekly rules, monitoring and race execution. Races, targets and phase dates: `current-status.md` and `calendar.md`. Phases 1-5 rules: `protocols/archive/running-phases-1-5.md`.

## Key Context

The limiter is cardiovascular, not muscular. HR and RPE govern easy days and hot weather; pace is secondary. Lab lactate test (FCDEFUC, 2026-04-28): LT1 145 bpm @ 5:52/km, LT2 172 bpm @ 5:00/km, individual threshold 142 bpm @ 6:00/km. The 10K PR pace (5:00/km) sits at LT2, so 10K racing is a threshold effort.

## HR Zones (lactate-anchored)

| Zone | Name          | HR Range  | % of LT2 | Purpose                                            |
| ---- | ------------- | --------- | -------- | -------------------------------------------------- |
| 1    | Recovery      | <125      | <73%     | Walking only: walk breaks and walk recoveries between reps |
| 2    | Aerobic Base  | 125-142   | 73-83%   | Easy runs, long runs (cap = lab individual threshold) |
| 3    | Aerobic Dev   | 143-151   | 83-88%   | Steady aerobic                                     |
| 4    | Sub-Threshold | 152-168   | 88-98%   | Norwegian / cruise intervals: work band 152-165, hard ceiling 168 |
| 5    | Threshold     | 169-175   | 98-102%  | Tempo, threshold reps, 10K race effort             |
| 6    | VO2max        | 176-185   | 102-108% | Hard intervals, late-race surge                    |
| 7    | Anaerobic     | >185      | >108%    | Sprints, final kick                                |

Anchors: LT1 145, LT2 172, max ~190 (race-observed).

**The zones apply in every environment; pace-at-HR does not transfer between them.** Outdoor easy pace currently runs ~6% faster than the control belt at the same HR (6:33–6:39/km @138 outdoors against 8.6 km/h = 6:59/km @136–137 on the treadmill; the 1% incline and belt calibration are confounds). Compare pace-at-HR within one environment only.

**Compressed range.** This athlete cannot run below ~130 bpm; below that is a walk. The functional easy band is therefore **~135–142**, a ~7 bpm window under the cap. Logged easy runs average ~137–142, and brief drift to 143–145 is his natural easy ceiling, governed by RPE and conversation. Easy and sub-T sit only ~10 bpm apart, so RPE and pace must separate them. The same compression makes outdoor easy pace-at-HR a noisy fitness signal; the treadmill control run is the clean read.

### Garmin Device Settings

The watch zones are entered in bpm: Warm Up ≥95, Easy ≥120, Aerobic ≥143, Threshold ≥158, Maximum ≥172. They are an on-watch display only; the table above and per-session targets govern. Threshold power is set manually to **360 W** (from the Ansião 10K's 371 W normalized power at avg HR 176), so the power gauge and power-based Training Effect read sensibly; power is not a training governor.

## Easy-Run Rules

| Environment | Ceiling | Spike Max | Typical Pace            |
| ----------- | ------- | --------- | ----------------------- |
| All         | 142 bpm | 145 bpm   | 6:30-7:30/km outdoor, 6:40-7:30/km treadmill |

- Easy = RPE 3-4 and full conversation. RPE above 5 → slow down, whatever the HR says.
- Easy and long runs are **one Garmin step** at the cap, with no warmup or cooldown block (`[[feedback-easy-run-single-step]]`).
- **Between interval reps the recovery is a walk** (or jog → walk): HR will not fall into any jog band in ~90 s. Walk recovery lowers rep-entry HR, so judge a rep by its end-of-rep max, not its average.
- **Treadmill control run, fortnightly on the Monday easy slot:** **5.0 km, belt locked at 8.6 km/h, 1% incline, treadmill mode, COROS armband always** (an entry on any other sensor is void). The tracked number is **avg HR**. Never raise the belt: it restarts the series. Valid series: Jul 13 **137** · Jul 27 **136**. Three entries before any read; ≥3 bpm across three entries is a real change.
- **Weekly strides slot:** one easy run a week finishes with **6 × 20 s strides**, relaxed-fast at ~5K/mile turnover, RPE 7–8, full walk-back recovery, by feel rather than HR. Stop early if form fades. Its home is the easy run furthest from the quality day; never on the quality day or the day before it. The reason it is standing: sub-47 (4:42/km) needs roughly cadence 180 × stride 118 cm, against the Mar 8 race's 175.9 × 113.5. Stride length is an output of force and elastic return, and strides let it self-organise at speed. **Never prescribe conscious stride lengthening**: overreaching lands ahead of the centre of mass and brakes.

## Pre-Run Warm-Up (Daily 5)

1. Pogo Hops - 30s
2. A-Skips - 30s
3. Leg Swings (Front/Back) - 30s/side
4. Leg Swings (Lateral) - 30s/side
5. Walking Lunges - 30s

**Quality days:** add one power drill after the jog warm-up — Broad Jumps 3x5 or Power A-Skips 3x20 m. Crisp, low-fatigue contacts; skip it if calf or Achilles pain is above 2/5.

## Workout Types

### Easy/Base Runs

- **HR:** ~135-142 (cap 142). **Pace:** 6:30-7:30/km outdoor, 6:40-7:30/km treadmill. **Duration:** 30-60 min. **RPE:** 3-4.

### Long Runs

- **HR:** ~135-142, drift ceiling 145 (LT1). **Distance:** 12-16 km (≤14 km in Cut 3). **RPE:** 4-5.
- A progression finish only when planned, at most every other week; it counts as the week's second stimulus. An unplanned fast finish is a breach of the easy contract.
- Banana + coffee before; the day is on the Long tier.

### Sub-Threshold Intervals

| Session          | Structure        | HR Target      | Recovery      |
| ---------------- | ---------------- | -------------- | ------------- |
| Norwegian Long   | 3x10 to 4x10 min | 152-160        | 60-90 sec walk |
| Norwegian Short  | 8-10x3 min       | 152-165        | 45-60 sec walk |
| Cruise Intervals | 5-6x1 km         | 152-165        | 60-90 sec walk |

Sub-T sits between LT1 145 and LT2 172. **Hard ceiling 168**; past it the session has become threshold work (the athlete's tendency is to over-cook the openers). The first rep opens at the low end of the band.

### Tempo (threshold)

- **HR:** 165-172, at or just under LT2. **Structure:** 20-30 min continuous or 3×7-8 min. **RPE:** 7-8.
- Past 172 you are racing the tempo, not running it: back off.

### 10K-Pace Intervals

- **Governor:** HR/effort, not pace — reps at 168-174 bpm, RPE 8-9.
- **Pace:** currently ~4:52-5:05/km. Goal pace 4:42/km is a convergence target, earned at the same HR as fitness rises; forcing it now drives HR to 176+ and makes it a VO2 session.
- **Structure:** 6-8x1 km or 4-5x1.5 km with 60-90 sec walk.

### VO2max Intervals

- **HR:** 175-185 by end of rep. **Reps:** 400-1000 m, faster than 10K pace. **RPE:** 9-10. Only when recovery supports it.

### X-Element

- Hill sprints 6-8x10-15 sec · strides 4-8x20 sec after easy runs · 6-8x200 m at mile effort.

## Quality Session Selection (derive before prescribing)

Derive the week's quality session; never reach for the athlete's phrasing ("speed work") or the prior day's frame. Surface the derivation in one or two lines of the `/plan` summary:

1. **Recent quality history:** the last 2–3 quality types in the daily files. Don't repeat a stimulus blindly or skip a rung.
2. **Ladder:** the default rung from § Build Quality Ladder (the Phase 9 sharpen in § Weekly Rules).
3. **Block gap:** the under-trained stimulus this block.
4. **Recovery and trailing load:** can today carry it, or does it drop a rung?
5. **Goal relevance:** what the next hard effort needs now — the Oct 25 B-race, then the spring 10K. Threshold base comes before speed sharpening.

A deviation from the default rung needs its reason logged in the daily file. Garmin's Daily Suggested Workout is a cross-check, not an authority (its paces are heat-blind).

### Build Quality Ladder (Oct 12 2026 – Jan 3 2027)

| Build week | Dates | Default quality |
| --- | --- | --- |
| 1 | Oct 12–18 | Sub-T (cruise or Norwegian) |
| 2 | Oct 19–25 | Oct 25 B-race replaces it (2-3 easy days before) |
| 3 | Oct 26 – Nov 1 | Sub-T, after 48-72 h easy |
| 4 | Nov 2–8 | Trekking — exempt, no quality |
| 5–6 | Nov 9–22 | Threshold |
| 7–10 | Nov 23 – Dec 20 | 10K-pace reps. Week 9 (Dec 7–13): the Dec 12 hard effort replaces the quality and the long run, with 3 easy days before |
| 11 | Dec 21–27 | One short VO2 touch |
| 12 | Dec 28 – Jan 3 | Threshold |

Cut 3 holds one quality a week, alternating threshold and 10K-pace.

## Weekly Rules (Phases 6-10)

Scheduling is fully flexible; these rules set session counts and spacing. The week is **four core runs plus a bonus fifth**, sized to the athlete's stated capacity (4–5 runs + 3 lifts):

1. **One quality session** on the ladder. The Oct 25 B-race replaces it that week, then 48-72 h easy.
2. **One long run** (§ Long Runs).
3. **One easy run with the strides slot** (outdoor).
4. **One easy run on the Monday slot:** the treadmill control run on alternate weeks, a plain outdoor easy on the others (no strides: Monday is the day before the quality).
5. **Bonus easy run** (5-7 km) when the week has room; the first thing dropped.

- Volume **floor 30 km, band 32-42**. Heavy rain: the treadmill is the fallback, not the plan.
- **No second full quality session** while body composition ranks first; strides and the planned progression finish are the second stimulus. **Exception, trial Oct 9 – Oct 20 2026 (athlete's call 2026-10-06, Option B):** Tuesday is the main quality and Friday carries a second, shorter one (threshold touch; Fridays Oct 9 and Oct 16, Tuesday Oct 20; Oct 23 is race-adjacent and stays easy). Qualities stay ≥72 h apart, Friday's replaces the strides run, and the leg half of Legs + shoulders is dropped for the length of the trial. Any warning-sign rule below turns that Friday back into an easy run. Reviewed at Oct 25 on delivered strength, control-run HR, easy pace-at-HR and sleep/HRV.
- Qualities ≥72 h apart; Legs ≥36 h before any quality and never on the same day as a hard run.
- **Drop order on a compromised week** (athlete's call: run over Legs): bonus run → strides → the leg half of Legs + shoulders → quality (to easy) → long run shortened to 10 km → Chest and Back merged.
- **Phase 9 (Apr 13 – Jun 14 2027):** the same shape plus a 3-4 week sharpen (10K-pace reps weekly, one short VO2 touch) and § Race-Week Running Pattern into the spring 10K. No taper longer than 7 days.

**Scoreboard** (reported weekly, every week — the running numbers are the athlete's motivation driver): (1) volume ≥30 km and ≥4 runs, (2) the quality session at target HR, (3) the control-run avg-HR trend, (4) long-run and easy pace-at-HR on matched routes, (5) the Garmin prediction milestone line (`current-status.md` § Race Schedule).

## Heat and Weather Adaptation

- ≥18 °C or dew point ≥16 °C → run to HR and RPE, not pace; expect ~3-5 s/km slower at the same effort.
- ≥24 °C → shorten quality volume 10-20% unless run very early or late, and take the pre-run sodium and fluid in `nutrition.md` § Hydration and Heat Rules before quality and long runs.
- In summer, outdoor quality before 09:00 or after 19:30.
- Easy runs in heat: walk 20-30 s when HR drifts over target rather than shuffling.
- Carry fluids on trail or long runs >75 min in heat.

## Monitoring

### Volume Floor and Delivery Tripwire

- **Floor: 30 km of delivered running per week, all phases**, checked by `/report` against Garmin.
- **A week below the floor, or ACWR <0.8, needs a logged corrective action** in the `current-status.md` coaching log, same as ACWR >1.5.
- **Exemptions are declared in advance** (deload, taper, illness, travel); a week that simply ends low is a breach even if the cause was benign.
- **Delivery tripwire:** the same planned session type missed two weeks running means the schedule is wrong — restructure the week.

### ACWR

Acute km this week ÷ mean km of the **four preceding weeks** (the acute week is not in its own denominator).

| ACWR    | Status          | Action                 |
| ------- | --------------- | ---------------------- |
| 0.8-1.3 | Sweet spot      | Continue               |
| 1.3-1.5 | Caution         | Hold or trim next week |
| >1.5    | Danger          | Reduce volume; log a corrective action |
| <0.8    | Detraining risk | Log a corrective action; rebuild toward the 30 km floor next week |

### Warning Signs

- Easy runs slowing at the capped HR for 3 runs on matched routes → extra rest day (under the 142 cap, the signal shows up as pace, not HR)
- Sleep score <60 for 2 nights → replace quality with easy
- RHR +5 bpm above baseline for 3 days → reduce weekly volume 20%
- HRV >15% below the 7-day average for 3 days → 2 easy or rest days
- Body Battery <30 at wake → full rest day
- Heat + poor sleep on the same day → no intensity

## Race Execution

- **Oct 25 (B, hard effort):** even effort at ~172–176 avg HR, climbs run by effort; 2-3 easy days before, no taper, no heavy Legs in the 3 days before. Fueling per `nutrition.md` § Race Fueling. Recorded as a fitness read.
- **Dec 12 (B, hard effort, run with friends):** even effort at ~172–176 avg HR; 3 easy days before, no taper, no heavy Legs in the 3 days before; no separate long run that week. The evening-start logistics in `protocols/archive/running-dec12-arace-plan.md` apply. Recorded as a fitness read, the last one before the cut.
- **Spring 2027 (A, sub-47):** even pacing at 4:42/km — km 1 between 4:40 and 4:45, hold 4:40-4:43 to km 8, then whatever is left. Set the final pace from the sharpen block's 10K-pace reps.

### Race-Week Running Pattern

- **10 days out:** last substantial long run
- **7 days out:** last real threshold session, reduced volume
- **4-5 days out:** short 10K-pace sharpening only
- **2 days out:** 20-30 min easy + 4 strides, or rest if warm and fatigued
- **1 day out:** rest or a 15 min shakeout

## Post-Race Recovery

- **After a hard 10K:** 48 h easy walking and mobility, no lower-body lifting; an easy run at 72 h only if legs feel normal and pain ≤2/5; resume the full week once sleep, HR and soreness normalise.
- **After an HM or trail 21K:** 3 days minimum without quality, 5-7 days before hard lower-body lifting, 2 days at maintenance calories. Fueling for those distances: `nutrition.md` § Race Fueling (none is planned before June 2027; revisit at the Jan 4 checkpoint).

## Data Source

Live Garmin MCP only (fallback: direct `garminconnect` pull via the token cache).

# STRENGTH EXERCISES — MASTER

> Personal strength database: one row per exercise — where it can be trained, current working load, how to program it, and the verified Garmin Connect enum.
> **Single source of truth for strength baselines** (migrated out of `current-status.md` on 2026-06-17). Nothing else holds working loads.

## Gyms & Equipment

Three locations. The **Gym** column on each exercise says where it can be trained.

### G1 — default (self-directed)

- Barbell · dumbbells · **kettlebells (16 kg, 20 kg only)**
- Squat rack · benches: flat, incline
- **Dual adjustable pulley** — 60 kg/arm, vertical + horizontal, rope + handles. **Crossover yes; cable row no.**
- Row-erg (cardio)
- **No dip station, no pull-up bar** → no full dips, no pull-ups here.

### G2 — self-directed

- Barbell · dumbbells (**no kettlebells**)
- Squat rack · benches: flat, incline, decline
- Pec-deck + chest-press machine
- **Single-pulley system:** low pulley (cable rows) + high pulley (lat pulldown), many bar adapters. **No crossover** (single pulley).
- Dip station · pull-up bar

### PT — coach-led

- Full facility incl. leg machines (leg press, leg extension, leg/ham curl, back extension). **The coach picks the work; the DB only stores the loads you log** — it does not drive selection here.

## How this file is used

- **`/report`** owns the numbers: each week it updates **Working load × reps** and **Last logged**, and upgrades a Garmin-enum status from `⚠ guess` to `✓ <date>` (or records a new trap) when `/garmin` confirms one.
- **`/plan`** reads the **Gym** column (filter to the day's gym — default **G1**), the **Working load** (progression), and **Pattern / rotation** (rotate the selection vs the last same-type session) when programming strength.
- **`/garmin`** reads the **Garmin enum** column before building a strength workout — use the `✓` enum, heed the `⚠ not …` traps, and treat `free-entry` as "closest category + name in the step description." After read-back it upgrades the status here.
- **History note:** full set-by-set history lives in the daily `logbook/` files — this table holds only the _current_ working top set plus a one-line trend.

## Legend

- **Gym:** `G1` / `G2` / `PT`; `G1·G2` = either self-directed gym.
- **`✓ MM-DD`** — `exerciseName` survived a `get_workout_by_id` read-back on that date (year 2026).
- **`⚠ guess`** — best candidate enum, not yet confirmed; `/garmin` must verify on the next upload and date it.
- **`⚠ not X`** — known silent-drop trap: Garmin keeps the category but discards `X`; use the listed name instead.
- **`free-entry`** — no surviving `exerciseName`; upload with the category shown and put the real name in the step `description`.

## Exercises

| Exercise                        | Pattern / rotation        | Gym   | Rep role              | Working load × reps                | Last logged | Garmin enum (category / exerciseName · status)                        | Notes                                                     |
| ------------------------------- | ------------------------- | ----- | --------------------- | ---------------------------------- | ----------- | --------------------------------------------------------------------- | --------------------------------------------------------- |
| Barbell bench press (flat)      | Horizontal press          | G1·G2 | Upper 8–12            | 50 kg × 8, 8                       | 2026-05-20  | `BENCH_PRESS` / `BARBELL_BENCH_PRESS` ⚠ guess                         | also 40 kg × 12, 12 same session                          |
| Flat DB press                   | Horizontal press          | G1·G2 | Upper 8–12            | —                                  | —           | `BENCH_PRESS` / `DUMBBELL_BENCH_PRESS` ⚠ guess                        | rotation off barbell                                      |
| Incline DB press                | Horizontal press          | G1·G2 | Upper 8–12            | 20 kg/DB × 10, 10, 8, 8            | 2026-06-16  | `BENCH_PRESS` / `INCLINE_DUMBBELL_BENCH_PRESS` ✓ 06-16                | target 22 kg — under-shot lifting blind                   |
| Decline barbell press           | Horizontal press          | G2    | Upper 8–12            | —                                  | —           | `BENCH_PRESS` / `BARBELL_DECLINE_BENCH_PRESS` ⚠ guess                 | G2 decline bench                                          |
| Chest-press machine             | Horizontal press          | G2    | Upper 8–12            | —                                  | —           | `BENCH_PRESS` / free-entry                                            | G2 machine                                                |
| Standing cable chest press      | Horizontal press          | G1·G2 | Upper 10–12           | —                                  | —           | `BENCH_PRESS` / free-entry                                            | G1 dual or G2 single-arm; constant tension                |
| Overhead press (barbell)        | Vertical press            | G1·G2 | Upper 8–12            | 30 kg × 8, 8, 8                    | 2026-06-08  | `SHOULDER_PRESS` / `OVERHEAD_BARBELL_PRESS` ⚠ guess                   | re-anchored; supersedes 16 kg DB                          |
| Seated DB shoulder press        | Vertical press            | G1·G2 | Upper 8–12            | 16 kg/DB × 8                       | 2026-06-16  | `SHOULDER_PRESS` / `SEATED_DUMBBELL_SHOULDER_PRESS` ✓ 06-16           | ramped blind; target 20 kg                                |
| Arnold press (DB)               | Vertical press            | G1·G2 | Upper 8–12            | —                                  | —           | `SHOULDER_PRESS` / `DUMBBELL_ARNOLD_PRESS` ⚠ guess                    | full-ROM delt sweep                                       |
| Push press (BB/DB)              | Vertical press            | G1·G2 | Upper 5–8             | —                                  | —           | `SHOULDER_PRESS` / `BARBELL_PUSH_PRESS` ⚠ guess                       | leg-drive power option                                    |
| Cable crossover                 | Chest accessory           | G1    | Upper 12–15           | by feel                            | 2026-06-16  | `FLYE` / `CABLE_CROSSOVER` ✓ 06-16                                    | dual pulley — G1 only                                     |
| Low-to-high cable flye          | Chest accessory           | G1    | Upper 12–15           | —                                  | —           | `FLYE` / free-entry                                                   | dual pulley; upper-chest bias (single-arm possible at G2) |
| Pec-deck flye                   | Chest accessory           | G2    | Upper 12–15           | —                                  | —           | `FLYE` / free-entry                                                   | G2 machine                                                |
| DB flye                         | Chest accessory           | G1·G2 | Upper 12–15           | —                                  | —           | `FLYE` / `DUMBBELL_FLYE` ⚠ guess                                      | flat/incline bench                                        |
| Bench dip (weighted)            | Triceps / dips            | G1·G2 | Upper 8–15            | +12.5 kg × 10                      | 2026-06-16  | `TRICEPS_EXTENSION` / `BENCH_DIP` ✓ 06-16                             | from +10 kg (Jun 8)                                       |
| Dips (full, bodyweight)         | Triceps / dips            | G2    | Upper 8–12            | BW × 8, 8, 7                       | 2026-06-16  | `TRICEPS_EXTENSION` / `DIP` ⚠ guess                                   | needs dip station — G2 only; add load once 3×12           |
| Cable triceps pushdown          | Triceps / dips            | G1·G2 | Upper 10–15           | —                                  | —           | `TRICEPS_EXTENSION` / `TRICEPS_PRESSDOWN` ✓ 06-19                     | high pulley; rope or bar                                  |
| Overhead cable triceps ext      | Triceps / dips            | G1·G2 | Upper 10–15           | —                                  | —           | `TRICEPS_EXTENSION` / free-entry                                      | long-head stretch                                         |
| DB lateral raise                | Lateral / delts           | G1·G2 | Upper 12–15           | 8 kg × 12                          | 2026-06-16  | `LATERAL_RAISE` / `DUMBBELL_LATERAL_RAISE` ✓ 06-16                    | up from 7 kg (May 20)                                     |
| Cable lateral raise             | Lateral / delts           | G1·G2 | Upper 12–20           | —                                  | —           | `LATERAL_RAISE` / free-entry — ⚠ not `CABLE_LATERAL_RAISE` (drops 06-19) | single-arm constant tension; name in step description                               |
| Lat pulldown                    | Vertical pull             | G1·G2 | Upper 6–10            | 110 kg × 8, 8                      | 2026-06-17  | `PULL_UP` / `LAT_PULLDOWN` ✓ 06-17                                    | G1 dual high anchor / G2 high pulley; next 110×10 |
| Pull-ups (strict)               | Vertical pull             | G2    | Upper 5–10            | BW × 5, 5, 3                       | 2026-05-28  | `PULL_UP` / `PULL_UP` ⚠ guess                                         | needs pull-up bar — G2 only                               |
| Straight-arm cable pulldown     | Vertical pull             | G1·G2 | Upper 12–15           | —                                  | —           | `PULL_UP` / free-entry                                                | high pulley, lat isolation                                |
| Barbell row                     | Horizontal row            | G1·G2 | Upper 8–12            | 50 kg × 8, 8, 7                    | 2026-06-17  | `ROW` / `BARBELL_ROW` ✓ 06-17                                         | 3 working sets @ 50 kg (06-17); push reps to 12 before loading |
| DB row (1-arm)                  | Horizontal row            | G1·G2 | Upper 8–12            | 22.5 kg/hand × 10                  | 2026-06-12  | `ROW` / `DUMBBELL_ROW` ⚠ guess                                        | up from 20 kg (May 21)                                    |
| Chest-supported DB row          | Horizontal row            | G1·G2 | Upper 8–12            | —                                  | —           | `ROW` / `DUMBBELL_ROW` ⚠ guess                                        | incline bench, strict                                     |
| Seated cable row                | Row accessory             | G2    | Upper 10–12           | 55 kg × 10–12                      | 2026-06-12  | `ROW` / `SEATED_CABLE_ROW` ✓ 06-17                                    | low pulley — G1 can't do cable rows                       |
| Single-arm cable row            | Row accessory             | G2    | Upper 10–12           | —                                  | —           | `ROW` / free-entry                                                    | low pulley — G2 only                                      |
| Face pull                       | Rear delt                 | G1·G2 | Upper 15–20           | 35 kg × 15, 20, 20                 | 2026-06-17  | `ROW` / `FACE_PULL` ✓ 06-17                                           | high pulley + rope                                        |
| Cable reverse fly (X)           | Rear delt                 | G1    | Upper 15–20           | —                                  | —           | `FLYE` / `CABLE_REVERSE_FLY` ⚠ guess                                  | dual pulley cross — G1 (single-arm alt at G2)             |
| Reverse fly / rear-delt (DB)    | Rear delt                 | G1·G2 | Upper 15–20           | —                                  | —           | `FLYE` / free-entry — ⚠ not `DUMBBELL_REVERSE_FLY` (drops 06-19) | prone on incline bench; name in step description                                    |
| Barbell curl                    | Biceps                    | G1·G2 | Upper 10–12           | 27 kg × 12, 10, 7                  | 2026-06-17  | `CURL` / `BARBELL_BICEPS_CURL` ✓ 06-17 — ⚠ not `BARBELL_CURL` (drops) |                                                           |
| Incline DB curl                 | Biceps                    | G1·G2 | Upper 10–12           | —                                  | —           | `CURL` / `INCLINE_DUMBBELL_BICEPS_CURL` ✓ 06-19                       | stretch bias on incline bench                             |
| Hammer curl                     | Biceps                    | G1·G2 | Upper 10–12           | 12 kg × 11–13                      | 2026-06-12  | `CURL` / `DUMBBELL_HAMMER_CURL` ✓ 06-19                               | 4 sets @ 12 kg                                            |
| Cable curl                      | Biceps                    | G1·G2 | Upper 10–12           | —                                  | —           | `CURL` / `CABLE_BICEPS_CURL` ⚠ guess                                  | low pulley; Bayesian (behind body) for stretch            |
| Romanian deadlift               | Hinge (leg primary)       | G1·G2 | Leg 4–6 heavy         | 60 kg × 6 × 4                      | 2026-06-11  | `DEADLIFT` / `ROMANIAN_DEADLIFT` ✓ 06-11                              | RDL loads hamstrings harder at equal load                 |
| Barbell deadlift (conventional) | Hinge (leg primary)       | G1·G2 | Leg 4–6 heavy         | 70 kg × 8 top                      | 2026-05-28  | `DEADLIFT` / `BARBELL_DEADLIFT` ⚠ guess                               | ascending 60/65/70 × 8                                    |
| Single-leg RDL (DB/KB)          | Hinge / single-leg        | G1·G2 | Leg 8–10/leg          | —                                  | —           | `DEADLIFT` / `SINGLE_LEG_ROMANIAN_DEADLIFT` ⚠ guess                   | balance + ham; leg-curl substitute                        |
| Kettlebell swing                | Hinge (power)             | G1    | 3–5 × 10–15           | —                                  | —           | `HIP_SWING` / `KETTLEBELL_SWING` ⚠ guess                              | KB only (G1); capped at 20 kg                             |
| Cable pull-through              | Posterior chain           | G1·G2 | Leg 10–12             | —                                  | —           | `HIP_RAISE` / free-entry                                              | low pulley + rope, hinge — back-extension substitute      |
| Barbell hip thrust              | Posterior chain / glute   | G1·G2 | Leg 6–10              | —                                  | —           | `HIP_RAISE` / `BARBELL_HIP_THRUST` ⚠ guess                            | bench-supported                                           |
| Back extension                  | Posterior chain           | PT    | Upper 12–15           | 50 kg × 13                         | 2026-06-12  | `HYPEREXTENSION` / `BACK_EXTENSION` ⚠ guess                           | PT machine (sub: cable pull-through / good morning)       |
| Back squat                      | Squat (leg primary)       | G1·G2 | Leg 4–6 heavy         | 60 kg (tempo 6,6,8 / no-tempo 8×2) | 2026-06-11  | `SQUAT` / `BARBELL_BACK_SQUAT` ⚠ guess                                | tempo base May 28                                         |
| Front squat                     | Squat (leg primary)       | G1·G2 | Leg 4–6               | —                                  | —           | `SQUAT` / `BARBELL_FRONT_SQUAT` ⚠ guess                               | quad bias; leg-press substitute                           |
| Goblet squat (DB/KB)            | Squat (leg primary)       | G1·G2 | Leg 8–12              | —                                  | —           | `SQUAT` / `GOBLET_SQUAT` ⚠ guess                                      | KB only at G1 (≤20 kg); warm-up or volume                 |
| Leg press                       | Squat (leg primary)       | PT    | Leg 4–6 heavy         | TBD                                | 2026-06-11  | `SQUAT` / `LEG_PRESS` ✓ 06-11                                         | PT machine (sub: front/goblet squat)                      |
| Bulgarian split squat           | Single-leg (prehab dose)  | G1·G2 | Leg 2×8 light         | 12 kg DB × 8/leg                   | 2026-06-11  | `LUNGE` / free-entry                                                  | confirm per-hand vs total                                 |
| Walking lunges (DB/BB)          | Single-leg                | G1·G2 | Leg 8–10/leg          | —                                  | —           | `LUNGE` / `WALKING_LUNGE` ⚠ guess                                     |                                                           |
| Reverse lunge (DB/BB)           | Single-leg                | G1·G2 | Leg 8–10/leg          | —                                  | —           | `LUNGE` / `REVERSE_LUNGE` ⚠ guess                                     | knee-friendly                                             |
| Leg curl                        | Hamstring                 | PT    | Leg 8–10 mod          | by feel                            | 2026-06-11  | `LEG_CURL` / free-entry                                               | PT machine (sub: Nordic / single-leg RDL)                 |
| Nordic ham curl                 | Hamstring                 | G1·G2 | 3 × 5–8               | —                                  | —           | `LEG_CURL` / free-entry                                               | foot anchor (bench/partner); leg-curl substitute          |
| Leg extension                   | Quad accessory            | PT    | Leg 10                | 25 kg × 10 × 3                     | 2026-06-11  | `LEG_CURL` / ⚠ check category                                         | PT machine; single-leg 30 kg × 8/leg (May 28)             |
| Standing calf raise (DB/BB)     | Calf                      | G1·G2 | Leg 8–10 heavy-paused | by feel                            | 2026-06-11  | `CALF_RAISE` / `STANDING_CALF_RAISE` ✓ 06-11                          | load up per leg respec                                    |
| Seated DB calf raise            | Calf                      | G1·G2 | Leg 10–15             | —                                  | —           | `CALF_RAISE` / `SEATED_CALF_RAISE` ⚠ guess                            | soleus bias; DB on knee                                   |
| Box / broad jumps               | Plyo (leg)                | G1·G2 | 3–4 × 5 contacts      | —                                  | —           | `PLYO` / `BOX_JUMP` ⚠ guess                                           | bench as box; explosive block                             |
| Broad jump                      | Plyo (leg)                | G1·G2 | 3–4 × 3–5             | —                                  | —           | `PLYO` / free-entry                                                   | horizontal power vector                                   |
| Plank                           | Core anti-extension       | G1·G2 | 3 × 30–45 s           | BW                                 | 2026-06-16  | `PLANK` / `PLANK` ✓ 06-16                                             | time end-condition                                        |
| Ab-wheel rollout                | Core anti-extension       | G1·G2 | 3 × 8–12              | —                                  | —           | `CORE` / free-entry                                                   | needs an ab wheel — confirm available                     |
| Side plank                      | Core anti-lateral-flexion | G1·G2 | 3 × 30–45 s           | —                                  | —           | `PLANK` / `SIDE_PLANK` ✓ 06-19                                        | time end-condition                                        |
| Pallof press                    | Core anti-rotation        | G1·G2 | 3 × 10–12/side        | cable                              | 2026-06-16  | `CORE` / free-entry                                                   | single cable                                              |
| Half-kneeling cable chop        | Core anti-rotation        | G1·G2 | 3 × 10–12/side        | cable                              | 2026-06-17  | `CHOP` / `CABLE_WOODCHOP` ✓ 06-17                                     | single cable                                              |
| Hanging knee raise              | Core dynamic              | G2    | 3 × 10–12             | BW                                 | 2026-06-11  | `CRUNCH` / free-entry                                                 | needs pull-up bar — G2 only                               |
| Hanging leg raise               | Core dynamic              | G2    | 3 × 8–12              | BW                                 | —           | `LEG_RAISE` / `HANGING_LEG_RAISE` ⚠ guess                             | needs pull-up bar — G2; harder than knee raise            |
| Cable crunch                    | Core dynamic              | G1·G2 | 3 × 10–12             | cable                              | —           | `CRUNCH` / `CABLE_CRUNCH` ✓ 06-19                                     | high pulley + rope, kneeling                              |
| Suitcase carry                  | Carry / stability         | G1·G2 | 3 × 30–40 m/side      | 24 kg                              | 2026-06-17  | `CARRY` / `SUITCASE_CARRY` ✓ 06-17                                    | DB/KB; time end-condition (per side)                      |
| Farmer's carry (2 KB/DB)        | Carry / stability         | G1·G2 | 3 × 30–40 m           | —                                  | —           | `CARRY` / `FARMERS_WALK` ⚠ guess                                      | KB only at G1 (≤20 kg)                                    |

> **Lower-body programming note (leg respec 2026-06-12):** legs are **not** a hypertrophy target. Primary lift 3–4×4–6 heavy at RIR 2–3 (load-at-fixed-reps progression), explosive/plyo block, single-leg as a 2×8 prehab dose, hamstring curl + heavy calves as strain insurance. See `training.md` § Leg Day.
>
> **Gym note:** at **G1** (default) there are no cable rows, no full dips, no pull-ups, and KB work caps at 20 kg — program barbell/DB rows, bench dips, and lat pulldown instead. The PT-tagged leg machines aren't selectable on self-directed days; use their free-weight substitutes (front/goblet squat, RDL, Nordic curl, cable pull-through).

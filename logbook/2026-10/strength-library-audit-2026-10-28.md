# Strength library and rotation review — 2026-10-28

Athlete-raised after the Oct 28 Legs + shoulders: "way too shoulder heavy, and light on the legs", "the exact workout from last week?", and "ensure that exercise library is up to date, backed by science, and that you prescribe good exercises, with some variation to keep things interesting."

## What the session showed

- Oct 28 ran 6 leg working sets against 12 shoulder sets. The leg half had been halved on Tuesday's soft markers, and the file was carried into a Green Wednesday without re-deriving it (`memory/feedback-rederive-not-inherit.md`).
- Against Oct 15, three slots rotated (squat → RDL, face pull → reverse fly, side plank → carry). The overhead press, lateral raise and jump squats repeated, which `training.md` allows, and the single-leg and hamstring slots were left out both times. That is why it read as the same workout.

## What the evidence says

Sources are web-search summaries and secondary pages, not full papers read end to end. Treat them as direction, not proof.

| Question | Finding | What it changes |
| --- | --- | --- |
| Does variety build more muscle? | No. Baz-Valle et al. 2019 (21 trained men, 8 weeks) and Nunes et al. 2024 (70 young women) found similar muscle thickness and strength with fixed or varied selection. Varying exercises raised motivation (Baz-Valle). | Rotate for adherence and joint variety, not for growth. Scorecard lifts stay fixed. |
| How much volume? | Schoenfeld, Ogborn and Krieger 2017: growth rose with weekly sets, with 10+ sets per muscle per week giving the most. | Upper-body build volume (~10–12 sets for chest and back) stands. Legs stay low by the athlete's design. |
| Does the deficit change it? | Murphy and Koehler 2022 (59 studies): lean-mass gain is impaired in a deficit, though strength is not hurt. Smaller deficits (≤~500 kcal) protect lean mass best. | The slow cut's ~220 kcal/day is the right size. Expect retention, not gain, and use loads as the lean-mass instrument (already the rule). |
| Do heavy lifts or jumps help running economy more? | Heavy resistance training (g = −0.32) beat plyometrics (g = −0.13) in a 2022 meta-analysis; the largest effects came at ≥90% 1RM, over 10–14 weeks. | Keep the heavy primary lift in the leg half. The jump squats are the secondary slot. The RDL at ~5 reps, RIR 3 is below the 90% range, so heavier top sets are a question for later, not a change now. |
| Hamstring injury prevention | Nordic programmes cut hamstring injuries by about half (risk ratio ~0.49, 15 studies, 8,459 people), mostly in team sports. | Nordics come up at least every third Legs session. Extrapolation to a runner is reasonable but not proven. |
| Lengthened-position training | Maeo et al. 2023: overhead triceps extension grew the triceps ~1.4× more than a neutral-arm extension. | The overhead cable extension is already in Back day. Incline curl is already in Chest day. No change. |
| Front raises | No source found in this pass. Reasoning only: pressing already loads the front delt heavily. | Not added. Revisit if you want them for a reason other than variety. |

## Library audit findings

1. `training.md` listed **Step-Ups** and **Trap-Bar Deadlift** as Legs options, but `strength-exercises.md` had no row for either, and neither self-led gym has a trap bar. Step-up row added, trap bar dropped.
2. **16 rows carry `⚠ guess` enums** (incline barbell press, decline press, push press, dips, pull-ups, single-leg RDL, KB swing, hip thrust, back extension, front squat, goblet squat, seated calf raise, hanging leg raise, weighted sit-up, and others). They are unverified, not wrong. The cheapest fix is to rotate them into sessions and let `/garmin` read them back.
3. The **Arnold press** is in the library, but it cannot replace the overhead press because that is a scorecard lift fixed in its slot.
4. **Back extension** is tagged "Upper 8–15" as its rep role though it is a posterior-chain leg-day option, and its Garmin auto-detect is known to mislabel it as `CABLE_CRUNCH`. Not changed yet.
5. Working loads are the athlete's: `/report` owns them, and the 35 kg OHP and 60 kg RDL set from Oct 28 await a verified second session.

## Edits made (`protocols/`)

- `training.md` § Legs + Shoulders: all four leg slots run unless a marker downgrades the day; slots 3 and 4 rotate against the last two Legs sessions; the shoulders drop to the press plus one superset if the leg half is cut below 8 sets; the lateral raise alternates DB and cable; the rear delt rotates across three options; no front raises; trap bar dropped.
- `strength-exercises.md`: step-up row added.

## Not done, for the athlete to decide

- A full sweep to verify every `⚠ guess` enum is a series of uploads, not an edit.
- Heavier leg top sets for running economy (the evidence favours ≥90% 1RM), which needs a re-entry-aware plan after the trekking week.

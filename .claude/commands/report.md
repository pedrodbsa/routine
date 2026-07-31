# Report - Weekly / Monthly Progression Review (MASTER)

## Usage

```
/report
/report weekly
/report monthly
```

## Function

1. **Pull live Garmin data first** (revised 2026-07-31): all trends compute from the live Garmin MCP (fallback: direct `garminconnect` pull). Verify the pull covers the full reporting week before computing ACWR, weekly km, or the volume-floor check.
2. Analyze recent strength, running, nutrition, body composition, and recovery data
3. Identify progression, plateaus, and warning signs
4. Compare outcomes to the live body-recomp target (`current-status.md` § Goals): ~72.5-73 kg / ~17.5-18% BF at the Sep 20 cut hard stop, holding 59.6 kg lean (Bod Pod 2026-04-28 baseline: 76.11 kg @ 21.7%); 71 kg / 16% resumes post-Dec 12. Scale BF% is BIA and reads ~7 pp high vs Bod Pod — govern by the weight trend and lean-mass retention, not scale BF%.
5. Review compliance with sleep, mobility, weigh-ins, and food tracking
6. Run phase-aware weekly checks:
    - Compute ACWR and flag >1.3 or <0.8. **An ACWR <0.8 or a week below the 30 km volume floor is not advisory** (2026-06-12): it requires a logged corrective action in the coaching log, same as >1.5.
    - Score the cut-phase running scoreboard (`running.md` § Phase 4-5 running success metrics): treadmill control-run pace-at-HR trend (the heat-independent signal — one easy run per week runs on the treadmill at fixed conditions), both quality sessions completed at target HR (Q2 strides/hill-sprint conversions count), VO2max estimate ≥47 (read via the Garmin race-time prediction as proxy — 10K not slower than ~50:00-50:30 — when the direct VO2max endpoint returns no data), weekly volume ≥30 km. Easy-run outdoor pace is off the scoreboard until September — do not report it as a progression/regression signal during the cut.
    - Compute Composite Load and compare it to the rolling 4-week average
    - Compute 7-day weight average and compare to prior week
    - Flag stalls during cut phases
    - Check whether heat or sleep modified the week materially
    - Check strength-session count and nutrition on-plan compliance (the athlete eats to the portion-locked rotation / `/plan` meal table and does **not** log digitally — judge by the weekly weight trend and the protein floor, not a food log)
    - Report the week's **average daily steps** (Garmin daily steps) as an expenditure/context read only — **NEAT is opportunistic, not a target or deficit lever (2026-06-23)**, so do not flag "short of 8-10k." The deficit rests on the plan-day calorie tiers + social-day control; note any social-day surplus pattern, since plan-day food is held fixed. Note weeks where skipped sessions were correctly absorbed by re-tiering the day's food down (not by added walking).
7. Update `protocols/current-status.md` when this stack is active. Set the
   `Last verified` date in the header to the report date — this is the date the
   `/plan` staleness guard checks.
8. Update `protocols/strength-exercises.md` — the single source of truth for
   strength loads (migrated out of `current-status.md` on 2026-06-17). Refresh the
   **Working load × reps** and **Last logged** cells from the week's logged
   sessions, and upgrade any Garmin-enum status that `/garmin` confirmed this week
   (`⚠ guess` → `✓ <date>`, or record a new `⚠ not …` trap). Do not re-add a loads
   table to `current-status.md`.
9. **Protocol sync check (added 2026-07-31)** — the last step of every report, added
    after the Oct→Dec A-race change lived only in a conversation for weeks while
    every file kept planning against the stale calendar. Three passes, cheap and
    mechanical:
    - **Unrecorded-decision sweep.** Scan the week's daily files (`## Context` /
      decision notes) and anything the athlete reports as "we agreed X" for
      decisions touching the race calendar, goals, targets, phase boundaries, or
      standing rules. Each one must exist in the `current-status.md` coaching log
      AND be propagated to every affected protocol file. An unrecorded or
      half-propagated decision is a defect to fix in this report, not a note. If
      the athlete references a decision with no file trace at all, say so plainly
      and reconstruct it with him — never silently adopt or silently ignore it.
    - **Cross-file consistency check.** Grep the load-bearing values and confirm
      they agree everywhere they appear: race dates/targets and phase boundaries
      (`current-status.md` ↔ `running.md` ↔ `training.md` ↔ `nutrition.md` ↔
      `AGENTS.md`), calorie tiers and protein/fat floors (macros must actually sum
      to the stated kcal), HR anchors, and volume bands. Disagreements resolve by
      the source-of-truth hierarchy (lab data > logged data > athlete decisions >
      the designated single-source file) and get logged.
    - **Staleness/archive pass.** Anything in the operational files that is
      superseded, completed, or >2 weeks dead-narrative moves to
      `protocols/archive/` (pointer left behind). `current-status.md` stays
      operational-only — if it is growing back toward pre-2026-07-31 size, trim it.
    This step is the weekly *sync* check. The deep false-assumption hunt
    (physiology claims, unattainable targets, zombie rules) stays with the `/audit`
    skill — run that on demand or roughly quarterly, not weekly.

## Requirements

- Keep recommendations actionable and specific.
- Mention upcoming phase transitions when within 7 days.
- Mention whether a fallback week is needed.
- Save monthly output to `logbook/YYYY-MM/report.md`.

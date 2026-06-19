# Report - Weekly / Monthly Progression Review (MASTER)

## Usage

```
/report
/report weekly
/report monthly
```

## Function

1. **Refresh Garmin data exports first** (2026-06-12): verify `data/activities.csv` includes the current week's activities before computing any trend. A stale export (the Jun 12 review found June runs missing) silently corrupts ACWR, weekly km, and the volume-floor check. If the export is stale, re-pull before proceeding.
2. Analyze recent strength, running, nutrition, body composition, and recovery data
3. Identify progression, plateaus, and warning signs
4. Compare outcomes to the locked body-recomp target (`current-status.md`): 76.11 kg @ 21.7% BF (Bod Pod 2026-04-28) -> 71 kg @ 16% BF, holding 59.6 kg lean. Scale BF% is BIA and reads ~7 pp high vs Bod Pod — govern by the weight trend and lean-mass retention, not scale BF%.
5. Review compliance with sleep, mobility, weigh-ins, and food tracking
6. Run phase-aware weekly checks:
    - Compute ACWR and flag >1.3 or <0.8. **An ACWR <0.8 or a week below the 30 km volume floor is not advisory** (2026-06-12): it requires a logged corrective action in the coaching log, same as >1.5.
    - Score the cut-phase running scoreboard (`running.md` § Phase 4-5 running success metrics): treadmill control-run pace-at-HR trend (the heat-independent signal — one easy run per week runs on the treadmill at fixed conditions), both quality sessions completed at target HR (Q2 strides/hill-sprint conversions count), VO2max estimate ≥47 (read via the Garmin race-time prediction as proxy — 10K not slower than ~50:00-50:30 — when the direct VO2max endpoint returns no data), weekly volume ≥30 km. Easy-run outdoor pace is off the scoreboard until September — do not report it as a progression/regression signal during the cut.
    - Compute Composite Load and compare it to the rolling 4-week average
    - Compute 7-day weight average and compare to prior week
    - Flag stalls during cut phases
    - Check whether heat or sleep modified the week materially
    - Check strength-session count and nutrition on-plan compliance (the athlete eats to the portion-locked rotation / `/plan` meal table and does **not** log digitally — judge by the weekly weight trend and the protein floor, not a food log)
    - Compute the week's **average daily steps** (Garmin daily steps) and flag if it falls short of the ~8-10k NEAT target — this is the cut's primary deficit lever this block (2026-06-18). Also note any social-day surplus pattern, since plan-day food is held fixed.
7. Run the weekly skin assessment (`protocols/skin-log.md`):
    - Ask the athlete for this week's skin: severity (0–5), affected areas /
      barrier feel, the regimen used this week (products, or "none"), and any
      change versus last week.
    - Pull the week's objective drivers already gathered above: average sleep
      duration and score, weekly stress average, HRV trend, and training load.
    - Append one block to the Weekly Log using the documented format, drawing a
      conclusion that correlates the skin state against those drivers for the
      week — not a generic note. Revise the working-hypothesis ranking in that
      file when the accumulated evidence justifies it.
    - Skin is weekly-only; never request or infer a daily skin score.
8. Update `protocols/current-status.md` when this stack is active. Set the
   `Last verified` date in the header to the report date — this is the date the
   `/plan` staleness guard checks.
9. Update `protocols/strength-exercises.md` — the single source of truth for
   strength loads (migrated out of `current-status.md` on 2026-06-17). Refresh the
   **Working load × reps** and **Last logged** cells from the week's logged
   sessions, and upgrade any Garmin-enum status that `/garmin` confirmed this week
   (`⚠ guess` → `✓ <date>`, or record a new `⚠ not …` trap). Do not re-add a loads
   table to `current-status.md`.

## Requirements

- Keep recommendations actionable and specific.
- Mention upcoming phase transitions when within 7 days.
- Mention whether a fallback week is needed.
- Save monthly output to `logbook/YYYY-MM/report.md`.

---
name: feedback-living-nutrition-table
description: "On /log meal, overwrite the eaten meal's row in the daily Nutrition table with the actual and re-tune the remaining meals to hold the day-type macros"
metadata: 
  node_type: memory
  type: feedback
  originSessionId: 6511e9a5-af58-4f82-b7f2-664a2001ea85
  modified: 2026-08-04T10:14:59.751Z
---

When the athlete logs a meal (`/log meal …`), don't just record it under `## Actuals`. Make the daily file's `## Nutrition` table **living**:

1. **Overwrite the eaten meal's row in place** with the actual food + actual macros and mark it eaten. The planned text doesn't matter — the macro/calorie accounting is what's tracked.
2. **Re-tune the remaining (not-yet-eaten) meals' targets** to absorb any macro/calorie deviation and hold the day-type tier.
3. Keep a three-row **macro-tracking summary** current: **Expected** (tier target) / **Actual so far** (eaten meals) / **Projected** (day end).
4. `## Actuals` then carries **only genuine deviations, swaps, and flags** — no duplicate meal-by-meal record.

**Why:** the athlete weighs his food and wants the daily file to track macros/calories live, not as a frozen morning plan plus a separate after-the-fact log. Granted 2026-06-22.

**How to apply:** respect the protein-distribution rule (≥3 boluses ≥30 g, pre-bed ≥40 g) and the fat floor when re-tuning; if a quality or long-run day projects under tier, flag underfueling. Encoded in `.claude/commands/log.md` § Meal and `protocols/daily-template.md` §§ Nutrition / Actuals. See [[feedback-prefers-activity-over-food-cuts]] and [[feedback-tracking-adherence]].

**True the projection at write time, not only on change (2026-08-04).** The athlete caught a day projecting +2.4% over tier after two meal swaps — but the swaps contributed 5 kcal; `/plan` had already written the morning projection at **+2.1% over**, rationalised in prose as "lands +2.1% on tier," and `/log` then re-tuned around that inflated baseline twice without re-examining it. **A Projected row that sits over Expected is a defect at the moment it is written**, not a rounding tolerance to be narrated away — and once it is in the file, every subsequent re-tune inherits it. Trim the plan to the tier before presenting it. The same fix usually solves an athlete complaint about portion size (here, 7 egg whites → 4), because the overshoot is normally sitting in a protein source.

**Correcting a shortfall (2026-06-22):** when a logged meal leaves the day under the protein floor, prescribe the **minimal-calorie top-up that just clears the floor** (whey is the leanest-per-calorie source) — do NOT overshoot protein and push calories over the day-type tier. On a cut the calorie tier dominates; the protein floor is a floor, not a target, and soft distribution niceties (e.g. nudging a 37 g pre-bed bolus to ≥40 g) are NOT worth ~100+ kcal over tier once the leucine threshold (~30 g) is already met at that feed. The athlete will (correctly) push back on protein overshoot that drags calories up.

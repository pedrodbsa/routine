---
name: feedback-weight-drop-water-vs-tissue
description: "How to decompose a fast weight drop into water vs tissue — hydration-matched subset plus absolute body water in kg, never body-water percent"
metadata: 
  node_type: memory
  type: feedback
  originSessionId: 9d770203-359e-4686-91b7-4bcb766e3767
  modified: 2026-07-29T09:57:51.540Z
---

When a fasted-morning series drops fast and you need to know whether it is fat or water, run two checks before concluding anything:

1. **Hydration-matched subset.** Drop the readings that follow two or more consecutive training days — they carry the window's lowest body-water percentages and drag the average down for reasons that have nothing to do with fat. Compare what is left against the prior window.
2. **Absolute body water in kg, not percent.** Multiply weight × body-water %. A percentage can hold steady while total water falls (or vice versa) simply because the denominator moved. On 2026-07-29 the six-reading post-trim average was −1.09 kg, but the matched subset was **−0.84 kg with absolute water flat at 36.3 kg** — which is what made it a tissue story rather than a water story.

Then sanity-check the implied TDEE: `tier + (kg/wk × 7700 / 7)`. If it lands somewhere absurd (2,900 kcal/day for a 75 kg athlete on 33 km/wk), a large share of the drop is not fat, whatever the water numbers say.

**Why:** BIA body-water percent is the number the scale reports and the number that misleads. Percent moves with the denominator; kilograms do not. And a recent carb cut has a specific alternative explanation with tight arithmetic — glycogen carries ~3 g water per gram, so a 250–300 g glycogen drawdown is 1.0–1.2 kg on the scale with zero fat lost, and it is self-limiting within one to two weeks.

**How to apply:** report both framings and name which one you trust. If they disagree, the discriminator is time, not more analysis — say so rather than forcing a verdict. See [[feedback-weigh-in-check-timestamps]] and [[feedback-weigh-in-state-not-clock]] for getting the readings clean in the first place.

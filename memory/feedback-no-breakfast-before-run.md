---
name: feedback-no-breakfast-before-run
description: "No breakfast before QUALITY/hard runs (banana + coffee at most); easy runs tolerate breakfast fine — and breakfast must never be deleted from a double day, it is the pre-lift fuel"
metadata:
  node_type: memory
  type: feedback
  originSessionId: eb965fee-0afb-438a-b0a2-dad254e35827
  modified: 2026-08-03T10:30:48.756Z
---

The rule is **conditional on run intensity**, not absolute. The 2026-07-31 correction (athlete had a banana and ate breakfast after a full breakfast was specced 90 min pre-run) was about a **quality session** — cruise intervals. On 2026-08-03 the athlete corrected the over-generalisation: *"I can run with breakfast as long as it's an easy run."*

- **Quality / long / hard runs:** banana + coffee at most. Breakfast lands after.
- **Easy runs:** breakfast beforehand is fine.

**Why:** GI comfort at intensity is the actual constraint, not a blanket rule about food and running. Storing it as absolute caused a second, worse failure on 2026-08-03: `/plan` deleted breakfast from the day *entirely* on a midday pre-lunch double, leaving a 30-min easy run plus a full 8-slot Upper Push to run on one banana and a scoop of whey (~5 g of carbs). The athlete flagged the under-fuelling himself. `nutrition.md` § Carbohydrate Partitioning on Double Days explicitly says the opposite — **"post-run shake plus breakfast are the pre-lift fuel — land roughly 35-45% of the day's carbs there so the lift is fed."**

**How to apply:** on a pre-lunch double, breakfast is never dropped — it sits **between the run and the lift** and is the lift's fuel (protocol default: run → shake → breakfast → lift). Before a quality run, keep breakfast post-run. Before an easy run it may sit either side. A late/midday gym trip creates a ~4 h fasted morning and produced real pre-run hunger on 2026-08-03 — treat the pre-run banana as fixed, never as something to optimise away for marginal lift-fuelling gains (that swap was made and reverted within ten minutes). Related: [[feedback-check-time-before-nutrition]], [[feedback-treadmill-run-backtoback-with-lift]], [[feedback-no-single-dominant-feed]].

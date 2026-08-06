---
name: feedback-trailing-load-check
description: "/plan must synthesize trailing multi-day load (consecutive run/training days, days since rest) before prescribing — not just same-day markers"
metadata: 
  node_type: memory
  type: feedback
  originSessionId: cc16e194-8dc9-493e-9b5b-31a227526fc0
---

Before prescribing any session in `/plan`, explicitly count and weigh trailing load: consecutive run days, consecutive training days, days since last full rest, and number of hard sessions in the last 7 days. The same-day readiness decision tree (sleep / HRV / BB / RHR) is marker-based and has no memory of recent load — relying on it alone misses cumulative-fatigue cases.

**Why:** On 2026-06-15 the first `/plan` draft prescribed an easy run on the athlete's 5th consecutive run day (after a hard Sat quality + Sun long run, into a benchmark-taper week) because "no same-day override flag fired." The athlete caught it. The activity data had already been pulled — the failure was not synthesizing it into a load pattern.

**How to apply:** Build and print a 7-day load ledger (date · session · ran? · hard?) alongside the multi-day recovery trend (HRV / RHR / BB), and state it before the readiness verdict. The flag is load *without* recovery, not a raw day count — this athlete runs 5-7 days/week by design, so frequency alone is normal. Trigger a default-to-easy/rest on: ≥2 hard sessions (quality, long run, heavy legs) in the trailing 3 days; or consecutive training days coinciding with a recovery downtrend; and bias to freshness when a race is within ~7 days. (Avoid the trap of a tidy round-number threshold like "≥4 consecutive days" — that misfires on a high-frequency template. Decide on the merits, not a borrowed heuristic.) See [[coaching-lessons]].

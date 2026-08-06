---
name: feedback-walk-recovery-intervals
description: "On interval sessions prescribe WALK recovery, not jog — his HR won't drop into a jog-recovery band in ~90s after a rep"
metadata: 
  node_type: memory
  type: feedback
  originSessionId: 49f06e38-c910-4f65-b083-07eed2252290
---

On interval/cruise sessions the athlete **walks the recoveries, not jogs** (confirmed 2026-07-15, sub-T 4×1km). After a sub-T/threshold rep his HR does not fall into the prescribed jog-recovery band (~120–150) within a ~90 s recovery — his HR decays slowly and his range is compressed (easy jog already ~135–145; see the /garmin 2026-06-13 HR-band calibration). Jogging keeps him above the band, so walking is the only way to actually recover between reps.

**Why it matters (two effects):**
1. **Workout design:** prescribe **walk recovery** (or "jog then walk to bring HR down") on interval sessions, and set the Garmin recovery step's expectation accordingly — the 120–150 *jog* band is unrealistic for him in short rests. This is a `running.md` / `/garmin` recovery-step refinement (flag for `/report`).
2. **Data interpretation:** walk recovery lets each rep **start from a lower HR**, which pulls the rep *average* HR down. So a low rep-average is partly a walk-recovery artifact, not purely fitness — read the **end-of-rep max HR** for the true effort level, and don't over-read a low rep-average as an efficiency gain. (Root of the 2026-07-15 "4:55/km looks like a breakout" over-read, corrected.)

Relates to the compressed-HR-range calibration (easy ceiling 142, jog ≥130) and [[feedback-pace-hr-calibration]].

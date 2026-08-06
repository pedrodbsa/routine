---
name: feedback-treadmill-run-backtoback-with-lift
description: "When a treadmill run is prescribed on a day that also has a strength session, assume they're done back-to-back in one gym trip"
metadata: 
  node_type: memory
  type: feedback
  originSessionId: a914de46-aaea-4d6c-abac-147cc2c9276a
---

Whenever `/plan` prescribes a **treadmill run** on a day that also carries a **strength session**, assume the athlete does them **back-to-back in a single gym trip** — he won't make two separate trips.

**Why:** time-constrained (work + toddler); one gym visit is the realistic pattern. Stated 2026-07-13.

**How to apply:**
- Prescribe the treadmill run + lift as one contiguous block (default pre-lunch double per `training.md` § Double-Day Guidelines), not two separately-timed sessions.
- Sequence peri-workout fuel for back-to-back: if done fasted, take the post-run shake *before* the lift so it isn't done empty (the double-day guideline already covers this); breakfast/lunch land after the block.
- Applies specifically to the weekly **treadmill control run** (the fixed-protocol easy run) when it lands on a Push/Pull/Legs day — pair it with that session rather than spreading them across the day.
- Outdoor runs are unaffected (those can be run-before-breakfast, lift-before-lunch); this is about the treadmill run sharing the gym trip with the lift.

Related: [[feedback-adjust-day-on-skipped-session]], [[feedback-garmin-watch-offsite-reference]].

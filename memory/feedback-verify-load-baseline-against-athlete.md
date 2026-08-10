---
name: feedback-verify-load-baseline-against-athlete
description: Garmin strength rep counts are pre-filled from the prescription — a load baseline built on them can be fiction; the athlete's recall of "I tried it and it was too heavy" outranks the record
metadata:
  type: feedback
---

A structured Garmin strength workout pre-fills each set's rep count from the prescription, and
the athlete only edits it sometimes. **The weight field is hand-edited and trustworthy; the rep
field may be the prescription echoed straight back.** The tell is uniformity — if every set in a
session reads the same rep number across unrelated exercises, the reps are almost certainly not
counted.

This produced a fictional baseline: `strength-exercises.md` recorded seated DB shoulder press at
**20 kg × 12** from 2026-07-20 and told `/plan` to consolidate there. The athlete reported
2026-08-10 that he had picked up the 20s that day and they were too heavy. The activity showed a
14 → 16 → 20 ramp with *every* rep field reading 12, including all three bench sets. The
neighbouring sessions agreed with him — Jul 1 had 16 as a top single, Aug 10 delivered 16 × 12,
12, 10 — so Jul 20 was the outlier and the "regression" flagged against Aug 10 was an artifact of
the bad baseline.

**Why:** a load baseline is the input to every future progression decision on that movement, and
it also feeds the `nutrition.md` early-restore tripwire ("working loads regressing across two
consecutive sessions of the same type"). A phantom baseline can fire a calorie change on a
regression that never happened.

**How to apply:** before flagging a load regression, check whether the *prior* entry is real —
look for the uniform-rep signature in the source activity and sanity-check it against the
sessions on either side. When the athlete says a recorded load was never genuinely performed,
take his account: the asymmetry favours him, since re-anchoring low costs one session that he
blows through, while holding a phantom load costs every session until it is caught. Correct the
DB row, say plainly that the baseline was retracted, and withdraw any flag built on it. Related:
[[feedback-verify-session-completed-against-garmin]], [[feedback-benchmark-matched-reps]].

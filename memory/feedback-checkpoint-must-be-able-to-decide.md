---
name: feedback-checkpoint-must-be-able-to-decide
description: Before writing a checkpoint rule, check it can actually resolve its own effect and that its threshold still serves the live target
metadata:
  type: feedback
---

When writing any checkpoint, tripwire, or re-read rule, test it two ways before it goes in the stack.

**Power.** Compute the effect size the rule is meant to detect, and compare it to the noise in the measurement over the window. The Aug 11 re-read was built to detect a 100 kcal change, worth ~0.09 kg over its 7-day window, against a ~0.11 kg standard error on the difference of two fasted-morning window means. Signal ≈ noise, so the rule could not produce a decision — it could only produce a coin flip with a procedure attached. Widen the window or drop the rule; do not ship it.

**Threshold vs the live target.** Re-derive the trigger from the goal that is actually in force, not from the phase design rate it was inherited from. The Aug 11 trim-back fired below 0.30 kg/wk, but from 74.27 kg the Sep 20 landing of 72.5–73.0 needed only **0.21–0.30 kg/wk** — the trigger fired at rates that hit the target. The threshold survived the Sep 20 extension unexamined because nobody re-ran the arithmetic after the timeline moved.

**Also check what happens between reads.** A decision that holds unmonitored for three weeks (a holiday with no scale) carries far more regret than one re-checkable in seven days. Bias toward the reversible action and move the real decision to the first date it can actually be measured — but **pre-commit the moved decision in writing**, or moving it is just a deferral.

Related: [[feedback-weight-drop-water-vs-tissue]] for decomposing a flat or fast scale before reading a rate at all, and [[feedback-benchmark-matched-reps]] for the same shape of error on the training side.

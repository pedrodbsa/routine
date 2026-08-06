---
name: feedback-rederive-not-inherit
description: "Re-derive each day's session from rules + data + the watch DSW; never inherit yesterday's \"week shape,\" and justify any conservative default."
metadata: 
  node_type: memory
  type: feedback
  originSessionId: 48a57b9a-2b05-4628-bab4-1e745f8ba3ad
---

On 2026-06-24 `/plan` prescribed an easy run when a quality (threshold) session was the correct call. Nothing in the protocol barred quality — 72 h+ since the last hard effort, 0 hard in the trailing 3 days, markers green and rising — and the athlete's watch was suggesting a threshold session. The error surfaced only because the athlete pushed back.

**Why:** The mistake was inheriting a stale frame instead of re-deriving from the rules. The Jun 20 race was in wk3; the Jun 22→23 files had labelled wk4 a "0-quality recovery week" and that label was carried forward across three days unexamined. The Jun 23 slot-logic ("Wed collides with Thu legs, Sat stacks on Sun long") had never checked Wednesday *itself* — the very slot the quality belonged in. Two compounding misses: defaulting to the more conservative session without a logged reason (overrides require justification, but so should a conservative default — symmetrically), and not consulting the Garmin Daily Suggested Workout, which contradicted the easy call. The athlete follows the plans faithfully, so an unjustified easy default directly costs earned training.

**How to apply:**
- **Re-derive the week's shape (quality count, long run, volume) from the phase template + recovery each morning — do not edit yesterday's "Week ahead" table forward.** A "recovery week" label set days ago is a hypothesis to re-test, not a fact. When a race rolls from one week into the next, re-check whether *this* week still warrants reduced load, and re-check the slot logic against every day including today.
- **Capture the watch DSW every plan** (`get_training_status` is unreliable for this athlete — ask him what the watch suggests). If the prescription is easier than the DSW, justify the gap out loud.
- **Default discipline is symmetric.** Green markers + no load rule firing ≠ "easy is safe." Surface the case for the harder alternative and give the specific reason for the call either way. Legitimate reasons to default easy are nameable (a load rule fired, race within ~7 days, softening markers); "it was a recovery week" inherited from a file is not.
- Encoded in `.claude/commands/plan.md` (step 4 DSW pull, step 6 weekly re-derivation, step 7 reconcile-vs-DSW + justify-the-default, Requirements "Default discipline (symmetric)").

Related: [[feedback-quality-session-periodization]] (derive the harder quality from the ladder + phase week, cross-check the DSW), [[feedback-adjust-day-on-skipped-session]], [[feedback-trailing-load-check]].

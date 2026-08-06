---
name: feedback-strength-rotation-two-session-lookback
description: "Rotate strength exercise selection against the last TWO same-type sessions, not one — a one-session lookback flip-flops A/B and repeats a session inside two weeks"
metadata: 
  node_type: memory
  type: feedback
  originSessionId: 0249edc3-b6fd-4fc9-b691-5ff0cbaeb031
  modified: 2026-07-27T13:18:30.592Z
---

When programming a strength day, rotate the exercise selection against the **two most recent same-type sessions**, not just the last one. `strength-exercises.md` § *Pattern / rotation* says "rotate the selection vs the last same-type session", and following that literally produces an A/B flip-flop.

**Why:** On 2026-07-27 the prescribed Upper Push repeated **six of seven slots** from Jul 13 (flat bench, barbell OHP, low-to-high cable flye, bench dip, DB lateral raise, plank) because `/plan` rotated off Jul 20 — straight back into Jul 13. The athlete noticed before the coach did ("different exercises because you carbon copied the previous one") and substituted incline barbell press and DB flyes himself, which was better programming than what was prescribed.

**How to apply:** Before writing the strength table in `/plan`, read the last **two** logbook files for that session type (Push / Pull / Legs) and require each slot's exercise to differ from both. If the movement library can't supply a third option for a slot, say so explicitly in the plan rather than silently repeating. Related: [[feedback-garmin-onwatch-strength-loads]].

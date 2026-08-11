---
name: feedback-weigh-in-state-not-clock
description: "Weigh-in must be anchored to body STATE (post-void, pre-food), never to a fixed clock time — bowel timing is not controllable and a clock rule makes the series worse"
metadata: 
  node_type: memory
  type: feedback
  originSessionId: 2ed65531-8491-44fd-9e44-dcf9270fea41
  modified: 2026-07-22T09:15:39.247Z
---

The athlete weighs **post-void (bladder + bowel), after black coffee, before water and before food**. The clock time this lands on varies by a couple of hours (seen 07:31, 08:28, 09:07) because bowel timing is not controllable. He drinks the coffee first *because it triggers the bowel movement*, so coffee necessarily precedes the weigh-in — and water does not precede it either (restated by the athlete 2026-08-11).

**Corollary, because this was missed once: never flag a reading as food-confounded merely because it is timestamped after the morning coffee.** Every reading in the series is post-coffee; the condition is constant, so it cannot bias a window-to-window comparison. On 2026-08-11 a reading at 08:28 was flagged as possibly-fed because the day's plan put a pre-run banana at 08:15 — the banana came after the weigh-in, as it always does. The flag cost nothing but it should not have been raised, because this file already answered it.

On 2026-07-22 `/plan` told him to "pin the weigh-in time" to remove variance. **That advice was wrong and he corrected it.**

**Why:** the clock is a proxy for the state, not the thing being controlled. A fixed clock time would force some mornings pre-void and some post — a 0.1–0.3 kg swing, *larger* than the ~0.1 kg of insensible loss across the 1.5 h of clock drift the rule was trying to eliminate. His existing practice is stricter than the rule I proposed, not looser. The pre-weigh coffee is ~250 mL, consistent day to day, and largely absorbed/partly excreted by the time the bowel movement arrives hours later — well inside noise.

**How to apply:** never prescribe a fixed weigh-in clock time. The rule is *post-void, pre-food, whenever that lands*. When timing variance shows up in the series, do not treat it as a protocol breach. Related: [[feedback-weigh-in-check-timestamps]] — the real weigh-in failure mode is a changed *state* (post-run vs fasted-morning), which is exactly what this state anchor prevents.

General lesson: before "correcting" an athlete's routine, check whether the variance is controllable and whether the existing practice already controls the larger error term. See also [[feedback-tracking-adherence]].

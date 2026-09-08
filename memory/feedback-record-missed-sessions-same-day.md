---
name: Record missed sessions same-day
description: When a planned session is missed, write the reason into a daily file (or one-line log) the same day — silent misses made the Aug 24–30 week unreconstructable
type: feedback
---

When a planned session does not happen, record **that it was missed and why** the same day — a daily file, or at minimum a one-line entry. Verification against Garmin (`[[feedback-verify-session-completed-against-garmin]]`) catches *that* a session didn't happen, but the *reason* is unrecoverable later, and reasons are what separate a benign miss from a pattern.

**Why:** The Aug 27 file planned a full re-entry (easy + Pull Thu, easy + Legs Fri) on green markers; only the Sunday run happened, no files were written Aug 28–29, and by the Sep 7 `/report` the misses had no recoverable cause. Two of August's four weeks could not be scored properly. Same failure shape on Sep 3–5 (a 4.53 h night and a rule-breaching run with no record).

**How to apply:** `/plan` and `/log` should prompt for it; `/report` treats a missed planned session with no recorded reason as a process defect (as in `logbook/2026-08/report.md`), not just a data gap. This also feeds the skipped-session re-tiering rule ([[feedback-adjust-day-on-skipped-session]]), which cannot fire on a miss nobody recorded.

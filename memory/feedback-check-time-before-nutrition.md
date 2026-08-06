---
name: feedback-check-time-before-nutrition
description: Check the actual local time before making any time-sensitive nutrition / meal-sequencing decision
metadata: 
  node_type: memory
  type: feedback
  originSessionId: 8e5b5c9d-24ce-4baf-84d1-348e257578fe
---

Before laying out meal times, pre-/post-workout feeds, or any "eat X by HH:MM" guidance (in `/plan`, `/log`, or ad-hoc nutrition adjustments), check the actual current local time first — never assume a standard morning start.

**Why:** On 2026-06-29 the `/plan` day was built around a ~07:30 breakfast, then resequenced around an 11:30 training block — but the athlete was still fasted at 10:26, so the planned breakfast was already impossible and the day had to collapse from 5 feeds to 4 (eggs folded into lunch to hold the fat floor). Meal timing and sequence depend on how much of the day remains and what's already been eaten; an assumed start produces a plan that's dead on arrival.

**How to apply:** Run `date "+%Y-%m-%d %H:%M %A %Z"` (Bash) or `Get-Date` (PowerShell) for the authoritative local time before sequencing the day — the session reminder gives the date but not the time. Then build/re-sequence around the real remaining window, holding the protein (165 g) and fat (60 g) floors and cutting from carbs. Relates to [[feedback-adjust-day-on-skipped-session]] and [[feedback-living-nutrition-table]].

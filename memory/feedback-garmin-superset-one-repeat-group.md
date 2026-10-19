---
name: feedback-garmin-superset-one-repeat-group
description: "Garmin strength supersets must be one repeat group of [A, rest, B, rest]; separate groups per exercise leave the watch repeating A"
metadata:
  type: feedback
---

On Mon 2026-10-19 the Back + triceps workout (`1735066442`) was uploaded with each exercise as its own repeat group and the superset only in the step text ("Rest 15 s, then pushdown"). On the watch the straight-arm pulldown ran all its sets back to back with the 15 s rest, and the paired triceps exercise never came up, so the superset could not be done as written. Every earlier superset upload had the same structure.

**Why:** the watch walks the step tree in order. A repeat group containing only exercise A repeats A for all its iterations; the "then B" in the rest step's description is only text.

**How to apply:** in `/garmin`, build a superset as one `RepeatGroupDTO` (`numberOfIterations` = sets) with steps `[A, rest ~15 s, B, full rest]`. Rule lives in `.claude/commands/garmin.md` § Strength workouts. This structure has not yet been seen working on the watch: the first superset workout after 2026-10-19 verifies it, and the athlete is asked on that day whether the watch alternated. Related: [[feedback-garmin-onwatch-strength-loads]] (loads go in the step text), [[feedback-garmin-watch-offsite-reference]].

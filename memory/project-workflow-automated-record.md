---
name: project-workflow-automated-record
description: "Decided 2026-09-29 — the daily record is automated (scheduled morning /plan + evening Garmin reconciliation), the athlete supplies one line a day (motivation 1–5 + skip reason) by Telegram, and a missing session with no reason by next morning is a breach; schedules OPEN (coach, by Oct 5) and conflict with the remote-coach map's 'manual /plan' rule"
metadata:
  type: project
---

At the 2026-09-29 consult the athlete chose **option A** for the silent-stretch problem (Aug 24–30 and Sep 21–27 had no files; every 7/7-dependent rule died from missing input):

1. A **scheduled morning `/plan`** (~06:30) writes the day's file from Garmin readiness alone, whether or not he replies.
2. A **scheduled evening reconciliation** pulls the day's Garmin activities and weigh-in into the file and marks anything planned-but-missing as *not delivered — reason?*.
3. The athlete's job is **one line a day, by Telegram in the evening**: motivation 1–5 plus a word on anything skipped.
4. A missing session with **no reason by the next morning is a breach** — the file records "not delivered, no reason" and `/report` counts it against the volume floor / exemption rules.

**Why:** on a low day the record is the first thing that goes; the fix has to take the athlete off the record's critical path so a bad week produces evidence instead of a hole. The motivation score has been requested three times and delivered once — one number a day is the whole ask.

**Status / OPEN (coach, by 2026-10-05):**
- The schedules are not built yet. Mechanisms available: a cloud routine (the `schedule` skill) or a Dokploy schedule running `claude -p` in the container (`docs/container.md` already runs `git-sync` that way).
- **Conflict to resolve:** the remote-coach map (`.scratch/coach-remote/map.md`, 2026-07-22) says `/plan` is manually triggered, never by cron, because it depends on the morning weigh-in landing first. The new design runs it at a fixed time and lets the evening pass pick up the weigh-in. Decide which wins when building the schedule; the consult decision is the newer one.
- **The Telegram bot does not exist** (remote-coach ticket 07 open — [[project-remote-coach-service]]). Until it does, the daily line arrives through the Remote Control session on the phone.

**How to apply:** `/plan` written by the schedule is a draft the athlete corrects by replying, not a decision; `/log` and `/report` treat a reason-less miss as a breach; do not let the absence of the Telegram channel delay the schedules — the record can be automated before the channel is. Related: [[feedback-record-missed-sessions-same-day]], [[feedback-verify-session-completed-against-garmin]], [[project-dokploy-container]].

---
name: project-workflow-automated-record
description: "Decided 2026-09-29, built the same day — morning /plan fires on Garmin's sleep record (skip at 12:00), /recap every evening, /report Sunday after the recap, all delivered on Telegram; one athlete line a day; a reason-less miss by next morning is a breach. Awaiting deploy + Telegram pairing"
metadata:
  type: project
---

At the 2026-09-29 consult the athlete chose **option A** for the silent-stretch problem (Aug 24–30 and Sep 21–27 had no files; every 7/7-dependent rule died from missing input):

1. A **scheduled morning `/plan`** (consult said ~06:30; built to fire on the sleep record, below) writes the day's file from Garmin readiness alone, whether or not he replies.
2. A **scheduled evening reconciliation** pulls the day's Garmin activities and weigh-in into the file and marks anything planned-but-missing as *not delivered — reason?*.
3. The athlete's job is **one line a day, by Telegram in the evening**: motivation 1–5 plus a word on anything skipped.
4. A missing session with **no reason by the next morning is a breach** — the file records "not delivered, no reason" and `/report` counts it against the volume floor / exemption rules.

**Why:** on a low day the record is the first thing that goes; the fix has to take the athlete off the record's critical path so a bad week produces evidence instead of a hole. The motivation score has been requested three times and delivered once — one number a day is the whole ask.

**Status (2026-09-29): built, not yet deployed.** Remaining: redeploy the container, create the bot, install + pair the Telegram plugin, add the `coach-tick` Dokploy schedule (`docs/container.md` § Telegram, § Set up the coach schedule), then retire the cloud `/report` routine after the first Sunday report lands (`calendar.md` TODO).

How it was built (athlete decisions in the build session, 2026-09-29):
- **Telegram is the single interface** — plan, recap and report all arrive there; Remote Control is for troubleshooting only. Telegram comes from the official channel plugin in a separate interactive session (tmux `telegram`), not the greenfield n8n bot of [[project-remote-coach-service]].
- **Morning trigger = Garmin's sleep record, not a clock.** `coach-tick` polls a free `garminconnect` check every 10 min from 05:00; once the night is on Garmin it runs `/plan scheduled` (a draft; "ok" on Telegram uploads). **No file and no sleep record at 12:00 → the day's plan is skipped**; the athlete can always send "plan" (e.g. watch battery died → `/plan` § No Sleep Record). This resolves the old conflict with the remote-coach map's "manual /plan because of the weigh-in": the consult decision won, and the weigh-in is picked up by the recap.
- **`/recap` runs every evening at 21:30, plan or not** — with no plan it writes a minimal file and asks why (`Plan: none — reason?`, same breach rule).
- **`/report` runs Sunday 21:30 chained after the recap** ("a deeper recap"), replacing the cloud routine "Weekly /report reminder" (`trig_01FHEGq1csjRWNEzYWo2DJw3`, Sun 17:00 UTC), which only reminded him to run it by hand. Headless runs can't edit `protocols/`, so it proposes numbered edits in `report.md` and the athlete replies "apply".

**How to apply:** `/plan` written by the schedule is a draft the athlete corrects by replying, not a decision; `/log` and `/report` treat a reason-less miss as a breach; a scheduled run failing is reported on Telegram, never silent. Related: [[feedback-record-missed-sessions-same-day]], [[feedback-verify-session-completed-against-garmin]], [[project-dokploy-container]].

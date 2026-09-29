---
model: sonnet
effort: medium
# Garmin reconciliation against the day's plan, plus one short message.
---
# Recap - Evening Reconciliation of the Day (MASTER)

## Usage

```
/recap
/recap [YYYY-MM-DD]
```

## Function

`/recap` closes the day's record from Garmin so that a bad day still leaves evidence
rather than a hole (consult 2026-09-29, `memory/project-workflow-automated-record.md`).
`cron-coach` runs it headless every evening at 21:30, **whether or not the day had a
plan**, and sends its final message to the athlete on Telegram. The athlete can also
ask for it from Telegram at any time. It never touches Garmin Connect and never edits
`protocols/`.

1. Get the local date and time (`date`). The target is today, or the date passed.
2. Read the day's file, `logbook/YYYY-MM/YYYY-MM-DD.md`, if it exists.
3. Pull the day from Garmin: activities (`get_activities_fordate`), weigh-ins
   (`get_daily_weigh_ins`), daily steps, and last night's sleep summary (onset and
   score) if the file doesn't already carry it. Classify every weigh-in by its
   timestamp as fasted-morning or not
   (`memory/feedback-weigh-in-check-timestamps.md`).
4. **Reconcile the plan against Garmin.** For each prescribed session, find the
   matching activity (`memory/feedback-verify-session-completed-against-garmin.md`).
   A session is delivered only if Garmin has it. Unequipped sessions with no upload
   trail are delivered only if the athlete has said so in the file.
   - Delivered: write the actuals into `## Actuals` per `daily-template.md` (run
     distance, pace, average and max HR; strength per exercise from
     `get_activity_exercise_sets`, flagging uniform pre-filled reps as unverified per
     `memory/feedback-verify-load-baseline-against-athlete.md`).
   - Not delivered, and no reason recorded yet: write
     **"not delivered — reason?"**. If a reason is already in the file, write
     "not delivered — <reason>".
   - An activity with no matching prescription (a swap or an extra) is recorded as
     such, not forced onto the plan.
5. **No daily file.** The plan was skipped at the 12:00 cutoff or never run. Create a
   minimal file from `protocols/daily-template.md`: the title line, `Plan: none —
   reason?` in place of `## Today`, `## Workout` and `## Nutrition`, and `## Actuals`
   filled from Garmin as in step 4. The next morning's breach check treats a
   still-unanswered `Plan: none — reason?` like any unexplained miss.
6. Write the weigh-in (with its state), steps, and anything notable into `## Actuals`
   if not already there. Do not rewrite meal rows. `/log meal` owns the living
   `## Nutrition` table, and the athlete does not log food digitally.
7. Read `calendar.md` for items due tomorrow, and for today's items that are still
   open.
8. Commit the daily file.
9. **The final message is the Telegram text**, and nothing else: plain text (no
   markdown tables or headers), under ~1,000 characters. In order:
   - one line on what was delivered, with the key numbers (e.g. "Easy 8.1 km @ 139
     avg HR ✓ · Push ✓ — 3 sets each, loads per plan");
   - each miss, as "not delivered — reason?";
   - the weigh-in if there was one (fasted or not);
   - tomorrow's calendar items and anything today that is still open;
   - if there was no plan today, ask why in one line;
   - the ask, always last: *"Your line for today: motivation 1–5, and a word on
     anything skipped."*

## Requirements

- Garmin is ground truth for what happened. Never mark a session delivered from the
  plan alone.
- The recap asks. It does not coach. No next-day prescription and no re-tiering
  here. `/plan` does that in the morning from the full picture.
- Keep the message short enough to answer with one thumb. The daily file holds the
  detail.
- If Garmin is unreachable, say so in the message, record "Garmin unavailable —
  reconcile tomorrow" in `## Context`, and still ask for the daily line. The next
  `/recap` or `/plan` fills the gap.

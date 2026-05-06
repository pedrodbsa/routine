# CLAUDE.md

> **Read `protocols/current-status.md` first** for current phase, body composition, and recent training data before generating any plan.

## Repository Purpose

Personal routine management system for a 39-year-old male software engineer focused on concurrent running performance and body recomposition.

## Protocol Lookup

| Domain            | File                          | Contains                                                    |
| ----------------- | ----------------------------- | ----------------------------------------------------------- |
| Current state     | `protocols/current-status.md` | Profile, goals, phase, metrics, training load, adherence    |
| Coaching rules    | `protocols/coaching.md`       | Quality standards, accountability, communication style      |
| Running           | `protocols/running.md`        | HR zones, pacing, race targets, MAF protocol            |
| Strength          | `protocols/training.md`       | Weekly structure, exercises, progressions               |
| Nutrition         | `protocols/nutrition.md`      | Macros, meal timing, fueling strategy                   |
| Supplements       | `protocols/supplements.md`    | Dosages, timing, interactions                           |
| Mobility          | `protocols/mobility.md`       | Daily routine, injury tracking                          |
| Daily file format | `protocols/daily-template.md` | Required fields, sections, logging rules                |

## Directory Structure

- `protocols/` — Core protocols and guidelines
- `data/` — Garmin data in CSV format (auto-exported)
- `days/` — Daily files combining plan + log (format: `YYYY-MM-DD.md`)
- `reports/` — Weekly and monthly progression reviews
- `research/` — Evidence base for methodology decisions

## Daily Workflow

1. **Morning:** `/plan` → generates today's plan in `days/YYYY-MM-DD.md`
2. **After training:** `/log-workout` → updates Log section with completion status
3. **After meals:** `/log-meal` → checks off meals, notes deviations
4. **As needed:** `/note` → adds observations to Notes section
5. **Weekly:** `/report` → progression review, updates `current-status.md`

## Available Commands

**Daily (all update `days/YYYY-MM-DD.md`):**

- `/plan` — Generate today's workout + nutrition plan
- `/log-workout [details]` — Mark workout complete, add actual performance
- `/log-meal [details]` — Check off meals, note deviations
- `/note [text]` — Add observations to Notes section

**Periodic:**

- `/report` — Weekly/monthly progression review (also updates `current-status.md`)
- `/body` — Sync body composition to Garmin

## Coaching Primer

_Full rules in `protocols/coaching.md` — read before generating plans._

- Be critical and data-driven — recovery markers (HRV, BB, RHR, stress) are ground truth
- Push back on athlete assumptions when wrong
- Don't be passive or perpetually conservative — recovered athletes need stimulus
- Evidence-based only; always check finasteride interactions for supplements
- Include plyometric warm-ups in every plan; pre-run carbs for high-intensity sessions

# CLAUDE.md

> **Read `protocols/current-status.md` first** for current phase, body composition, and recent training data before generating any plan.

## Repository Purpose

Personal routine management system for a 39-year-old male software engineer focused on concurrent body recomposition ("beach ready") and 10K running performance peak.

## Protocol Lookup

| Domain            | File                          | Contains                                                    |
| ----------------- | ----------------------------- | ----------------------------------------------------------- |
| Current state     | `protocols/current-status.md` | Profile, goals, phase, metrics, training load, adherence    |
| Coaching rules    | `protocols/coaching.md`       | Quality standards, accountability, communication style      |
| Running           | `protocols/running.md`        | HR zones, pacing, race targets, 10K specific workouts       |
| Strength          | `protocols/training.md`       | Weekly structure, double-day templates, progression rules   |
| Nutrition         | `protocols/nutrition.md`      | Phase-aware calorie cycling tables, meal timing, daily weigh-in protocol |
| Supplements       | `protocols/supplements.md`    | Dosages, timing, interactions                           |
| Mobility          | `protocols/mobility.md`       | Daily routine, pain back-off triggers, injury tracking      |
| Daily file format | `protocols/daily-template.md` | Required fields, sections, ACWR, day-type fields            |

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
- `/log note [text]` — Add observations to Notes section
- `/log [anything]` — General logging tool

**Periodic:**

- `/report` — Weekly/monthly progression review (also updates `current-status.md`)
- `/body` — Sync body composition to Garmin

## Coaching Primer

_Full rules in `protocols/coaching.md` — read before generating plans._

- Be critical and data-driven — recovery markers (HRV, BB, RHR, stress, Garmin sleep score) are ground truth
- Check current phase in `protocols/current-status.md` before generating any plan — calorie targets, workout structure, and strength programming all vary by phase
- Calorie cycling is mandatory: rest/easy days and quality/long-run days have different targets
- Thursday is always rest from running. Legs on Thursday except Phase 6 weeks 6-8 (legs dropped, pure rest)
- Push back on athlete assumptions when wrong
- Don't be passive or perpetually conservative — recovered athletes need stimulus
- Evidence-based only; always check finasteride interactions for supplements
- Include plyometric warm-ups in every plan; pre-run carbs (banana + coffee) for all runs >90 min directly into plan
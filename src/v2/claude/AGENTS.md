# CLAUDE.md

> **Read `protocols/current-status.md` first** for current phase, body composition, and recent training data before generating any plan.

## Repository Purpose

Personal routine management system for a 39-year-old male software engineer focused on concurrent running performance and body recomposition.

## Protocol Lookup

| Domain | File | Contains |
|---|---|---|
| Current state | `protocols/current-status.md` | Profile, goals, phase, metrics, training load, adherence |
| Coaching rules | `protocols/coaching.md` | Quality standards, accountability, communication style |
| Running | `protocols/running.md` | HR zones, pacing, race targets, periodization |
| Strength | `protocols/training.md` | Weekly structure, exercises, progressions |
| Nutrition | `protocols/nutrition.md` | Phase-aware macros, meal timing, calorie cycling |
| Supplements | `protocols/supplements.md` | Dosages, timing, interactions |
| Mobility | `protocols/mobility.md` | Daily routine, injury tracking, cut-phase emphasis |
| Daily file format | `protocols/daily-template.md` | Required fields, sections, logging rules |

## Directory Structure

- `protocols/` — Core protocols and guidelines
- `data/` — Garmin data in CSV format (auto-exported)
- `days/` — Daily files combining plan + log (format: `YYYY-MM-DD.md`)
- `reports/` — Weekly and monthly progression reviews
- `research/` — Evidence base for methodology decisions

## Daily Workflow

1. **Morning:** `/plan` → generates today's plan in `days/YYYY-MM-DD.md`
2. **After training:** `/log [workout details]` → updates Log section with completion status
3. **After meals:** `/log meal [details]` → checks off meals, notes deviations
4. **As needed:** `/log note [text]` → adds observations to Notes section
5. **Weekly:** `/report` → progression review, updates `current-status.md`

## Available Commands

**Daily (all update `days/YYYY-MM-DD.md`):**

- `/plan` — Generate today's workout + nutrition plan
- `/log [details]` — Log workouts, meals, body metrics, or notes (auto-detects type)

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
- Check current phase in `protocols/current-status.md` before generating any plan — calorie targets, workout structure, and strength programming all vary by phase
- Calorie cycling is mandatory: rest/easy days and quality/long-run days have different targets
- Thursday is always rest from running. Legs on Thursday except Phase 6 weeks 6-8 (legs dropped, pure rest)

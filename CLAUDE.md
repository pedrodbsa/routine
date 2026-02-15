# CLAUDE.md

> **Last verified: 2026-02-10** — If reading this, check `protocols/current-status.md` for latest state.

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Repository Purpose

This is a personal routine management system for a 39-year-old male software engineer focused on concurrent running performance and body recomposition. The system tracks protocols for exercise, nutrition, supplements, and daily schedules.

**Quick context:** Read `protocols/current-status.md` first for current phase, body composition, and recent training data before generating any plan.

## Race Calendar

| Date               | Race                    | Distance | Role       | Goal                         |
| ------------------ | ----------------------- | -------- | ---------- | ---------------------------- |
| **March 8, 2026**  | 4 Estações Coimbra      | 10K      | Tune-up    | Fitness benchmark            |
| **March 29, 2026** | Meia Maratona de Fátima | 21K      | **A-Race** | Sub-2:00 (stretch: sub-1:50) |

## Key System Architecture

### Personal Context

- **Age:** 39 (DOB March 1986), Male, 172cm
- **Family:** Parent with baby (sleep disruptions expected)
- **Current:** 77.8kg, 30% body fat, taking finasteride 1mg/day
- **Goal:** Phase 1 (race prep): 74-76kg at 24-26% BF · Phase 2 (post-race): 72-74kg at 18-20% BF
- **Max HR:** 190 bpm (observed: 188-192 on Garmin; auto-set 195)

_For detailed stats, see `protocols/profile.md` and `protocols/current-status.md`._

### Training Philosophy

- **Balanced approach:** Full-body development with 3 strength sessions/week
- **Running program:** Claude-coached progressive running plan (MAF base → Norwegian race-specific)
- **Schedule flexibility:** Training times vary daily based on schedule and life constraints
- **Typical timing:** Run before lunch, weight training after lunch (but adaptable)
- **Coach-driven:** Claude plans all workouts based on recent data and progression
- **Mobility:** Daily 10-min routine (non-negotiable) — see `protocols/mobility.md`

_Full details in `protocols/training.md` and `protocols/running.md`._

### Nutrition Framework

- **Intermittent fasting:** 12:30-21:00 eating window — _Exception: pre-run banana/gel for high-intensity morning sessions_
- **Daily targets:** 1,900 cal — 156g protein (33%), 190g carbs (40%), 57g fat (27%)
- **High-intensity days:** 2,200 cal — 160g protein, 260g carbs, 58g fat
- **Timing:** Post-workout shake (12:30), lunch (13:00), snack (17:00), dinner (21:00)
- **Family integration:** Shared dinners at 21:00 with portion control
- **Caffeine:** 2-4 cups/day, strict cutoff by 15:00

_Full macros, meal options, and fueling strategy in `protocols/nutrition.md`._

### Supplement Protocol

- **Post-workout (12:30):** Creatine 5g, Vitamin D3 6000 IU + K2 120mcg, Multivitamin
- **Lunch (13:00):** Omega-3 2g EPA/DHA, Zinc 20mg, Finasteride 1mg
- **Dinner (21:00):** Astaxanthin 8mg · Curcumin 1000mg _(as-needed for pain only)_
- **Sleep (22:00):** Magnesium 400mg

_Full rationale and interaction notes in `protocols/supplements.md`._

## Directory Structure

- `protocols/` - Core routine protocols and guidelines
    - `current-status.md` - **Living document: current phase, metrics, adherence (read first)**
    - `profile.md` - Personal profile, goals, and constraints
    - `nutrition.md` - Meal plans, macros, and food quality guidelines
    - `running.md` - Running profile, HR zones, and training philosophy
    - `training.md` - Strength workout programs with progressions
    - `supplements.md` - Supplement dosages, interactions, and specifications
    - `mobility.md` - Daily mobility routine and injury tracking
- `data/` - Garmin data in CSV format (auto-exported)
- `days/` - Daily files combining plan + log (format: YYYY-MM-DD.md)
- `reports/` - Weekly and monthly progression reviews
- `research/` - Evidence base for methodology decisions

## Success Metrics Priority

1. Body composition (strength gains, waist circumference, visual progress)
2. Performance (running pace/endurance, lifting progression with tracked weights)
3. Energy & mood (daily levels, training quality, RPE trends)
4. Health markers (sleep quality, recovery, stress management)

## Core Principles

### Protocol Quality Standards

- **Evidence-based only** - all training, nutrition, and supplement recommendations must be backed by current research
- **Finasteride interactions** - always consider drug interactions for supplement recommendations
- **Real-world constraints** - account for family priorities, sleep disruptions, schedule flexibility
- **Progressive overload** - track and recommend appropriate weight/volume progressions with actual numbers
- **Individual context** - recommendations must fit 39-year-old parent with work-from-home lifestyle
- **Neuromuscular & Fueling** - automatically include plyometric warm-ups in every plan and pre-run carbs for high-intensity sessions
- **Injury prevention** - include mobility work daily, track pain/tightness, compute ACWR

### Communication Style

- **Concise and direct** - minimize unnecessary explanations
- **Specific recommendations** - actionable guidance for training, nutrition, supplementation
- **Technical precision** - accurate terminology for exercises, macros, dosages
- **Critical analysis** - compare performance data, identify trends, suggest evidence-based adjustments

## Daily File Template

Every `days/YYYY-MM-DD.md` must include:

### Status Section (required fields)

| Field          | Description                             |
| -------------- | --------------------------------------- |
| Sleep          | Duration + score + qualifier            |
| HRV            | Value in ms                             |
| Body Battery   | Current (and peak at wake if available) |
| Resting HR     | bpm                                     |
| Stress         | Average level                           |
| Pain/Tightness | None / [location] [severity 1-5]        |
| Motivation     | 1-5 scale                               |
| Caffeine       | Cups + cutoff time                      |

### Workout Section

- Include **RPE (1-10)** for every session
- Strength exercises must include **actual weight (kg)** used
- Running must include **distance, pace, avg HR, max HR**

### Log Section

- Meals with calories and protein logged
- Running total vs daily target

## Daily Workflow

1. **Morning:** Run `/plan` to generate today's plan in `days/YYYY-MM-DD.md`
2. **After training:** Run `/log-workout` to update the Log section with completion status
3. **After meals:** Run `/log-meal` to check off meals and note any deviations
4. **As needed:** Run `/note` to add observations to the day's Notes section
5. **Weekly:** Run `/report` for progression review — update `protocols/current-status.md`

All daily activity goes into one file (`days/YYYY-MM-DD.md`) with Plan and Log sections.

## Available Commands

**Daily (all update `days/YYYY-MM-DD.md`):**

- `/plan` - Generate today's workout + nutrition plan
- `/log-workout [details]` - Mark workout complete, add actual performance
- `/log-meal [details]` - Check off meals, note deviations
- `/note [text]` - Add observations to Notes section

**Periodic:**

- `/report` - Weekly/monthly progression review (also updates `current-status.md`)
- `/body` - Sync body composition to Garmin

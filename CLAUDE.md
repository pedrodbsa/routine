# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Repository Purpose

This is a personal routine management system for a 39-year-old male software engineer focused on body recomposition goals. The system tracks protocols for exercise, nutrition, supplements, and daily schedules to achieve a "leading man" physique transformation (target: 70kg at 12-15% body fat from 80kg at 30% body fat).

## Key System Architecture

### Personal Context

- **Age:** 39 years old, work-from-home software engineer
- **Family:** Parent with baby (sleep disruptions expected)
- **Current:** 80kg, 30% body fat, taking finasteride
- **Goal:** 70kg, 12-15% body fat, lean defined physique
- **Timeline:** 12-month transformation

### Training Philosophy

- **Balanced approach:** Full-body development with 3 strength sessions/week
- **Running program:** Claude-coached progressive running plan
- **Schedule flexibility:** Training times vary daily based on schedule and life constraints
- **Typical timing:** Run before lunch, weight training after lunch (but adaptable to 8am or other times as needed)
- **Coach-driven:** Claude plans all workouts based on recent data and progression

### Nutrition Framework

- **Intermittent fasting:** 12:30-21:00 eating window (8.5 hours) - _Exception: Performance fuel permitted before hard morning runs._
- **Macros:** 2,000 calories - 140g protein, 175g carbs, 50g fat
- **Timing:** Post-workout shake (12:30), lunch (13:00), snack (17:00), dinner (21:00)
- **Family integration:** Shared dinners at 21:00 with portion control

### Supplement Protocol

- **Post-workout (12:30):** Creatine 5g, Vitamin D3 6000 IU, K2 120mcg
- **Lunch (13:00):** B-complex, Omega-3 2g, Zinc 20mg, Finasteride 1mg
- **Dinner (21:00):** Ashwagandha 600mg, Astaxanthin 8mg, Curcumin 1000mg
- **Sleep (22:30):** Magnesium 400mg, L-Theanine 300mg

## Directory Structure

- `data/` - Garmin data in CSV format
- `protocols/` - Core routine protocols and guidelines
    - `nutrition.md` - Meal plans, macros, and food quality guidelines
    - `profile.md` - Personal profile, goals, and constraints
    - `running.md` - Running profile and training philosophy
    - `supplements.md` - Supplement dosages, interactions, and specifications
    - `training.md` - Complete workout programs with progressions
- `days/` - Daily files combining plan + log (format: YYYY-MM-DD.md)
- `reports/` - Weekly and monthly progression reviews only

## Success Metrics Priority

1. Body composition (strength gains, measurements, visual progress)
2. Performance (running pace/endurance, lifting progression)
3. Energy & mood (daily levels, training quality)
4. Health markers (sleep quality, recovery, stress management)

## Core Principles

### Protocol Quality Standards

- **Evidence-based only** - all training, nutrition, and supplement recommendations must be backed by current research
- **Finasteride interactions** - always consider drug interactions for supplement recommendations
- **Real-world constraints** - account for family priorities, sleep disruptions, schedule flexibility
- **Progressive overload** - track and recommend appropriate weight/volume progressions
- **Individual context** - recommendations must fit 39-year-old parent with work-from-home lifestyle
- **Neuromuscular & Fueling** - automatically include plyometric warm-ups in every plan and pre-run carbs for high-intensity sessions.

### Communication Style

- **Concise and direct** - minimize unnecessary explanations
- **Specific recommendations** - actionable guidance for training, nutrition, supplementation
- **Technical precision** - accurate terminology for exercises, macros, dosages
- **Critical analysis** - compare performance data, identify trends, suggest evidence-based adjustments

## Daily Workflow

1. **Morning:** Run `/plan` to generate today's plan in `days/YYYY-MM-DD.md`
2. **After training:** Run `/log-workout` to update the Log section with completion status
3. **After meals:** Run `/log-meal` to check off meals and note any deviations
4. **As needed:** Run `/note` to add observations to the day's Notes section
5. **Weekly/Monthly:** Run `/report` for progression review

All daily activity goes into one file (`days/YYYY-MM-DD.md`) with Plan and Log sections.

## Available Commands

**Daily (all update `days/YYYY-MM-DD.md`):**

- `/plan` - Generate today's workout + nutrition plan
- `/log-workout [details]` - Mark workout complete, add actual performance
- `/log-meal [details]` - Check off meals, note deviations
- `/note [text]` - Add observations to Notes section

**Periodic:**

- `/report` - Weekly/monthly progression review
- `/body` - Sync body composition to Garmin

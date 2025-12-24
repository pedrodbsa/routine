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
- **PT guidance:** 1 session/week (typically leg-focused, PT-selected exercises)
- **Self-directed:** 2 sessions/week (user-selected exercises and gym location)
- **Running program:** Garmin Coach half-marathon plan (race in 3 months)
- **Schedule flexibility:** Training times vary daily based on schedule (communicate day's schedule each morning for planning)
- **Typical timing:** Run before lunch, weight training after lunch (but adaptable to 8am or other times as needed)

### Nutrition Framework
- **Intermittent fasting:** 12:30-21:00 eating window (8.5 hours)
- **Macros:** 2,000 calories - 140g protein, 175g carbs, 50g fat
- **Timing:** Post-workout shake (12:30), lunch (13:00), snack (17:00), dinner (21:00)
- **Family integration:** Shared dinners at 21:00 with portion control

### Supplement Protocol
- **Post-workout (12:30):** Creatine 5g, Vitamin D3 6000 IU, K2 120mcg
- **Lunch (13:00):** B-complex, Omega-3 2g, Zinc 20mg, Finasteride 1mg
- **Dinner (21:00):** Ashwagandha 600mg, Astaxanthin 8mg, Curcumin 1000mg
- **Sleep (22:30):** Magnesium 400mg, L-Theanine 300mg

## Directory Structure

-   `protocols/` - Core routine protocols and guidelines
    -   `profile.md` - Personal profile, goals, and constraints
    -   `schedule.md` - Daily timeline, weekly training split, and timing protocols
    -   `training.md` - Complete workout programs with progressions
    -   `nutrition.md` - Meal plans, macros, and food quality guidelines
    -   `supplements.md` - Supplement dosages, interactions, and specifications
-   `plans/` - Daily training and nutrition plans (format: YYYY-MM-DD.md)
-   `reports/` - Weekly check-ins for progression analysis

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

### Communication Style
- **Concise and direct** - minimize unnecessary explanations
- **Specific recommendations** - actionable guidance for training, nutrition, supplementation
- **Technical precision** - accurate terminology for exercises, macros, dosages
- **Critical analysis** - compare performance data, identify trends, suggest evidence-based adjustments

## Daily Planning Workflow

Each day starts with user providing:
1. **Schedule availability** (e.g., "8am free slot" or "training after lunch")
2. **Garmin Coach running workout** (if scheduled that day)

Claude then plans:
1. **Weight training session** (considering PT vs self-directed, exercise selection, gym choice)
2. **Nutrition timing and meals** (aligned with training schedule and macro targets)

### Weekly Check-ins
- **Weight progression:** Track strength increases across key exercises
- **Running performance:** Pace improvements, volume tolerance
- **Body composition:** Measurements, visual progress
- **Recovery quality:** Sleep, energy levels, training readiness
- **Protocol adjustments:** Evidence-based modifications based on data

## Available Commands

### Daily Planning
- `/plan-day [schedule] [garmin-workout]` - Generate weight training + nutrition plan for the day
- `/adjust-plan [reason]` - Modify today's plan based on changes

### Weekly Analysis
- `/weekly-checkin` - Comprehensive progression review and protocol adjustments

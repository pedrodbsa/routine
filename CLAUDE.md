# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Repository Purpose

This is a personal routine management system for a 39-year-old male software engineer focused on body recomposition goals. The system tracks protocols for exercise, nutrition, supplements, and daily schedules to achieve a "leading man" physique transformation (target: 70kg at 12-15% body fat from 80kg at 30% body fat).

## Directory Structure

- `protocols/` - Core routine protocols and guidelines
  - `baseline_profile_goals.md` - Personal profile, goals, and constraints
  - `daily_schedule_protocols.md` - Daily timeline and weekly training split
  - `exercise_programs_detailed.md` - Complete workout programs with progressions
  - `nutrition_meal_plans.md` - Meal plans, macros, and food quality guidelines
  - `supplement_schedule_complete.md` - Supplement timing, dosages, and interactions
- `reports/` - Daily tracking and progress reports (format: YYYY-MM-DD.md)

## Key System Architecture

### Personal Context
- **Age:** 39 years old, work-from-home software engineer
- **Family:** Parent with baby (sleep disruptions expected)
- **Current:** 80kg, 30% body fat, taking finasteride
- **Goal:** 70kg, 12-15% body fat, lean defined physique
- **Timeline:** 12-month transformation

### Training Philosophy
- **Upper body focus:** 4 sessions/week (chest/triceps, back/biceps alternating)
- **Daily cardio:** 4-5km runs at 5:30/km pace for mood elevation
- **Timing:** 11:00-12:00 strength training (fasted), 06:30 daily runs
- **Sports:** Padel 2-3x/week (Monday replaces weight training)

### Nutrition Framework
- **Intermittent fasting:** 12:30-21:00 eating window (8.5 hours)
- **Macros:** 2,200 calories - 190g protein, 200g carbs, 65g fat
- **Timing:** Post-workout shake (12:30), lunch (13:00), snack (17:00), dinner (21:00)
- **Family integration:** Shared dinners at 21:00 with portion control

### Supplement Protocol
- **Post-workout (12:30):** Creatine 5g, Vitamin D3 6000 IU, K2 120mcg
- **Lunch (13:00):** B-complex, Omega-3 2g, Zinc 20mg, Finasteride 1mg
- **Dinner (21:00):** Ashwagandha 600mg, Astaxanthin 8mg, Curcumin 1000mg
- **Sleep (22:30):** Magnesium 400mg, L-Theanine 300mg

## Daily Report Format

Reports should follow the structure in `reports/2025-07-01.md`:

1. **Workout section** with detailed exercise tracking (sets, reps, weights, notes)
2. **Nutrition & Supplements** with timed meals and supplement compliance
3. **Hydration status** and daily water intake
4. **Performance notes** and next session targets

### Exercise Tracking Standards
- Include weight, reps, and subjective difficulty notes
- Record "working weight" and progression targets
- Track autoregulation adjustments during sessions
- Note form quality and range of motion

### Nutrition Tracking
- Calculate precise macros for each meal
- Track supplement compliance with checkmarks
- Include meal timing within eating window
- Note hydration levels throughout day

## Common Operations

### Creating Daily Reports
```bash
# Create new daily report
touch reports/$(date +%Y-%m-%d).md
```

### Analyzing Progress
- Compare workout volumes between sessions
- Track weight progression across similar exercises
- Monitor adherence to nutrition timing and macros
- Assess supplement consistency and effectiveness

### Protocol Adjustments
- Modify based on progress stalls (protocols include adjustment guidelines)
- Account for schedule disruptions and family priorities
- Maintain flexibility within structured framework

## Important Constraints

- **Non-negotiable:** Daily running for mood elevation
- **Family priority:** Kid care 07:45-09:00, dinner coordination at 21:00
- **Medication:** Finasteride interactions considered in all supplement recommendations
- **Sleep:** Baby disruptions expected, optimize around constraints
- **Flexibility:** Built-in adaptability for real-world implementation

## Success Metrics Priority

1. Body composition (photos, measurements, strength gains)
2. Energy & mood (daily levels, stress management)
3. Performance (running pace, strength progression)
4. Health markers (sleep quality, stress levels)
5. Lifestyle integration (family satisfaction, sustainability)

This system emphasizes evidence-based, sustainable habits that fit the constraints of a busy parent while maintaining family connections and work productivity.
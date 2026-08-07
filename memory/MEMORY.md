# Auto Memory — Routine Project

## Critical Coaching Lessons

See `coaching-lessons.md` for details.

- **Recovery markers are ground truth** — HRV, BB, RHR, stress determine training readiness, not assumptions
- **Don't extend easy-only blocks beyond 1 week** without reassessing recovery data
- **Vigorous minutes drive Garmin fitness age** — easy-only training will always regress it
- **Athlete expects push-back** — be critical, don't be passive. The user trusts coaching autonomy.

## Project Conventions

- 10K race: **March 8, 2026** (4 Estações Coimbra) — result: ~49:57 (PR, prev 52:12)
- HM A-race: **March 29, 2026** (Meia Maratona de Fátima)
- Post-HM races: 10K May 17, Trail 14.7 km May 24 (not 21K — corrected), ~~10K Jun 20~~ (benchmark dropped 2026-06-16), 10K Oct 25 (**B-race** — hilly, run as hard supported effort, demoted 2026-07-31), **10K Dec 12 (A-RACE, sub-47/stretch 46 — S. Silvestre Coimbra, 18:30 EVENING start; 2025 result ~54:00)**. Cut hard stop Sep 20 → reverse diet Sep 21 → maintenance through Dec 12 → cut resumes post-race
- Always read `protocols/current-status.md` first before any plan generation
- Daily files: `logbook/YYYY-MM/YYYY-MM-DD.md` (plan + log in one file). Monthly reports live alongside as `logbook/YYYY-MM/report.md`. Reorg 2026-06-15: flat `plans/` + top-level `reports/` folded into per-month `logbook/` (earlier history: `days/` → `plans/`)
- **Easy ceiling: 142 bpm all environments** (lab-prescribed, FCDEFUC 2026-04-28). LT1 145, LT2 172. Drift cap on long runs ≤145.
- **Treadmill easy pace: 8-9 km/h** (6:40-7:30/km). Outdoor costs ~6-10 bpm more at same effort.
- **HR monitor: COROS armband** (optical arm-worn, accurate — trust the data)
- **Lab-tested LT2: 172 bpm @ 5:00/km** (was assumed ~170, close). Sub-T targets = 156-168 (91-98% LT2).
- **Always pull Garmin data for run logging** — never rely on manual input for runs; athlete tracks all runs on Garmin
- **Legs session moved to Mon Feb 16** — skipped Sun due to time, not fatigue. Pair with recovery run.

## Workflow Preferences

- [Check time before nutrition](feedback-check-time-before-nutrition.md) — get the actual local time (`date` / `Get-Date`) before sequencing meals or pre/post-workout feeds; don't assume a morning start (root of the 2026-06-29 phantom-07:30-breakfast miss)
- [Record decisions same-session](feedback-record-decisions-same-session.md) — calendar/goal changes agreed in chat must be written to the stack before the session ends; the Oct→Dec A-race move lived only in conversation and later sessions planned against a stale calendar (fixed 2026-07-31)
- [Re-derive, don't inherit](feedback-rederive-not-inherit.md) — rebuild the week's shape from rules+data each morning, never carry yesterday's "recovery week" frame forward; capture the watch DSW and justify any conservative default (symmetric discipline). Root of the 2026-06-24 easy-vs-quality miss
- [Soft markers — check anxiety first](feedback-soft-markers-check-anxiety.md) — a long awake-time / mid-night waking on balanced HRV + normal deep sleep = anxiety/rumination (skin, travel), NOT training fatigue; don't auto-blame the last quality. Manage stress-side, not by down-dosing. Root of the 2026-07-01 misattribution
- [Living nutrition table](feedback-living-nutrition-table.md) — on `/log meal`, overwrite the eaten row with actuals + re-tune remaining meals to hold the tier; track Expected/Actual/Projected; Actuals = deviations/flags only
- [Report format](feedback-report-format.md) — monthly only, updated progressively; no weekly reports
- [Pace-HR calibration](feedback-pace-hr-calibration.md) — sub-T pace ~5:00-5:15/km (not faster); calibrate off 49:57 10K PR, not generic tables
- [Walk recovery on intervals](feedback-walk-recovery-intervals.md) — prescribe WALK recovery (not jog); HR won't drop into a jog band in ~90s, and walk-recovery lowers rep-entry HR so read end-of-rep max, not rep average
- [Trailing-load check](feedback-trailing-load-check.md) — count consecutive run/training days + days-since-rest before prescribing; same-day markers alone miss cumulative fatigue
- [Verify a session happened against Garmin](feedback-verify-session-completed-against-garmin.md) — never write a session as completed without checking activities for that date, especially unequipped sessions with no upload trail (2026-07-23 phantom plyo sat in the file 4 days)
- [Garmin MCP over CSV](feedback-garmin-mcp-over-csv.md) — for audits/reports, pull live Garmin MCP; data/*.csv exports are stale
- [Garmin direct-pull fallback](reference-garmin-direct-pull-fallback.md) — MCP down? pull via `uvx --with garminconnect` + the `~/.garminconnect` token cache; never block /plan waiting on a restart
- [Check weigh-in timestamps](feedback-weigh-in-check-timestamps.md) — classify every reading fasted-morning vs post-run before trending; post-run reads ~0.9 kg low and faked a month of fat loss (found 2026-07-21)
- [Daily supplement → daily anchor](feedback-daily-supplement-daily-anchor.md) — never hang a daily dose on a training-contingent feed (creatine lost 23 days on the shake, same failure as iso on dinner); also, BIA muscle mass is creatine-sensitive and useless as a lean-mass tripwire during washout/reload
- [Weight drop: water vs tissue](feedback-weight-drop-water-vs-tissue.md) — decompose a fast drop with a hydration-matched subset + absolute body water in **kg** (never %), then sanity-check the implied TDEE; a recent carb cut explains 1.0–1.2 kg as glycogen+water
- [Benchmark on matched reps](feedback-benchmark-matched-reps.md) — compare repeat quality sessions on the warmed-up reps, not session means; a prescribed conservative opener fakes a regression
- [Weigh-in: state, not clock](feedback-weigh-in-state-not-clock.md) — anchor is post-void + pre-food, NOT a fixed time; bowel timing isn't controllable and coffee precedes it by design. Never prescribe a clock time (wrong advice given 2026-07-22, corrected by athlete)
- [VO2max endpoint](reference-garmin-vo2max-endpoint.md) — VO2max MCP endpoints unreliable; use 10K race prediction as proxy (≤~50:00-50:30 ≈ VO2max ~47)
- [Quality session periodization](feedback-quality-session-periodization.md) — derive the harder quality from the sub-T→threshold→10K-pace→VO2 ladder + phase week; cross-check the Garmin DSW; don't pull a rung forward on the athlete's phrasing
- [Garmin easy paces work](feedback-garmin-easy-paces-work.md) — athlete saw race-prediction gains following Garmin's easy/base paces exactly (~6:20/km zone 2); lean polarized, keep easy days genuinely easy, weigh the DSW as a real input (don't auto-stack a 2nd full quality on green markers)
- [Garmin on-watch strength loads](feedback-garmin-onwatch-strength-loads.md) — watch doesn't display structured target weights mid-workout; embed loads in step name/description or the athlete lifts blind
- [Garmin watch = offsite reference](feedback-garmin-watch-offsite-reference.md) — watch is the only gym-side reference; embed execution data (loads/structure) there, keep nutrition OUT (always done at home, consultable)
- [No box jumps](feedback-no-box-jumps.md) — athlete won't jump onto a bench/box; default the leg explosive block to light jump squats (or broad jumps / A-skips), never box jumps
- [No calf training](feedback-no-calf-training.md) — never program direct calf work (calves already too big/disproportionate); Achilles/stiffness role covered by the plyo block + running, removed from the leg-day spec
- [Treadmill control run protocol](project-treadmill-control-run-protocol.md) — fix the belt at 8.6 km/h, 1% incline, 30:00, treadmill mode; tracked number is avg HR. Do NOT raise the belt speed (restarts the series). Watch under-reads belt by 2.4%
- [Strength rotation: two-session lookback](feedback-strength-rotation-two-session-lookback.md) — rotate exercise selection against the last TWO same-type sessions; a one-session lookback flip-flops A/B and repeated 6/7 slots inside 14 days (caught by athlete 2026-07-27)
- [Saturday is a rest day](feedback-saturday-is-rest-day.md) — standing rest day since Jul 4 (verified, 5 consecutive); never plan a run or lift there, and treat the Phase 4-5 template's Saturday column as a stale reference layout
- [Treadmill run back-to-back with lift](feedback-treadmill-run-backtoback-with-lift.md) — when a treadmill run + strength session land on the same day, assume one gym trip done back-to-back; sequence peri-workout fuel accordingly (shake between run and lift if fasted)

## Tooling & Workflow

- [Git allowed in this project](feedback-git-allowed-this-project.md) — git is permitted in the routine repo (overrides global user-only rule); commit protocols/reports/logbook
- [Dokploy container](project-dokploy-container.md) — repo runs as an always-on Remote Control session on the server; Auto Deploy must stay off, pushes come from a `git-sync` schedule. Runbook: `docs/container.md`
- **This directory is the memory.** Write new memories here as files + a pointer line above; never to `~/.claude/projects/<slug>/memory/`

## Active Build

- [Remote Coach Service](project-remote-coach-service.md) — coach reachable from any browser + Telegram; **read `.scratch/coach-remote/map.md` first — it supersedes the committed spec**
- [Repo relevant parts](reference-repo-relevant-parts.md) — only protocols/ (+archive/), logbook/, .claude/ are live; the .venv Python garmin CLI + data/*.csv were DELETED 2026-07-31 (never reference them; live Garmin MCP only). Spec's garmin-cli is a different Rust/DuckDB tool.

## Medical

- [Isotretinoin course](project-isotretinoin-course.md) — derm prescribed isotretinoin 2026-06-25 at a MICRODOSE (~5 mg/day actual); training/race impact largely de-risked at this dose. Take with fat-containing meal. It's control/suppression not cumulative-dose cure; baseline lipids/LFTs prudent, dry lips/SPF, no picking. Target-duration + stop-plan TBC with derm

## Post-HM Plan (Apr-Oct 2026)

- [Post-HM Holistic Plan](post-hm-plan.md) — 30-week concurrent cut + 10K peak, Approach B (NOTE: targets need recalc per Bod Pod data)
- [Tracking & Adherence Feedback](feedback-tracking-adherence.md) — UPDATED Jun 18: athlete weighs food & follows the plan on non-social days, doesn't log digitally; stall = social-day surplus, not non-adherence
- [Mythos Ligeiro yogurt](reference-mythos-ligeiro-yogurt.md) — athlete's staple Greek yogurt is protein-weak (5.3 g P/100 g); won't carry the protein floor alone — add whey
- [No breakfast before a *quality* run](feedback-no-breakfast-before-run.md) — conditional on intensity: banana + coffee at most before quality/long, but easy runs tolerate breakfast fine (over-generalisation corrected 2026-08-03). On a pre-lunch double, breakfast is NEVER deleted — it sits between run and lift as the lift's fuel
- [Oats fruit mix-in](feedback-oats-fruit-mix-in.md) — plain oats unpalatable; spec oat breakfasts as reduced oats + **mango or strawberries** stirred in (frozen, they cool the bowl) — never banana/apple/generic berries
- [No grams for eggs](feedback-no-grams-for-eggs.md) — express eggs as whole-egg/white counts, never grams (corrected 3×); grams still fine for oats/rice/meat
- [Post-dinner snack for evening hunger](feedback-post-dinner-snack-hunger.md) — hardest hunger window is post-dinner; keep the afternoon snack small, add a post-dinner dessert (funded from it, timing-neutral)
- [Solid snack, not a shake](feedback-solid-snack-over-shake.md) — afternoon anchor is ~200 g skyr + a scoop of whey stirred through + fruit; whey *in* the bowl is fine, pourable is not
- [No single dominant feed](feedback-no-single-dominant-feed.md) — athlete rejects any day built around one big meal; keep feeds flat (~450-750 meals, ~270 snack) and cap protein boluses near 45 g. Spread a light meal's shortfall across the rest, don't dump it into dinner
- [Starch at both main meals](feedback-starch-at-both-main-meals.md) — never delete rice/potato from lunch or dinner to save calories; shrink the portion instead. "Smaller lunch" + "I need starches" is incompatible — spec the starch and say plainly the day got bigger
- [Iso taken at night with dinner](project-isotretinoin-course.md) — take iso with DINNER (fattiest meal), never "with breakfast" (repeated /plan miscue, corrected 2026-07-15)
- [Post-lunch sweet = craving control](feedback-fruit-after-lunch-craving-control.md) — **vehicle changed to 0-cal gelatin 2026-08-06** (was fruit); spec gelatin and fold the carbs into lunch. Post-lunch slot ONLY — oats mix-in and post-dinner dessert untouched
- [Rice served with beans](reference-rice-served-with-beans.md) — rice is habitually arroz com feijão; account for ~80 g beans (P9 C22 F0.5/100 g) in every rice meal's macros
- [Prefers Activity Over Food Cuts](feedback-prefers-activity-over-food-cuts.md) — finds eating less hard; build deficit from NEAT/walking + social-day control, not plan-day cuts or more hard running
- [Adjust day on skipped session](feedback-adjust-day-on-skipped-session.md) — when a session is skipped/swapped, re-tier the whole day (calories incl.) down to match output; do NOT prescribe compensatory NEAT (time-constrained; NEAT is opportunistic extra). Cut carbs, never the protein/fat floors. **Name the feed to cut** — left alone he deletes the midafternoon snack, the one feed holding both floors (Aug 6: calories right, both floors broken)
- [Fat floor — never plan a pourable drizzle](feedback-fat-floor-lean-fish-dinners.md) — 5th miss Jul 30. Build fat into the dish, AND assume one meal/day gets swapped wholesale: bank the floor in the at-home meals so a grabbed lunch (9 g F) can't break the day; re-tune dinner's fat up the moment a lunch logs light
- [Lab-tested physiology](lab-tested-physiology.md) — Bod Pod + lactate ramp 2026-04-28, supersedes BIA and assumed LT

## Training Milestones

- **Feb 15:** First MAF-compliant long run (13km, 141 avg HR). Prior long runs were 162-168. See `coaching-lessons.md`.
- **Feb 11 Upper Push baselines:** DB Bench 18kg (→20kg next), Dips BW x15 (→add weight), Arnold 10-12kg, Lat Raise 6-7kg
- **Feb 20:** First outdoor quality session (cruise intervals). HR zones revised — original sub-T targets too conservative. Pacing discipline needs work (36s spread across reps).

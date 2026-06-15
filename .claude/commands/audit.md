# Protocol Stack Audit — Hunt False Assumptions & Inconsistencies

## Objective
Audit the full protocol stack for claims that are internally contradictory,
physiologically/nutritionally wrong, or unsupported by the athlete's own measured
data — anything that would mis-target a prescription and make adherence effort
unproductive. Find the false premises, not just typos or stale wording.

## Ground-truth hierarchy (what wins when sources disagree)
1. **Lab measurements** (FCDEFUC 2026-04-28: lactate thresholds, Bod Pod body
   comp, hydration flag) — re-read from current-status.md. Never override these;
   if a prescription contradicts them, the prescription is the defect.
2. **The athlete's own logged Garmin data** — actual easy-run HR, executed
   strength loads, sleep durations, weigh-in trend, race HRs. A target the logged
   data shows is unattainable or false is a defect, regardless of how reasonable
   it looks on paper.
3. **Standing athlete decisions/preferences** in the coaching log (pre-lunch
   training, 2 quality/wk, no leg hypertrophy, daily breakfast / no IF, etc.).
4. **Generic textbook defaults** — lowest priority. Flag anywhere a generic
   default contradicts 1–3.

## Files in scope
All `protocols/*.md`, `AGENTS.md`, and `.claude/commands/*.md`. Treat the command
docs as live: their defaults regenerate into daily files every run.

## Defect categories to hunt
- **A. Internal inconsistency** — the same number/rule stated differently in two
  places; a value that trails an update made elsewhere; a declared "single source
  of truth" that another file silently contradicts.
- **B. False assumption / wrong reasoning** — a claim that's physiologically,
  biochemically, or statistically incorrect, or an inference that runs backwards.
  (Precedents: "low reps = bulk" was inverted; a heat rule that *lowers* an HR
  target is backwards, since heat raises HR at a fixed lactate.)
- **C. Unsupported-as-stated / unattainable** — an assumption presented as
  established fact with no basis, or a target the athlete's measured data shows
  they cannot hit. (Precedent: "recovery jog <133" and Zone 1 "recovery jogs"
  when the athlete can't run below ~130 bpm.)
- **D. Zombie rules** — a rule superseded by a later coaching-log decision but
  still present and firing somewhere. (Precedents: retired 148 HR ceiling,
  Thursday no-running rule, IF eating window.)
- **E. Regenerating defaults** — a default baked into a command doc that re-emits
  a bad value on every run. (Precedent: Garmin warmup ≤125 / cooldown ≤130.)

## Method
1. Re-read current-status.md first to load current lab anchors, phase, goals, and
   the full coaching-log decision history (the supersession record).
2. Map every quantitative prescription and hard rule, noting where each is the
   source of truth vs a reference copy. Cross-reference for disagreements (A).
3. For every athlete-specific target (HR, pace, load, calories, sleep, hydration),
   PULL the relevant logged Garmin data and test attainability/consistency
   against reality (C). Pull actual data — never assume it.
4. For every causal physiological/nutritional claim, ask: is this empirically
   true? Verify load-bearing, checkable claims against current evidence
   (web/literature), not memory — per the standing rule, never assert biological
   or spec facts from pretraining alone. Mark a confidence level on each.
5. Walk the coaching log and confirm every superseded decision was actually
   removed everywhere it appeared (D).
6. Scan command docs for regenerating defaults (E).

## Output — do NOT edit yet
Produce a findings report sorted by severity:
- **Critical** — mis-targets training/nutrition or wastes the athlete's effort
  (wrong zone, false premise driving a prescription, unattainable target).
- **Major** — a contradiction that confuses execution, or a zombie rule still
  firing.
- **Minor** — cosmetic/stale wording, no execution impact.

Each finding: `file:line` · category (A–E) · the exact claim · why it's wrong +
the contradicting evidence/source · proposed correction · confidence
(high/med/low). Batch the obvious fixes so they can be approved together. Then
STOP and wait for approval before changing anything — same as the HR-range pass.

## Guardrails
- Never rewrite the lab anchors or fabricate data to resolve a conflict. If two
  sources disagree and neither is clearly the measured truth, raise it as a
  question — don't silently pick one.
- Explicitly separate **measured fact** vs **assumption** vs **preference**. A
  preference is not a defect; a preference dressed as a physiological fact is.
- Skepticism over politeness. Flag what's wrong even in decisions a prior session
  or the athlete made.

# Skin - Capture a Skin-Relevant Observation (MASTER)

## Usage

```
/skin [whatever you noticed]
/skin
```

## Function

`/skin` is **capture-only**. It records what the athlete believes is relevant and
freezes the day's objective context alongside it, then stops. It does **not**
interpret, score, or re-rank hypotheses — all correlation and synthesis happens
weekly in `/report`. The end goal is a rich, timestamped evidence base that the
weekly pass can correlate against the athlete's life data to crack a long-running
skin condition.

### `/skin [observation]` — capture

1. Open `protocols/skin-log.md` and append one entry to the **Pending Observations**
   section (the section `/report` drains into the Weekly Log).
2. Record the athlete's note **verbatim** — his words, the variables he thinks
   matter. Do not paraphrase into clinical language or pre-judge relevance.
3. **Auto-attach the day's objective context** so the entry is self-contained for
   later correlation. Pull it primarily from today's daily file
   (`logbook/YYYY-MM/YYYY-MM-DD.md`, already assembled by `/plan`: readiness
   snapshot, nutrition, Actuals). Fall back to live Garmin MCP only for a marker the
   daily file is missing. Capture:
   - recovery — sleep h / score, HRV, stress, RHR, Body Battery
   - training that day — session(s) and load
   - day context — day type, and the nutrition / social / alcohol / heat flags
4. **Auto-tag** the entry with 1–2 inferred tags to make the weekly filter easier —
   `skin-state`, `product-change`, `med`, `candidate-trigger`, `environment`, or
   similar. Infer them; never ask the athlete to categorize.
5. **Stop there.** No "Read", no hypothesis change, no single-point diagnosis at
   capture time. Confirm the entry was logged and show it back.

### `/skin` — no args

Show a read-only status: the current Pending Observations awaiting synthesis and the
standing working-hypothesis ranking from `skin-log.md`. Then offer to capture a new
observation. Do not interpret.

### Entry format

```
- **YYYY-MM-DD (Day) HH:MM:** <verbatim observation>
  - **Context:** sleep <h> / <score>; HRV <ms / trend>; stress <n>; RHR <bpm>; BB <state>; training <session / load>; day type <type>; flags <nutrition / social / alcohol / heat>.
  - **Tags:** <tag>, <tag>
```

## Requirements

- **Capture-only.** No interpretation, no hypothesis re-ranking, no severity score at
  capture. The weekly `/report` owns all correlation and synthesis.
- **No daily severity score.** Acne evolves on a multi-week cycle; a daily 0–5 reading
  is noise. `/skin` captures events and observations, not a daily rating.
- **Verbatim first.** The athlete's own words are the new signal; the auto-attached
  context is the substrate. Preserve both, keep them distinct.
- **Single home.** Write to `protocols/skin-log.md` § Pending Observations only — never
  to the daily file. One canonical place keeps the evidence base coherent.
- **Event-driven, not a checklist.** `/skin` runs when the athlete notices something;
  it is not a standing daily commitment and is not scored for adherence.
- **Isotretinoin confound (from 2026-06-25).** The microdose course now dominates skin
  change. Capture observations as normal, but the weekly read must treat any lifestyle
  correlation as **low-confidence while on the drug** and say so — do not let a flare or
  a clearing be over-attributed to lifestyle when the drug is the bigger lever.
- The weekly correlation (in `/report`) must name confounders, not just hits, and must
  not re-rank a working hypothesis on a single observation.

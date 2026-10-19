---
model: sonnet
effort: low
# Short data entry, but it writes to Garmin, the ground-truth record.
---
# Body - Sync Smart Scale to Garmin (MASTER)

## Usage

```
/body
```

## Function

1. Ask for smart-scale measurements
2. Sync them to Garmin
3. Display current vs baseline vs target

## Progress Table

> Scale data is BIA; body-fat reads ~7 pp high vs the Bod Pod reference. The weight trend and lean-mass retention govern — not scale BF%.

| Metric    | Current | Baseline (Bod Pod 2026-04-28) | Target           | Delta from baseline |
| --------- | ------- | ----------------------------- | ---------------- | ------------------- |
| Weight    | XX kg   | 76.11 kg                      | ~70.0–70.5 kg (Aug 1 2027) | -X kg          |
| Body Fat  | XX%     | 21.7%                         | ~15%             | -X%                 |
| Fat Mass  | XX kg   | 16.48 kg                      | ~10.5–10.7 kg    | -X kg               |
| Lean Mass | XX kg   | 59.6 kg                       | Maintain 59.6 kg | +/-X kg             |

## Requirements

- Compare against the Bod Pod baseline 76.11 kg / 21.7% BF / 59.6 kg lean (2026-04-28), per `current-status.md`.
- Use the Aug 1 2027 scorecard target: ~15% BF (~70.0–70.5 kg at the lab lean), holding ≥59.6 kg lean mass (set 2026-10-19; the Phase 8 rate of −0.2 kg/wk and its rate reads in `nutrition.md` govern what "on track" means on any given date). Also record the weekly navel waist tape when the athlete gives it.
- Scale BF% is BIA (~7 pp high vs Bod Pod); report the weight trend and lean retention as the governing signals, not scale BF%.

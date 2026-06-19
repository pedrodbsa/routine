# Body - Sync Smart Scale to Garmin (MASTER)

## Usage

```
/body
```

## Function

1. Ask for smart-scale measurements
2. Sync them to Garmin
3. Display current vs baseline vs target
4. Remind the user to export CSVs if needed

## Progress Table

> Scale data is BIA; body-fat reads ~7 pp high vs the Bod Pod reference. The weight trend and lean-mass retention govern — not scale BF%.

| Metric    | Current | Baseline (Bod Pod 2026-04-28) | Target           | Delta from baseline |
| --------- | ------- | ----------------------------- | ---------------- | ------------------- |
| Weight    | XX kg   | 76.11 kg                      | 71 kg            | -X kg               |
| Body Fat  | XX%     | 21.7%                         | 16%              | -X%                 |
| Fat Mass  | XX kg   | 16.48 kg                      | ~11.4 kg         | -X kg               |
| Lean Mass | XX kg   | 59.6 kg                       | Maintain 59.6 kg | +/-X kg             |

## Requirements

- Compare against the Bod Pod baseline 76.11 kg / 21.7% BF / 59.6 kg lean (2026-04-28), per `current-status.md`.
- Use target 71 kg / 16% BF, holding 59.6 kg lean mass.
- Scale BF% is BIA (~7 pp high vs Bod Pod); report the weight trend and lean retention as the governing signals, not scale BF%.
- Include reminder to export Garmin CSVs after sync.

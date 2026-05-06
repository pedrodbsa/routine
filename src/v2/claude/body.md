# Body - Sync Smart Scale to Garmin

Bridge smart scale measurements to Garmin Connect for CSV export.

## Usage

```
/body
```

## Function

1. Ask user for smart scale measurements:
    - Weight (kg)
    - Body fat (%)
    - Muscle mass (% or kg)
    - Visceral fat (index/rating)
    - Body water (%)

2. Sync to Garmin via `mcp__garmin__add_body_composition`:
    - Convert muscle mass % to kg if needed (weight x percentage)
    - Round visceral fat rating to integer
    - Use today's date

3. Display confirmation with:
    - Current vs target comparison
    - Fat mass / lean mass breakdown
    - Progress from baseline (76.8kg/29.2% BF → target 70-72kg/21-23% BF)

4. Remind user to run exporter for CSV:
    ```
    python scripts/export_garmin_data_csv.py body
    ```

## Data Fields

| Smart Scale | Garmin Field | Notes |
|---|---|---|
| Weight | weight | kg |
| Body Fat % | percent_fat | percentage |
| Muscle Mass | muscle_mass | Convert % to kg |
| Visceral Fat | visceral_fat_rating | Integer |
| Body Water % | percent_hydration | percentage |

## Output Format

```
## Body Composition Logged - [Date]

**Synced to Garmin:**
- Weight: XX.X kg
- Body Fat: XX%
- Muscle Mass: XX.X kg
- Visceral Fat: X
- Hydration: XX%

**Progress:**
| Metric | Current | Baseline (Mar) | Target | Delta from baseline |
|---|---|---|---|---|
| Weight | XX kg | 76.8 kg | 70-72 kg | -X kg |
| Body Fat | XX% | 29.2% | 21-23% | -X% |
| Fat Mass | XX kg | 22.4 kg | ~15 kg | -X kg |
| Lean Mass | XX kg | 54.4 kg | Maintain | +/-X kg |

**To export CSV:** `python scripts/export_garmin_data_csv.py body`
```

## Requirements

- Use mcp__garmin__add_body_composition for Garmin sync
- Calculate derived metrics (fat mass, lean mass)
- Compare to baseline (76.8kg, 29.2% BF) and target (70-72kg, 21-23% BF)
- Include export command reminder

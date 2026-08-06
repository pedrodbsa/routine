---
name: project-treadmill-control-run-protocol
description: "Weekly treadmill control run — fix the belt at 8.6 km/h, 1% incline, 30:00, treadmill mode, COROS armband for HR; the tracked number is average HR, and the belt speed must not be raised"
metadata: 
  node_type: memory
  type: project
  originSessionId: 0249edc3-b6fd-4fc9-b691-5ff0cbaeb031
  modified: 2026-08-05T13:39:21.102Z
---

The weekly control run is the only heat-independent fitness signal in the stack. As of **2026-08-05** its protocol is: **belt 8.6 km/h · 1% incline · 30:00 · started in `treadmill_running` mode · HR from the COROS armband · tracked number = average HR.** Falling HR at 8.6 km/h is the fitness signal.

**The HR source is a fixed condition, added 2026-08-05.** The Aug 5 run came back at block avg **131** against 137 / 136 — a 6–8 bpm drop that would have been the best aerobic signal of the block. Belt was confirmed at 8.60, so speed was not the cause; but that session ran on **watch wrist-optical HR alone**, and the athlete could not recall whether the armband was worn on Jul 13 or Jul 27. Wrist optical lags on ramps and under-reads in steady state, which depresses an *average* more than a *max* — and the Aug 5 max fell only 2–5 bpm while the average fell 6–8, exactly that shape. **The read was voided**, not entered in the series. Fixing belt/incline/duration/mode while leaving the sensor free makes the whole series unfalsifiable.

**Why:** It was originally written as "HR cap 142, let pace float", which made the tracked number Garmin's *derived* pace — and treadmill-mode distance comes from an unverified stride calibration. Measured 2026-07-27: belt 8.6 reads 8.39 on the watch (−2.4%). Belt speed is a number the athlete sets; derived pace is a number the watch estimates. Two failures already: **Jul 22 was recorded as an outdoor `running` activity**, producing a phantom 6:11/km at HR 136 that read as a large fitness gain and was pure recording artifact; the two genuine treadmill-mode points (Jul 13, Jul 27) sit at HR 137 at the same belt speed, i.e. **flat**.

**How to apply:** Prescribe the belt speed explicitly, not a pace range, and require treadmill mode. **Do not raise the belt speed** — the athlete proposed this on 2026-07-27 because HR 137 sits under the 142 cap. Changing the fixed variable restarts the series (only two comparable points exist) and spending easy-day HR headroom is the same instinct behind the standing above-prescription flag. If it genuinely becomes too easy, raise it once at a `/report` boundary and note the reset. See [[feedback-pace-hr-calibration]] and [[feedback-garmin-easy-paces-work]].

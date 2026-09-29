---
name: project-treadmill-control-run-protocol
description: "Fortnightly treadmill control run — 5.0 km at a locked 8.6 km/h, 1% incline, treadmill mode, COROS armband; the tracked number is average HR and the belt speed must not be raised"
metadata:
  type: project
---

The control run is the only heat-independent fitness signal in the stack: **5.0 km · belt locked at 8.6 km/h · 1% incline · `treadmill_running` mode · HR from the COROS armband · tracked number = average HR**, fortnightly on the Monday easy slot. Falling HR at 8.6 km/h is the fitness signal. Protocol and series: `current-status.md` § Aerobic Threshold Compliance.

**Why every condition is fixed:**
- **Speed, not pace.** Treadmill-mode distance comes from an unverified stride calibration (the watch reads the 8.6 belt as 8.39, −2.4%). A Jul 22 run recorded as outdoor `running` produced a phantom 6:11/km that read as a large gain.
- **Sensor.** Aug 5 came back at avg 131 against 137 / 136, on wrist-optical HR only. Wrist optical under-reads steady-state averages more than maxima, which matched the shape, so the read was voided. An entry on any sensor other than the armband is void.

**How to apply:** prescribe the belt speed, never a pace range, and require treadmill mode. **Do not raise the belt speed** (the athlete proposed it on 2026-07-27 because HR 137 sits under the 142 cap): it restarts a series that has only two comparable points. If it genuinely becomes too easy, raise it once at a `/report` boundary and note the reset. Related: [[user-motivation-running-numbers]].

---
name: reference-garmin-direct-pull-fallback
description: "When the garmin MCP server is down, pull the same data directly via garminconnect + the cached token — never block /plan on it"
metadata: 
  node_type: memory
  type: reference
  originSessionId: 21c6e7d1-5102-4c35-ac07-36956ee4b816
  modified: 2026-07-29T07:27:50.911Z
---

The `garmin` MCP server is the normal data path, but it breaks on upstream dependency drift and an `.mcp.json` fix needs a **session restart** to take effect — which would block `/plan` for the day. It does not have to.

**Fallback:** a throwaway Python script run through `uvx --python 3.12 --with garminconnect python <script>` reaches the same API with no MCP involved. Auth needs no credentials — `Garmin().login(os.path.expanduser("~/.garminconnect"))` resumes from the cached token at `C:\Users\Pedro\.garminconnect`.

Useful methods: `get_sleep_data`, `get_hrv_data`, `get_body_battery(start, end)`, `get_rhr_day`, `get_stats`, `get_training_readiness` (usually empty for this athlete), `get_activities_by_date`, `get_body_composition(start, end)`.

Two gotchas:
- Dump to a file and summarise with a second script — a full pull runs ~300 KB and should never go straight into context.
- Garmin's `...TimestampLocal` fields are epoch-shifted so that **formatting them as UTC yields the local wall clock**. Convert with `datetime.fromtimestamp(ms/1000, timezone.utc)` and read the result as local time.

Known break (2026-07-29): `ModuleNotFoundError: No module named 'mcp.server.fastmcp'` — the current `mcp` SDK dropped that module. Fixed by adding `--with mcp>=1.2,<2` to the `uvx` args in `.mcp.json`.

Related: [[feedback-garmin-mcp-over-csv]] — the `data/*.csv` exports are stale and are not an acceptable substitute for a live pull.

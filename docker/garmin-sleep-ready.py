"""Exit 0 once Garmin holds a finished sleep record for today, 1 while it does not, 2 on error.

cron-coach polls this every 10 minutes from the morning window's start, so the scheduled /plan
fires after the watch has synced the night rather than at a fixed clock time.

It reuses the Garmin MCP's token cache and never logs in with the password: a rate-limited SSO
login from a cron job would lock the MCP out as well. Prints one status line, never the payload.
"""

import datetime
import os
import sys

from garminconnect import Garmin


def main() -> int:
    today = os.environ.get("COACH_DATE") or datetime.date.today().isoformat()
    tokenstore = os.path.expanduser(os.getenv("GARMINTOKENS") or "~/.garminconnect")

    try:
        garmin = Garmin()
        garmin.login(tokenstore)
        dto = (garmin.get_sleep_data(today) or {}).get("dailySleepDTO") or {}
    except Exception as exc:  # noqa: BLE001 — any failure is reported, not raised
        print(f"error: {type(exc).__name__}: {exc}"[:300])
        return 2

    seconds = dto.get("sleepTimeSeconds")
    if dto.get("calendarDate") != today or not dto.get("sleepEndTimestampGMT") or not seconds:
        print(f"not ready: no finished sleep record for {today}")
        return 1

    # Garmin's *Local timestamps are shifted so that formatting them as UTC gives local wall time.
    woke = ""
    if dto.get("sleepEndTimestampLocal"):
        end = datetime.datetime.fromtimestamp(dto["sleepEndTimestampLocal"] / 1000, datetime.timezone.utc)
        woke = f", woke {end:%H:%M}"
    print(f"ready: slept {seconds / 3600:.1f} h{woke}")
    return 0


if __name__ == "__main__":
    sys.exit(main())

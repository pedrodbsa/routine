"""Print today's Garmin activities, one per line: id, type, name. Exit 2 on error.

cron-activity polls this every 10 minutes through the day and hands each new activity to the
coach session as `/log activity <id>`.

Like garmin-sleep-ready.py, it reuses the Garmin MCP's token cache and never logs in with the
password.
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
        activities = garmin.get_activities_by_date(today, today) or []
    except Exception as exc:  # noqa: BLE001 — any failure is reported, not raised
        print(f"error: {type(exc).__name__}: {exc}"[:300], file=sys.stderr)
        return 2

    for a in activities:
        kind = (a.get("activityType") or {}).get("typeKey", "")
        print(f"{a['activityId']}\t{kind}\t{a.get('activityName', '')}")
    return 0


if __name__ == "__main__":
    sys.exit(main())

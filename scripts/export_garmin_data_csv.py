import argparse
import datetime as dt
import sys
from pathlib import Path
from typing import Any, Dict, List, Optional

from garmin_exporter import EXPORTERS, init_client, load_state, save_state
from garmin_exporter.exporters.base import DatasetExporter
from garmin_exporter.utils import append_rows, log_progress


STATE_FILE = Path("data/garmin_export_state.json")
BASELINE_START = "2025-08-01"


def get_default_start(exporter: DatasetExporter) -> str:
    """Get default start date for an exporter."""
    if exporter.default_start_static:
        return exporter.default_start_static
    days = exporter.default_start_days_back if exporter.default_start_days_back is not None else 30
    return (dt.date.today() - dt.timedelta(days=days)).isoformat()


def get_default_end() -> str:
    """Get default end date (today)."""
    return dt.date.today().isoformat()


def get_start_from_state(exporter: DatasetExporter, state_value: Optional[str]) -> str:
    """Determine start date based on state, considering lookback days."""
    if state_value:
        try:
            last_date = dt.date.fromisoformat(state_value)
            start_date = last_date - dt.timedelta(days=exporter.lookback_days)
            baseline_str = get_default_start(exporter)
            try:
                baseline_date = dt.date.fromisoformat(baseline_str)
                if start_date < baseline_date:
                    start_date = baseline_date
            except ValueError:
                pass
            return start_date.isoformat()
        except ValueError:
            pass
    return get_default_start(exporter)


def get_next_state_value(end_date: str) -> str:
    """Get the state value to save after a successful run."""
    return end_date


def run_exporter(
    exporter: DatasetExporter,
    args: argparse.Namespace,
    client: Any,
    quiet: bool = False,
) -> List[Dict[str, Any]]:
    csv_path = Path(getattr(args, "csv"))
    setattr(args, "csv", csv_path)
    existing = exporter.load_existing_keys(csv_path)
    if not quiet:
        log_progress(exporter.name, f"starting {getattr(args, 'start', '')} -> {getattr(args, 'end', '') or ''}")
    rows = exporter.fetch_rows(client, args, existing)
    append_rows(csv_path, exporter.fieldnames, rows)

    if not quiet:
        if rows:
            print(f"{exporter.name}: appended {len(rows)} rows to {csv_path}")
        else:
            print(f"{exporter.name}: no new data")

    return rows


def run_sync(state_file: Path, dry_run: bool) -> None:
    state = load_state(state_file)
    client: Optional[Any] = None if dry_run else init_client()
    state_changed = False

    for exporter in EXPORTERS:
        start = get_start_from_state(exporter, state.get(exporter.name))
        end = get_default_end()

        try:
            start_date = dt.date.fromisoformat(start)
            end_date = dt.date.fromisoformat(end)
        except ValueError:
            print(f"{exporter.name}: invalid date range start={start}, end={end}; skipping")
            continue

        if start_date > end_date:
            print(f"{exporter.name}: start {start} is after end {end}; skipping")
            continue

        log_progress(exporter.name, f"starting sync {start} -> {end}")
        args_dict = exporter.default_args()
        args_dict.update({"start": start, "end": end, "csv": exporter.default_csv})
        export_args = argparse.Namespace(**args_dict)

        if dry_run:
            print(f"{exporter.name}: would fetch {start} -> {end} into {exporter.default_csv}")
            continue

        rows = run_exporter(exporter, export_args, client, quiet=True)
        if rows:
            print(f"{exporter.name}: appended {len(rows)} rows to {exporter.default_csv}")
        else:
            print(f"{exporter.name}: no new data")

        new_state = get_next_state_value(end)
        if state.get(exporter.name) != new_state:
            state[exporter.name] = new_state
            state_changed = True

    if not dry_run and state_changed:
        save_state(state_file, state)


def build_parser() -> argparse.ArgumentParser:
    parser = argparse.ArgumentParser(description="Fetch Garmin data and store it locally")
    subparsers = parser.add_subparsers(dest="dataset", metavar="dataset")

    for exporter in EXPORTERS:
        sub = subparsers.add_parser(exporter.name, help=exporter.help)
        exporter.add_arguments(sub)
        sub.set_defaults(exporter=exporter)

    sync_parser = subparsers.add_parser(
        "sync",
        help="Run all exporters using saved state to fetch only new data",
    )
    sync_parser.add_argument(
        "--state-file",
        type=Path,
        default=STATE_FILE,
        help=f"Path to JSON state file (default: {STATE_FILE})",
    )
    sync_parser.add_argument(
        "--dry-run",
        action="store_true",
        help="Show planned fetch ranges without calling the Garmin API",
    )
    sync_parser.set_defaults(sync=True)

    return parser


def main() -> None:
    parser = build_parser()
    args = parser.parse_args()

    if getattr(args, "sync", False):
        run_sync(Path(args.state_file), args.dry_run)
        return

    exporter: DatasetExporter = getattr(args, "exporter", None)
    if exporter is None:
        parser.print_help()
        sys.exit(1)

    # Load state to determine start date if not specified
    state = load_state(STATE_FILE)
    
    # Use state to determine start date if not provided by user
    if not hasattr(args, "start") or args.start is None:
        args.start = get_start_from_state(exporter, state.get(exporter.name))
    
    # Use default end date if not provided
    if not hasattr(args, "end") or args.end is None:
        args.end = get_default_end()

    client = init_client()
    rows = run_exporter(exporter, args, client)
    
    # Update state with the new end date
    new_state = get_next_state_value(args.end)
    if state.get(exporter.name) != new_state:
        state[exporter.name] = new_state
        save_state(STATE_FILE, state)
        print(f"Updated state: {exporter.name} -> {new_state}")


if __name__ == "__main__":
    main()

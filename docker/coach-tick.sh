#!/usr/bin/env bash
# Runs the coach's scheduled jobs and sends their output to Telegram. Driven by a Dokploy
# schedule every 10 minutes; each tick decides from local time and per-day markers whether
# anything is due, so almost every tick is a no-op that costs no tokens.
#
#   morning  from COACH_MORNING_FROM, once Garmin has today's sleep record: /plan scheduled.
#            If there is still no daily file and no sleep record at COACH_PLAN_CUTOFF, the day
#            is skipped and the evening recap asks why.
#   recap    every day from COACH_RECAP_AT, plan or not: /recap.
#   report   on COACH_REPORT_DOW, chained after a successful recap: /report scheduled.
#
# Usage: coach-tick                          normal tick
#        coach-tick --force morning|recap|report
#                                            run one job now, ignoring gates, markers and caps
# COACH_DRY_RUN=1 prints what a tick would do without running Claude or sending anything.
# COACH_NOW="2026-10-05 06:40" pretends it is that local time (testing the gates).
set -euo pipefail

REPO="${COACH_REPO:-/app}"
STATE_DIR="${COACH_STATE_DIR:-/root/.coach/state}"
MORNING_FROM="${COACH_MORNING_FROM:-05:00}"
PLAN_CUTOFF="${COACH_PLAN_CUTOFF:-12:00}"
RECAP_AT="${COACH_RECAP_AT:-21:30}"
REPORT_DOW="${COACH_REPORT_DOW:-7}"
MAX_ATTEMPTS="${COACH_MAX_ATTEMPTS:-3}"
RUN_TIMEOUT="${COACH_RUN_TIMEOUT:-45m}"
DRY_RUN="${COACH_DRY_RUN:-0}"

# Scheduled runs must never see the bot token under the name the channel plugin reads, or their
# copy of the plugin would start polling and evict the Telegram session (see coach-telegram).
unset TELEGRAM_BOT_TOKEN

mkdir -p "${STATE_DIR}"
exec 9>"${STATE_DIR}/tick.lock"
if ! flock -n 9; then
  echo "previous tick still running; skipping"
  exit 0
fi

now_ref="${COACH_NOW:-now}"
today="$(date -d "${now_ref}" +%F)"
now="$(date -d "${now_ref}" +%H:%M)"
dow="$(date -d "${now_ref}" +%u)"
daily="${REPO}/logbook/${today:0:7}/${today}.md"

marker() { echo "${STATE_DIR}/$1-${today}"; }

notify() {
  if [ "${DRY_RUN}" = 1 ]; then
    echo "dry run: would send: $1"
  else
    printf '%s\n' "$1" | telegram-send || echo "telegram-send failed" >&2
  fi
}

# Runs one Claude job and delivers its result. Returns non-zero if the job did not succeed.
run_job() {
  local job=$1 prompt=$2 force=${3:-0}
  local attempts_file out rc result detail n

  if [ "${DRY_RUN}" = 1 ]; then
    echo "dry run: would run ${job}: claude -p \"${prompt}\""
    return 0
  fi

  attempts_file="$(marker "${job}").attempts"
  n="$(cat "${attempts_file}" 2>/dev/null || echo 0)"
  if [ "${force}" != 1 ]; then
    if [ "${n}" -ge "${MAX_ATTEMPTS}" ]; then
      echo "${job}: gave up after ${n} attempts today"
      return 1
    fi
    echo $((n + 1)) >"${attempts_file}"
  fi

  echo "${job}: running ${prompt}"
  rc=0
  out="$(cd "${REPO}" && timeout "${RUN_TIMEOUT}" claude -p "${prompt}" --output-format json \
    2>"$(marker "${job}").stderr")" || rc=$?
  result="$(jq -r 'select(.is_error != true) | .result // empty' <<<"${out}" 2>/dev/null || true)"

  if [ "${rc}" -eq 0 ] && [ -n "${result}" ]; then
    printf '%s\n' "${result}" | telegram-send || echo "${job}: telegram-send failed" >&2
    touch "$(marker "${job}").done"
    echo "${job}: done"
    return 0
  fi

  # A failure is never silent: the athlete hears about every failed attempt, with the reason.
  detail="$(jq -r '.result // .subtype // empty' <<<"${out}" 2>/dev/null | head -c 400 || true)"
  if [ -z "${detail}" ]; then
    detail="$(tail -c 400 "$(marker "${job}").stderr" 2>/dev/null || true)"
  fi
  notify "⚠️ Coach: ${job} failed (exit ${rc}, attempt $((n + 1))/${MAX_ATTEMPTS}). ${detail}"
  echo "${job}: failed with exit ${rc}" >&2
  return 1
}

# 0 = today's sleep record is on Garmin, 1 = not yet. A failing check counts as "not yet" and
# is reported once a day, so a broken Garmin token doesn't silently cost the morning plan.
sleep_ready() {
  local status rc=0
  status="$(COACH_DATE="${today}" uvx --quiet --python 3.12 --with garminconnect==0.3.2 \
    python "${COACH_LIB:-/usr/local/lib/coach}/garmin-sleep-ready.py" 2>&1)" || rc=$?
  echo "morning: sleep check: ${status}"
  if [ "${rc}" -eq 2 ] && [ ! -e "$(marker sleep-check).warned" ]; then
    touch "$(marker sleep-check).warned"
    notify "⚠️ Coach: the Garmin sleep check is failing (${status}). The morning plan waits for it until ${PLAN_CUTOFF}; send \"plan\" to run it now."
  fi
  [ "${rc}" -eq 0 ]
}

morning() {
  if [ -e "$(marker morning).done" ] || [ -e "$(marker morning).skipped" ]; then return 0; fi
  if [[ "${now}" < "${MORNING_FROM}" ]]; then return 0; fi
  if [ "$(cat "$(marker morning).attempts" 2>/dev/null || echo 0)" -ge "${MAX_ATTEMPTS}" ]; then
    return 0
  fi

  if [ -e "${daily}" ]; then
    echo "morning: ${daily} already exists (planned by hand); nothing to do"
    touch "$(marker morning).done"
    return 0
  fi

  if sleep_ready; then
    run_job morning "/plan scheduled" || true
  elif [[ ! "${now}" < "${PLAN_CUTOFF}" ]]; then
    echo "morning: no daily file and no sleep record at ${PLAN_CUTOFF}; skipping the day's plan"
    [ "${DRY_RUN}" = 1 ] || touch "$(marker morning).skipped"
  fi
}

evening() {
  if [[ "${now}" < "${RECAP_AT}" ]]; then return 0; fi

  if [ ! -e "$(marker recap).done" ]; then
    run_job recap "/recap" || return 0
  fi
  if [ "${dow}" = "${REPORT_DOW}" ] && [ ! -e "$(marker report).done" ]; then
    run_job report "/report scheduled" || true
  fi
}

if [ "${1:-}" = "--force" ]; then
  case "${2:-}" in
    morning) run_job morning "/plan scheduled" 1 ;;
    recap) run_job recap "/recap" 1 ;;
    report) run_job report "/report scheduled" 1 ;;
    *) echo "usage: coach-tick [--force morning|recap|report]" >&2; exit 2 ;;
  esac
  exit
fi

# Markers older than two weeks are noise.
find "${STATE_DIR}" -type f -name '*-20??-??-??*' -mtime +14 -delete

morning
evening

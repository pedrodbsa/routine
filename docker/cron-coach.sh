#!/usr/bin/env bash
# Drives the coach's day. Runs from a Dokploy schedule every 10 minutes, does only the
# deterministic work itself (clock gates, per-day markers, the Garmin sleep check), and hands
# every Claude job to the one long-lived `coach` session by typing the command into its tmux
# pane. The session does the job and sends its own Telegram message, so whatever it did stays
# in the conversation the athlete replies to. Almost every run is a no-op that costs no tokens.
#
#   morning  from COACH_MORNING_FROM, once Garmin has today's sleep record: /clear, then
#            /plan scheduled. If there is still no daily file and no sleep record at
#            COACH_PLAN_CUTOFF, the day is skipped and the evening recap asks why.
#   recap    every day from COACH_RECAP_AT, plan or not: /recap scheduled.
#   report   on COACH_REPORT_DOW, after the recap has finished: /report scheduled.
#
# A command is typed only while the session is idle: keys sent during a turn would queue, and
# keys sent during a permission dialog would answer it. A job counts as done once the session is
# idle again and util-telegram-send has sent something since the command went in, and, for the
# plan and the report, their file has changed too (a recap may have nothing new to write). Anything else is reported on Telegram and retried, up to COACH_MAX_ATTEMPTS a day.
#
# Usage: cron-coach                          normal run
#        cron-coach --force morning|recap|report
#                                            send one job now, ignoring gates, markers and caps
# COACH_DRY_RUN=1 prints what a run would do without typing or sending anything.
# COACH_NOW="2026-10-05 06:40" pretends it is that local time (testing the gates).
set -euo pipefail

REPO="${COACH_REPO:-/app}"
STATE_DIR="${COACH_STATE_DIR:-/root/.coach/state}"
SESSION="${COACH_SESSION:-coach}"
MORNING_FROM="${COACH_MORNING_FROM:-05:00}"
PLAN_CUTOFF="${COACH_PLAN_CUTOFF:-12:00}"
RECAP_AT="${COACH_RECAP_AT:-21:30}"
REPORT_DOW="${COACH_REPORT_DOW:-7}"
MAX_ATTEMPTS="${COACH_MAX_ATTEMPTS:-3}"
RUN_TIMEOUT_MIN="${COACH_RUN_TIMEOUT_MIN:-45}"
DRY_RUN="${COACH_DRY_RUN:-0}"

# Nothing here may see the bot token under the name the channel plugin reads (see
# claude-session-coach), not even `claude agents`.
unset TELEGRAM_BOT_TOKEN

mkdir -p "${STATE_DIR}"
exec 9>"${STATE_DIR}/run.lock"
if ! flock -n 9; then
  echo "previous run still running; skipping"
  exit 0
fi

now_ref="${COACH_NOW:-now}"
today="$(date -d "${now_ref}" +%F)"
now="$(date -d "${now_ref}" +%H:%M)"
dow="$(date -d "${now_ref}" +%u)"
daily="${REPO}/logbook/${today:0:7}/${today}.md"
report="${REPO}/logbook/${today:0:7}/report.md"
# util-telegram-send touches this on every successful send.
sent_stamp="${STATE_DIR}/last-telegram-send"

marker() { echo "${STATE_DIR}/$1-${today}"; }

notify() {
  if [ "${DRY_RUN}" = 1 ]; then
    echo "dry run: would send: $1"
  else
    # Unstamped, so a notice never passes for a job's own message.
    printf '%s\n' "$1" | COACH_SEND_STAMP=0 util-telegram-send || echo "util-telegram-send failed" >&2
  fi
}

# The session's state as `claude agents` reports it: idle, busy, or anything else (a pending
# permission dialog, a missing session). Matched by the PID of the Claude process in the tmux
# pane rather than by name, so it holds across /clear and restarts.
session_status() {
  local pane_pid pid
  pane_pid="$(tmux list-panes -t "=${SESSION}" -F '#{pane_pid}' 2>/dev/null | head -1)"
  [ -n "${pane_pid}" ] || { echo missing; return; }
  pid="$(pgrep -P "${pane_pid}" | head -1 || true)"
  [ -n "${pid}" ] || { echo missing; return; }
  claude agents --json 2>/dev/null \
    | jq -r --argjson pid "${pid}" 'map(select(.pid == $pid))[0].status // "missing"' \
    || echo missing
}

# Types one line into the session and presses Enter.
type_line() {
  tmux send-keys -t "=${SESSION}" -l "$1"
  sleep 1
  tmux send-keys -t "=${SESSION}" Enter
}

wait_idle() {
  local i
  for i in $(seq 1 "${1:-30}"); do
    [ "$(session_status)" = idle ] && return 0
    sleep 2
  done
  return 1
}

# Sends a job's command(s) to the session. Each argument is one line, typed after the session
# is idle again. Returns non-zero, without counting an attempt, if the session isn't idle.
send_job() {
  local job=$1 force=$2 status n line
  shift 2
  local attempts_file
  attempts_file="$(marker "${job}").attempts"

  if [ "${DRY_RUN}" = 1 ]; then
    echo "dry run: would type into ${SESSION}: $*"
    return 0
  fi

  status="$(session_status)"
  if [ "${status}" != idle ]; then
    echo "${job}: session ${SESSION} is ${status}; trying again next run"
    return 1
  fi

  n="$(cat "${attempts_file}" 2>/dev/null || echo 0)"
  if [ "${force}" != 1 ] && [ "${n}" -ge "${MAX_ATTEMPTS}" ]; then
    echo "${job}: gave up after ${n} attempts today"
    return 1
  fi
  echo $((n + 1)) >"${attempts_file}"

  date +%s >"$(marker "${job}").sent"
  for line in "$@"; do
    if ! wait_idle; then
      echo "${job}: session never went idle before \"${line}\"" >&2
      notify "⚠️ Coach: ${job} could not be started — the session stayed busy."
      rm -f "$(marker "${job}").sent"
      return 1
    fi
    echo "${job}: typing ${line}"
    type_line "${line}"
  done
}

# Checks a job that was sent earlier. An empty file means only the Telegram send is checked. Prints nothing and returns 0 when the job is done (and
# marks it), 1 while it is still running or failed (a failure clears the sent marker so the next
# run retries, within the daily cap).
check_job() {
  local job=$1 file=$2 sent status age
  sent="$(cat "$(marker "${job}").sent")"
  status="$(session_status)"
  age=$(( ($(date +%s) - sent) / 60 ))

  if [ "${status}" != idle ]; then
    if [ "${age}" -ge "${RUN_TIMEOUT_MIN}" ] && [ ! -e "$(marker "${job}").slow" ]; then
      touch "$(marker "${job}").slow"
      notify "⚠️ Coach: ${job} has been running for ${age} min (session ${status}). Check it with tmux attach -t ${SESSION}."
    fi
    echo "${job}: still running (${age} min, session ${status})"
    return 1
  fi

  if { [ -z "${file}" ] || { [ -e "${file}" ] && [ "$(stat -c %Y "${file}")" -ge "${sent}" ]; }; } \
    && [ -e "${sent_stamp}" ] && [ "$(stat -c %Y "${sent_stamp}")" -ge "${sent}" ]; then
    touch "$(marker "${job}").done"
    rm -f "$(marker "${job}").sent"
    echo "${job}: done"
    return 0
  fi

  rm -f "$(marker "${job}").sent"
  notify "⚠️ Coach: ${job} finished without ${file:+writing ${file#"${REPO}"/} or }sending its message (attempt $(cat "$(marker "${job}").attempts")/${MAX_ATTEMPTS}). Retrying on the next run."
  echo "${job}: finished without its file or message" >&2
  return 1
}

# Advances one job: checks it if it was sent, otherwise sends it. Returns 0 only once it is done.
step_job() {
  local job=$1 file=$2
  shift 2
  [ -e "$(marker "${job}").done" ] && return 0
  if [ -e "$(marker "${job}").sent" ]; then
    check_job "${job}" "${file}"
    return
  fi
  if [ "$(cat "$(marker "${job}").attempts" 2>/dev/null || echo 0)" -ge "${MAX_ATTEMPTS}" ]; then
    return 1
  fi
  send_job "${job}" 0 "$@" || true
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

  if [ -e "$(marker morning).sent" ]; then
    step_job morning "${daily}" || true
    return 0
  fi

  # A plan made by hand counts. The session is not cleared then: its context holds that plan.
  if [ -e "${daily}" ]; then
    echo "morning: ${daily} already exists (planned by hand); nothing to do"
    touch "$(marker morning).done"
    return 0
  fi

  if sleep_ready; then
    # /clear starts the day's conversation; yesterday lives in the repo.
    step_job morning "${daily}" "/clear" "/plan scheduled" || true
  elif [[ ! "${now}" < "${PLAN_CUTOFF}" ]]; then
    echo "morning: no daily file and no sleep record at ${PLAN_CUTOFF}; skipping the day's plan"
    [ "${DRY_RUN}" = 1 ] || touch "$(marker morning).skipped"
  fi
}

evening() {
  if [[ "${now}" < "${RECAP_AT}" ]]; then return 0; fi
  # The morning plan must not be typed into the session while it is still running.
  if [ -e "$(marker morning).sent" ]; then return 0; fi

  step_job recap "" "/recap scheduled" || return 0
  if [ "${dow}" = "${REPORT_DOW}" ]; then
    step_job report "${report}" "/report scheduled" || true
  fi
}

if [ "${1:-}" = "--force" ]; then
  case "${2:-}" in
    morning) send_job morning 1 "/clear" "/plan scheduled" ;;
    recap) send_job recap 1 "/recap scheduled" ;;
    report) send_job report 1 "/report scheduled" ;;
    *) echo "usage: cron-coach [--force morning|recap|report]" >&2; exit 2 ;;
  esac
  exit
fi

# Markers older than two weeks are noise.
find "${STATE_DIR}" -type f -name '*-20??-??-??*' -mtime +14 -delete

morning
evening

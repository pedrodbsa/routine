---
name: feedback-report-format
description: Reports are monthly — one logbook/YYYY-MM/report.md updated progressively; the Sunday /report is a weekly pass inside it, never a separate weekly file
metadata:
  type: feedback
---

Reports are monthly: one `logbook/YYYY-MM/report.md` per month, updated progressively. The Sunday `/report` is a weekly pass that adds a section to that file and sends its summary on Telegram. Never create a standalone weekly report file.

**Why:** the athlete finds weekly report files not useful; monthly is the right granularity for the record.

**How to apply:** `/report` creates or updates the current month's file and nothing else (`.claude/commands/report.md` § Scheduled Mode).

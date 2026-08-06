---
name: Report format preference
description: Reports are monthly only (reports/YYYY-MM.md), updated progressively — no standalone weekly reports
type: feedback
---

Don't create standalone weekly report files. Reports are monthly (`reports/YYYY-MM.md`), updated progressively through the month as `/report` is run.

**Why:** User finds weekly report files not useful — monthly is the right granularity.

**How to apply:** When running `/report`, create or update the current month's file (`reports/YYYY-MM.md`). Add new sections or update existing ones with each run. Never create `*-weekly.md` files.

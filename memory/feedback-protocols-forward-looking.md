---
name: feedback-protocols-forward-looking
description: "Protocol files state rules as they stand now — no audit/change tags, 'corrected'/'retracted' notes or strikethroughs; history goes in the coaching log and audit record, completed material to archive"
metadata:
  type: feedback
---

When the 2026-09-29 `/audit` applied its fixes with inline "(2026-09-29 audit)" tags, "corrected"/"retracted" explanations and struck-through expired rules, the athlete stopped it: "you've added a bunch of places stating a reason why this changed. I don't think we need that." He defined the audit's purpose as detecting inconsistencies, pushing back on suboptimal premises, dropping dead weight so the wording is just enough to provide context, and making the agents more effective. "The protocols are forward looking and just carry historical protocols/data when valuable."

**Why:** the protocol files are context for the agents that execute them. Change narratives cost tokens on every read and make a rule harder to apply without improving it.

**How to apply:** in any edit to `protocols/`, `AGENTS.md` or `.claude/commands/`, write the rule as it now stands. Keep a one-clause reason only when it stops an agent from undoing the rule (e.g. why Legs sits on Thursday). Put the change history in the `current-status.md` coaching log and the logbook record (`audit-…`, `consult-…`, `report.md`). Move completed-phase tables and expired rules to `protocols/archive/` with a pointer instead of striking them through. Related: [[feedback-record-decisions-same-session]].

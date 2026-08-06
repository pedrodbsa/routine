---
name: feedback-git-allowed-this-project
description: "Git is permitted in the routine project (overrides the global \"git is user-only\" rule); commit the agent-driving context files"
metadata: 
  node_type: memory
  type: feedback
  originSessionId: 10fe7e0e-3367-4de2-a08b-ddf242487d8d
---

In the **routine** project specifically, Claude may perform git actions. This overrides the user's global rule (`~/.claude/rules/git.md`) that git is the user's exclusively — that rule still applies to all other projects.

The agent-driving context files (`protocols/*`, monthly reports, daily logbook files) should be committed.

**Why:** the user said so on 2026-06-19 while designing the remote-coach service ([[project-remote-coach-service]]). The protocols/reports/logbook are the substrate that drives the coaching agent, so they belong in version control.

**How to apply:** make focused commits of design/context changes in this repo. Still don't sweep unrelated pre-existing working-tree changes into a commit without asking. On `main`, follow the usual "branch first" caution only if the change is risky — routine daily files are normally committed straight to main.

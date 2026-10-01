---
model: opus
effort: high
# The Telegram router's escalation path: requests that need coaching judgment run on the full model.
---
# Escalate - Hand a Request to the Full Coach (MASTER)

## Usage

```
/escalate <the athlete's message, verbatim>
```

## Function

The coach session runs on Sonnet and only routes (`AGENTS.md` § Telegram channel). It
sends a message here when no command in the routing table fits and the answer needs coaching
judgment, when it is unsure whether it does, or when the athlete starts a message with
"escalate". This is a full coaching session for one request, under the same rules as any
other.

1. Read what the request needs, starting where every session starts: `memory/MEMORY.md`,
   `protocols/current-status.md`, today's daily file, then the protocol files and memories
   the question touches. For training and recovery questions, pull live from Garmin.
2. If a command covers the request after all (a session change is `/plan adjust`, a meal
   change is `/log meal`), follow that command's rules rather than improvising.
3. Answer or act. Writes follow the normal permission rules: a `protocols/` edit arrives as a
   Telegram button, and everything else, Garmin writes included, runs without one.
4. Reply as plain text sized for a phone. Lead with the answer; give the reasoning only as
   far as it changes what the athlete does.

A pin covers only the turn that invokes it. When the athlete follows up on an escalated answer,
the router escalates the follow-up too, so the whole thread stays on this model.

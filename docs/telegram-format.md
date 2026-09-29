# Telegram message format

This applies **only to text that goes to Telegram**: the final message of a `scheduled` run
(`/plan scheduled`, `/recap scheduled`, `/report scheduled`), which `cron-coach` sends, and
the `reply` calls of the Telegram session. It never applies to a terminal, desktop or Remote
Control session, which keep the normal output of each command.

Telegram has no tables and no headings, and the athlete reads on a phone. The message is a
glance summary; the daily file and `report.md` hold the detail.

## Two syntaxes, one look

| Where | Syntax | How it is sent |
| --- | --- | --- |
| Final message of a scheduled run | **HTML** | `util-telegram-send --html`, which resends as plain text if Telegram rejects the markup |
| Telegram session replies | **MarkdownV2** | `reply` with `format: "markdownv2"`; if the tool returns a parse error, send the same text again with `format: "text"` and the markup removed |

HTML only needs `<`, `>` and `&` escaped (`&lt;` `&gt;` `&amp;`) outside tags. Newlines are
literal; there is no `<br>`. Allowed tags: `<b>`, `<i>`, `<u>`, `<s>`, `<code>`, `<pre>`,
`<blockquote>`, `<blockquote expandable>`, `<a href="…">`.

MarkdownV2 fails on any unescaped special character. Outside code, put a backslash before
each of these 18 characters: _ * [ ] ( ) ~ ` > # + - = | { } . !, including the `.` in "8.1 km" and the
`-` in a date. Inside `` ` `` and ```` ``` ```` blocks, escape only `` ` `` and `\`. Bold is
`*x*`, italic `_x_`, code `` `x` ``, a block ```` ```…``` ````, and an expandable quote is a
run of lines starting with `>`, the first line beginning `**>` and the last ending `||`.
When a reply is short and has nothing to lay out, plain `format: "text"` is fine.

## Building blocks

- **Section lines** start with one emoji and a bold label: 🏃 run, 🏋️ strength, 🍽 food,
  💤 recovery, ⚠️ flags, 📅 calendar, 📈 running numbers, ✅ done, ❌ not delivered.
- **Numbers that line up** (meals, splits, adherence rows) go in one monospace block
  (`<pre>` or ```` ``` ````), **at most 32 characters wide** so it doesn't wrap on a phone.
  Abbreviate to fit: `07:30 Breakfast  380 P30`.
- **Detail the athlete may want but rarely needs** (the reasoning, the harder alternative
  and why it was rejected, the load ledger, the rest of the week) goes in an **expandable
  quote** at the end, so it stays folded until tapped.
- **The ask is always the last line**, in bold.
- No tables, no headings, no nested lists, no emoji on every line.

## Layouts

**Morning plan** (`/plan scheduled`, HTML):

```
<b>Mon 5 Oct · Easy + Push</b> · 🟢 Green
💤 7h10, onset 23:05 · HRV 58 (balanced)
🏃 <b>Easy 8 km</b> · HR ≤145 · RPE 3
🏋️ <b>Push</b> · 5 slots, ~45 min
🍽 <b>Easy tier</b> · 2,150 kcal · P170 C210 F65
<pre>07:30 Breakfast  380 P30
12:30 Lunch      720 P50
16:00 Skyr snack 250 P32
20:30 Dinner     800 P58</pre>
⚠️ Fasted weigh-in + waist tape (Monday)
📅 Oct 12: Build starts, +300 tiers
<blockquote expandable>Why easy, not quality: …
Load: 4 run days in a row, last hard Sat …</blockquote>
<b>Reply ok to send the workouts to Garmin, or tell me what to change.</b>
```

**Evening recap** (`/recap scheduled`, HTML): a ✅ line per delivered session with its key
numbers, a ❌ line per miss ending "reason?", the weigh-in, 📅 tomorrow, then the ask in
bold. It arrives with 1–5 buttons, so the ask reads: **"Tap your motivation 1–5, and a word
on anything skipped."**

**Weekly report** (`/report scheduled`, HTML): the week line, 📈 the running numbers (always),
the adherence rows in one `<pre>` block as `✓`/`✗` against their targets, ⚠️ breaches by
date and next-week flags, then "Reply apply …" in bold when edits are proposed. The per-row
reasoning goes in an expandable quote.

**Session replies** (MarkdownV2): the same building blocks, usually two to five lines. A
changed plan shows only the changed lines.

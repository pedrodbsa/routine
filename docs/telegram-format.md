# Telegram message format

This applies **only to text that goes to Telegram**: the final message of a `scheduled` run
(`/plan scheduled`, `/recap scheduled`, `/report scheduled`), which the coach session sends
with `util-telegram-send`, and its `reply` calls. It never applies to a terminal, desktop or Remote
Control session, which keep the normal output of each command.

Telegram has no tables and no headings, and the athlete reads on a phone. The message is a
glance summary; the daily file and `report.md` hold the detail.

## Two syntaxes, one look

| Where | Syntax | How it is sent |
| --- | --- | --- |
| Final message of a scheduled run | **HTML** | `util-telegram-send --html` (with `--buttons` where the layout says), which resends as plain text if Telegram rejects the markup |
| Coach session replies | **MarkdownV2** | `reply` with `format: "markdownv2"`; if the tool returns a parse error, send the same text again with `format: "text"` and the markup removed |

HTML only needs `<`, `>` and `&` escaped (`&lt;` `&gt;` `&amp;`) outside tags. Newlines are
literal; there is no `<br>`. Allowed tags: `<b>`, `<i>`, `<u>`, `<s>`, `<code>`, `<pre>`,
`<blockquote>`, `<blockquote expandable>`, `<a href="…">`.

MarkdownV2 fails on any unescaped special character. Outside code, put a backslash before
each of these 18 characters: _ * [ ] ( ) ~ ` > # + - = | { } . !, including the `.` in "8.1 km" and the
`-` in a date. Inside `` ` `` and ```` ``` ```` blocks, escape only `` ` `` and `\`. Bold is
`*x*`, italic `_x_`, code `` `x` ``, a block ```` ```…``` ````, and an expandable quote is a
run of lines starting with `>`, the first line beginning `**>` and the last ending `||`.
When a reply is short and has nothing to lay out, plain `format: "text"` is fine.

**Escaped text and `format: "markdownv2"` go together.** `format` defaults to plain text, so
escaped text sent without it shows every backslash and asterisk on the phone (`re\-entry`,
`*73\.79 kg*`, found 2026-09-30). Decide the format first: write MarkdownV2 only when the
call sets `format: "markdownv2"`, and write unescaped text for `format: "text"`, including
the resend after a parse error.

## Building blocks

- **Section lines** start with one emoji and a bold label: 🏃 run, 🏋️ strength, 🍽 food,
  💤 recovery, ⚠️ flags, 📅 calendar, 📈 running numbers, ✅ done, ❌ not delivered.
- **A blank line between sections.** Group lines that belong together (the day and its
  recovery line; the two sessions; the tier and its meals; the flags) and put one empty line
  between groups. A wall of consecutive lines is hard to read on a phone.
- **Meals carry their ingredient quantities**, the same weights and counts as the daily
  file's Detail column (eggs as counts, weights cooked unless noted). The athlete weighs his
  food from this message, so kcal and protein alone are not enough. One meal per group: a
  bold time-and-name line with kcal and protein, then the ingredients on the next line,
  separated by `·`. Leave out zero-calorie fixtures (coffee, creatine, gelatin) except as a
  word on the line they ride with.
- **Numbers that line up** (splits, adherence rows) go in one monospace block (`<pre>` or
  ```` ``` ````), **at most 32 characters wide** so it doesn't wrap on a phone. Abbreviate to
  fit: `Z2 pace   6:42  -0:08`. Meals are not a monospace block, because the ingredients don't
  fit in 32 characters.
- **Detail the athlete may want but rarely needs** (the reasoning, the harder alternative
  and why it was rejected, the load ledger, the rest of the week) goes in an **expandable
  quote** at the end, so it stays folded until tapped.
- **The ask is always the last line**, in bold.
- No tables, no headings, no nested lists, no emoji on every line.

## Layouts

**Morning plan** (`/plan scheduled`, HTML):

```
<b>Mon 5 Oct · Easy + Chest/Biceps</b> · 🟢 Green
💤 7h10, onset 23:05 · HRV 58 (balanced)

🏃 <b>Easy 8 km</b> · HR ≤142 · RPE 3
🏋️ <b>Chest + biceps</b> · 6 slots, ~45 min

🍽 <b>Easy tier</b> · 2,250 kcal · P165 C251 F65

<b>07:30 Breakfast</b> · 380 · P30
3 eggs · 40 g oats · 80 g strawberries

<b>12:30 Lunch</b> · 720 · P50
130 g chicken · 180 g rice · 80 g beans · 150 g veg · 1 tbsp oil cooked in

<b>16:00 Snack</b> · 250 · P32
200 g skyr · ¾ scoop whey · 80 g strawberries

<b>20:30 Dinner</b> · 800 · P58
150 g salmon · 200 g potato · 250 g veg · 1 tbsp oil in the pan

⚠️ Fasted weigh-in + waist tape (Monday)
📅 Oct 12: Build starts, +300 tiers

<blockquote expandable>Why easy, not quality: …
Load: 4 run days in a row, last hard Sat …</blockquote>

<b>Reply ok to send the workouts to Garmin, or tell me what to change.</b>
```

**Evening recap** (`/recap scheduled`, HTML): a ✅ line per delivered session with its key
numbers, a ❌ line per miss ending "reason?", the weigh-in, 📅 tomorrow, then the ask in
bold, with a blank line between those groups. It arrives with 1–5 buttons, so the ask reads:
**"Tap your motivation 1–5, and a word on anything skipped."**

**Weekly report** (`/report scheduled`, HTML): the week line, 📈 the running numbers (always),
the adherence rows in one `<pre>` block as `✓`/`✗` against their targets, ⚠️ breaches by
date and next-week flags, then "Reply apply …" in bold when edits are proposed. The per-row
reasoning goes in an expandable quote.

**Session replies** (MarkdownV2): the same building blocks, usually two to five lines, with
a blank line between groups (what was done, the numbers, what comes next). A changed plan
shows only the changed lines; a changed meal shows its ingredient quantities.

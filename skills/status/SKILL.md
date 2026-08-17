---
name: status
description: "Dashboard for Brandon's 4-month principal track. Use whenever he asks where he is in the track, what's left, what to ship next, or how he's progressing."
allowed-tools: "Bash(date *), Bash(mv ${CLAUDE_PLUGIN_DATA}*)"
---

Render Brandon's track dashboard. Compact and terminal-friendly: short lines, glyphs, no giant tables.

## State
Read `${CLAUDE_PLUGIN_DATA}/progress.json` first.
- Missing → tell him there's no track state yet, point him to `/principal-track:setup`, stop.
- Invalid JSON → report it as corrupt (quote the error), do NOT guess or overwrite, point him to `/principal-track:setup`, stop.
- Today's date: `date +%F`. Never fabricate dates or progress.

## Dashboard
Also read `${CLAUDE_PLUGIN_ROOT}/data/plan.md`. Week = floor(days since started / 7) + 1. Month = current_month from state (the review ritual advances it, not the calendar). Month→artifacts map: 1→A1,A2 · 2→A3,A4,A5,A6 · 3→A7,A8 · 4→A9,A10.

Keep it ~12 lines:
- Header: `Month <m> (Week <w>) — <that month's title line from plan.md>`
- Modules on one or two lines, glyphs: ✓ solid · ~ in-progress · · not-started (e.g. `m01~ m02· m03~ ...`)
- Artifacts: `<n>/10 shipped` + shipped ids; then `next → <id> <title>` = first unshipped in the current month's set, else first unshipped overall
- Weak topics: top 3 from weak_topics, or `none logged`
- Recency: days since last quiz (quiz_log) and since last ship (artifact dates); `never` if empty
- Final line `next action →`: the single highest-leverage move — no quiz in 7+ days → `/principal-track:quiz`; no session_log touch on the month's artifact this week → build block via `/principal-track:today`; otherwise the month's SHIP item from plan.md.

## Statusline
Rewrite `${CLAUDE_PLUGIN_DATA}/statusline.txt` (write `statusline.txt.tmp`, then `mv` over it), single line:
`principal-track · Month <m> · <n>/10 artifacts · weak: <top 1–2 topics, or none>`
No other state changes.

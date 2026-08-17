---
name: review
description: "Weekly track review: what shipped, recall check, time audit, next week's build block. Use when Brandon asks for his weekly review or retro."
allowed-tools: "Bash(date *), Bash(mv ${CLAUDE_PLUGIN_DATA}*)"
---

Brandon's weekly ritual. Four steps, in order, conversational — one step at a time, wait for his answers. Direct and warm; no scolding, no fluff.

## State
Read `${CLAUDE_PLUGIN_DATA}/progress.json` first.
- Missing → no track state yet; point him to `/principal-track:setup`, stop.
- Invalid JSON → corrupt; quote the error, do NOT guess or overwrite, point to `/principal-track:setup`, stop.
- Today's date: `date +%F`.
Also read `${CLAUDE_PLUGIN_ROOT}/data/plan.md` and the Operating cadence RULE in `${CLAUDE_PLUGIN_ROOT}/data/curriculum.md`.

## 1 · What shipped
Artifacts dated in the last 7 days + this week's session_log. Nothing shipped → say it plainly and ask what blocked.

## 2 · What was learned
2–3 recall questions built from THIS week's session_log (learn / paper / quiz topics), one at a time. Misses join weak_topics.

## 3 · Time audit
Ask: average daily reading minutes this week, and did anything ship? Reading >45 min/day AND nothing shipped → invoke the RULE: he unsubscribes from one thing. Ask which. Hold out for a name.

## 4 · Next week
The single most important build block: artifact id + one concrete step, from the current month's SHIP line in plan.md.

## Month check + write
Calendar month = full months elapsed since started, +1 (cap 4). If it's ahead of current_month, advance ONLY if the current month's SHIP-gate artifacts are all shipped — gates: month 1→A1 · 2→A4,A5 · 3→A7,A8 · 4→A9,A10. Not all shipped → say so plainly, keep current_month, and point next week's block at the gap. Past month 4 with gates still open → the track is in overtime; say that too.
Write once: current_month, weak_topics, session_log `{date, skill: "review", summary: "<one line>"}` — full JSON to `progress.json.tmp` (same directory), `mv` over `progress.json`. Then statusline.txt (write `.tmp`, `mv` over): `principal-track · Month <m> · <n>/10 artifacts · weak: <top 1–2, or none>`.

---
name: today
description: "Plan today's time-boxed session; the build block always advances this month's ship artifact. Use when Brandon asks what to work on today or to plan a session."
argument-hint: "[minutes available]"
allowed-tools: "Bash(date *), Bash(mv ${CLAUDE_PLUGIN_DATA}*)"
---

Plan today's session for Brandon. Building beats reading; the plan exists to advance this month's artifact.

## State
Read `${CLAUDE_PLUGIN_DATA}/progress.json` first.
- Missing → no track state yet; point him to `/principal-track:setup`, stop.
- Invalid JSON → corrupt; quote the error, do NOT guess or overwrite, point to `/principal-track:setup`, stop.
- Today's date: `date +%F`.

## Inputs
- The current month's block in `${CLAUDE_PLUGIN_ROOT}/data/plan.md` (WORK / LOCAL / SHIP lines) + weekly_hours, weak_topics, module notes.
- Ask exactly one question — "How long do you have?" — unless the argument already says (e.g. `/principal-track:today 90`).

## The plan
Three blocks max, minutes summing to his answer. 90-min example: 20 scan / 60 build / 10 recall.
- scan — daily cadence reading (Operating cadence in `${CLAUDE_PLUGIN_ROOT}/data/curriculum.md`). Drop it entirely under ~60 total minutes; never let it grow past 20.
- build — always the biggest block, never dropped, always advancing this month's SHIP artifact. Name the artifact id and give ONE concrete next step sized to the block (e.g. `A1: wire promptfoo into CI on the summarizer repo — one failing assertion blocks the merge`). Month→artifacts: 1→A1,A2 · 2→A3,A4,A5,A6 · 3→A7,A8 · 4→A9,A10.
- recall — 5–10 min: 1–2 actual questions on his weak_topics, written out, answers withheld.
End with one line: what "done today" looks like.

## Log
Append to session_log: `{date, skill: "today", summary: "<minutes> min planned: <artifact/topic>"}`. Write the full JSON to `progress.json.tmp` in the same directory, then `mv` over `progress.json`. Statusline unchanged.

---
name: quiz
description: "Retrieval-practice quiz via the quizmaster agent; logs the score and updates weak topics. Use when Brandon asks to be quizzed or tested on track material."
argument-hint: "[module-id — optional]"
allowed-tools: "Bash(date *), Bash(mv ${CLAUDE_PLUGIN_DATA}*)"
---

Quiz round for Brandon, then the bookkeeping.

## State
Read `${CLAUDE_PLUGIN_DATA}/progress.json` first.
- Missing → no track state yet; point him to `/principal-track:setup`, stop.
- Invalid JSON → corrupt; quote the error, do NOT guess or overwrite, point to `/principal-track:setup`, stop.
- Today's date: `date +%F`.

## Scope
`$ARGUMENTS` names a module (m01–m08) → quiz that module. Empty → build a mix weighted toward weak_topics plus modules with status in-progress. Pull the matching section(s) from `${CLAUDE_PLUGIN_ROOT}/data/curriculum.md`.

## Delegate to the quizmaster
Subagents can't address Brandon directly — you relay:
1. Spawn the `principal-track:quizmaster` agent with: the scope, curriculum section(s), current weak_topics, and the last 2 quiz_log entries (so it escalates instead of repeating).
2. It asks ONE question per message. Show each verbatim; send Brandon's answer back to the SAME agent (resume it, never spawn fresh), formatted exactly as `Brandon's answer: "<his words verbatim>"` — the agent is told to trust that prefix. Repeat through all 5–7 questions to its final report (score, misses as flashcards, resurface list). Show that verbatim too.
3. No hints, no grading commentary of your own, and never answer for him.

## Bookkeeping — one state write
- quiz_log append: `{date, module: "<id or 'mixed'>", score: "<points>/<max>", weak: [missed topics]}`
- weak_topics: add each topic scored 0 or 1 (dedupe). Remove a topic only when this quiz AND the previous quiz that covered it both scored it 2 — check quiz_log; if the history isn't there, it stays.
- statusline.txt (write `.tmp`, `mv` over): `principal-track · Month <m> · <n>/10 artifacts · weak: <top 1–2, or none>`
Write the full JSON to `progress.json.tmp` (same directory), then `mv` over `progress.json`.
Close: the score, plus the one topic to hit again tomorrow.

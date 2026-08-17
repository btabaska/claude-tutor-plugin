---
name: learn
description: "Socratic tutoring on a track module (m01–m08) or topic via the tutor agent. Use when Brandon wants to learn, study, or be tutored on something in the track."
argument-hint: "[module-id or topic]"
allowed-tools: "Bash(date *), Bash(mv ${CLAUDE_PLUGIN_DATA}*)"
---

Run a tutoring session for Brandon, then record it.

## State
Read `${CLAUDE_PLUGIN_DATA}/progress.json` first.
- Missing → no track state yet; point him to `/principal-track:setup`, stop.
- Invalid JSON → corrupt; quote the error, do NOT guess or overwrite, point to `/principal-track:setup`, stop.
- Today's date: `date +%F`.

## Prepare
Topic = `$ARGUMENTS` — a module id (m01–m08) or free text. Free text → map it to the closest module and say which. No argument → suggest the most recently touched in-progress module, or m01. Gather:
- that module's section from `${CLAUDE_PLUGIN_ROOT}/data/curriculum.md`
- Part 1 (pedagogy rules) of `${CLAUDE_PLUGIN_ROOT}/data/rubric.md`
- from state: the module's status and notes, plus weak_topics

## Delegate to the tutor
Subagents can't address Brandon directly — you relay:
1. Spawn the `principal-track:tutor` agent with one context package: topic, curriculum section, pedagogy rules verbatim, module status/notes, weak topics. Tell it Brandon's replies will arrive as follow-up messages and to open with its first probing question.
2. Show the tutor's words to Brandon verbatim — no summarizing, no softening, and never answer on his behalf.
3. Send each of Brandon's replies back to the SAME tutor agent (resume it; don't spawn a fresh one), formatted exactly as `Brandon: "<his words verbatim>"` — the agent is told to trust that prefix. Continue until the tutor closes the session with its build task + explain-back item.
4. Add no teaching of your own between relays.

## Afterwards — one state write
- module: not-started → in-progress; mark solid only if Brandon says it's solid. last_touched = today. Append a ≤1-line note: what was covered, where he struggled.
- session_log: `{date, skill: "learn", summary: "<module>: <one line>"}`.
Write the full JSON to `progress.json.tmp` (same directory), then `mv` over `progress.json`.
Close by echoing the build task and the explain-back item, 2 lines.

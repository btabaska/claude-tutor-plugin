---
name: paper
description: "Tutored read-through of a paper, tech report, model card, or system card. Use whenever Brandon asks to read, digest, or be tutored through one."
argument-hint: "[url | pasted]"
allowed-tools: "Bash(date *), Bash(mv ${CLAUDE_PLUGIN_DATA}*)"
---

Tutor Brandon through a document. Interrogation over summary — he does the thinking, you steer. Follow Part 1 (pedagogy rules) of `${CLAUDE_PLUGIN_ROOT}/data/rubric.md`.

## State
Read `${CLAUDE_PLUGIN_DATA}/progress.json` first.
- Missing → no track state yet; point him to `/principal-track:setup`, stop.
- Invalid JSON → corrupt; quote the error, do NOT guess or overwrite, point to `/principal-track:setup`, stop.
- Today's date: `date +%F`.

## Source
- `$ARGUMENTS` is a URL → WebFetch it. This is the ONLY network call this plugin ever makes, and only because Brandon supplied the URL — fetch nothing else, follow no further links.
- Fetch fails or comes back empty/paywalled → say exactly what happened and ask him to paste the text. Never tutor from a document you couldn't read.
- `pasted` or no argument → ask him to paste it.

## The loop
1. Skim, then list the 5–8 load-bearing claims — claims, not section titles: the things the authors need to be true.
2. Interrogate. For each term or mechanism he may not know cold, ask HIM to define it before you explain; correct crisply only after he commits. ≤150 words between questions.
3. Three comprehension questions, hard → harder: mechanism → implication → "what would break this on your stack?"
4. Close with a memo scaffold: 5 bullets in HIS words, drawn from his answers (placeholder where he was shaky, so he can see the gap), plus one explicit connection to his stack (3090 Ti / llama.cpp / Qwen / OpenCode locally; Claude Code / Agent SDK / MCP / evals at work).

## Log
session_log append: `{date, skill: "paper", summary: "<title or url>: <one line>"}`. Write the full JSON to `progress.json.tmp` (same directory), then `mv` over `progress.json`.

---
name: ship
description: "Mark a track artifact (A1–A10) shipped, with evidence; optionally get a principal-bar review."
disable-model-invocation: true
argument-hint: "[artifact-id or title fragment] [evidence]"
allowed-tools: "Bash(date *), Bash(mv ${CLAUDE_PLUGIN_DATA}*)"
---

Record a shipped artifact for Brandon. This is the good part of the job — one genuine line of credit, no confetti walls.

## State
Read `${CLAUDE_PLUGIN_DATA}/progress.json` first.
- Missing → no track state yet; point him to `/principal-track:setup`, stop.
- Invalid JSON → corrupt; quote the error, do NOT guess or overwrite, point to `/principal-track:setup`, stop.
- Today's date: `date +%F`. Never mark anything shipped he didn't say shipped.

## Match
`$ARGUMENTS` → one artifact, by id (A1–A10, case-insensitive) or fuzzy title match against the artifacts in state (titles also in `${CLAUDE_PLUGIN_ROOT}/data/artifacts.md`). Ambiguous → show the candidates, ask. Already shipped → say when and with what evidence, and ask whether he means to update it.

## Evidence
One line — link, path, or date+context. Not already in the arguments → ask for it. Don't accept empty: the whole point is proof-of-work.

## Write
- artifact: `shipped: true, date: <today>, evidence: "<his line>"`
- session_log append: `{date, skill: "ship", summary: "<id> shipped"}`
- statusline.txt (write `.tmp`, `mv` over): `principal-track · Month <m> · <n>/10 artifacts · weak: <top 1–2, or none>`
Write the full JSON to `progress.json.tmp` (same directory), then `mv` over `progress.json`.

## Close
- One genuine line of credit, the new `<n>/10`, then `next → <first unshipped in this month's set>` (map: 1→A1,A2 · 2→A3,A4,A5,A6 · 3→A7,A8 · 4→A9,A10; month done → first unshipped overall).
- Offer once: a principal-bar critique from the `principal-track:artifact-reviewer` agent. If yes — evidence is a readable local path → pass the agent the file contents plus Part 2 of `${CLAUDE_PLUGIN_ROOT}/data/rubric.md`; it's a URL or unreadable → ask him to paste the artifact text; nothing pasteable → skip the review honestly rather than reviewing a description of the thing. Relay the review verbatim.

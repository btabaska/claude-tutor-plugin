---
name: setup
description: "Create or reset the principal-track progress state via a short interview."
disable-model-invocation: true
argument-hint: "[start-date] [hours/week] — optional, skips those questions"
allowed-tools: "Bash(date *), Bash(mkdir -p ${CLAUDE_PLUGIN_DATA}*), Bash(mv ${CLAUDE_PLUGIN_DATA}*)"
---

Initialize Brandon's principal-track state. He's a peer, not a student: direct, warm, zero fluff. Get today's date with `date +%F`; never fabricate dates or progress.

## Existing state check — do this first
Look at `${CLAUDE_PLUGIN_DATA}/progress.json`:
- Exists and parses → show a 4-line summary (started, current month, artifacts shipped n/10, modules beyond not-started) and ask explicitly: keep it (stop here) or reset? Only reset on a clear yes, and first copy the old file to `progress.json.bak-<today>`.
- Exists but is not valid JSON → say it's corrupt, quote the parse error, and offer the same backup-then-reset choice. Never silently overwrite.
- Missing → proceed.

## Interview — short; any answer already provided in the arguments is not re-asked
1. Start date? (default: today)
2. Weekly hours? (default: 18)
3. Any module already past not-started? Show the eight module names from `${CLAUDE_PLUGIN_ROOT}/data/curriculum.md` and take ratings not-started / in-progress / solid. Skipped = not-started.

## Create state
`mkdir -p "${CLAUDE_PLUGIN_DATA}"`. Write the full JSON to `${CLAUDE_PLUGIN_DATA}/progress.json.tmp`, then `mv` it over `progress.json`. Shape:

```json
{
  "version": 1,
  "operator": "Brandon",
  "started": "<YYYY-MM-DD>",
  "weekly_hours": 18,
  "current_month": 1,
  "modules": {
    "m01": { "status": "not-started", "last_touched": null, "notes": "" },
    "m02": {}, "m03": {}, "m04": {}, "m05": {}, "m06": {}, "m07": {}, "m08": {}
  },
  "artifacts": [ { "id": "A1", "title": "<from artifacts.md>", "shipped": false, "date": null, "evidence": "" } ],
  "quiz_log": [],
  "weak_topics": [],
  "session_log": []
}
```
- All eight modules get the full `{status, last_touched, notes}` shape with his ratings.
- All ten artifacts A1–A10, ids and titles exactly from `${CLAUDE_PLUGIN_ROOT}/data/artifacts.md`.
- If he backdated the start, set current_month to full months elapsed since then (cap 4).

Also write `${CLAUDE_PLUGIN_DATA}/statusline.txt`, one line: `principal-track · Month <m> · 0/10 artifacts`.

## Close
Confirm what was created and where, ≤3 lines. Suggest `/principal-track:today` to plan the first session.

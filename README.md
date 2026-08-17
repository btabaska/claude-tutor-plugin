# principal-track

Personal Claude Code plugin: tutor, quizmaster, and progress tracker for Brandon's 4-month principal-AI-engineer track. Curriculum, plan, and artifact list live in `data/` and are the source of truth; progress lives in the plugin's persistent data directory (`${CLAUDE_PLUGIN_DATA}` → `~/.claude/plugins/data/<id>/`), so it survives plugin updates.

## Install

- Try it: `claude --plugin-dir /path/to/principal-track`
- Keep it: copy this folder to `~/.claude/skills/principal-track/` — auto-loads next session as `principal-track@skills-dir`
- Share it: publish to a marketplace repo, then `claude plugin install principal-track@<marketplace>`

Note: the persistent data directory is keyed by plugin id, which can differ between install methods. If you switch methods and `/principal-track:status` says there's no state, move your old folder under `~/.claude/plugins/data/` to the new id.

## Commands

- `/principal-track:setup` — create or reset progress state (short interview)
- `/principal-track:status` — dashboard: month, modules, artifacts n/10, weak topics, next action
- `/principal-track:today` — time-boxed session plan; the build block advances this month's artifact
- `/principal-track:learn <module|topic>` — Socratic session with the tutor agent
- `/principal-track:quiz [module]` — retrieval practice with the quizmaster agent; updates weak topics
- `/principal-track:paper <url|pasted>` — tutored read-through of a paper / tech report / model card
- `/principal-track:ship <artifact> [evidence]` — mark A1–A10 shipped; optional principal-bar review
- `/principal-track:review` — weekly ritual: shipped, recall, time audit, next week's block

Agents: `tutor` and `quizmaster` (teach, can't touch files), `artifact-reviewer` (scores against `data/rubric.md`). A SessionStart hook prints the one-line statusline when state exists — that's the only hook.

## No dependencies

Plain POSIX shell, no npm, no MCP servers. The only network call is WebFetch inside `/principal-track:paper`, on a URL you supply.

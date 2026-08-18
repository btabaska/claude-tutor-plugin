# principal-track

A Claude Code plugin that acts as a personal tutor, quizmaster, and progress tracker for a 4-month "principal AI engineer" learning track. Built for my own track — a work lane (Claude Code, Agent SDK, MCP, evals in CI) and a local lane (RTX 3090 Ti, llama.cpp, Qwen, OpenCode) — but the machinery is generic: fork it, swap in your own curriculum, run your own track.

The premise: reading doesn't compound, shipping does. Every command ends with something built, recalled, or honestly scored. Progress is proof-of-work — ten artifacts, each needing evidence — and the plugin never invents it: missing or corrupt state stops the ritual and says so instead of guessing.

## The loop

Each session opens with one line of context, printed by a `SessionStart` hook:

```
principal-track · Month 1 · 1/10 artifacts · weak: attention scaling (sqrt d_k)
```

Then the rituals, in the order a week actually uses them:

| Command | What it does |
|---|---|
| `/principal-track:setup` | One-time interview → creates the progress state. Warns before touching existing state. |
| `/principal-track:status` | Dashboard: month + week, module glyphs, artifacts n/10, weak topics, one recommended next action. |
| `/principal-track:today [min]` | Time-boxed session plan. The biggest block always advances this month's ship artifact; a recall block hits your weak topics. |
| `/principal-track:learn <module\|topic>` | Socratic session with the tutor agent — probes before explaining, ≤150 words between questions, ends with a ≤30-minute build task and one concept to explain back tomorrow. |
| `/principal-track:quiz [module]` | Retrieval practice with the quizmaster agent — 5–7 questions, one at a time, no multiple choice, graded 0–2. Misses become tracked weak topics that resurface in later sessions. |
| `/principal-track:paper <url\|pasted>` | Tutored read-through of a paper, tech report, or model card: load-bearing claims, interrogation, then a memo scaffold in *your* words with the gaps left visible. |
| `/principal-track:ship <id> [evidence]` | Mark artifact A1–A10 shipped, with one line of evidence. Offers a principal-bar critique from the reviewer agent. |
| `/principal-track:review` | Weekly ritual: what shipped, recall check on the week's sessions, time audit (reading >45 min/day with nothing shipped → unsubscribe from something), next week's single build block. Advances the month only when the month's ship-gate artifacts are actually done. |

## Install

Requires Claude Code ≥ 2.1.199 (the tutor and quizmaster resume subagent conversations).

```
claude plugin marketplace add btabaska/claude-tutor-plugin
claude plugin install principal-track@btabaska
```

Then, in a new session: `/principal-track:setup`. Update later with `claude plugin marketplace update btabaska` followed by `claude plugin update principal-track`.

Local alternatives: `claude --plugin-dir /path/to/principal-track` for a session, or copy the folder to `~/.claude/skills/principal-track/` to auto-load as `principal-track@skills-dir`.

The first state write asks for permission once (`~/.claude/plugins/data/` is a protected path) — allow it and you're set.

## How it works

```
principal-track/
├── .claude-plugin/     plugin.json + marketplace.json (the repo is its own marketplace)
├── skills/             8 skills — the slash commands above
├── agents/             tutor · quizmaster · artifact-reviewer
├── hooks/              one SessionStart hook (statusline)
├── scripts/            statusline.sh — plain POSIX sh
└── data/               curriculum.md · plan.md · artifacts.md · rubric.md  ← source of truth
```

- **Skills** carry the rituals. `setup` and `ship` are user-invocable only (`disable-model-invocation`), so the model never decides on its own that something shipped. Always-on context cost for the whole plugin is ~585 tokens.
- **Agents**: `tutor` and `quizmaster` teach and can't touch files (`disallowedTools: Write, Edit`); `artifact-reviewer` scores shipped work against the six-dimension rubric in `data/rubric.md` — claim clarity, evidence, tradeoffs, cost, security, actionability, 0–2 each. Subagents can't address the user directly, so the invoking skill relays: agent messages are shown verbatim, and replies go back prefixed `Brandon:` / `Brandon's answer:` — that prefix marks the trusted channel (without it, a defensive agent will halt the round as suspected injection; found the hard way).
- **State** is one JSON file, `${CLAUDE_PLUGIN_DATA}/progress.json`: modules m01–m08, artifacts A1–A10 with evidence, quiz log, weak topics, session log. Every write is atomic (temp file, then `mv`). Corrupt state is quoted, never overwritten, and routed to `/principal-track:setup`. The data directory lives under `~/.claude/plugins/data/<id>/` and survives plugin updates; the `<id>` differs by install method, so if you switch methods, move the folder to the new id.
- **The curriculum drives everything.** `data/curriculum.md` (8 modules with sources), `data/plan.md` (month-by-month with ship gates), and `data/artifacts.md` (the 10 proofs of work) are read by the skills at invocation time — the code never hardcodes what to learn.

## Make it your own track

1. Fork, then rewrite `data/curriculum.md`, `data/plan.md`, and `data/artifacts.md` for your subject and timeline.
2. Re-anchor the stack references — the tutor grounds every concept in concrete hardware and tools. They live in `agents/tutor.md` and Part 1 of `data/rubric.md` (and the operator name is in `skills/setup/SKILL.md`, if you're not a Brandon).
3. The month→artifact maps are one-line lookups inside the `status`, `today`, `ship`, and `review` skills — update them if your artifact numbering changes.
4. `claude plugin validate . --strict` should stay clean, then install from your fork.

## Guarantees

No npm packages, no MCP servers, no telemetry. The only network call is `WebFetch` inside `/principal-track:paper`, on a URL you supply. The hook is plain POSIX shell that prints one line, or nothing. All state stays on your machine.

## License

[MIT](LICENSE)

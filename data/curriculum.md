# Principal Track — Curriculum Data
Two lanes: WORK = frontier/Claude at the company (factory, evals, enablement). LOCAL = 3090 Ti / llama.cpp / Qwen / OpenCode (training, serving, kernels).

## Module 01 — Evals (priority #1, BOTH lanes)
Discipline: error analysis on real traces first, then judges, then gates in CI.
- Free evals email course (Hamel Husain & Shreya Shankar), 17 lessons — https://ai.hamel.dev/eval-course
- AI Evals for Engineers & PMs, Maven cohort (paid, lifetime access) — https://maven.com/parlance-labs/evals
- Reference hub — https://evals.info and https://hamel.dev
- Inspect eval framework (UK AISI) — https://inspect.aisi.org.uk ; promptfoo — https://www.promptfoo.dev ; Arize Phoenix — https://phoenix.arize.com
- Video intro: Lenny's Podcast episode — https://www.youtube.com/watch?v=BsWxPI9UM4c

## Module 02 — Judgment layer (WORK)
- Chip Huyen, "AI Engineering" (O'Reilly) — https://huyenchip.com/books/
- swyx, "The Rise of the AI Engineer" + Latent Space — https://www.latent.space/p/ai-engineer
- AI Engineer conference talk archives — https://www.youtube.com/@aiDotEngineer

## Module 03 — Fundamentals & architecture literacy (LOCAL, run in parallel)
- Stanford CS336 "Language Modeling from Scratch" — https://cs336.stanford.edu ; lectures https://www.youtube.com/playlist?list=PLoROMvodv4rOY23Y0BoGoBGgQ1zmU_MT_
- Raschka, "Build a Large Language Model (From Scratch)" — https://www.manning.com/books/build-a-large-language-model-from-scratch ; code https://github.com/rasbt/LLMs-from-scratch
- Raschka, "The Big LLM Architecture Comparison" — https://magazine.sebastianraschka.com/p/the-big-llm-architecture-comparison
- Karpathy, Zero to Hero — https://karpathy.ai/zero-to-hero.html ; nanochat — https://github.com/karpathy/nanochat
- HF Learn (LLM course, smol-course) — https://huggingface.co/learn ; Labonne LLM course — https://github.com/mlabonne/llm-course ; Umar Jamil — https://www.youtube.com/@umarjamilai
- 3Blue1Brown neural nets — https://www.3blue1brown.com/topics/neural-networks

## Module 04 — Agents & the software factory (WORK, priority)
- Anthropic, "Building Effective Agents" — https://www.anthropic.com/engineering/building-effective-agents
- "Writing effective tools for AI agents" — https://www.anthropic.com/engineering/writing-tools-for-agents
- "Effective context engineering for AI agents" — https://www.anthropic.com/engineering/effective-context-engineering-for-ai-agents
- Anthropic engineering index (harnesses, Agent Skills, sandboxing) — https://www.anthropic.com/engineering
- Anthropic Academy (Claude Code, subagents, MCP, Skills) — https://www.anthropic.com/learn
- Claude Code docs — https://docs.claude.com/en/docs/claude-code/overview ; Agent SDK — https://docs.claude.com/en/api/agent-sdk/overview
- MCP — https://modelcontextprotocol.io ; DeepLearning.AI × Anthropic MCP course — https://www.deeplearning.ai/short-courses/mcp-build-rich-context-ai-apps-with-anthropic/
- OpenCode — https://opencode.ai/docs and https://github.com/sst/opencode (LOCAL mirror)
- Breadth: HF Agents Course — https://huggingface.co/learn/agents-course ; LangGraph Academy — https://academy.langchain.com ; claude-flow — https://github.com/ruvnet/claude-flow

## Module 05 — Post-training: SFT → RL → distillation (LOCAL)
Licensing rule: distill only from open-weight teachers (DeepSeek, Qwen); frontier API terms prohibit training competing models on outputs.
- Unsloth docs — https://unsloth.ai/docs ; LoRA hyperparameters guide — https://unsloth.ai/docs/get-started/fine-tuning-llms-guide/lora-hyperparameters-guide
- Nathan Lambert, "The RLHF Book" — https://rlhfbook.com
- Raschka, "Build a Reasoning Model (From Scratch)" — https://www.manning.com/books/build-a-reasoning-model-from-scratch
- HF TRL — https://huggingface.co/docs/trl ; Axolotl — https://github.com/axolotl-ai-cloud/axolotl ; torchtune — https://github.com/pytorch/torchtune
- Thinking Machines, "On-Policy Distillation" — https://thinkingmachines.ai/blog/on-policy-distillation
- Ultra-Scale Playbook — https://huggingface.co/spaces/nanotron/ultrascale-playbook ; OLMo open recipes — https://allenai.org/olmo

## Module 06 — Inference & serving (LOCAL → WORK)
Heuristic: SGLang RadixAttention wins on prefix-heavy agent traffic; vLLM is the flexible high-throughput default; gap narrows with model size.
- vLLM — https://docs.vllm.ai
- SGLang — https://github.com/sgl-project/sglang
- TensorRT-LLM (awareness) — https://github.com/NVIDIA/TensorRT-LLM

## Module 07 — GPU kernels (LOCAL, Month 4)
Path: Triton first, CUDA when the profiler says so.
- GPU MODE — https://github.com/gpu-mode/lectures ; https://www.youtube.com/@GPUMODE ; Discord https://discord.gg/gpumode ; PMPP textbook via the lectures README
- Triton tutorials — https://triton-lang.org ; Modal GPU Glossary — https://modal.com/gpu-glossary
- Practice: LeetGPU — https://leetgpu.com ; Tensara — https://tensara.org
- Read real kernels: llama.cpp CUDA backend — https://github.com/ggml-org/llama.cpp

## Module 08 — Security & governance (WORK)
- Simon Willison, prompt-injection archive — https://simonwillison.net/tags/prompt-injection/ ; "The Lethal Trifecta" — https://simonwillison.net/2025/Jun/16/the-lethal-trifecta/
- OWASP GenAI / LLM Top 10 — https://genai.owasp.org
- Anthropic engineering: sandboxing & containment posts — https://www.anthropic.com/engineering

## Operating cadence
- Daily ~20 min: TLDR AI (https://tldr.tech/ai) or AlphaSignal (https://alphasignal.ai); star 1–2 on HF Daily Papers (https://huggingface.co/papers); skim r/LocalLLaMA.
- Weekly ~2 h: Interconnects (https://www.interconnects.ai), Ahead of AI (https://magazine.sebastianraschka.com), Simon Willison (https://simonwillison.net); one starred paper with alphaXiv (https://www.alphaxiv.org) as tutor; one Latent Space or Dwarkesh (https://www.dwarkesh.com) episode.
- RULE: reading > 45 min/day with nothing shipped that week → unsubscribe from one thing.

# The Four-Month Plan (15–20 h/wk; work-time counts)
Month 1 — Foundation under load (M01, M02, M03, M04)
  WORK: Factory v0 on Claude Code / Agent SDK — one real multi-agent workflow, MCP tool layer, managed secrets, eval gate in CI. Start evals email course day one.
  LOCAL: CS336 lectures 1–6; fast pass of Raschka LLM book; Huyen alongside.
  SHIP: a pipeline where a failing eval blocks a merge.
Month 2 — Post-training + enablement (M03, M05)
  WORK: Enablement v1 — Academy-based tracks, internal Skills library, office hours.
  LOCAL: QLoRA a Qwen-class model with Unsloth; small GRPO/verifier run; RLHF book alongside.
  SHIP: before/after eval on the fine-tune; "how to read a tech report" memo written as Qwen 3.8 vs Gemma 4.
Month 3 — Serving + security (M06, M08)
  WORK: Hardening sprint — injection red-team of own agents, OWASP pass, sandbox policy; wire cheap local tier into the factory router.
  LOCAL: Weekend H100 rental — Qwen 3.8 27B on vLLM and SGLang vs llama.cpp baseline.
  SHIP: cost-per-token memo; security review doc.
Month 4 — Depth + capstone (M05, M07)
  WORK: Capstone — "State of our AI stack" talk/doc: architecture, evals, costs, security posture, 12-month roadmap.
  LOCAL: First Triton kernel (fused RMSNorm or softmax) benchmarked vs PyTorch; Ultra-Scale Playbook read-through.
  SHIP: kernel benchmark; capstone doc.

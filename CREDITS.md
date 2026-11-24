# Credits

These skills are written from scratch. The ideas behind them come from:

| Idea | Source | License |
| --- | --- | --- |
| File-backed state (project-plan, build-plan, overview, current spec, findings ledger, review receipt, history); feature → implement → check → audit → complete loop; critique gate on specs; stable build-plan IDs; P0-P3 + status ledger; review receipts tied to a commit; approval required for every commit/merge/push | [AI Blueprint](https://github.com/aiblueprinthq/ai-blueprint) by Brad Traversy ([site](https://ai-blueprint.dev/)) | MIT |
| Brainstorm → plan → TDD → review lifecycle; verification before completion | [obra/superpowers](https://github.com/obra/superpowers) | MIT |
| Interview the user one question at a time until shared understanding | [mattpocock/skills](https://github.com/mattpocock/skills) (grill-me) | see repo |
| Skill writing: description says when, Gotchas section, progressive disclosure | Thariq, "Lessons from Building Claude Code: How We Use Skills" | n/a |
| Cross-model review (one lab writes, another reviews); mutation check on tests | Hacker News threads on AI coding workflows, 2025-2026 | n/a |
| Codex review commands and AGENTS.md review guidelines | [OpenAI Codex docs](https://developers.openai.com/codex/skills) | n/a |

`/release`, `/seo`, `/secure`, `/explain`, `/tests` and `/ci` take their scope ideas from AI Blueprint's release, tests, ci, brief and audit commands, Next.js metadata docs, and common OWASP practice; the wording is original.

What this collection changes from AI Blueprint: the independent reviewer is always the other lab's model (Codex ↔ Claude); build steps are test-first with a mutation check; a separate money-rules skill; no runtime CLI, dashboard or config.json (pure markdown skills).

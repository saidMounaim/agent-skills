# Credits

Every skill here is written from scratch. The ideas come from:

| Idea | Source | License |
| --- | --- | --- |
| State in files (project plan, build plan, overview, one active spec, findings ledger, review receipt, history); the spec → build → check → audit → complete loop; stable build-plan IDs; severity and status on findings; receipts tied to a commit; asking before every commit, merge and push | [AI Blueprint](https://github.com/aiblueprinthq/ai-blueprint) by Brad Traversy | MIT |
| Brainstorm → plan → test-first build → review; verify before claiming done | [obra/superpowers](https://github.com/obra/superpowers) | MIT |
| Interviewing the user one question at a time | [mattpocock/skills](https://github.com/mattpocock/skills) | see repo |
| A `design.md` that design skills read | [Hallmark](https://www.usehallmark.com) | MIT |
| How to write skills: descriptions that say when, Gotchas sections | Thariq, "Lessons from Building Claude Code: How We Use Skills" | n/a |
| One model builds, another reviews; breaking code on purpose to test the tests | Hacker News threads on AI coding, 2025-2026 | n/a |

What is different here: the reviewer is a different model from the builder; every build step starts with a test; skills hold no stack-specific commands and read them from one Commands table; there is no CLI, dashboard or config file, only Markdown.

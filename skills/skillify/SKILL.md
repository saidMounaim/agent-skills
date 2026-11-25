---
name: skillify
description: Use inside the agent-skills repo when the user wants to add a skill, adapt an idea from someone else's skill or framework, or turn a correction they keep repeating into a skill. Not for using existing skills.
---

# Skillify

Turns other people's good ideas, and your own repeated corrections, into skills you own.

## Steps

1. **Get the source.** A link, a file, or a description of the repeated mistake. Read it. Note its license.
2. **Take the idea, not the text.** In 3-5 bullets: the problem, when it applies, the key steps, the failure it prevents.
3. **Check for overlap** with `skills/`. Improving an existing skill beats adding a near-copy.
4. **Write `skills/<name>/SKILL.md`** in your own words:
   - `name`: one lowercase word, same as the folder. Avoid names agents already use (`help`, `init`, `status`, `review`, `clear`, `plan`).
   - `description`: when to use it and when not to. The agent decides from this line alone.
   - Body: steps, a template if useful, and **Gotchas** from real failures.
   - Leave out what a model does anyway. Stay under about 120 lines; longer material goes in `references/` or `templates/` inside the skill folder.
   - No stack-specific commands. Read them from the AGENTS.md Commands table.
   - Workflow state lives under `plan/`, like the other skills.
5. **Credit** the source in `CREDITS.md`: link, license, the idea you took.
6. Add the skill to the README table. Run `scripts/check.sh`.
7. **Try it**: in a fresh agent session, describe a task that should trigger it. If it does not load, fix the description.
8. Offer a commit: `skill: add <name>`. After the push, reinstall with the command in the README.

## Gotchas

- Never copy large parts of a source that has no license or forbids reuse. Rewrite the idea.
- One skill, one job. A description that needs "and" three times is two skills.
- When an agent makes the same mistake twice, add a line to that skill's Gotchas.

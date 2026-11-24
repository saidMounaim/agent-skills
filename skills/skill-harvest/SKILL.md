---
name: skill-harvest
description: Use when the user wants to add a new skill to this collection, adapt an idea from someone else's skill or framework (AI Blueprint, Superpowers, Matt Pocock, Anthropic, Vercel), or turn a repeated correction into a skill. Not for using existing skills.
---

# Skill harvest

Turn good ideas from other people's skills, and from your own repeated corrections, into skills you own.

## Steps

1. **Collect the source.** Ask for the link or file. Read it. Note its license (MIT / Apache / none).
2. **Extract the idea, not the text.** In 3-5 bullets: what problem it solves, when it triggers, the key steps, the failure it prevents.
3. **Check for overlap** with existing skills in `skills/`. Prefer improving one over adding a near-duplicate. The core loop is: workflow-init, project-discovery, feature-spec, implement-spec, verify-spec, cross-review, complete-feature (+ debug-isolate, build-status).
4. **Write it in your own words** as `skills/<kebab-name>/SKILL.md`:
   - `name`: kebab-case, same as the folder. Avoid names of built-in agent commands (`status`, `review`, `init`, `help`).
   - `description`: say **when** to use it (and when not). This is what the agent reads to decide.
   - Body: steps, a template if useful, and a **Gotchas** section from real failures.
   - Skip what the model already does by default. Keep under ~150 lines; move long references or templates into `skills/<name>/templates/` or `references/`.
   - If it reads or writes workflow state, use the `plan/` paths the other skills use.
5. **Credit it** in `CREDITS.md`: source link, license, what idea you took.
6. **Test it**: start a fresh agent session, describe a task that should trigger it, and check it loads. Fix the description if it does not.
7. Commit: `skill: add <name>` and push. Reinstall with the command in README.

## Gotchas

- Never paste large parts of a source with no license, or one that forbids reuse. Rewrite the idea.
- One skill = one job. If the description needs "and" three times, split it.
- When the agent makes the same mistake twice in real work, add a line to that skill's Gotchas.

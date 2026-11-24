---
name: feature-spec
description: Use before writing any code for a new feature or a change bigger than a one-line fix. Interviews the user, then writes a spec with acceptance criteria to docs/specs/. Do not use for typo fixes or pure refactors.
---

# Feature spec

Goal: no code starts until the feature has a spec the user approved.

## Steps

1. Read the project context first: CLAUDE.md / AGENTS.md, `docs/specs/` and any domain skill (for example `money-minor-units`).
2. Interview the user **one question at a time**. Only ask questions whose answer changes what gets built. Stop when you can write every acceptance criterion without guessing.
   Cover: who uses it, the happy path, states and transitions, error messages the user sees, permissions (who can see/change what), data that must never change, edge cases.
3. Write `docs/specs/NNN-<slug>.md` using the template below. `NNN` = next number in the folder.
4. Show the spec and ask for approval. Do not plan or code until the user says yes.

## Template

```markdown
# NNN <Feature name>
Status: draft | approved

## Why
One or two sentences.

## Scope
- In: ...
- Out (not now): ...

## Acceptance criteria
- Given ..., when ..., then ...

## Done when
- [ ] <command or check that proves it, e.g. `pnpm test money`>
- [ ] <manual check, e.g. PDF shows tax per rate>

## Edge cases
- ...

## Open questions
- (must be empty before approval)
```

## Gotchas

- Do not fill gaps with your own assumptions. A guess here becomes a wrong design later. Ask.
- "Done when" items must be checkable by running something, not "works well".
- Keep it to one feature. If the interview reveals two features, write two specs.

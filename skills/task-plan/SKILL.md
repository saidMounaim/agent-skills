---
name: task-plan
description: Use after a spec in docs/specs/ is approved and before implementation. Splits the feature into small, test-first tasks and writes docs/plans/. Do not use without an approved spec.
---

# Task plan

## Steps

1. Read the approved spec. If it is not marked approved, stop and run `feature-spec`.
2. Read the code that the feature touches. Name real files, not guesses.
3. Split the work into tasks of roughly 30 minutes or less. Each task must be reviewable as one small diff.
4. Write `docs/plans/NNN-<slug>.md` (same number as the spec) with the template below.
5. Ask the user to review the plan. Suggest sending it to the other agent for review (`cross-review`, plan mode) before coding.

## Template

```markdown
# Plan NNN <Feature name>
Spec: docs/specs/NNN-<slug>.md

## Task 1: <name>
- Files: src/..., tests/...
- Failing test first: <test name and what it asserts>
- Proof: <command that must pass>
- Out of scope: ...

## Task 2: ...

## Risks
- <race conditions, migrations, security>
```

## Gotchas

- Order tasks so the pure logic (calculations, validation) comes before UI.
- A task with no test is a smell. If it really has none (copy, styling), say why.
- Anything not in the spec does not go in the plan. Note it as a follow-up instead.

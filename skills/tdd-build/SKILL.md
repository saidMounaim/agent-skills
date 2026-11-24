---
name: tdd-build
description: Use when implementing a task from docs/plans/. Enforces red-green-refactor, one task at a time, with small commits. Do not use for exploratory spikes the user marked as throwaway.
---

# TDD build

## Loop (per task)

1. **Red**: write the failing test named in the plan. Run it. Show it fails, and that it fails for the right reason (an assertion, not an import error).
2. Commit the test alone: `test: <task>`. From now on the test is locked.
3. **Green**: write the minimal code to pass. Run the task's proof command and paste the real output.
4. **Refactor** if needed, tests still green.
5. Run the full gate: typecheck, lint, all tests. Paste the output.
6. Commit: `feat: <task>`. Tell the user which task is next. Do not start it in the same breath if the context is long; suggest `session-handoff`.

## Mutation check (for important logic)

Temporarily break the code the test covers (return a wrong value, remove a condition). Run the test and show it fails. Restore the code and show it passes. A test that stays green when the code is broken is worthless.

## Gotchas

- **Never edit, skip or weaken a locked test to make it pass.** If the test is wrong, stop and ask the user.
- Do not mock the function under test. Mock only the edges (network, clock, email).
- Do not touch files outside the task. Note unrelated problems for later.
- "It should work" is not proof. Run the command.

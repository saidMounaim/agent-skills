---
name: spec
description: Use to start any feature or fix. Turns the next unchecked plan/build-plan.md item (or a bug or small unplanned change, in fix mode) into one spec in plan/context/current.md with small test-first steps, then stops for approval. Also use to abandon the active spec. Never writes app code.
---

# Spec

One spec at a time. No code until the user approves it.

## Preflight

1. `plan/context/current.md` must be empty (only the stub comment). If a spec is active, stop and show it. The user can continue it (`next`) or say **abandon**: with their yes, move it to `plan/history/` with `--abandoned` in the file name and reset the stub.
2. Pick the target:
   - **Feature**: the first unchecked item in `plan/build-plan.md`, or the ID the user names.
   - **Fix**: a bug or small change the user describes. Not added to the build plan. Cause unknown → `diagnose` first.
   - A new feature that is not in the plan: propose a line at the end of the build plan, wait for a yes.
3. Branch name: `feat/<id>-<short-title>` or `fix/<short-title>`.

## Gather context (keep it small)

- The item's "Feature notes" in `plan/context/overview.md`, plus directly related sections.
- AGENTS.md: Commands, Rules, Gotchas.
- One targeted look at the code the work touches.
- UI work: `design.md` and the item's screen in `plan/references/`.
- Any domain skill that applies (for example `money`).
- Run `verify` (Commands table) once, so the spec records the starting state.

## Interview

Ask one question at a time, and only what would change the build: rules, permissions, error messages, limits, edge cases. If the user is unsure, propose the smallest option.

## Write `plan/context/current.md`

```markdown
# <Title>
**Type:** feature | fix   **Build plan:** <id or none>
**Branch:** <branch>      **Status:** draft
<!-- Status: draft → approved → in-progress → built → verified -->

## Goal
## In scope
## Out of scope
## Data and contracts
(stored data, inputs and outputs of each endpoint / action / function, validation, who may do what)
## UI
(screen reference, states: loading, empty, error, forbidden; "none" if no UI)
## Build steps
- [ ] 1. <small step that leaves the project working>
  - Test first: <test name and what it asserts>
  - Done when: <observable result tied to a command or check>
- [ ] 2. ...
## Files and areas
## Notes for the agent
## Open questions
(must be empty before approval)
```

## Check your draft before showing it

- Every step is one small, reviewable diff and has a test and a checkable "Done when".
- Contracts are concrete and match the existing code.
- Permissions and data ownership are stated (who can see and change what).
- UI states are covered, or UI says "none".
- Nothing outside the build-plan item. No dependency or abstraction that no requirement needs.
- Named files, routes and commands really exist.
- Everything it depends on is already built.

## Then

Show the spec and stop. On approval set **Status:** `approved` and suggest `build`. For risky work (auth, money, data migrations, deletes, permissions) suggest `audit plan` first.

## Gotchas

- Never invent defaults, limits or permissions. An unknown that matters becomes an Open question, and you stop.
- Prefer the smallest design that can be undone.
- After approval, change the spec only when the user asks.

---
name: feature-spec
description: Use to start any feature or fix. Turns the next unchecked plan/build-plan.md item (or a bug / small unplanned change, in fix mode) into one reviewed spec in plan/context/current.md, then stops for approval. Never writes app code.
---

# Feature spec

One spec at a time. No code until the user approves it.

## Preflight

1. `plan/context/current.md` must be empty (only the stub comment). If not, stop: finish or abandon the active spec first (`build-status` shows it).
2. Pick the target:
   - **Feature mode**: the first unchecked item in `plan/build-plan.md`, or the ID the user names. Stop if it is already checked.
   - **Fix mode**: the user describes a bug or a small change. Not added to the build plan. For a bug that is not yet understood, run `debug-isolate` first.
   - New feature not in the plan: propose a build-plan line (at the end), wait for approval, then continue.
3. Attempt number: 1, or one more than the highest archived attempt for this ID in `plan/history/features/`. If history is ambiguous, ask.
4. Branch: `feat/<id>-<kebab-title>` or `fix/<kebab-title>`; add `--build-N` for attempt N > 1.

## Gather context (keep it bounded, about 4 rounds of tool calls)

- The matching "Feature notes" passage in `plan/context/overview.md`, plus directly related sections only.
- One targeted look at the code the feature touches.
- AGENTS.md (Verify command, rules) and any domain skill that applies (e.g. `money-minor-units`).
- Run Verify once, so the spec knows the starting state.

## Interview

Ask the user, one question at a time, only what would change the build: rules, permissions, error messages, edge cases, limits. If the user is unsure, offer the smallest option.

## Spec template (write `plan/context/current.md` once)

```markdown
# <Title>
**Type:** feature | fix   **Build plan:** <id or none>   **Attempt:** <n>
**Branch:** <branch>      **Status:** draft

## Goal
## In scope
## Out of scope
## Data and contracts
(tables/columns, API or server action inputs and outputs, validation, permissions)
## Build steps
- [ ] 1. <small step that leaves the app working>
  - Test first: <test name and what it asserts>
  - Done when: <observable result tied to a command or check>
- [ ] 2. ...
## Files and areas
## Testing
(unit, e2e, manual "Try it now" path)
## Notes for the agent
## Open questions
(must be empty before approval)
```

## Critique gate (run on your draft before writing it)

Check and fix: missing UI states (loading, empty, error, forbidden), contracts that are vague or contradict the code, scope creep, abstractions or dependencies no requirement needs, steps too big for one small diff, data or security behavior left unspecified (who can see/change what), files or routes that do not exist, "Done when" that cannot be checked, prerequisites not built yet.

## Then

Set **Status:** to `draft`, show the spec, and stop. On approval, set it to `approved`. Suggest `cross-review` in plan mode for risky work (auth, money, migrations, deletes).

## Gotchas

- Do not invent defaults, limits or permissions. A material unknown becomes an Open question, and you stop.
- Prefer the smallest reversible design.
- After approval, edit the spec only for requested revisions. Do not quietly rewrite it.
- Never claim test results you did not run.

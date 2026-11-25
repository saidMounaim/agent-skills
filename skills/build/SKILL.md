---
name: build
description: Use to implement the approved spec in plan/context/current.md, step by step and test-first, on the spec's branch. Also use to resume a half-built spec or to fix audit findings. Stops before the final commit and merge, which belong to finish.
---

# Build

## Preflight

- `plan/context/current.md` must hold a spec with **Status:** `approved` or `in-progress`, or any later status that still has unticked steps (a fix round after `audit`). Empty → `spec`. Draft → ask the user to approve it.
- `git status`, current branch. Switch to the spec's **Branch**, creating it if needed. Never change app code on the default branch. Leave unrelated local changes alone.
- Resuming: start at the first unticked step. If a ticked box and the code disagree, ask.
- Set **Status:** `in-progress`.

The spec carries the context. Read code for the current step only.

## For each step

1. **Red.** Write the step's test. Run it. It must fail on its assertion, not on a typo or missing import.
2. **Green.** Make the smallest change that meets the step's "Done when".
3. Run the narrowest check that covers it (that test file or package). Paste the output.
4. Read your own diff: matches the contract, checks permissions and ownership, handles errors, no stray edits.
5. Tick the step.
6. Report in a few lines: what changed, files, check output. Ask: continue, checkpoint commit (only with a yes), or stop.

## Stop and ask when

- the spec does not answer a product decision,
- a step needs a dependency, service or config the spec does not mention,
- the work is growing beyond the spec,
- the same check has failed 3 times.

Propose a change to the spec. Do not improvise.

## After the last step

1. Compare the whole diff with In scope and every "Done when". Remove code no requirement needs. Keep validation and safety checks.
2. Run `verify` from the AGENTS.md Commands table. Paste the real output. Fix failures that are in scope, then rerun.
3. Set **Status:** `built`. Hand off: branch, what changed, checks run, open risks. Next: `verify`.

## Gotchas

- Never edit, skip or weaken an existing test to make it pass. If a test is wrong, stop and ask.
- Do not mock the unit under test. Mock only the edges: network, clock, email, payments.
- For core logic, run one mutation check: break the code on purpose, show the test fails, restore it.
- Database changes: write a migration, never edit the database by hand; say whether it can be rolled back.
- UI: use the tokens and components in `design.md`. No new colors, fonts or spacing values.
- No merge, push or deploy in this skill.

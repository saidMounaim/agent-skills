---
name: build
description: Use to build the approved spec in plan/context/current.md, step by step and test-first, on the spec's branch. Also use to resume a half-built spec. Stops before the final commit and merge, which belong to finish.
---

# Implement spec

## Preflight (one batch of reads)

- `plan/context/current.md`: must exist with **Status:** `approved` (or `in-progress` when resuming). Empty → run `spec`. Draft → ask the user to approve.
- `git status`, current branch, recent log. Check out or create the spec's **Branch**. Never edit `main`/`master`. Keep any unrelated local changes untouched.
- Resume: start at the first unchecked step. Use git status to tell finished from unfinished work; if a box and the code disagree, ask.
- Set **Status:** `in-progress`.

Do not re-read broad project docs: the spec already carries what you need. Look at the code for the current step only.

## Per step

1. **Red**: write the step's test. Run it. Show it fails for the right reason (an assertion, not a typo or import error).
2. **Green**: make the smallest change that meets the step's "Done when".
3. Run the narrowest useful check (that test file, that package). Paste the output.
4. Self-review the diff: contract matches the spec, permissions and user scoping, error handling, no stray edits.
5. Tick the step's box only after its check passes.
6. Report briefly: what changed, files, check output. Ask: continue, checkpoint commit (`feat: checkpoint <step>`, only if the user says yes), walk me through it, or stop.

## Stop and ask instead of improvising when

- a product decision is needed that the spec does not answer,
- the step needs a new dependency, service or config the spec does not allow,
- scope grows noticeably,
- the same check fails 3 times.
Propose a spec revision; do not just do it.

## After the last step

1. Compare the full diff against every In-scope item and every "Done when". Remove speculative code that no requirement needs (but keep real validation and safety).
2. Run the Verify command from AGENTS.md exactly once. Paste the real output. Repair in-scope failures only, then rerun.
3. Set **Status:** `built`. Hand off with: branch, changes by area, checks run, open risks, and next step: `verify`.

## Gotchas

- Never edit, skip or weaken an existing test to make it pass. If a test is wrong, stop and ask.
- Do not mock the function under test. Mock only edges (network, clock, email, payments).
- For core logic, do a mutation check once: break the code on purpose, show the test fails, restore it.
- You never merge, push or deploy in this skill.

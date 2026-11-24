---
name: verify
description: Use after build, or whenever the user asks to prove a feature works. Checks real behavior against every "Done when" in plan/context/current.md and writes a "Try it now" guide for the user. Also use before saying anything is done.
---

# Verify spec

Build output is not proof of behavior. This skill observes the feature actually working.

## Modes

- **verify** (default, "prove it works"): run checks, record evidence.
- **guide** ("how do I test it"): write the manual "Try it now" steps only. A guide is never evidence.

## Verify

1. Read `plan/context/current.md`. List every "Done when" and every In-scope item.
2. For each one, choose the strongest evidence available and actually run it:
   - logic → its tests (name the test, paste the result),
   - API / server action → call it (test or script) and show the response, including a forbidden case for another user,
   - UI → Playwright or the browser tool: open the page, do the flow, report what you saw. If a dev server is needed and you cannot start it, ask the user to start it.
3. Run the Verify command from AGENTS.md. Paste the output.
4. Confirm no test was deleted, skipped (`.skip`, `xit`, `@pytest.mark.skip`) or loosened on this branch: `git diff <base> -- '*test*' '*spec*'`.
5. Write a result table into the spec under `## Verification`:

| Done when | Evidence | Result |
| --- | --- | --- |

6. Add a `## Try it now` section: 3-8 steps the user can follow in the running app (what to open, click, and expect).

## Output

End with exactly one line:

- `VERIFIED`: all criteria passed. Set **Status:** `verified`. Next: `audit`.
- `FAILED`: which criteria, the evidence, and the next step (usually back to `build`).

## Gotchas

- Never report a result you did not run. If something cannot run here, mark it `not run` and say why; that is not a pass.
- "0 tests" or an empty suite is a failure.
- A demo or a guide does not count as verification.

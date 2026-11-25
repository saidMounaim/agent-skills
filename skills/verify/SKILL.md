---
name: verify
description: Use after build, or when the user asks to prove a feature works. Checks real behavior against every "Done when" in plan/context/current.md, compares UI with its screen reference, and writes a "Try it now" guide. Use before saying anything is done.
---

# Verify

Passing a build is not proof that the feature works. This skill watches it work.

## Steps

1. Read `plan/context/current.md`. List every "Done when" and every In-scope item.
2. For each one, run the strongest evidence you can:
   - logic → its tests (name the test, paste the result),
   - endpoint / action / command → call it and show the response, including one forbidden case (another user's data, bad input),
   - UI → drive the real app with a browser or device tool (Playwright, the agent's browser tool, a simulator). Report what you saw. If you cannot start the app, ask the user to start it.
3. UI with a screen in `plan/references/`: take screenshots at a desktop and a phone width, compare with the reference, list the differences. Small pixel differences are fine; wrong layout, missing elements or off-token colors are not.
4. Run `verify` from the AGENTS.md Commands table, and `e2e` if it is separate. Paste the output.
5. Check that no test was deleted, skipped or loosened on this branch: diff the test files against the base branch.
6. Add to the spec:

```markdown
## Verification
| Done when | Evidence | Result |
| --- | --- | --- |

## Try it now
1. <what to open or run>
2. <what to do>
3. <what you should see>
```

## Output

End with one line:

- `VERIFIED`: every item passed. Set **Status:** `verified`. Next: `audit`.
- `FAILED`: which items, the evidence, and the next step (usually `build`).

## Gotchas

- Never report a result you did not run. Something that cannot run here is `not run`, with the reason. That is not a pass.
- Zero tests, or an empty suite, is a failure.
- The "Try it now" guide is for the user. It is not evidence.

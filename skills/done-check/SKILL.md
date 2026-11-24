---
name: done-check
description: Use before saying a task, feature or fix is done, finished, working or ready to commit or merge. Runs every proof and blocks completion on any failure.
---

# Done check

A thing is done only when every check below has been **run in this session** and the output shown.

## Checklist

1. Every "Done when" item in the spec: run it, paste the result, tick it.
2. Project gate: typecheck, lint, unit tests, build. (Look up the exact commands in CLAUDE.md / AGENTS.md / package.json.)
3. If there is UI: start the app and exercise the feature (Playwright or the browser tool if available). Report what you saw.
4. `git diff --stat` against the base branch: confirm only files from the plan changed.
5. Confirm no test was deleted, skipped (`.skip`, `xit`, `@pytest.mark.skip`) or loosened in this branch.

## Output

End with exactly one of:

- `DONE`: all checks passed (list them).
- `BLOCKED`: what failed, the output, and the next step.

## Gotchas

- Never report a command result you did not run. If a command cannot run here, say so.
- An empty test suite or "0 tests" is a failure, not a pass.
- Open serious findings from `cross-review` (P0/P1) mean BLOCKED.

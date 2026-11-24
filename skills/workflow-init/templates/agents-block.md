## Workflow

This repo uses a spec-driven loop. State lives in `plan/`.

- Verify command: `<VERIFY_COMMAND>`. Run it before saying anything is done; paste the real output.
- Loop: `feature-spec` → user approves → `implement-spec` → `verify-spec` → `cross-review` → `complete-feature`.
- One active spec at a time, in `plan/context/current.md`. Nothing is built that is not in it.
- Never work on `main`. Each spec names its branch.
- Never commit, merge or push without the user's explicit yes for that action.
- Never edit, skip or weaken an existing test to make it pass. Fix the code or ask.
- Never claim a check ran if it did not.
- Read `plan/context/overview.md` only for the sections the task needs.

## Review guidelines

- P0: wrong money or data, data loss, cross-user access, secrets in code or logs.
- P1: missing input validation, broken contract with the spec, fake or weak test, unhandled error path.
- Ignore style issues the linter covers.

## Gotchas

- (add a line every time an agent makes the same mistake twice)

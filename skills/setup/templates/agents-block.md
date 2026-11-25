## Workflow

This repo uses a spec-driven loop. All state lives in `plan/`.

`spec` → user approves → `build` → `verify` → `audit` → `finish`. Ship: `secure` → `seo` → `release`. Lost: `next`.

## Commands

| Task | Command |
| --- | --- |
| install | `<...>` |
| dev | `<...>` |
| typecheck | `<...>` |
| lint | `<...>` |
| test | `<...>` |
| e2e | `<...>` |
| build | `<...>` |
| deps-audit | `<...>` |
| migrate | `<...>` |
| **verify** | `<all checks chained>` |

## Rules

- One active spec at a time, in `plan/context/current.md`. Nothing is built that is not in it.
- App code is never changed on the default branch. Each spec names its branch. Files under `plan/` may be committed on the default branch.
- Never commit, merge, push, deploy or run production migrations without the user's explicit yes for that action.
- Tests first. Never edit, skip or weaken an existing test to make it pass. Fix the code or ask.
- Never claim a check ran if it did not. Paste real output.
- Run `verify` before saying anything is done.
- UI work follows `design.md` and the screens in `plan/references/` when they exist.
- Read `plan/context/overview.md` only for the sections the task needs.
- Tiny changes (typo, copy, comment, one-line config with no behavior change) skip the loop: branch, change, `verify`, commit with the user's yes.

## Review guidelines

- P0: wrong data or money, data loss, cross-user access, secrets in code or logs.
- P1: missing input validation, broken contract with the spec, fake or weak test, unhandled error path.
- Ignore style issues the linter covers.

## Gotchas

- (add a line every time an agent makes the same mistake twice)

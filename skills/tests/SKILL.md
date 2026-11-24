---
name: tests
description: Use when a project has no test runner, a broken one, or needs browser (end-to-end) tests. Sets up unit tests (Vitest by default) or Playwright, with one real passing test, and wires them into the Verify command. Not for writing feature tests, which happen in build.
---

# Tests

## Modes

- `tests` (default): unit/integration runner.
- `tests browser`: Playwright end-to-end.

## Unit (default)

1. Detect what exists (package.json scripts, config files). If a runner already works, stop and say so.
2. Pick the runner that fits the stack: Vitest for Vite/Next.js/TS, Jest only if the repo already uses it, pytest for Python. Ask before adding a dependency.
3. Install, add config, and add scripts: `test` (run once) and `test:watch`.
4. Write **one real test** against existing logic (a pure function), not `expect(true).toBe(true)`.
5. Run it and paste the output. Then run the mutation check: break the function, show the test fails, restore.
6. Add the test command to the Verify command in AGENTS.md.

## Browser

1. Install Playwright (`pnpm create playwright` or equivalent), Chromium only to start.
2. Configure `webServer` in `playwright.config.ts` so tests start the app themselves.
3. Write one smoke test: open the home page, assert a real heading, and one key flow if it exists (log in, open dashboard).
4. Add `e2e` script and add it to Verify (or to CI only, if it is slow; say which).
5. Run and paste the output.

## Gotchas

- An empty suite or a placeholder test is not "tests set up".
- Do not put secrets in test config. Use `.env.test` with fake values and add it to `.gitignore` if it holds anything real.
- Keep test data isolated: a separate test database or transactions rolled back per test.

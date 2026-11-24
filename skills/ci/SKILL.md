---
name: ci
description: Use to set up or fix continuous integration. Makes one Verify command that runs the same checks locally and in GitHub Actions on every push and pull request. Use when the user says CI, GitHub Actions, or checks.
---

# CI

Goal: the exact same Verify command passes on your machine and in CI. No surprises at merge time.

## Steps

1. Read the Verify command from AGENTS.md. If missing, build it from package scripts: `typecheck && lint && test && build`. Make it one script, e.g. `"verify": "pnpm typecheck && pnpm lint && pnpm test && pnpm build"`.
2. Run `pnpm verify` locally. It must pass before writing CI. Paste the output.
3. Write `.github/workflows/verify.yml`:
   - triggers: `pull_request` and `push` to the default branch,
   - `actions/checkout`, `pnpm/action-setup`, `actions/setup-node` with the repo's Node version and pnpm cache,
   - `pnpm install --frozen-lockfile`, then `pnpm verify`,
   - a Postgres `services:` block only if tests need a database, with env vars from the workflow (never real secrets),
   - Playwright as a separate job if e2e exists (install browsers, upload the report on failure),
   - `concurrency` to cancel outdated runs on the same branch.
4. List every env variable CI needs. Fake values go in the workflow; real ones are GitHub secrets the user adds (give the exact names, never values).
5. Update AGENTS.md: `Verify command: pnpm verify (also runs in CI)`.
6. Offer a commit. After push, ask the user to check the Actions tab, or read it with `gh run watch`.

## Gotchas

- Pin the Node and pnpm versions to what the repo uses (`.nvmrc`, `packageManager`).
- Do not add deploy steps here. Deploy readiness is `release`.
- Suggest branch protection on the default branch (require the Verify check). The user turns it on in GitHub settings.

---
name: release
description: Use to prepare a deploy or a version release on any host (Vercel, Netlify, Render, Railway, Fly, a VPS, Docker, an app store). Checks readiness, env variables and migrations, then writes the changelog, version bump, release checklist and rollback plan. It never deploys, pushes or runs production migrations itself.
---

# Release

Makes the deploy boring. The user presses the button.

## 1. Readiness (stop at the first failure)

- On the default branch, clean tree, in sync with the remote.
- No unfinished spec in `plan/context/current.md`.
- No `open` or `fixed` P0/P1 in `plan/context/findings.md`. Suggest `secure` if it has not run since the last release, and `seo` if public pages changed.
- `verify` from the AGENTS.md Commands table passes now. Paste the output. CI is green on the latest commit.
- A production build starts locally and its health check answers.

## 2. Configuration

1. Read the Deployment section of `plan/project-plan.md`. Ask for anything missing (host, region, domain).
2. List every env variable the code reads. Compare with the example env file. Show a table: name, required, used where, set on the host (the user confirms). Never print values.
3. Database: list pending migrations. Check that the version now running still works after they run (no dropped column it still uses). Write the exact command (`migrate` row) and whether it runs before or after the deploy. Confirm a backup exists.
4. Host settings: build command, start command, runtime version, health check, scheduled jobs, workers. Create or change the host's config file only if needed, and show the diff.

## 3. Release notes

1. Version: propose a semver bump from the specs archived since the last tag. The user confirms.
2. Update `CHANGELOG.md` (Added, Changed, Fixed) in words a user understands.
3. Write `plan/releases/<version>.md`:

```markdown
# Release <version> (<date>)
## Changes
## Env variables to add or change
## Migrations (command, order)
## Deploy steps
## Smoke test (5 checks on the live app)
## Rollback (exact steps)
```

## 4. Hand off

Show the checklist. Offer, each with its own yes: commit `chore(release): <version>`, tag `v<version>`, push. The user deploys. Then offer to run the smoke test on the live URL.

## Gotchas

- Never deploy, run production migrations or change host settings yourself.
- Values built into the client at build time need a rebuild to change.
- App stores: note review time, version and build numbers, and screenshots in the checklist.

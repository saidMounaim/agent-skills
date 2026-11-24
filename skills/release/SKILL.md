---
name: release
description: Use to prepare a deploy or a version release (Vercel, Render, Railway, Fly, a VPS). Checks readiness, writes the release checklist, changelog and rollback plan, and bumps the version. It never deploys, pushes or runs production migrations by itself.
---

# Release

Prepares everything so the deploy is boring. The user presses the deploy button.

## 1. Readiness gates (stop on the first failure)

- On the default branch, clean tree, up to date with the remote.
- No active spec in `plan/context/current.md`, or it is finished.
- No open or fixed P0/P1 in `plan/context/findings.md`. Suggest `secure` if it has not run since the last release.
- Verify command passes now (paste output). CI is green on the latest commit (`gh run list -L 1`).
- Production build runs locally: `pnpm build && pnpm start`, and the health check path responds.

## 2. Configuration

1. Read the Deployment section of `plan/project-plan.md`. Ask for missing facts (host, region, domain).
2. List every env variable the app reads (grep `process.env` / config). Compare with `.env.example`. Output a table: name, required, where it is used, set in host (user confirms). Never print values.
3. Database: pending migrations listed; confirm they are backwards compatible (no dropping a column the running version uses). Write the exact migration command and when to run it (before or after the deploy). Confirm a backup exists.
4. Host config: build command, start command or output dir, Node version, health check path, cron jobs, background workers, image/domain allowlists. Create or update the host file (`vercel.json`, `render.yaml`, `Dockerfile`, `fly.toml`) only if needed, and show the diff.

## 3. Release notes

1. Version: semver bump based on the archived specs since the last tag (`plan/history/` and `git log <last-tag>..HEAD`). Ask the user to confirm.
2. Update `CHANGELOG.md` (Added / Changed / Fixed, user-facing words).
3. Write `plan/releases/<version>.md`:

```markdown
# Release <version> (<date>)
## Changes
## Env vars to set / change
## Migrations (command, order)
## Deploy steps
## Smoke test after deploy (5 checks on the live URL)
## Rollback (exact steps: redeploy previous build, migration down or forward-fix)
```

## 4. Hand off

Show the checklist. Offer: commit `chore(release): <version>`, tag `v<version>`, push: **each only with the user's explicit yes**. Then the user deploys. Offer to run the smoke test against the live URL with Playwright afterwards.

## Gotchas

- Never deploy, run production migrations, or change host settings yourself.
- `NEXT_PUBLIC_*` values are baked in at build time: changing them needs a rebuild.
- If SEO matters for the site, run `seo` before the first public release.

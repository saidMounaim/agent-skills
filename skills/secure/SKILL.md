---
name: secure
description: Use for a whole-project security pass before a release, after auth, payment or permission work, or when the user asks about security. Checks sign-in, permissions, input handling, secrets, dependencies and configuration, and records findings in plan/context/findings.md. Does not change app code.
---

# Secure

Writes findings only. Fixes go through `spec` (fix mode) and `build`.

## Checklist

1. **Sign-in**: sessions or tokens expire and can be revoked, password reset and email verification are safe, login and signup are rate limited.
2. **Permissions**: every read and write is checked on the server and limited to the current user or tenant. For each main entity, try to read and change another user's record with a test or script. Never touch real data.
3. **Input**: every endpoint, action and command validates its input. No queries built by joining strings. File uploads check type, size and where they are stored.
4. **Output**: no stack traces or internal details sent to clients. User content is escaped where it is shown.
5. **Secrets**: none in the repo or its history, env files are ignored by git, server-only keys never reach the client or the app bundle. Report where and what kind, never the value.
6. **Dependencies**: run the `deps-audit` row of the AGENTS.md Commands table. List high and critical issues with the fixed version.
7. **Configuration**: HTTPS only, safe cookie flags, security headers (CSP, frame rules), CORS limited for signed-in routes, debug mode off in production.
8. **Data**: personal data is not logged, backups exist (ask), records the business must keep are not hard-deleted.
9. **Mobile or desktop apps**: nothing sensitive in plain local storage, no secrets in the shipped binary.

Run any security scanner the repo or the agent has (Semgrep, CodeQL, a security skill) and include its results.

## Record

Add each issue to `plan/context/findings.md` in the same format as `audit`, found by `secure`, using and raising `Next ID`. P0 means it can be exploited now.

Finish with: count per severity, what you could not check and why, and the order to fix things in.

## Gotchas

- A check you could not run is a gap, not a pass.
- Never attack production or services you do not own.
- A pass over one area only is recorded as partial.

---
name: secure
description: Use for a full security pass before a release, after auth/payment/permission work, or when the user asks about security. Reviews authentication, authorization, input handling, secrets, dependencies and headers across the whole app, and records findings in plan/context/findings.md. Read-only on app code.
---

# Secure

Read-only on app code. Writes findings only. Fixes go through `spec` (fix mode) → `build`.

## Checklist

1. **Auth**: session handling, password reset, email verification, rate limits on login and signup, logout really ends the session.
2. **Authorization**: every read and write is scoped to the current user/tenant on the server. Try one route per entity with another user's ID (write a test or script; do not touch real data).
3. **Input**: every server action / API route validates input (Zod or equivalent). No raw SQL with string building. File uploads: type, size, storage path.
4. **Output**: no stack traces or internal IDs leaked to clients. User HTML is escaped (no unsanitized `dangerouslySetInnerHTML`).
5. **Secrets**: none in the repo or git history (`git log -p | grep -iE "secret|api_key|password"` as a quick scan), `.env*` in `.gitignore`, server-only keys never in `NEXT_PUBLIC_*`. Report location and type only, never the value.
6. **Dependencies**: `pnpm audit --prod` (or npm/yarn equivalent). List high/critical with the fix version.
7. **Headers and config**: HTTPS only, secure + httpOnly + sameSite cookies, CSP, `X-Frame-Options`/`frame-ancestors`, CORS not `*` for authenticated routes.
8. **Data**: PII not logged, backups exist (ask), deletes are soft where the business needs history (invoices).

If the Trail of Bits skills or Semgrep/CodeQL are installed, run them and include their results.

## Record

Add each issue to `plan/context/findings.md` (same format and IDs as `audit`, found by `secure`). P0 = exploitable now. Summarize: counts by severity, what was not checked and why, suggested fix order.

## Gotchas

- Missing tools are gaps, not passes. Say what you could not check.
- Do not run attacks against production or third-party services.
- A focused pass (one area) is labelled partial.

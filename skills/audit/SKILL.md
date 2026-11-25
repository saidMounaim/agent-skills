---
name: audit
description: Use after verify, after fixing findings, or on a risky spec before coding (audit plan). Gets an independent review from the other AI model (Codex reviews Claude's work, Claude reviews Codex's) in a fresh context, and records findings in plan/context/findings.md and a receipt in plan/context/review.md.
---

# Audit

The builder does not review its own work. Another model, in a fresh context, does.

## Scope

- **diff** (default): everything on the spec's branch since it left the default branch, plus the code that calls it.
- **plan**: the spec in `plan/context/current.md`, before any code. No commit needed.
- **full**, or a path: when the user asks.

## 1. Prepare

1. Diff scope: the work must be committed, because the receipt names one commit. If it is not, show the diff and ask for a checkpoint commit.
2. Note the commit SHA and the base branch.

## 2. Run the reviewer

Give the reviewer this brief (fill in the brackets):

```
You are an independent senior reviewer. Read-only: do not edit any file.
Scope: [git diff <base>...<sha> and the code that calls it | the spec in plan/context/current.md].
Spec: plan/context/current.md. Rules: AGENTS.md "Review guidelines". Design: design.md if present.
Check: correctness against the spec; security (permissions, data ownership, input validation,
injection, secrets); performance (queries in loops, unbounded work, race conditions);
tests (gaps, weak assertions, skipped tests, mocking the unit under test).
For each finding give: severity P0-P3, file:line, why it matters, a failing scenario, the smallest fix.
Real defects only. No style comments. End with "VERDICT: PASS" or "VERDICT: CHANGES".
```

- You are Claude Code → run Codex: `codex exec "<brief>"`
- You are Codex → run Claude Code: `claude -p "<brief>"`
- Another agent → use any second model's CLI the same way.

**No second model available?** Tell the user. With their OK, run the brief in a fresh context of the same tool (a subagent or a new process) and mark the receipt `independence: same-model`. That is weaker; say so.

## 3. Record

1. Add each finding to `plan/context/findings.md`, using the `Next ID` in its header, then raise `Next ID`. IDs are never reused.

```markdown
### F-04 · P1 · open · <short title>
- File: <path:line>
- Found: <date> by <reviewer> (<scope> @ <sha>)
- Why: <what goes wrong, for whom>
- Fix: <smallest fix>
- Resolution:
```

2. Earlier findings marked `fixed` become `closed` only if this review looked at that code and found the fix sound.
3. Write the receipt in `plan/context/review.md`: reviewer, independence (`cross-model` or `same-model`), scope, commit SHA, date, verdict, count per severity.

## 4. Act on findings

For each one, say whether it is valid and why. Reviewers are wrong sometimes.

- Valid P0 or P1 → add a build step to the spec (test first), then `build` → `verify` → `audit` again. Mark it `fixed` when repaired.
- Not valid → mark `invalid` with the reason.
- Only the user can mark a finding `accepted`.

After 3 rounds without agreement, stop and let the user decide.

## Gotchas

- A receipt stays valid while nothing outside `plan/` has changed since its commit: `git diff --quiet <sha> HEAD -- . ':(exclude)plan'` and a clean tree outside `plan/`.
- Never put secret values in a finding. Give the location and the kind of secret.
- A review of one area only is recorded as partial.

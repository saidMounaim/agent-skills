---
name: cross-review
description: Use after a plan is written or a task passes done-check, before commit or merge. Gets an independent review from a different AI model (Codex reviews Claude's work, Claude reviews Codex's work) and processes the findings.
---

# Cross-model review

The model that wrote the code shares its own blind spots. Get the review from the **other** agent, in a fresh context.

## 1. Run the review

If you are Claude Code, the reviewer is Codex:

```bash
# diff review (read-only)
codex exec review --base main
codex exec review --uncommitted

# adversarial brief
codex exec "Review the diff vs main against <spec path> and the Review guidelines in AGENTS.md. \
Try to break it. For each finding: severity P0/P1/P2, file:line, a failing scenario, the smallest fix. \
Real defects only, no style. End with PASS or ISSUES."

# plan review (before coding)
codex exec "Read <spec> and <plan>. List missing edge cases, race conditions, security holes and \
tasks that are too big. Do not write code. End with PASS or ISSUES."
```

If you are Codex, the reviewer is Claude Code:

```bash
claude -p "Review the git diff vs main against <spec path> and AGENTS.md review rules. \
Read-only, do not edit files. Findings as severity P0/P1/P2, file:line, failing scenario, smallest fix. \
End with PASS or ISSUES."
```

If the other CLI is not installed, say so and stop. Do not review your own work and call it a cross-review.

## 2. Process the findings

For each finding:

1. Decide if it is valid. Explain why in one line.
2. Valid: write a failing test that shows the bug, then fix it (`tdd-build`).
3. Invalid: explain why and leave it.

## 3. Repeat

Re-run the review until PASS with no P0/P1. Stop after 3 rounds and hand the disagreement to the user.

## Severity

- P0: wrong data or money, data loss, security or cross-user access, broken invariant. Blocks merge.
- P1: missing validation, fake or weak test, unhandled error path, secrets or PII in logs. Fix before merge.
- P2: readability and small refactors. Optional.

## Gotchas

- Reviewers hallucinate too. Findings are input, not orders.
- Give the reviewer the spec, otherwise it reviews against its own idea of the feature.
- Ask for real defects only. Style is the linter's job.

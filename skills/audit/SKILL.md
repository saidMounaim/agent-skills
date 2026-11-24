---
name: audit
description: Use after verify, after fixing review findings, or on a risky spec before coding. Gets an independent review from the OTHER AI model (Codex reviews Claude's work, Claude reviews Codex's) in a fresh context, records findings in plan/context/findings.md and a receipt in plan/context/review.md.
---

# Cross-model review

The builder never reviews its own work and calls it independent. The other lab's model, in a fresh context, does.

## Scope

- **diff** (default): the active work item: branch changes since the merge base, staged/unstaged edits, untracked source files, and nearby callers.
- **plan**: the spec in `plan/context/current.md` before coding.
- **full** or a path: on request.

## 1. Prepare the request (builder)

1. Make sure the work to review is committed. If not, show the diff and ask for a checkpoint commit (needs the user's yes). The receipt is tied to one commit.
2. Write the request into `plan/context/review.md`: scope, commit SHA, spec path, date, status `pending`.

## 2. Run the reviewer (the other agent)

If you are Claude Code, the reviewer is Codex:

```bash
codex exec "You are an independent senior reviewer. Read-only: do not edit files.
Scope: git diff <merge-base>..<sha> plus nearby callers. Spec: plan/context/current.md.
Rules: AGENTS.md 'Review guidelines'. Existing ledger: plan/context/findings.md (do not just re-check it; review fresh).
Lenses: correctness vs spec, security (authz, user scoping, input trust, injection, secrets),
performance (N+1, unbounded work, races), tests (gaps, weak asserts, skips, mocks of the unit under test).
For each finding: severity P0-P3, file:line, why it matters, a failing scenario, the smallest fix.
Real defects only, no style. End with: VERDICT: PASS or VERDICT: CHANGES."
```

Quick alternative for diff scope: `codex exec review --base <base-branch>`.

If you are Codex, the reviewer is Claude Code:

```bash
claude -p "<same brief as above>"
```

If the other CLI is not installed or not logged in, stop and tell the user. Do not fall back to self-review.

## 3. Record

1. Add each finding to `plan/context/findings.md`:

```markdown
### F-04 · P1 · open · Missing ownership check on getInvoice
- File: src/app/invoices/[id]/page.tsx:18
- Found: 2026-11-24 by codex (diff review @ e4f5g6h)
- Why: any logged-in user can open another user's invoice by ID
- Fix: scope the query by business_id of the session user
- Resolution:
```

2. Next free ID (F-01, F-02...). Never reuse or renumber.
3. Re-checked findings: `fixed` → `closed` only when the review covered that file and confirms the fix with no new defect. Wrong findings → `invalid` with a reason.
4. Write the receipt into `review.md`: reviewer (codex / claude), scope, commit SHA, verdict, counts by severity.

## 4. Act

For each new finding: say whether it is valid and why (reviewers hallucinate too).
- valid P0/P1 → add a build step to the spec, fix it test-first with `build`, mark `fixed`, then run audit again.
- invalid → mark `invalid` with the reason.
- the user may mark a finding `accepted`; you never do.

Stop after 3 rounds of disagreement and let the user decide.

## Gotchas

- A receipt is valid only for its commit. Any new commit makes it stale.
- Never paste secrets into findings. Report category and location only.
- A focused review (one lens) is labelled as partial. Missing tools are gaps, not passes.

---
name: build-status
description: Use when the user asks where the project stands, what is next, or starts a new session and wants to resume. Read-only summary of plan/ state, git state and blockers, ending with the one next command.
---

# Build status

Read-only. Changes nothing.

## Read (one batch)

- `plan/build-plan.md`: checked vs unchecked items.
- `plan/context/current.md`: active spec, its Status, ticked vs unticked steps.
- `plan/context/findings.md`: open or fixed P0/P1.
- `plan/context/review.md`: latest receipt and the commit it covers.
- `git status`, current branch, `git log -5 --oneline`.

## Report

```
Progress: 3/9 features done (1, 2, 3)
Active: 4. Draft invoices — in-progress, steps 2/5, branch feat/4-draft-invoices
Blockers: F-03 P1 open (missing Zod validation on saveDraft)
Review: stale (receipt for a1b2c3d, HEAD is e4f5g6h)
Drift: <spec steps ticked but uncommitted, or code changed outside the spec, or overview older than the plans>
Next: implement-spec (resume at step 3)
```

## Next-command rules

- No `plan/` folder → `workflow-init`.
- Empty plans → `project-discovery`.
- No active spec → `feature-spec` (next item: <id>).
- Spec draft → user approves it.
- approved / in-progress → `implement-spec`.
- built → `verify-spec`.
- verified, no valid review → `cross-review`.
- open/fixed P0/P1 → `implement-spec` to fix, then `cross-review`.
- verified + passing current review → `complete-feature`.

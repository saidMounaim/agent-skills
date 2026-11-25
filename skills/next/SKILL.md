---
name: next
description: Use when the user asks where the project stands, what to do next, or starts a new session and wants to resume. Read-only summary of the plan/ files and git state, ending with the one skill to run next.
---

# Next

Changes nothing.

## Read

- `plan/build-plan.md`: ticked and unticked items.
- `plan/context/current.md`: the active spec, its Status, ticked and unticked steps.
- `plan/context/findings.md`: open or fixed P0/P1.
- `plan/context/review.md`: the latest receipt and its commit.
- AGENTS.md Commands table. `git status`, current branch, last 5 commits.

## Report

```
Progress: 3/9 features done (1, 2, 3)
Active:   4. Draft invoices — in-progress, steps 2/5, branch feat/4-draft-invoices
Blockers: F-03 P1 open (no input validation on saveDraft)
Review:   out of date (receipt covers a1b2c3d, code changed since)
Drift:    <ticked steps with no code, code changed outside the spec, overview older than the plans>
Next:     build (resume at step 3)
```

## Which skill is next (first match wins)

| State | Next |
| --- | --- |
| No `plan/` folder | `setup` |
| Plans empty, or no overview | `discover` |
| Active spec is `draft` | the user approves it (or `audit plan` for risky work) |
| `approved` or `in-progress`, or unticked steps | `build` |
| `built` | `verify` |
| `verified`, open or fixed P0/P1 | `build` (add fix steps) |
| `verified`, no valid receipt | `audit` |
| `verified`, valid PASS receipt | `finish` |
| No active spec, unticked build-plan items | `spec` (name the item) |
| Everything ticked, or the user wants to ship | `secure` → `seo` (public web pages only) → `release` |

Also mention once, without blocking: no test runner → `tests`; no CI → `ci`; UI project without `design.md` → `design`.

A receipt is valid while nothing outside `plan/` has changed since its commit.

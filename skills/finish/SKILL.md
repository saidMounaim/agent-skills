---
name: finish
description: Use when the active spec is verified and audited and the user wants to close it. Runs the final gates, archives the spec and its findings to plan/history, ticks the build plan, resets the context files, then commits and merges only with explicit approval.
---

# Finish

## Gates (stop at the first failure and name the skill to run)

1. You are on the spec's **Branch**, not the default branch, with no unrelated changes.
2. **Status:** is `verified` and every build step is ticked. → `build`, `verify`
3. `verify` from the AGENTS.md Commands table passes now. Paste the output.
4. `plan/context/review.md` has a `PASS` receipt that is still valid (nothing outside `plan/` changed since its commit). → `audit`
   - `same-model` receipts are not enough for auth, money, data migrations, deletes or permissions, unless the user says so explicitly.
   - The user may skip the audit for low-risk work by saying so. Never skip it yourself.
5. No `open` or `fixed` P0/P1 in `plan/context/findings.md`. → `build`, `audit`

## Archive

1. Copy the spec to `plan/history/features/<id>-<short-title>.md`, or `plan/history/fixes/<date>-<short-title>.md` for a fix. If the name exists, add `-2`.
2. Append the resolved findings (`closed`, `accepted`, `invalid`) and the review receipt to that file.
3. Read the archive back to confirm it is complete.
4. Feature: tick its line in `plan/build-plan.md`. Tick a parent item only when all its sub-items are ticked.
5. If the feature ended up different from its "Feature notes" in `plan/context/overview.md`, update that passage in one or two lines.
6. Reset `current.md` and `review.md` to their stubs. In `findings.md`, remove the archived entries, keep unresolved ones, and keep the `Next ID` line.

## Commit and land (ask before each action)

1. Show a diff summary and the commit message, for example `feat(4): draft invoices with live totals`. Commit after a yes.
2. Ask how to land it:
   - **Merge locally**: squash-merge into the default branch. Pushing is a separate question.
   - **Pull / merge request**: push the branch and open it (`gh pr create`, `glab mr create`, or give the user the link). Include the summary, checks run and the review receipt. Never merge it yourself.
3. After the merge, suggest deleting the branch, then `next`.

## Gotchas

- "Looks good" about the code is not a yes to commit or merge. Ask for each.
- Never mark a finding accepted on the user's behalf.
- One work item becomes one commit on the default branch.
- If a previous finish was interrupted, check the archive and the git log before repeating a step.

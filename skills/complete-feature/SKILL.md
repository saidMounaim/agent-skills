---
name: complete-feature
description: Use when the active spec is verified and reviewed and the user wants to finish it. Runs final gates, archives the spec and resolved findings to plan/history, ticks the build plan, resets context files, and makes one commit and merge only with explicit approval.
---

# Complete feature

## Gates (all must pass; stop on the first failure and say what to run)

1. Branch is not `main`/`master`, matches the spec's **Branch**, and has no unrelated changes.
2. Spec **Status:** `verified` (from `verify-spec`), every build step ticked.
3. Verify command from AGENTS.md passes **now**, in this session. Paste the output.
4. `plan/context/review.md` has a `PASS` receipt from the other model for the current HEAD commit. Stale or missing → `cross-review`. Required for: auth, money, data model/migrations, deletes, permissions; recommended for everything.
5. No `open` or `fixed` P0/P1 in `plan/context/findings.md`.

## Archive

1. Feature: copy the spec to `plan/history/features/<id>-<kebab-title>[--build-N].md`. Fix: `plan/history/fixes/<YYYY-MM-DD>-<kebab-title>.md`.
2. Append to the archive: the resolved findings (`closed`, `accepted`, `invalid`) with IDs prefixed by the item (e.g. `4/F-02`), and the review receipt.
3. Read the archive file back to confirm it was written.
4. Feature: tick its line in `plan/build-plan.md`. Tick a parent only when all its sub-items are done.
5. Reset `current.md`, `review.md` to their stubs. In `findings.md`, remove resolved entries; keep unresolved P2/P3 ones.

## Commit and land (each needs the user's explicit yes)

1. Show the full diff summary and the proposed message, e.g. `feat(4): draft invoices with live totals`. Commit only after yes.
2. Ask how to land:
   - **local merge**: squash-merge into the default branch. Push is a separate question.
   - **pull request**: push the branch and open a PR with `gh pr create` (summary, checks run, review receipt). Never merge the PR yourself, never enable auto-merge.
3. Suggest removing the worktree/branch after merge, and `build-status` for what is next.

## Gotchas

- "Looks good" about the code is not approval to commit or merge. Ask for each action.
- Never waive a required review or accept a finding on the user's behalf.
- One work item = one squashed commit on the default branch.
- If a completion was interrupted, check the archive and git log before redoing anything.

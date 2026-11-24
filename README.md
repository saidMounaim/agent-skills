# said-agent-skills

My personal, spec-driven workflow for Claude Code and Codex: one feature at a time, file-backed state, test-first builds, and an independent review by the other AI model before anything merges.

Works in any agent that reads the open `SKILL.md` format.

## Install

```bash
# all skills, globally, into Claude Code and Codex
npx skills add saidmounaim/agent-skills --all -g

# only some skills
npx skills add saidmounaim/agent-skills --skill feature-spec --skill cross-review -g -a claude-code -a codex

# see what is in the repo
npx skills add saidmounaim/agent-skills --list
```

Replace `saidmounaim/agent-skills` with wherever you push this repo (private repos work with your Git/`gh` login).
Manual install: copy each `skills/<name>` folder into `~/.claude/skills/` (Claude Code) and `~/.agents/skills/` (Codex).
After editing a skill, run the install command again.

## The loop

```
workflow-init → project-discovery → [ feature-spec → (you approve) → implement-spec → verify-spec → cross-review → complete-feature ] → next item
                                       debug-isolate → feature-spec (fix mode)        build-status: where am I, what's next?
```

| Skill | What it does | Writes |
| --- | --- | --- |
| `workflow-init` | Installs the `plan/` folder, templates and AGENTS.md rules | `plan/**`, AGENTS.md |
| `project-discovery` | Interviews you to fill the two plans; generates the overview | project-plan, build-plan, overview |
| `feature-spec` | Next build-plan item (or a bug) → one reviewed spec with small, test-first steps | `context/current.md` |
| `implement-spec` | Builds the spec step by step, test first, on its branch; resumes from checkboxes | code, ticks steps |
| `verify-spec` | Proves every "Done when" with real evidence; writes "Try it now" | Verification section |
| `cross-review` | The other model reviews in a fresh context; findings ledger + receipt | `findings.md`, `review.md` |
| `complete-feature` | Final gates, archive, tick build plan, one commit, merge only with your yes | `history/**` |
| `debug-isolate` | Reproduces and finds the root cause without editing code | debug report |
| `build-status` | Read-only progress, blockers, drift, next command | nothing |
| `money-minor-units` | Rules for money, tax, rounding and invoice totals | (domain rules) |
| `skill-harvest` | Adds a new skill from someone else's idea, in your own words | `skills/**`, CREDITS |

## Project files (created by workflow-init)

```
plan/
  project-plan.md     you own it: problem, users, data, stack, deploy, constraints
  build-plan.md       you own it: ordered checklist, stable IDs, never renumbered
  context/
    overview.md       generated context, read in slices
    current.md        the ONE active spec
    findings.md       F-01.. ledger: P0-P3, open/fixed/closed/accepted/invalid
    review.md         cross-review request + receipt tied to a commit
  history/
    features/         archived specs (4-draft-invoices.md)
    fixes/
```

Because state lives in files, you can stop any time and continue in a fresh session, or switch between Claude Code and Codex. Start with `build-status`.

## Hard rules (in every skill)

- One active spec. Nothing gets built unless it is in the spec.
- Never on `main`. Never commit, merge or push without your explicit yes.
- Tests first; existing tests are never weakened to pass.
- No claimed result without real command output.
- Open or fixed P0/P1 findings block completion. Only you can accept a finding.
- The reviewer is always the other model.

## Use

- Claude Code: `/feature-spec`, or describe the task and the skill loads from its description.
- Codex: `$feature-spec`, or `/skills`.

## Grow it

"Use skill-harvest to make a skill from <link or idea>." Commit, push, reinstall.
Project-only rules (e.g. invoice numbering) go in that project's `.claude/skills/` and `.agents/skills/`, not here.

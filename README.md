# said-agent-skills

My personal agent skills for Claude Code, Codex and any agent that reads the open `SKILL.md` format.
One repo, installed everywhere with one command.

## Install

```bash
# all skills, globally, into Claude Code and Codex
npx skills add saidmounaim/agent-skills --all -g

# only some skills
npx skills add saidmounaim/agent-skills --skill cross-review --skill done-check -g -a claude-code -a codex

# see what is in the repo
npx skills add saidmounaim/agent-skills --list
```

Rename `saidmounaim/agent-skills` to wherever you push this repo. It works with private repos too, using your normal Git or `gh` login.

Manual install (no CLI): copy or symlink each `skills/<name>` folder into
`~/.claude/skills/` (Claude Code) and `~/.agents/skills/` (Codex).

Update after changing a skill: run the same `npx skills add ...` command again.

## The skills

| Skill | When it runs | Loop step |
| --- | --- | --- |
| `feature-spec` | Before any non-trivial code | 1. Spec |
| `task-plan` | After the spec is approved | 2. Plan |
| `tdd-build` | Implementing a planned task | 3. Build |
| `done-check` | Before saying "done" | 4. Prove |
| `cross-review` | After a plan or a finished task | 5. Review by the other model |
| `session-handoff` | Long session, next task, or "continue later" | Context reset |
| `money-minor-units` | Any money, tax or invoice code | Domain rules |
| `skill-harvest` | Adding or adapting a skill | Grow this repo |

The loop: **spec → plan → (cross-review plan) → test-first build → done-check → cross-review → you merge.**

## Use

- Claude Code: type `/feature-spec` (or just describe the task; skills load from their description).
- Codex: type `$feature-spec`, or run `/skills`.

## Add a skill

Ask your agent: "use skill-harvest to make a skill from <link or idea>". It writes `skills/<name>/SKILL.md`
in your own words and credits the source in `CREDITS.md`. Commit, push, reinstall.

## Project-specific skills

Rules for one project only (e.g. invoice numbering for the invoice app) go in that project's
`.claude/skills/` and `.agents/skills/`, not here. This repo is for skills you want in every project.

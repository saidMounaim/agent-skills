---
name: session-handoff
description: Use when the session is long, the context is getting full, a task is finished and the next one starts, or the user says handoff, wrap up, or continue later. Writes a note so a fresh session can continue without the chat history.
---

# Session handoff

Write `docs/handoff/YYYY-MM-DD-<slug>.md` (create the folder if needed) and show the path.

## Template

```markdown
# Handoff: <feature / task>
Spec: docs/specs/...   Plan: docs/plans/...
Branch / worktree: ...

## Done
- Task 1: <what changed> (commit <sha>)

## State right now
- Tests: <passing / failing, which>
- Uncommitted changes: <yes/no, what>

## Next step
- <the very next action, concrete>

## Decisions made (and why)
- ...

## Watch out
- <traps found in this session; also add repeated ones to CLAUDE.md / AGENTS.md Gotchas>
```

## Then

Tell the user: start a new session and say "read <handoff path> and continue".

## Gotchas

- Facts only. Do not write "done" for anything not verified.
- Keep it short: the next session reads the spec and plan for details.

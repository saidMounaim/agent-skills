---
name: explain
description: Use when the user wants to understand code: a walkthrough of the current feature, a file, a flow, or an upcoming build-plan item before its spec. Read-only; changes nothing. Use when the user says explain, walk me through, how does this work, or brief me.
---

# Explain

Read-only. The point is that the user still understands their own codebase.

## Modes

- **feature** (default when a spec is active): walk through what `build` did for `plan/context/current.md`.
- **flow**: follow one user action end to end (e.g. "issue an invoice": button → server action → DB transaction → PDF).
- **file / folder**: what it is for, its main parts, who calls it.
- **brief <id>**: explain an upcoming build-plan item before writing its spec: what it involves, which code it touches, the decisions it will need, the risks.

## How

1. Start with a 3-5 line map: the pieces and how they connect (an ASCII or Mermaid diagram if it helps).
2. Then step through in execution order. For each step: file:line, what it does, why it is done this way, anything non-obvious (a trade-off, a gotcha, a security check).
3. Point out what the tests cover and what they do not.
4. End with 2-3 questions the user could ask to go deeper, or things worth reviewing by hand.

## Gotchas

- Explain the code as it is, not as the spec intended. If they differ, say so; that is a finding for `audit`.
- A walkthrough is not verification and not a review.
- Keep it short; offer to go deeper on any step.

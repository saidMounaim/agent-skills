---
name: explain
description: Use when the user wants to understand code: a walkthrough of the feature just built, one user flow end to end, a file or folder, or a preview of an upcoming build-plan item (explain 5). Read-only. Use when the user says explain, walk me through, or how does this work.
---

# Explain

Changes nothing. The goal is that the user still understands their own project.

## Modes

- **Feature** (default when a spec is active): what `build` did for `plan/context/current.md`.
- **Flow**: follow one user action from start to finish, through every layer.
- **File or folder**: what it is for, its main parts, who calls it.
- **Upcoming item** (`explain <id>`): what a build-plan item will involve before its spec: the code it touches, the decisions it needs, the risks.

## How

1. Start with a short map: the pieces and how they connect. Draw a small diagram if it helps.
2. Walk through in the order things run. For each step: file and line, what it does, why it is done this way, anything surprising.
3. Say what the tests cover and what they do not.
4. End with 2-3 things worth reading by hand or asking about next.

## Gotchas

- Explain the code as it is, not as the spec meant it. If they differ, say so; that is a finding for `audit`.
- An explanation is neither verification nor a review.
- Keep it short. Offer to go deeper on any step.

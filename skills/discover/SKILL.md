---
name: discover
description: Use after setup to fill plan/project-plan.md and plan/build-plan.md through an interview, or to (re)generate plan/context/overview.md from plans the user wrote. Use when the user says discover, plan the project, or the plans changed a lot. Writes no app code.
---

# Discover

Pick the mode from what the user says and from the files:

- Plans empty or half-filled → **Interview**, then **Overview**.
- Plans already written, or the user says "skip the interview" → **Overview** only.

## Interview

1. Read `plan/project-plan.md` and `plan/build-plan.md`. Keep everything the user already wrote.
2. Look at the repo lightly (manifest files, top-level folders, AGENTS.md) so you do not ask what the repo already answers.
3. Ask **one question at a time**, section by section. Offer 2-3 concrete options when the user is unsure. Skip questions that would not change what gets built.
4. Write the answers into project-plan.md in the user's words. Unanswered lines stay blank, never guessed.
5. Propose the build plan: about 6-12 features, one line each, ordered by dependency:
   - foundations (core domain logic with no UI, auth),
   - then the main user flow, end to end,
   - then everything else.
   Each item should be buildable and reviewable alone. Show it, adjust with the user, then write `plan/build-plan.md` with IDs 1, 2, 3...

## Overview

1. Read both plans and the code they refer to.
2. Write `plan/context/overview.md` using the template's sections, under ~15 KB. Include one short "Feature notes" passage per build-plan ID; `spec` later reads just that passage.
3. Set the Source line: today's date and the current commit.
4. Put anything the plans leave unclear under "Open questions" and tell the user.

## Gotchas

- Suggest features, never add them on your own. The user decides the plan.
- Plans say WHAT and WHY. HOW (files, functions) belongs in each spec.
- No app code, no installs. Offer one commit at the end: `docs: project plans`.

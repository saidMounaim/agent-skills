---
name: project-discovery
description: Use after workflow-init to fill plan/project-plan.md and plan/build-plan.md through an interview, and to (re)generate plan/context/overview.md. Use when the user says discovery, plan the project, or the plans changed a lot. Writes no app code.
---

# Project discovery

## Mode A: fill the plans (interview)

1. Read `plan/project-plan.md` and `plan/build-plan.md`. Keep anything the user already wrote.
2. Read the codebase lightly (package.json, top-level folders) so you do not ask what the repo already answers.
3. Interview **one question at a time**, section by section of project-plan.md. Offer 2-3 concrete options when the user is unsure. Skip questions that would not change the build.
4. Write the answers into project-plan.md in the user's words. Unanswered items stay blank, never guessed.
5. Propose the build plan: 6-12 ordered features, one line each. Order by dependency:
   - foundations first (test runner if missing, auth, core domain logic with no UI),
   - then the main user flow end to end,
   - then the rest.
   Show it, adjust with the user, then write `plan/build-plan.md` with IDs 1, 2, 3...
6. Go to Mode B.

## Mode B: generate the overview

1. Read both plans and the relevant code.
2. Write `plan/context/overview.md` from the template sections. Under ~15 KB. Include one short "Feature notes" passage per build-plan ID, so `feature-spec` can read just that passage later.
3. Record the source line: date and current commit.
4. List anything the plans leave unclear as "Open questions" at the end, and tell the user.

## Gotchas

- Do not invent features the user did not ask for. Suggest, then let them decide.
- Plans describe WHAT and WHY. Leave HOW (file names, functions) to each feature spec.
- No app code, no installs, no commits in this skill. Offer a commit at the end: `docs: project plans`.

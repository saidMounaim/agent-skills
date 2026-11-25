---
name: ci
description: Use to set up or repair continuous integration so the project's verify command runs on every push and pull request (GitHub Actions, GitLab CI or Bitbucket Pipelines). Use when the user says CI, pipeline, or checks.
---

# CI

The same `verify` command passes on your machine and in CI.

## Steps

1. Read the Commands table in AGENTS.md. No `verify` row → build it from the rows that exist (`typecheck && lint && test && build`) and add it as one script in the project.
2. Run `verify` locally. It must pass before you write any CI. Paste the output.
3. Pick the CI from the git remote: GitHub → `.github/workflows/verify.yml`, GitLab → `.gitlab-ci.yml`, Bitbucket → `bitbucket-pipelines.yml`.
4. Write the pipeline:
   - runs on pull / merge requests and on pushes to the default branch,
   - checks out the code, sets up the language at the version the repo pins, restores the dependency cache,
   - installs with the lock file (the `install` row), then runs `verify`,
   - starts a database or other service only if the tests need one, with fake values,
   - runs `e2e` as a separate job if it exists, and keeps its report when it fails,
   - cancels older runs of the same branch.
5. List the env variables CI needs. Fake values go in the pipeline file. Real ones are CI secrets the user adds; give the names, never values.
6. Note in AGENTS.md that `verify` also runs in CI. Offer a commit.
7. After the push, check the run (`gh run watch`, `glab ci status`) or ask the user to.

## Gotchas

- Pin the same language and tool versions as local development.
- No deploy steps here. That is `release`.
- Suggest protecting the default branch so it requires this check. The user turns that on.

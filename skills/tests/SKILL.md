---
name: tests
description: Use when a project has no test runner, a broken one, or needs end-to-end tests (tests e2e). Sets up the runner that fits the stack with one real passing test and adds it to the Commands table. Not for writing feature tests, which happen in build.
---

# Tests

## Unit tests (default)

1. Check what exists. If a runner already works, say so and stop.
2. Pick the stack's standard runner. If the repo already uses one, keep it.

| Stack | Runner |
| --- | --- |
| Node / TypeScript | Vitest (Jest if already present) |
| Python | pytest |
| Go, Rust | built in (`go test`, `cargo test`) |
| PHP | Pest or PHPUnit |
| Ruby | RSpec or Minitest |
| Java / Kotlin | JUnit 5 |
| .NET | xUnit |
| Flutter / Dart | `flutter test` |
| Elixir | ExUnit |

3. Ask before adding a dependency. Install it, add the config, add `test` to the project's scripts.
4. Write **one real test** of existing logic. Not a placeholder.
5. Run it and paste the output. Break the code on purpose, show the test fails, restore it.
6. Fill the `test` row in the AGENTS.md Commands table and add it to `verify`.

## End-to-end (`tests e2e`)

1. Web, any backend → Playwright. Mobile → the platform's tool (Maestro, Flutter `integration_test`, XCUITest, Espresso); ask which.
2. Configure it to start the app by itself.
3. Write one smoke test: open the first screen, assert real content, and one key flow if it exists.
4. Fill the `e2e` row. If it is slow, keep it out of `verify` and run it in CI; say which.
5. Run it and paste the output.

## Gotchas

- An empty suite or a placeholder test is not a test setup.
- Tests get their own data: a test database, or transactions rolled back per test. Never the dev or production database.
- No real secrets in test config.

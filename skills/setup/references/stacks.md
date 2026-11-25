# Stack detection

Find the signal file, then fill the Commands table. **The repo's own scripts always win** over these defaults (package.json scripts, Makefile, justfile, Taskfile, composer scripts). Only list tools that are installed.

| Signal | Stack | install | typecheck / lint | test | build | deps-audit |
| --- | --- | --- | --- | --- | --- | --- |
| `package.json` | Node / TS (Next.js, NestJS, Vite, Expo...) | `<pm> install` | `<pm> run typecheck`, `<pm> run lint` | `<pm> test` | `<pm> run build` | `<pm> audit --prod` |
| `pyproject.toml`, `requirements.txt` | Python (Django, FastAPI, Flask) | `uv sync` or `pip install -r requirements.txt` | `ruff check .`, `mypy .` or `pyright` | `pytest` | none (or `python -m build`) | `pip-audit` |
| `go.mod` | Go | `go mod download` | `go vet ./...`, `golangci-lint run` | `go test ./...` | `go build ./...` | `govulncheck ./...` |
| `Cargo.toml` | Rust | `cargo fetch` | `cargo clippy -- -D warnings` | `cargo test` | `cargo build --release` | `cargo audit` |
| `composer.json` | PHP (Laravel if `artisan`) | `composer install` | `vendor/bin/phpstan`, `vendor/bin/pint --test` | `php artisan test` or `vendor/bin/phpunit` | asset build if any | `composer audit` |
| `Gemfile` | Ruby (Rails if `bin/rails`) | `bundle install` | `bundle exec rubocop` | `bin/rails test` or `bundle exec rspec` | `bin/rails assets:precompile` | `bundle exec bundle-audit` |
| `pom.xml` | Java (Maven) | `mvn -q dependency:resolve` | (in verify) | `mvn -q test` | `mvn -q package` | OWASP dependency-check if configured |
| `build.gradle(.kts)` | Java / Kotlin / Android | `./gradlew dependencies` | `./gradlew check` | `./gradlew test` | `./gradlew build` | as configured |
| `*.sln`, `*.csproj` | .NET | `dotnet restore` | `dotnet format --verify-no-changes` | `dotnet test` | `dotnet build -c Release` | `dotnet list package --vulnerable` |
| `pubspec.yaml` | Flutter / Dart | `flutter pub get` | `flutter analyze` | `flutter test` | `flutter build <target>` | `dart pub outdated` |
| `mix.exs` | Elixir (Phoenix) | `mix deps.get` | `mix format --check-formatted`, `mix credo` | `mix test` | `mix compile` | `mix deps.audit` |

`<pm>` = the package manager of the lock file: `pnpm-lock.yaml` → pnpm, `yarn.lock` → yarn, `bun.lock(b)` → bun, `package-lock.json` → npm.

## Other signals

- **Monorepo**: `pnpm-workspace.yaml`, `turbo.json`, `nx.json`, `go.work`, Cargo workspace → use the root pipeline (`turbo run test`, `nx run-many`), or one table per app.
- **Database / migrations**: Prisma, Drizzle, TypeORM, Alembic, Django, Rails, Laravel, Flyway, EF Core, goose → fill the `migrate` row with the repo's real command.
- **End-to-end**: `playwright.config.*`, `cypress.config.*`, Maestro flows, `integration_test/` → fill the `e2e` row.
- **Containers**: `Dockerfile`, `docker-compose.yml` → note how to start local services (database, queue) in the `dev` row.
- **CI host**: `git remote -v` → github.com → GitHub Actions, gitlab → GitLab CI, bitbucket → Pipelines.

## The verify command

Chain every check that exists, fastest first, stopping on the first failure:

`typecheck && lint && test && build`

Slow e2e suites can stay out of `verify` and run in CI and in the `verify` skill; say so in the table.

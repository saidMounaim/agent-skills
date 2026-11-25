# Changelog

## 4.0.0

### Added
- `design`: writes `design.md` and tokens from screens, existing UI or a brief.
- Works with any stack: `setup` detects the stack and writes one Commands table in AGENTS.md; no other skill contains framework commands.
- `plan/references/` for screens; `spec`, `build` and `verify` use them.
- `audit` can fall back to a fresh session of the same tool when no second model is installed (marked `same-model`).
- `spec` can abandon the active spec.
- A rule for tiny changes that skip the loop.
- `scripts/check.sh` and a GitHub Action that validate every skill.

### Fixed
- Review receipts no longer go stale when only `plan/` files change.
- Finding IDs could be reused after `finish` cleaned the ledger; the ledger now keeps a `Next ID` line.
- After audit fixes, the loop is `build` → `verify` → `audit` everywhere, and `build` accepts a verified spec that has new fix steps.
- `audit plan` no longer asks for a commit.
- `setup` and `discover` may commit plan files on the default branch; the "never on main" rule now covers app code only.
- Skill titles matched their old names.
- The install command no longer installs into every agent on the machine.

## 3.0.0
- One-word names. Added `tests`, `ci`, `secure`, `seo`, `release`, `explain`.

## 2.0.0
- File-backed workflow inspired by AI Blueprint.

## 1.0.0
- First collection.

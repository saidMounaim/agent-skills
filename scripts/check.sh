#!/usr/bin/env bash
# Checks every skill in this repo. Run before pushing: scripts/check.sh
set -u
cd "$(dirname "$0")/.."
fail=0
err() { echo "FAIL $1"; fail=1; }

names=()
for dir in skills/*/; do
  name=$(basename "$dir")
  names+=("$name")
  f="$dir/SKILL.md"
  [ -f "$f" ] || { err "$name: no SKILL.md"; continue; }
  [[ "$name" =~ ^[a-z]+$ ]] || err "$name: folder name must be one lowercase word"
  [ "$(head -1 "$f")" = "---" ] || err "$name: SKILL.md must start with ---"
  fm_name=$(sed -n '2,/^---$/s/^name: //p' "$f" | head -1)
  [ "$fm_name" = "$name" ] || err "$name: name in SKILL.md is '$fm_name'"
  desc=$(sed -n '2,/^---$/s/^description: //p' "$f" | head -1)
  [ -n "$desc" ] || err "$name: no description"
  [ "${#desc}" -le 1024 ] || err "$name: description over 1024 characters"
  [[ "$desc" == Use* ]] || err "$name: description should start with 'Use' (say when)"
  grep -q '^## Gotchas' "$f" || [ "$name" = "next" ] || err "$name: no Gotchas section"
  lines=$(wc -l < "$f")
  [ "$lines" -le 150 ] || err "$name: $lines lines (keep under 150)"
  grep -q "\`/$name\`" README.md || err "$name: missing from README"
done

# every skill mentioned in backticks inside a skill must exist
known=" ${names[*]} "
for f in skills/*/SKILL.md skills/setup/templates/*.md; do
  for ref in $(grep -oE '→ `[a-z]+`|(run|Run|suggest|Suggest|Next:|through|with) `[a-z]+`' "$f" | grep -oE '`[a-z]+`' | tr -d '`' | sort -u); do
    case "$ref" in verify|e2e|test|migrate|install|build|none|draft|approved|built|verified|open|fixed|closed|accepted|invalid) continue ;; esac
    [[ "$known" == *" $ref "* ]] || err "$f: refers to unknown skill '$ref'"
  done
done

# templates that setup needs
for t in agents-block build-plan current findings overview project-plan review; do
  [ -f "skills/setup/templates/$t.md" ] || err "setup: missing template $t.md"
done
[ -f skills/setup/references/stacks.md ] || err "setup: missing references/stacks.md"

count=${#names[@]}
grep -q "^$count one-word skills" README.md || err "README: skill count should be $count"

[ "$fail" = 0 ] && echo "OK: $count skills checked" || exit 1

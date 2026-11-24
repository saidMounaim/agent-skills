---
name: debug-isolate
description: Use when something is broken and the cause is not yet known (error, failing test, wrong output, flaky behavior). Reproduces and isolates the failure WITHOUT editing app code, then hands a root cause to feature-spec fix mode.
---

# Debug and isolate

Understand first, fix later. Guess-and-patch loops are where agents waste the most time.

## Steps

1. **Restate** the symptom: expected vs actual, where, since when (`git log` around that time).
2. **Reproduce** it with the smallest command, test or script. A temporary failing test or a script under `tmp/` is fine; app code is not touched. If you cannot reproduce it, say what you tried and ask for more detail.
3. **Isolate**: narrow down by halving (inputs, commits with `git bisect`, layers: UI → API → DB). Add temporary logging only in your scratch script, not in app code.
4. **Prove the root cause**: show the exact line or condition and why it produces the symptom. Mark it `confirmed` or `suspected`.
5. **Report**:

```markdown
## Debug report
Symptom:
Reproduction: <command>
Root cause (confirmed | suspected): <file:line + why>
Blast radius: <what else is affected>
Smallest fix:
Test that should be added:
```

6. Suggest `feature-spec` in fix mode with this report. Delete your scratch files.

## Gotchas

- No fixes in this skill, even "obvious" one-liners. The fix goes through a spec and a test.
- Do not stop at the first plausible cause. Confirm it explains every symptom.
- Never print secrets from env or logs while debugging.

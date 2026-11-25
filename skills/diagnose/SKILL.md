---
name: diagnose
description: Use when something is broken and the cause is not known yet (an error, a failing test, wrong output, flaky behavior). Reproduces the failure and finds the root cause without editing app code, then hands a report to spec in fix mode.
---

# Diagnose

Understand first, fix later. Guess-and-patch loops waste the most time.

## Steps

1. **Restate** the problem: expected, actual, where, since when.
2. **Reproduce** it with the smallest command, test or script. A scratch test or a script in a temp folder is fine; app code stays untouched. Cannot reproduce → say what you tried and ask for more.
3. **Narrow it down** by halving: inputs, layers (interface → logic → data), commits (`git bisect`). Extra logging goes in your scratch script only.
4. **Prove the cause**: the exact line or condition, and why it produces the symptom. Mark it `confirmed` or `suspected`.
5. **Report**:

```markdown
## Diagnosis
Symptom:
Reproduce: <command>
Root cause (confirmed | suspected): <file:line and why>
Also affected:
Smallest fix:
Test to add:
```

6. Delete your scratch files. Next: `spec` in fix mode, with this report.

## Gotchas

- No fixes here, not even an obvious one-liner. The fix goes through a spec and a test.
- Do not stop at the first plausible cause. It must explain every symptom.
- Never print secret values from env files or logs.

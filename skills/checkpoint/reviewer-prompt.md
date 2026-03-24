# Checkpoint Review Prompt

Review the current plan or implementation slice against the plan, source idea, or agreed scope.

## Inputs

The orchestrating agent must populate these before dispatching the reviewer.

**Plan / scope / source idea:**
[paste or summarize here]

**Changes under review:**
[paste the commit range, diff summary, or staged-change description here]

**What changed:**
[brief summary]

**Verification results:**
[tests, linters, build results, smoke checks, or limits]

**Known constraints or trade-offs:**
[optional]

## Check

- Does the current plan or implementation slice satisfy the intended direction so far?
- Are meaningful requirements or behaviors missing?
- Are there logic bugs, regressions, or unsafe assumptions?
- Is the verification convincing for the changed behavior?
- Are there security, data-loss, migration, or blast-radius concerns?
- Is refactoring pressure or scope drift building up enough that work should pause before continuing?

## Severity

Use:

- Critical: must fix before continuing
- Important: should fix before the next meaningful step unless there is a clear reason not to
- Minor: worthwhile but non-blocking

## Output Format

### Strengths
- ...

### Critical
- [file:line if possible] [issue] - [why it matters]

### Important
- [file:line if possible] [issue] - [why it matters]

### Minor
- [file:line if possible] [issue] - [why it matters]

### Assessment
**Checkpoint outcome:** Continue coding | Refactor first | Fix before continuing

**Reasoning:**
- ...

# Implementation Review Prompt

Review the implementation against the plan, source idea, or agreed scope.

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

- Does the implementation satisfy the plan or intended scope?
- Are meaningful requirements or behaviors missing?
- Are there logic bugs, regressions, or unsafe assumptions?
- Is the verification convincing for the changed behavior?
- Are there security, data-loss, migration, or blast-radius concerns?

## Severity

Use:

- Critical: must fix before the implementation phase can be called complete
- Important: should fix before handoff unless there is a clear reason not to
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
**Implementation phase complete?** Yes | With fixes | No

**Reasoning:**
- ...

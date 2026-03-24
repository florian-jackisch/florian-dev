# Implementation Reviewer Prompt

Review the implementation against the plan or requirements, not just against local code style preferences.

## Inputs

The orchestrating agent must populate these before dispatching the reviewer.

**Plan / requirements:**
[paste or summarize the plan / requirements here]

**Changes under review:**
[paste the commit range, diff summary, or staged-change description here]

**What changed:**
[brief summary]

**Known constraints or trade-offs:**
[optional]

## Check

- Does the implementation satisfy the plan?
- Are important requirements missing?
- Are there logic bugs, regressions, or unsafe assumptions?
- Is test coverage convincing for the changed behavior?
- Are there security, data-loss, migration, or blast-radius concerns?

## Severity

Use:

- Critical: must fix before merge
- Important: should fix before merge unless there is a clear reason not to
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
**Ready to merge?** Yes | With fixes | No

**Reasoning:**
- ...

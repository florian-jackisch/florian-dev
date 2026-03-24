---
name: devils-advocate
description: 'This skill should be used when the user is making a meaningful choice and wants strong critical pressure before committing. It challenges preferred approaches, steel-mans the opposition, surfaces hidden assumptions, and forces confidence calibration before a decision hardens.'
---

# Devil's Advocate

Use adversarial reasoning before committing to an approach.

The purpose of this skill is to interrupt premature lock-in. Use it before architectural, product, workflow, tooling, or implementation decisions solidify.

## When to Use

Use this skill when:

- choosing between approaches
- selecting libraries, frameworks, or tools
- deciding implementation strategy
- recommending one option over several plausible alternatives
- the user asks "should I...", "what's the best way...", or "which option..."
- an idea sounds attractive but may hide risks

## When to Skip

Do not use this skill when:

- the user already made the decision clearly
- the task is mechanical or procedural
- only one realistic path exists
- the decision is trivial and low-impact

## Protocol

### 1. Identify the commitment

State:

- what decision is being made
- which option looks strongest at first glance
- why that option is attractive

### 2. Steel-man the opposition

Present the strongest case against the current inclination.

Include:

- obvious objections
- opportunity cost
- assumptions that may be false
- at least one non-obvious failure mode
- conditions under which the preferred option would fail badly

Do not perform token criticism. Attack the strongest version of the argument.

### 3. Defend or pivot

After the challenge:

- explain why the original choice still holds, or
- change the recommendation if the objections genuinely changed the conclusion

### 4. Calibrate confidence

End with:

- final recommendation
- key assumptions
- what would invalidate the decision
- signals to watch after committing

## Output Format

```markdown
## Decision: [what is being decided]

### Initial Inclination
[approach] because [reasons]

### Adversarial Challenge
**Against this approach:**
- ...
- ...
- ...

**What I might be wrong about:**
- ...

### Resolution
[why it still stands OR why the recommendation changed]

### Recommendation: [final choice]
- **Key assumptions:** ...
- **Watch for:** ...
```

## Principle

Models often commit too early and rationalize backward. This skill forces exploration of the solution space before commitment crystallizes.

## Relationship to Other Skills

- Use `brainstorming` to explore options broadly.
- Use `devils-advocate` when the choice is narrowing and pressure-testing matters.
- Use `interview` when the problem itself is still underspecified.

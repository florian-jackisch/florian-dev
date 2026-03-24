---
name: interview
description: 'This skill should be used when the user wants to be interviewed until an idea is fully clear, when requirements are vague but important, or when a project needs deep clarification before planning or implementation. It asks structured follow-up questions, detects uncertainty, and uses research loops when needed.'
---

# Interview

Use this skill to interrogate an idea until the important details are clear.

This is a deeper clarification mode than `brainstorming`. Use it when the user wants to be challenged, questioned, and guided toward sharper requirements.

## Core Philosophy

- Do not accept surface answers too quickly.
- Do not assume the user has already thought through consequences.
- Detect ambiguity, hidden trade-offs, and knowledge gaps.
- Research when uncertainty matters.
- Do not write implementation code while still interviewing.

## What This Skill Is For

Use it when:

- the user says they want to be interviewed
- the request is high-stakes or underspecified
- multiple reasonable interpretations still exist after initial discussion
- success depends on getting details right before planning or building

## Interview Flow

### 1. Initial orientation

Start with 2-3 broad questions that establish:

- the problem
- the target users or stakeholders
- whether this is new work or a change to something existing

### 2. Deep dive by category

Work through relevant categories such as:

- problem and goals
- user journey
- data and state
- technical landscape
- scale and performance
- integrations
- security
- deployment and operations

Do not mechanically ask every category if it is not relevant. Follow the shape of the project.

### 3. Detect uncertainty

When the user sounds unsure, name the uncertainty and help resolve it.

Typical signals:

- "I think"
- "maybe"
- overly generic technology choices
- conflicting requirements
- unexplored user flow

### 4. Research loops

When the user needs help making an informed decision, research before continuing.

Examples:

- comparing technologies
- checking current best practices
- understanding external constraints
- gathering examples from existing products

After research, return with a short summary and a sharper follow-up question.

### 5. Conflict resolution

When you discover that two goals conflict, surface it directly.

Examples:

- simple vs feature-rich
- cheap vs real-time
- fast to ship vs future-proof
- secure vs frictionless

Ask which dimension matters more, or offer to research alternatives.

### 6. Synthesis

Once the picture is clear enough, summarize:

- what the user is building
- for whom
- why
- key decisions and assumptions
- open risks or unresolved choices

Ask whether the summary is accurate.

## Output Discipline

This skill should not automatically force a specification file.

Default output is:

- a clear verbal summary in chat
- a list of decisions
- a short list of unresolved questions, if any

Only write a spec or a plan if the user explicitly asks for one or wants to transition into planning.

## Interview Style

- Ask pointed questions.
- Prefer questions that eliminate entire branches of ambiguity.
- Use multiple choice when it reduces friction.
- Use open questions when nuance matters.
- Be comfortable asking follow-up questions that challenge weak assumptions.
- Keep going until the important uncertainties are actually resolved.

## Handoff

When the interview is complete, ask what the user wants next:

- keep exploring with `brainstorming`
- challenge a choice with `devils-advocate`
- create a plan
- start implementation

# Plan Reviewer Prompt

Use this prompt when reviewing an implementation plan before coding begins.

## Dispatch Guidance

The orchestrating agent should launch a focused review sub-agent using:

- `agent_type: "general-purpose"`
- `model: "gpt-5.4"`
- an explicit label such as `GPT-5.4 plan review`

Populate the sections below before dispatching. Do not send the template with placeholders still intact.

## Goal

Verify that the plan is specific, executable, and aligned with the idea or requirements. The review output is for the orchestrating agent to refine the plan before presenting the revised plan to the user.

## Plan / Requirements

**Plan to review:**
[paste the plan, or provide a precise path and relevant excerpt]

**Requirements / source idea:**
[paste the requirements, spec, or summary the plan must satisfy]

## Review Focus

Check for:

- missing requirements or hidden scope gaps
- vague tasks that an implementer could interpret several ways
- missing file-level guidance where specificity matters
- bad task ordering
- missing red/green test flow
- incorrect use of built-in `/fleet` for work that is not truly independent
- missing boundaries, integration steps, or verification for any planned `/fleet` work
- missing verification steps
- missing branch or commit discipline
- hidden risk that should appear in the plan

## Calibration

Only flag issues that would materially harm execution.

Do not block approval for stylistic preferences, phrasing tweaks, or extra nice-to-have ideas.

## Output Format

Return focused execution feedback so the orchestrating agent can update the plan before user approval.

## Plan Review

**Status:** Approved | Issues Found

**Issues:**
- [Task or section]: [problem] - [why it matters]

**Recommendations:**
- [optional non-blocking suggestion]

Do not ask the user whether the review suggestions should be applied. Assume the orchestrating agent will fold material findings into the next revision of the plan before handoff.

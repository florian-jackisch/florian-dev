---
name: brainstorming
description: 'This skill should be used when the user wants to explore an idea, shape a vague direction, discuss possibilities, brainstorm approaches, or think through a feature before implementation. It encourages free-form conversation, light structure, critical questions, and internet research for inspiration without forcing specs or formal design documents.'
---

# Brainstorming

Use this skill to explore ideas conversationally before implementation.

The goal is to help the user think better, not to force a formal process. Keep the conversation lively, curious, and high-signal.

## Core Rules

- Do not start implementing until the user approves a direction.
- Prefer free-form conversation over rigid ceremony.
- Do not force a specification document, plan file, or design artifact unless the user asks for one.
- Ask focused questions, but do not drag the conversation out unnecessarily.
- Bring in outside inspiration or current information when it would improve the discussion.

## Default Style

This brainstorming mode should feel like a strong collaborative product-and-engineering conversation:

- exploratory
- skeptical in a useful way
- open to alternatives
- concise, but not sterile
- willing to use examples, analogies, and comparisons

## Process

### 1. Frame the idea

Start by understanding:

- what the user is trying to achieve
- why it matters
- what kind of outcome would feel successful

If the idea is still vague, ask a few high-leverage questions. Batch related questions when it helps the conversation move faster.

### 2. Broaden the option space

Before converging, surface a few credible directions:

- a pragmatic option
- a bolder or more creative option
- a simpler/minimal option when useful

Do not over-structure this. A short conversational comparison is often better than a formal matrix.

### 3. Bring in inspiration and research

When the idea would benefit from examples, trends, competitors, prior art, or current technical constraints, search the web early.

Examples:

- product inspiration
- UX patterns
- technical capabilities or limitations
- existing tools in the space
- common pitfalls others have encountered

Prefer current sources and concrete examples. Use research to enrich the conversation, not to derail it.

### 4. Stress-test lightly

Ask critical questions that improve the idea:

- what could make this fail?
- what is overcomplicated?
- what assumption may be wrong?
- what would a simpler version look like?
- what does the user actually care about most?

Use `devils-advocate` when the conversation turns into a real decision with non-obvious trade-offs.

### 5. Converge on a direction

When a direction is strong enough:

- summarize the choice
- explain why it seems best
- note key trade-offs or assumptions
- ask for explicit approval before implementation

Capture the decision inline in chat unless the user asks for a document.

## What Not to Do

- Do not insist on a spec for every idea.
- Do not write a design doc by default.
- Do not turn a lightweight idea discussion into a heavyweight workflow.
- Do not ask one low-value question per message if you could batch three strong ones.
- Do not stay abstract when concrete examples or web research would help.

## Good Prompts for This Skill

- "I have an idea and want to think it through."
- "Let’s brainstorm this feature."
- "I’m not sure what the right direction is."
- "Can you challenge this idea and help refine it?"
- "Show me a few ways this could work."

## Completion

A brainstorming session is done when the user has:

- a clearer problem framing
- a shortlist of viable directions
- a recommended path
- enough confidence to either proceed or keep exploring

If the user wants to move from brainstorming into a deeper discovery process, use `interview`.

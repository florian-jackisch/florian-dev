---
name: writing
description: 'This skill should be used when the task is primarily writing rather than coding: specifications, architecture docs, runbooks, developer docs, release notes, or user-facing technical documentation. It focuses on audience, structure, factual accuracy, examples, and review without forcing a coding workflow.'
---

# Writing

Use this skill for writing-heavy work that should not be forced through a coding implementation workflow.

## When to Use

Use this skill for:

- technical specifications
- architecture documents
- runbooks
- developer documentation
- API documentation
- release notes and changelogs
- user-facing technical guides

If the task is primarily code implementation, use `coding` instead.

## Core Principles

- Start from audience and purpose.
- Choose the right document type before writing.
- Prefer clear structure over clever prose.
- Keep examples accurate and runnable when possible.
- Review and verify factual claims before finalizing.

## Workflow

### 1. Identify the writing goal

Clarify:

- who the audience is
- what they need from the document
- what type of document this is
- what is in scope and out of scope

### 2. Propose structure first

Before drafting long content, outline the structure.

Examples:

- spec
- how-to guide
- reference
- explanation
- runbook
- changelog

### 3. Draft with evidence

Use project terminology consistently.

When the document references code, commands, APIs, or workflows:

- verify examples against the repository when possible
- keep commands copyable
- avoid stale or speculative claims
- explain why, not only how

### 4. Validate the document

Where applicable:

- run documented commands
- verify links and paths
- check code samples for realism
- ensure the document matches the current system behavior


### 5. Review for readability

Check:

- audience fit
- clarity
- missing prerequisites
- missing failure cases
- unnecessary jargon
- weak structure

## Relationship to the Other Skills

- use `brainstorming` when the ideas are still loose
- use `planning` when the output is an implementation plan
- use `coding` for executable behavior changes
- use `mermaid` when Markdown documentation would benefit from diagrams
- use `checkpoint` when written work benefits from an in-progress sanity check before broader handoff

## Red Flags

- writing before the audience is known
- mixing tutorial, reference, and explanation without intention
- unverified commands or examples
- documentation that describes behavior the code does not have
- forcing documentation work through a TDD coding workflow when that is not the task

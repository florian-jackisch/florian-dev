---
name: no-superpowers
description: 'This skill should be used when the user wants a lightweight session without the automatic obra/superpowers workflow. It disables automatic Superpowers skill use for the rest of the session unless the user explicitly asks for a Superpowers skill by name.'
---

# No Superpowers

Use this skill when the user wants a lightweight session without the automatic `obra/superpowers` workflow.

After this skill is invoked:

- do not auto-invoke `obra/superpowers` skills for the rest of the session
- do not route the conversation into mandatory brainstorming, planning, TDD, review, verification, or worktree workflows unless the user explicitly asks for them
- continue normally with built-in Copilot behavior and any non-Superpowers skills that are directly relevant

This is a session-level opt-out, not a permanent uninstall.

## Explicit user requests still win

If the user later explicitly asks for a Superpowers skill by name, or clearly asks to re-enable the Superpowers workflow, follow that request.

Examples:

- "Use `obra/superpowers` brainstorming for this feature." → allowed
- "Let's use Superpowers now." → allowed
- "Help me figure out this shell config issue." → stay lightweight, do not auto-invoke Superpowers

## Priority

Treat this skill as a direct user preference for the current session.

User instructions override automatic workflow activation.

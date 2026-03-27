# Copilot Instructions — flow

This repository is a **skills-only** GitHub Copilot CLI plugin.

## Plugin Identity

- Name: `flow`
- Install: `/plugin install florian-jackisch/flow`
- Format: standalone plugin with `plugin.json` at repo root
- Scope: curated repo-local skills plus shared MCP config

## Repository Layout

```text
flow/
├── plugin.json
├── .mcp.json
├── skills/
│   └── <skill-name>/
│       ├── SKILL.md
│       └── [scripts|references|examples|assets]
├── .github/
│   └── copilot-instructions.md
├── README.md
└── LICENSE
```

## Core Rules

- This plugin does **not** use agents. Do not add an `agents/` directory or an `agents` entry to `plugin.json`.
- Keep names lowercase-kebab-case.
- Keep skill `name` equal to the folder name.
- Write skill descriptions in third person with concrete trigger phrases.
- Prefer repo-local skills. Do **not** install skills globally.
- Use `copilot-instructions-improver` when auditing or rewriting this repo's Copilot instruction files.

## Adding or Adapting a Skill

1. Create `skills/<skill-name>/SKILL.md`.
2. Add YAML frontmatter:
   - `name`
   - `description`
3. Add optional support files only when useful:
   - `scripts/`
   - `references/`
   - `examples/`
   - `assets/`
4. If the skill comes from `skills.sh`, vendor it into `skills/` instead of keeping any `.agents/` install output.
5. Update `README.md` when relevant.
6. Bump `plugin.json` version before pushing.

## Workflow Fit

- Use `planning` to strengthen built-in `/plan` or plan mode once an idea is clear. Planning should review the draft plan internally, apply material review findings, and present the revised plan as the single approval point before implementation.
- During planning, consider built-in `/fleet` when the work naturally splits into independent, well-bounded tasks that can run in parallel.
- Use `start-worktree` after planning approval and before non-trivial coding so execution moves into an isolated sibling directory (e.g. `../repo.feature-branch`) on a fresh branch while the repository root stays on the default branch when practical. When the session name still looks generic, include the new branch name in the session rename handoff too.
- Use `coding` for implementation work.
- Use Context7 during planning and implementation whenever work depends on external libraries, frameworks, SDKs, or APIs. Prefer current docs over memory so integrations do not invent or rely on stale API shapes.
- For code workflow skills, prefer a hybrid refactoring cadence: small local cleanup inside red/green/refactor, plus a deliberate pre-review refactoring checkpoint when design pressure accumulates.
- Use `refactoring` when cleanup needs deliberate focus beyond a small local red/green/refactor step.
- Use `checkpoint` during planning or implementation when work should pause for a light opposite-family sanity check before continuing; keep it to one reviewer by default.
- Use `final-review` only on explicit request for MR/PR review or draft-undraft decisions; do not route into it automatically from other workflows. When used, default to two reviewers, with a one-reviewer fast path only for truly tiny changes and optional built-in `/fleet` escalation for especially large or high-risk reviews.
- Use `git` for commit preparation, commit messages, and MR authoring policy; never add `Co-authored-by`, avoid conventional-commit prefixes, keep summaries under 72 characters, create new MRs as draft, never undraft or assign reviewers automatically, and draft MR title/description/comment updates in Markdown for user review before applying them.
- Use `auto-draft` when the user explicitly wants a fast autonomous draft-delivery workflow from prompt to draft merge request. Its worktree phase should inherit the same branch-aware session rename behavior.
- Use `mermaid` alongside `writing` or `planning` when Markdown docs, specs, or plans would benefit from diagrams.
- For Markdown files, prefer drafting first without forcing cleanup too early. Before committing Markdown work, keep cleanup deliberate and diff-preserving: prefer new files first, and keep cleanup scoped to touched sections of existing files when practical so the diff stays small. Avoid broad churn in untouched parts of existing files unless that wider cleanup is a deliberate part of the change.
- Use `python` alongside `coding` or `refactoring` for Python-specific work.
- Use `rust` alongside `coding` or `refactoring` for Rust-specific work.
- Use `cpp` alongside `coding` or `refactoring` for C++-specific work.
- Use `bash` alongside `coding` or `refactoring` for Bash-specific work.
- Place linked worktrees as sibling directories next to the main repository root, named `<repo-name>.<path-safe-branch-name>`.

## Vendoring External Skills

When bringing in a skill from `skills.sh`, vendor it into this repository instead of leaving it in agent-managed locations.

Preferred workflow:

```bash
skills/find-skills/scripts/vendor-skill.sh <package> <skill-name>
```

Example:

```bash
skills/find-skills/scripts/vendor-skill.sh vercel-labs/skills find-skills
```

This uses `npx skills add ... --agent github-copilot --copy` in a temporary directory, copies the full installed skill tree into `./skills/<skill-name>/`, and cleans up afterward.

Important:

- Do not use `-g`.
- Do not rely on `~/.agents/skills` or other global skill state.
- Review vendored files before committing.

## MCP Notes

- Context7 is part of the normal workflow, not an optional extra. Prefer it for current library and framework API lookups during planning and implementation.
- Prefer Copilot CLI's built-in GitHub MCP instead of bundling a duplicate GitHub integration here.
- This plugin may bundle a GitLab MCP via `glab mcp serve`; keep that config simple and document the authentication prerequisite in `README.md`.

## Versioning

- Patch: documentation updates, description tweaks, non-breaking skill refinements
- Minor (`0.x.0`): new skill added
- Major (`x.0.0`): breaking changes to existing skills

## Commit Conventions

- Single summary line, max 72 characters
- No conventional-commit prefixes
- No `Co-authored-by` trailers

## Issues and Merge Requests

- Never create a new issue unless the user explicitly asks.
- Never create, edit, or comment on an issue or MR unless the user explicitly asks for that action.
- New MRs should always start as draft.
- Never undraft an MR automatically.
- Never assign reviewers automatically.
- When preparing a title, description, or comment update for an MR, draft the proposed content in a Markdown file first and let the user review it before applying the change.
- Keep issue and MR descriptions short and human rather than changelog-like.

`auto-draft` is the narrow exception to the MR-text pre-review rule:

- if the user explicitly invokes `auto-draft`, it may create or update draft MR text directly
- it must still keep the MR as draft
- it must never assign reviewers automatically
- it must never create an issue as part of that flow

## Local Verification

After changes:

1. Reinstall the plugin:
   ```text
   /plugin install florian-jackisch/flow
   ```
2. Check `/skills` to confirm the expected skill list.
3. If the current session does not pick up a new skill immediately, run `/restart`.

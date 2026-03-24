# Copilot Instructions — florian-dev

This repository is a **skills-only** GitHub Copilot CLI plugin.

## Plugin Identity

- Name: `florian-dev`
- Install: `/plugin install florian-jackisch/florian-dev`
- Format: standalone plugin with `plugin.json` at repo root
- Scope: curated repo-local skills plus shared MCP config

## Repository Layout

```text
florian-dev/
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
5. Update `README.md` and `ROADMAP.md` when relevant.
6. Bump `plugin.json` version before pushing.

## Workflow Fit

- Use `planning` to strengthen built-in `/plan` or plan mode once an idea is clear.
- During planning, consider built-in `/fleet` when the work naturally splits into independent, well-bounded tasks that can run in parallel.
- Use `coding` for implementation work.
- Use Context7 during planning and implementation whenever work depends on external libraries, frameworks, SDKs, or APIs. Prefer current docs over memory so integrations do not invent or rely on stale API shapes.
- For code workflow skills, prefer a hybrid refactoring cadence: small local cleanup inside red/green/refactor, plus a deliberate pre-review refactoring checkpoint when design pressure accumulates.
- Use `refactoring` when cleanup needs deliberate focus beyond a small local red/green/refactor step.
- Use `checkpoint` during planning or implementation when work should pause for a light opposite-family sanity check before continuing; keep it to one reviewer by default.
- Use `final-review` only on explicit request for MR/PR review or draft-undraft decisions; do not route into it automatically from other workflows. When used, default to two reviewers, with a one-reviewer fast path only for truly tiny changes and optional built-in `/fleet` escalation for especially large or high-risk reviews.
- Use `git` for commit preparation and commit messages; never add `Co-authored-by`, avoid conventional-commit prefixes, keep summaries under 72 characters, and only use a short body when it adds real context.
- Use `mermaid` alongside `writing` or `planning` when Markdown docs, specs, or plans would be clearer with Mermaid diagrams. Prefer embedded Mermaid blocks and simple maintainable diagrams before introducing a polished rendering pipeline.
- For Markdown files, prefer drafting first without forcing linting too early. Before committing Markdown work, run `prettier` and then `markdownlint` in a diff-preserving way: prefer new files first, and keep cleanup scoped to touched sections of existing files when practical so the diff stays small. Avoid broad formatter churn in untouched parts of existing files unless that wider cleanup is a deliberate part of the change. Do not add a default hook for this unless repeated misses prove the manual workflow is insufficient.
- Use `python` alongside `coding` or `refactoring` for Python-specific work; prefer type hints, `uv`, `ruff`, `pytest`, refactor-first test design, and named data structures over unclear tuples. If a repo has no type checker configured, still run a scoped checker on changed Python code, but keep fixes mostly to the touched area unless an obvious coupled bug appears.
- Use `rust` alongside `coding` or `refactoring` for Rust-specific work; prefer type-first design, `cargo clippy`, `cargo fmt`, `cargo test`, clearer structs over unclear tuples, and refactor-first testing over mock-heavy design. If a repo has no wrapped Rust verification flow, still run the relevant `cargo fmt --check`, `cargo clippy`, and `cargo test` commands for the touched crate or workspace area.
- Use `cpp` alongside `coding` or `refactoring` for C++-specific work; prefer modern C++ within the target standard, CMake with Ninja, `clang-format`, `clang-tidy`, sanitizer-backed verification, Catch2 or GoogleTest, Google Benchmark when profiling matters, balanced use of templates and header-only libraries, refactor-first low-mock testing, and named types over unclear tuples. If a repo has no wrapped C++ verification flow, still run the relevant configure, build, test, formatting, linting, and sanitizer checks for the touched target or project area when practical.
- Use `bash` alongside `coding` or `refactoring` for Bash-specific work; prefer `#!/usr/bin/env bash` plus immediate `set -euo pipefail`, `shellcheck`, `shfmt`, executable scripts, careful quoting, arrays over unsafe word splitting, and explicit shell error handling. If a repo has no wrapped shell verification flow, still run the relevant lint, format, permission, and execution checks for the touched script area when practical.

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

## Local Verification

After changes:

1. Reinstall the plugin:
   ```text
   /plugin install florian-jackisch/florian-dev
   ```
2. Check `/skills` to confirm the expected skill list.
3. If the current session does not pick up a new skill immediately, run `/restart`.

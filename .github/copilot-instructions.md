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
- For code workflow skills, prefer a hybrid refactoring cadence: small local cleanup inside red/green/refactor, plus a deliberate pre-review refactoring checkpoint when design pressure accumulates.
- Use `refactoring` when cleanup needs deliberate focus beyond a small local red/green/refactor step.
- Use `implementation-review` at the end of an implementation phase, not as a substitute for MR review; keep it light by default and only add a second reviewer for large or high-risk work.
- Use `code-review` for MR/PR review and draft-undraft decisions; default to two reviewers, with a one-reviewer fast path only for truly tiny changes.
- Use `git` for commit preparation and commit messages; never add `Co-authored-by`, avoid conventional-commit prefixes, keep summaries under 72 characters, and only use a short body when it adds real context.

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

# Copilot Instructions — florian-dev Plugin

This repository is a personal GitHub Copilot CLI plugin. It bundles curated
skills, agents, and MCP server configuration into a single installable package.

## Plugin Identity

- **Name:** `florian-dev`
- **Install:** `/plugin install florian-jackisch/florian-dev`
- **Format:** Standalone plugin (plugin.json at repo root)

## Repository Layout

```
florian-dev/
├── plugin.json          # Plugin manifest
├── .mcp.json            # MCP server configuration
├── skills/              # One subfolder per skill
│   └── <skill-name>/
│       ├── SKILL.md     # Required: skill definition with frontmatter
│       └── [assets]     # Optional: scripts, templates, data (<5 MB each)
├── agents/              # One file per agent
│   └── <name>.agent.md  # Agent definition with frontmatter
├── .github/
│   └── copilot-instructions.md   # This file
├── README.md
├── .gitignore
└── LICENSE
```

## Adding a New Skill

1. Create a new directory under `skills/` using lowercase-kebab-case:
   ```
   skills/my-new-skill/
   ```

2. Create `SKILL.md` inside it with YAML frontmatter:
   ```markdown
   ---
   name: my-new-skill
   description: "Clear, specific description of what this skill does and when it should be triggered."
   ---

   # My New Skill

   Instructions for the skill...
   ```

3. **Frontmatter rules:**
   - `name` must match the folder name exactly (lowercase-kebab-case, max 64 chars)
   - `description` must be 10–1024 characters, non-empty, and specific enough
     that the LLM can decide when to invoke this skill vs others

4. Optional: add bundled assets (scripts, templates, data files) alongside
   `SKILL.md`. Reference them from the skill content using relative paths.

5. Update `README.md` to list the new skill in the table.

## Adding a New Agent

1. Create a file in `agents/` named `<agent-name>.agent.md` (lowercase-kebab-case):
   ```
   agents/my-agent.agent.md
   ```

2. Add YAML frontmatter:
   ```markdown
   ---
   name: my-agent
   description: "When and why to use this agent."
   model: inherit
   ---

   You are an expert in...
   ```

3. **Frontmatter fields:**
   - `name` — matches the filename (without `.agent.md`)
   - `description` — concise trigger description; include example scenarios
   - `model` — use `inherit` to follow the user's selected model, or pin a
     specific model ID (e.g., `claude-sonnet-4.6`)
   - `tools` — optional array of tool names the agent can use

4. Update `README.md` to list the new agent.

## MCP Servers

MCP servers are declared in `.mcp.json` at the repo root and referenced from
`plugin.json` via the `mcpServers` field.

To add a new MCP server, add an entry under `mcpServers`:
```json
{
  "mcpServers": {
    "server-name": {
      "command": "npx",
      "args": ["-y", "@scope/package-name"]
    }
  }
}
```

Currently bundled:
- **context7** — library documentation lookups via Context7 API

## Naming Conventions

- **Directories and files:** lowercase-kebab-case everywhere
- **Skill names:** must match their folder name
- **Agent names:** must match their filename (minus `.agent.md`)
- **Plugin name:** always `florian-dev` — do not change it

## Versioning

Follow semantic versioning in `plugin.json`:
- **Patch** (0.1.x): skill/agent content tweaks, description improvements
- **Minor** (0.x.0): new skill or agent added
- **Major** (x.0.0): breaking changes to existing skills/agents

Bump the version in `plugin.json` before pushing changes.

## Commit Conventions

- Single summary line, max 72 characters, no conventional-commit prefixes
- Add a brief explanatory paragraph only when the summary is insufficient
- Never add `Co-authored-by` trailers

## Testing Locally

After making changes, reinstall the plugin to verify:
```
/plugin install florian-jackisch/florian-dev
```

Then check:
- `/skills` — verify new skills appear with correct names and descriptions
- `/agent` — verify new agents appear
- Invoke a skill and confirm it behaves as expected

## Adapting External Skills

When copying a skill from an external source:
1. Create the skill directory and SKILL.md as described above
2. Adapt the content to your personal preferences and workflow
3. Ensure the `name` and `description` frontmatter are updated
4. Remove any references to the original author's specific setup
5. Test the skill locally before committing

# florian-dev

Personal GitHub Copilot CLI plugin with curated repo-local skills for everyday development.

## Install

```text
/plugin install florian-jackisch/florian-dev
```

## Included Skills

| Skill | Description |
|-------|-------------|
| `skill-development` | Guidance for creating effective skills — structure, frontmatter, progressive disclosure, and validation |
| `find-skills` | Search skills.sh, evaluate results, and vendor selected skills into the repo-local `skills/` directory |

## Notes

- This plugin is **skills-only**. It does not ship agents.
- External skills should be vendored into `skills/`, not installed globally.
- If a newly added skill does not appear immediately after reinstalling the plugin, run `/restart`.

## MCP Servers

| Server | Purpose |
|--------|---------|
| `context7` | Library documentation lookups |

## License

[MIT](LICENSE)

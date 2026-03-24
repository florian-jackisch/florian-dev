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
| `copilot-instructions-improver` | Audit and improve repo-local GitHub Copilot instruction files, produce a quality report, and propose targeted edits |
| `debugging` | Evidence-first debugging with root-cause analysis, minimal hypothesis testing, and fix verification |
| `planning` | Implementation planning with exact files, TDD-oriented steps, feature-branch discipline, and plan review before execution |
| `coding` | Execution workflow with branch hygiene, reuse-first coding, red/green TDD, frequent working commits, and verification |
| `implementation-review` | End-of-implementation review against the plan or scope, with complexity-based reviewer depth and fix-and-rereview loops |
| `code-review` | MR/PR review workflow for reviewing others' changes or deciding whether your own draft is ready to undraft |
| `writing` | Writing workflow for specs, docs, runbooks, and other non-code tasks with audience and accuracy focus |
| `brainstorming` | Free-form ideation with light structure, critical questions, and web research without forcing specs |
| `interview` | Deep requirement clarification through structured follow-up questions and research loops |
| `devils-advocate` | Pre-commitment adversarial reasoning to challenge choices before they harden |

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

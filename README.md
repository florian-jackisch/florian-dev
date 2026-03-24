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
| `git` | Git hygiene and commit workflow with human commit messages, no conventional prefixes, and no `Co-authored-by` trailers |
| `python` | Python-specific companion workflow with type hints, scoped type checking, `uv`, `ruff`, `pytest`, refactor-first testing, and modern library preferences such as `dataclasses`, `rich`, `typer`, and `pydantic` |
| `rust` | Rust-specific companion workflow with type-first design, `cargo clippy`, `cargo fmt`, `cargo test`, low-mock testing, and clearer structs over unclear tuples |
| `cpp` | C++-specific companion workflow with modern C++, CMake plus Ninja, `clang-format`, `clang-tidy`, sanitizer-backed verification, Catch2 or GoogleTest, Google Benchmark when profiling matters, refactor-first low-mock testing, and balanced use of templates and header-only libraries |
| `bash` | Bash-specific companion workflow with portable shebang plus `set -euo pipefail`, `shellcheck`, `shfmt`, executable scripts, careful quoting, arrays over unsafe word splitting, and explicit shell error handling |
| `planning` | Implementation planning with exact files, red/green/refactor task structure, feature-branch discipline, built-in `/fleet` suggestions for well-bounded independent parallel work, and plan review before execution |
| `coding` | Execution workflow with branch hygiene, reuse-first coding, red/green/refactor cadence, deliberate cleanup when needed, and verification |
| `refactoring` | Behavior-preserving cleanup workflow for small in-cycle refactors and deliberate pre-review refactoring checkpoints |
| `implementation-review` | End-of-implementation review against the plan or scope, with light default review for routine slices, deeper review only for large or high-risk work, and fix-and-rereview loops |
| `code-review` | MR/PR review workflow for reviewing others' changes or deciding whether your own draft is ready to undraft, with a default two-reviewer path and a tiny-change fast path |
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
| `gitlab` | GitLab MCP via `glab mcp serve` for GitLab issues, merge requests, pipelines, and related workflows |

## Integration Notes

- `context7` should be part of normal planning and implementation workflow for current library and framework API lookups rather than treated as an optional separate skill.
- GitHub integration should generally use Copilot CLI's built-in GitHub MCP rather than a plugin-local replacement.
- The bundled GitLab MCP uses `glab mcp serve`, so `glab` must be installed and authenticated.

## License

[MIT](LICENSE)

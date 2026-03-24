# Roadmap

Tracking plugins, skills, and agents to migrate into this repo.

## Previously Installed Plugins

These were installed globally and should be evaluated for inclusion.

| Plugin | Source | Description | Status |
|--------|--------|-------------|--------|
| `anvil-dev` | `florian-jackisch/anvil` | Evidence-first coding agent with adversarial multi-model review, SQL-tracked verification, and automatic rollback. | ⏳ Evaluate |
| `superpowers` | `obra/superpowers-marketplace` | Core workflow skills library (planning, debugging, code review, TDD, brainstorming, etc.) | ⏳ Evaluate |

## Previously Installed Global Skills

These lived in `~/Documents/agents/global/skills/` (symlinked to `~/.copilot/skills`).

| Skill | Description | Status |
|-------|-------------|--------|
| `brainstorming` | Explores user intent, requirements, and design before any creative/implementation work. | ⏳ Evaluate |
| `context7` | Fetch up-to-date library documentation via Context7 API. | ⏳ Evaluate |
| `devils-advocate` | Forces adversarial reasoning before committing to architectural choices or approach selection. | ⏳ Evaluate |
| `find-skills` | Helps discover and install agent skills when asked "how do I do X" or "find a skill for". | ⏳ Evaluate |
| `gitlab-ci-patterns` | Build GitLab CI/CD pipelines with multi-stage workflows, caching, and distributed runners. | ⏳ Evaluate |
| `skill-creator` | Create, modify, improve, and benchmark skills. Run evals and optimize descriptions. | ⏳ Evaluate |

## Previously Installed Global Instructions

| File | Location | Notes |
|------|----------|-------|
| `copilot-instructions.md` | `~/.copilot/copilot-instructions.md` → `~/Documents/agents/global/copilot-instructions.md` | Commit authorship, git workflow, issue/MR rules. Keep as global or migrate into plugin. |

## Superpowers Skills (from plugin)

These came bundled with the superpowers plugin and may be worth adapting.

| Skill | Description |
|-------|-------------|
| `brainstorming` | Collaborative design exploration before implementation |
| `dispatching-parallel-agents` | Handle 2+ independent tasks in parallel |
| `executing-plans` | Execute written plans in separate sessions with review checkpoints |
| `finishing-a-development-branch` | Guide completion of development work (merge, PR, cleanup) |
| `receiving-code-review` | Handle code review feedback with technical rigor |
| `requesting-code-review` | Verify work meets requirements before merging |
| `subagent-driven-development` | Execute plans with independent tasks in current session |
| `systematic-debugging` | Debug bugs/failures before proposing fixes |
| `test-driven-development` | Write tests before implementation |
| `using-git-worktrees` | Create isolated git worktrees for feature work |
| `using-superpowers` | Establish skill discovery and usage patterns |
| `verification-before-completion` | Run verification before claiming work is done |
| `writing-plans` | Create multi-step implementation plans from specs |
| `writing-skills` | Create, edit, and verify skills |

## Superpowers Agents (from plugin)

| Agent | Description |
|-------|-------------|
| `code-reviewer` | Senior code reviewer for completed project steps |

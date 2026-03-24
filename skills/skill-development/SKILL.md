---
name: skill-development
description: "This skill should be used when the user asks to \"create a skill\", \"write a new skill\", \"add a skill\", \"improve a skill\", \"edit a skill\", or discusses skill structure, SKILL.md frontmatter, skill descriptions, or progressive disclosure patterns. Provides comprehensive guidance for creating effective skills for GitHub Copilot CLI plugins."
---

# Skill Development for Copilot CLI Plugins

Guidance for creating effective skills for GitHub Copilot CLI plugins.

## About Skills

Skills are modular, self-contained packages that extend Copilot's capabilities by providing specialized knowledge, workflows, and tools. Think of them as onboarding guides for specific domains or tasks — they transform the agent from a general-purpose assistant into a specialized one equipped with procedural knowledge that no model can fully possess.

### What Skills Provide

1. **Specialized workflows** — multi-step procedures for specific domains
2. **Tool integrations** — instructions for working with specific file formats or APIs
3. **Domain expertise** — company-specific knowledge, schemas, business logic
4. **Bundled resources** — scripts, references, and assets for complex and repetitive tasks

### Anatomy of a Skill

Every skill consists of a required SKILL.md file and optional bundled resources:

```
skill-name/
├── SKILL.md (required)
│   ├── YAML frontmatter metadata (required)
│   │   ├── name: (required)
│   │   └── description: (required)
│   └── Markdown instructions (required)
└── Bundled Resources (optional)
    ├── scripts/          - Executable code (Python/Bash/etc.)
    ├── references/       - Documentation loaded into context as needed
    └── assets/           - Files used in output (templates, icons, fonts, etc.)
```

#### SKILL.md (required)

**Metadata Quality:** The `name` and `description` in YAML frontmatter determine when the skill gets triggered. Be specific about what the skill does and when to use it. Use the third-person (e.g. "This skill should be used when..." instead of "Use this skill when...").

#### Bundled Resources (optional)

##### Scripts (`scripts/`)

Executable code (Python/Bash/etc.) for tasks that require deterministic reliability or are repeatedly rewritten.

- **When to include**: When the same code is being rewritten repeatedly or deterministic reliability is needed
- **Benefits**: Token efficient, deterministic, may be executed without loading into context

##### References (`references/`)

Documentation and reference material intended to be loaded as needed into context.

- **When to include**: For documentation that the agent should reference while working
- **Examples**: database schemas, API docs, domain knowledge, company policies
- **Best practice**: If files are large (>10k words), include grep search patterns in SKILL.md
- **Avoid duplication**: Information should live in either SKILL.md or references, not both

##### Assets (`assets/`)

Files not intended to be loaded into context, but used within the output produced.

- **When to include**: When the skill needs files used in the final output
- **Examples**: templates, images, icons, boilerplate code, fonts

### Progressive Disclosure Design Principle

Skills use a three-level loading system to manage context efficiently:

1. **Metadata (name + description)** — always in context (~100 words)
2. **SKILL.md body** — when skill triggers (<5k words)
3. **Bundled resources** — as needed (unlimited, scripts can execute without reading into context)

## Skill Creation Process

Follow these steps in order, skipping only when there is a clear reason.

### Step 1: Understand the Skill with Concrete Examples

To create an effective skill, clearly understand concrete examples of how the skill will be used. Ask questions like:

- "What functionality should this skill support?"
- "Can you give some examples of how this skill would be used?"
- "What would a user say that should trigger this skill?"

Avoid overwhelming users with too many questions at once. Start with the most important and follow up.

Conclude this step when there is a clear sense of the functionality the skill should support.

### Step 2: Plan the Reusable Skill Contents

Turn concrete examples into an effective skill by analyzing each example:

1. Consider how to execute on the example from scratch
2. Identify what scripts, references, and assets would be helpful when executing these workflows repeatedly

Establish the skill's contents by analyzing each concrete example to create a list of the reusable resources to include.

### Step 3: Create Skill Structure

Create the skill directory structure in the plugin:

```bash
mkdir -p skills/skill-name/{references,examples,scripts}
touch skills/skill-name/SKILL.md
```

Delete any example files and directories not needed for the skill. Create only the directories actually needed.

### Step 4: Edit the Skill

Remember that the skill is being created for another instance of the agent to use. Focus on including information that would be beneficial and non-obvious. Consider what procedural knowledge, domain-specific details, or reusable assets would help the agent execute tasks more effectively.

#### Start with Reusable Skill Contents

Begin implementation with the reusable resources identified above: `scripts/`, `references/`, and `assets/` files. This step may require user input (e.g., brand assets, documentation, templates).

#### Update SKILL.md

**Writing Style:** Write the entire skill using **imperative/infinitive form** (verb-first instructions), not second person. Use objective, instructional language (e.g., "To accomplish X, do Y" rather than "You should do X").

**Description (Frontmatter):** Use third-person format with specific trigger phrases:

```yaml
---
name: skill-name
description: "This skill should be used when the user asks to \"specific phrase 1\", \"specific phrase 2\", \"specific phrase 3\". Include exact phrases users would say."
---
```

**Good description examples:**

```
description: "This skill should be used when the user asks to \"create a hook\", \"add a PreToolUse hook\", \"validate tool use\", or mentions hook events."
```

**Bad description examples:**

```
description: Use this skill when working with hooks.  # Wrong person, vague
description: Provides hook guidance.  # No trigger phrases
```

To complete the SKILL.md body, answer:

1. What is the purpose of the skill, in a few sentences?
2. When should the skill be used? (Include in frontmatter description with specific triggers)
3. In practice, how should the agent use the skill? All reusable skill contents should be referenced.

**Keep SKILL.md lean:** Target 1,500–2,000 words for the body. Move detailed content to references/:

- Detailed patterns → `references/patterns.md`
- Advanced techniques → `references/advanced.md`
- API references → `references/api-reference.md`

**Reference resources in SKILL.md:**

```markdown
## Additional Resources

### Reference Files
- **`references/patterns.md`** — Common patterns
- **`references/advanced.md`** — Advanced use cases

### Examples
- **`examples/example-script.sh`** — Working example
```

### Step 5: Validate and Test

1. **Check structure**: Skill directory in `skills/skill-name/`
2. **Validate SKILL.md**: Has frontmatter with name and description
3. **Check trigger phrases**: Description includes specific user queries
4. **Verify writing style**: Body uses imperative/infinitive form, not second person
5. **Test progressive disclosure**: SKILL.md is lean (~1,500–2,000 words), detailed content in references/
6. **Check references**: All referenced files exist
7. **Validate examples**: Examples are complete and correct
8. **Test scripts**: Scripts are executable and work correctly

### Step 6: Iterate

After testing, users may request improvements. Common iterations:

- Strengthen trigger phrases in description
- Move long sections from SKILL.md to references/
- Add missing examples or scripts
- Clarify ambiguous instructions
- Add edge case handling

## Plugin-Specific Considerations

### Skill Location

Plugin skills live in the plugin's `skills/` directory:

```
florian-dev/
├── plugin.json
├── skills/
│   └── my-skill/
│       ├── SKILL.md
│       ├── references/
│       ├── examples/
│       └── scripts/
├── agents/
└── .github/
```

### Auto-Discovery

Copilot CLI automatically discovers skills by scanning the `skills/` directory for subdirectories containing `SKILL.md`. Metadata (name + description) is always loaded; the body loads when the skill triggers; resources load as needed.

### Testing

Test skills by reinstalling the plugin:

```
/plugin install florian-jackisch/florian-dev
```

Then verify with `/skills` that the skill appears with the correct name and description. Invoke it and confirm it behaves as expected.

## Writing Style Requirements

### Imperative/Infinitive Form

Write using verb-first instructions, not second person:

✅ **Correct:**
```
To create a hook, define the event type.
Configure the MCP server with authentication.
Validate settings before use.
```

❌ **Incorrect:**
```
You should create a hook by defining the event type.
You need to configure the MCP server.
```

### Third-Person in Description

The frontmatter description must use third person:

✅ **Correct:**
```
description: "This skill should be used when the user asks to \"create X\", \"configure Y\"..."
```

❌ **Incorrect:**
```
description: Use this skill when you want to create X...
```

## Validation Checklist

Before finalizing a skill:

**Structure:**
- [ ] SKILL.md file exists with valid YAML frontmatter
- [ ] Frontmatter has `name` and `description` fields
- [ ] Markdown body is present and substantial
- [ ] Referenced files actually exist

**Description Quality:**
- [ ] Uses third person ("This skill should be used when...")
- [ ] Includes specific trigger phrases users would say
- [ ] Lists concrete scenarios ("create X", "configure Y")
- [ ] Not vague or generic

**Content Quality:**
- [ ] SKILL.md body uses imperative/infinitive form
- [ ] Body is focused and lean (1,500–2,000 words ideal, <5k max)
- [ ] Detailed content moved to references/
- [ ] Examples are complete and working

**Progressive Disclosure:**
- [ ] Core concepts in SKILL.md
- [ ] Detailed docs in references/
- [ ] Working code in examples/
- [ ] Utilities in scripts/
- [ ] SKILL.md references these resources

## Common Mistakes to Avoid

### Weak Trigger Description

❌ `description: Provides guidance for working with hooks.`
✅ `description: "This skill should be used when the user asks to \"create a hook\", \"add a PreToolUse hook\", \"validate tool use\", or mentions hook events."`

### Too Much in SKILL.md

❌ One 8,000-word SKILL.md with everything
✅ 1,800-word SKILL.md + detailed references/ files

### Missing Resource References

❌ SKILL.md with no mention of references/ or examples/
✅ SKILL.md with clear "Additional Resources" section pointing to all bundled files

## Best Practices Summary

✅ **DO:**
- Use third-person in description with specific trigger phrases
- Keep SKILL.md lean (1,500–2,000 words)
- Use progressive disclosure (move details to references/)
- Write in imperative/infinitive form
- Reference supporting files clearly
- Provide working examples
- Create utility scripts for common operations

❌ **DON'T:**
- Use second person anywhere
- Have vague trigger conditions
- Put everything in SKILL.md (>3,000 words without references/)
- Leave resources unreferenced
- Include broken or incomplete examples
- Skip validation

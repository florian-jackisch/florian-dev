# Copilot Instructions Quality Criteria

## Scoring Rubric

### 1. Scope Clarity (20 points)

**20 points**: File has a clear purpose and boundaries
- It is obvious when this file applies
- It does not try to solve every problem
- Scoped files have a well-defined topic

**15 points**: Mostly clear, minor overlap

**10 points**: Broad but still usable

**5 points**: Confusing scope

**0 points**: No clear purpose

### 2. Repository Specificity (20 points)

**20 points**: Guidance is clearly tied to this repo
- Describes real workflows, directories, and constraints
- Avoids generic engineering advice
- Captures repo-specific decisions and conventions

**15 points**: Mostly specific, some generic filler

**10 points**: Mixed repo-specific and generic

**5 points**: Mostly generic advice

**0 points**: Could apply to any repo unchanged

### 3. Actionability (20 points)

**20 points**: Rules are concrete and executable
- Tells Copilot what to do
- Names actual files, commands, or patterns
- Uses clear constraints instead of vague preferences

**15 points**: Mostly actionable

**10 points**: Some useful rules, some vague wording

**5 points**: Mostly abstract guidance

**0 points**: Not actionable

### 4. Conciseness (15 points)

**15 points**: Dense, high-signal content
- Little to no filler
- No repetition inside the file
- Lists and short sections used well

**10 points**: Mostly concise, some padding

**5 points**: Verbose in places

**0 points**: Bloated or repetitive

### 5. Currency (15 points)

**15 points**: Reflects the current repository state
- File paths exist
- Workflows still match reality
- Tooling references are current

**10 points**: Mostly current, small stale details

**5 points**: Several stale references

**0 points**: Significantly outdated

### 6. Overlap and Conflict Management (10 points)

**10 points**: Responsibilities are well separated
- Root file and scoped files do not fight each other
- Shared rules are not duplicated everywhere
- Conflicts are absent or intentionally resolved

**7 points**: Minor duplication

**4 points**: Noticeable overlap

**0 points**: Contradictory instruction system

## Assessment Process

1. Read all discovered instruction files.
2. Check the actual repo structure and workflows.
3. Score each criterion.
4. Note stale references, overlap, and generic filler.
5. Suggest only improvements that materially help future Copilot sessions.

## Red Flags

- references to removed folders or workflows
- instructions that mention agents in a skills-only plugin
- generic advice like "write clean code" or "add tests"
- duplicated commit rules across multiple files without need
- large prose sections where a table or checklist would do
- scoped instruction files that duplicate the root file

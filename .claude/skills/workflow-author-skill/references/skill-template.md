# Skill Template

Copy the block for the skill type, fill it in, keep the pack's terse voice.

## Frontmatter rules
- `name`: exact skill id, matches the directory name and prefix (`role-`/`team-`/`workflow-`).
- `description`: third person, 1-2 sentences, ends with a concrete "Use when …" trigger. This is the only text Lead Producer sees when routing. No dates or version numbers.
- `context: fork`: teams and heavyweight opt-in workflows that should run in isolated context.
- `effort: high`: heavyweight, token-hungry skills (most teams, multi-round workflows).
- `status: deprecated | draft`: only when not active. Omit the field for active skills.
- Never add `user-invocable` — only `lead-producer` has it.

## role-* template
```markdown
---
name: role-<domain>
description: "<Domain> review: <key concerns>. Use when <concrete trigger>."
---
# <Role Name>

## Use When
## Do NOT Use When
## What You Own
## Working Method
## Default Output
\`\`\`text
<REPORT NAME>
=============
<sections>
\`\`\`
## Anti-Drift Rules
```

## team-* template
```markdown
---
name: team-<domain>
description: "<Domain> team: <angles synthesized>. Use when <concrete trigger>."
context: fork
---
# <Team Name>

## Purpose
## Composition
- **role-x**: what it owns here
- Synthesis: dedupe, conflict resolution, acceptance
## Use When
## Workflow
## Conflict Resolution
## Default Output
## Anti-Drift Rules
```

## workflow-* template
```markdown
---
name: workflow-<verb-or-domain>
description: "<Process>: <what it produces>. Use when <concrete trigger>."
---
# <Workflow Name>

## Purpose
## Use When
## Do NOT Use When
## Working Method   (or phased: ### Phase 1 …)
## Default Output   (or Default Artifact -> _artifacts/<type>-<slug>.md)
## Anti-Drift Rules
```

## Conventions reused across the pack
- Artifact persistence: `_artifacts/<type>-<slug>.md`; ask where to save if `_artifacts/` is absent.
- Confidence labeling: `high` / `medium` / `low`; prefix unverified assumptions with `UNCONFIRMED:`.
- "Do NOT Use When" should cross-reference the neighboring skills a reader might confuse this with.

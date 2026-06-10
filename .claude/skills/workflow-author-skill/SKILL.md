---
name: workflow-author-skill
description: "Author a new skill (role, team, or workflow) in this pack's conventions, then wire it into routing and docs. Use when adding, splitting, or formalizing a capability so it lands consistent and discoverable instead of ad hoc."
---
# Author Skill Workflow

## Purpose
Add a new skill that matches pack conventions and is fully wired into Lead Producer routing and the host docs. The deliverable is not just a SKILL.md — it is a consistent, discoverable, counted skill with no dangling references.

## Use When
- Adding a new role, team, or workflow to the pack
- Splitting an overloaded skill or formalizing a recurring ad-hoc move
- Converting a borrowed idea into a pack-native skill

## Do NOT Use When
- Only editing an existing skill's content (edit it directly)
- Deciding *whether* a capability is worth adding (that is an LP routing/scope judgment first)
- Authoring project context modules (those are reference material, not skills)

## Decide the Skill Type First
- **role-*** — one specialist perspective. Frontmatter: `name`, `description`. Sections: Use When, Do NOT Use When, What You Own, Working Method, Default Output, Anti-Drift Rules. Add `references/` only when content exceeds ~100 lines.
- **team-*** — composes 3-6 roles into one synthesized review. Frontmatter adds `context: fork` (and `effort: high` when heavyweight). Sections: Purpose, Composition, Use When, Workflow, Conflict Resolution, Default Output, Anti-Drift Rules.
- **workflow-*** — a multi-step process, often producing an artifact. Frontmatter: `name`, `description` (+ `context: fork`, `effort: high` for heavyweight opt-in plays). Sections: Purpose, Use When, Do NOT Use When, Working Method/phased Workflow, Default Output/Artifact, Anti-Drift Rules.

## Working Method
1. **Confirm the gap.** Search existing skills first. If an existing skill covers this with a small edit, stop and recommend that instead — do not accumulate.
2. **Name it.** Match the `role-` / `team-` / `workflow-` prefix to the type. Lowercase, dash-case, verb-or-domain clear.
3. **Draft `description`.** Third person, one or two sentences, ending with a concrete "Use when …" trigger. This is the only text the router sees — make it earn the route. No time-sensitive info. See `references/skill-template.md`.
4. **Draft SKILL.md** from the type's section set. Keep the pack's terse voice. Include a "Do NOT Use When" that cross-references neighboring skills so boundaries stay legible.
5. **Add references** only if the body would exceed ~100 lines; link them from a Reference Map and inline the key concepts as fallback.
6. **Wire it in.** Run the full `references/maintenance-checklist.md`: LP routing table entry, Suggested Plays + opt-in alias (if a play), CLAUDE.md and README counts, a smoke-test entry, and the lifecycle `status` field if not active.
7. **Verify.** Grep the new skill id across the repo for consistent spelling; confirm counts add up; confirm no contradiction with neighboring skills.

## Default Output
```text
NEW SKILL REPORT
================
Skill: id and type (role / team / workflow)
Gap: what it covers that nothing else did
Files: SKILL.md (+ references) created
Wiring: routing entry, suggested play (y/n), counts updated, smoke test added
Boundaries: neighboring skills it cross-references in Do NOT Use When
Verification: grep / count checks run
```

## Anti-Drift Rules
- Confirm the gap before authoring. Prefer editing an existing skill over adding a near-duplicate.
- A skill is not done when SKILL.md is written. It is done when routing and docs agree and counts are correct.
- The `description` field carries the route. Vague descriptions produce mis-routes — keep the "Use when" trigger concrete.
- Match the existing pack voice and section set. Do not invent new section headings without reason.
- Do not make a new skill `user-invocable` — only `lead-producer` is the entrypoint.

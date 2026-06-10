# Lead Producer Pack - Claude Code Host Guide

64 total skills: 1 coordinator + 63 specialist skills (37 roles, 12 teams, 14 workflows).

This file is Claude Code host guidance. Canonical skill content lives in `.claude/skills/`.
Codex uses the same skill files through linked installs and follows `.codex/INSTALL.md` for
host-specific setup.

## Loading Rules

**Do not load skills speculatively.** Only the Lead Producer is invoked directly, and it loads only the skills needed for the current task.

**Prohibited actions:**
- Do not read, scan, or invoke any SKILL.md file except `lead-producer` unless Lead Producer explicitly requests it for the current task.
- Do not pre-read skills to "understand scope" or "prepare for routing."
- Do not bypass Lead Producer by invoking skills directly, even if the routing table shows an obvious match.
- Do not load context modules unless the user or Lead Producer explicitly requests them.
- Do not list or infer skill availability from file structure.
- If the user names a specialist, play, or alias directly, still send the request through LP. `lead-producer/SKILL.md` owns which names and opt-ins are treated as routing signals.

**Lead Producer invocation protocol:**
1. In Claude Code, invoke `/lead-producer` with the user's full request.
2. Wait for LP's complete response. If LP asks a clarifying question, answer it; do not route to skills.
3. If LP says `Route Now: <skill-id>[, <skill-id> ...]`, load ONLY those exact skills. If LP describes a domain but does not name a skill, ask LP to specify.
4. If LP says `Suggested Play: <skill-id>`, do NOT load it yet. Wait for user opt-in.
5. If the user follows up after a suggested play, names a specialist directly, or uses a legacy alias, send that follow-up back through LP. Do not interpret undocumented routing phrases in this host guide.
6. If a loaded skill identifies the need for an additional skill, it escalates back to LP, not directly to the next skill.

**Lead Producer response modes:**
- **Route Now** - LP has named one or more skill ids to load immediately.
- **Suggested Play** - LP recommends a deeper workflow by ID; the user must opt in before it loads.

## Manual Smoke Test Prompts

Use these after linking `.claude` into a project:

- `/lead-producer Review this onboarding guide for clarity and accuracy.`
  Manual smoke expectation: first lines include `Route Now: team-documentation` and `Suggested Play: none`
- `/lead-producer This codebase is inherited and messy. Figure out whether we should do a focused architecture spike or a broader discovery pass first.`
  Manual smoke expectation: first lines include `Route Now: none` and `Suggested Play: workflow-project-discovery`
- `/lead-producer This payout rollback plan is high stakes. Run the specialist hardening play and repeat until 9.`
  Manual smoke expectation: first lines include `Route Now: workflow-specialist-hardening` and `Suggested Play: none`
- `/lead-producer We're about to migrate all player wallets to the new contract in one irreversible cutover next week. Pressure-test what could go wrong before we commit.`
  Manual smoke expectation: first lines include `Route Now: none` and `Suggested Play: workflow-premortem`
- `/lead-producer I want to add a new specialist skill to this pack for accessibility audits.`
  Manual smoke expectation: first lines include `Route Now: workflow-author-skill` and `Suggested Play: none`
- `/lead-producer We're ending for today; summarize this session so another agent can pick it up tomorrow.`
  Manual smoke expectation: first lines include `Route Now: workflow-session-handoff` and `Suggested Play: none`
- `/lead-producer I have a vague idea to "make the rewards feel better" but haven't thought it through. Grill me before we build anything.`
  Manual smoke expectation: first lines include `Route Now: workflow-requirements-grill` and `Suggested Play: none`
- `/lead-producer Review the questline for this new zone — does the story land and stay consistent with our lore?`
  Manual smoke expectation: first lines include `Route Now: role-narrative-designer` and `Suggested Play: none`
- `/lead-producer Lay out the encounter flow for the new dungeon — which mechanics appear and in what order.`
  Manual smoke expectation: first lines include `Route Now: role-level-designer` and `Suggested Play: none`
- `/lead-producer Plan the go-to-market and positioning for our launch next month.`
  Manual smoke expectation: first lines include `Route Now: role-product-marketing-manager` and `Suggested Play: none`

## Skill Lifecycle

Skills carry an optional `status` frontmatter field:
- No field -> active (the default; do not add `status: active`).
- `status: draft` -> unfinished, not ready to route.
- `status: deprecated` -> retired; include a one-line "replaced by `<skill-id>`" in the body.

Lead Producer must not route to `draft` or `deprecated` skills. Use `workflow-author-skill` to add or formalize skills so routing, counts, and docs stay consistent.

## Hierarchy

User -> Claude -> Lead Producer -> specialist roles/teams/workflows

Claude's only job is to invoke Lead Producer, execute `Route Now` decisions, or wait on `Suggested Play` recommendations until the user opts in. Even if the user asks to skip LP and invoke a skill directly, route through LP first.

## Routing Canon

Runtime routing truth lives in `.claude/skills/lead-producer/SKILL.md`. This host guide
intentionally does not duplicate LP's full route table.

When Claude needs routing semantics, follow LP's returned skill ids or the explicit opt-in aliases
in the invocation protocol above. Do not expand the contract from memory or infer undocumented
routes from file names.

## Project Context Modules

This pack supports external context module packs. Context modules are loaded ONLY when:
1. The user explicitly names them.
2. Lead Producer explicitly names them in a routing decision.

Do not load context modules by topic inference. Context modules are reference material only; they do not make design decisions.

---
name: workflow-test-driven-development
description: Use when a local team or role should implement under strict TDD while preserving local domain ownership, context modules, and routing. Defers the hard execution doctrine to `superpowers:test-driven-development`.
---
# Test-Driven Development Workflow
## Purpose
This is the repo-local adapter for test-first implementation. In the merged Lead Producer + Superpowers system, the strict execution doctrine comes from `superpowers:test-driven-development`. This workflow tells Lead Producer which local owner should carry that process and how it fits into this repo's expert model.

## Use When
- A feature or bugfix should be executed under strict TDD without losing local domain expertise
- Lead Producer has already decided that test-first execution is the right overlay
- Dev Team, QA Engineer, Principal Engineer, Move Team, Frontend Team, or another local owner needs disciplined implementation guidance
- Context modules such as Frontier or Sui expertise should stay in scope while coding rigor comes from Superpowers

## Do NOT Use When
- You need the hard TDD rules themselves; invoke `superpowers:test-driven-development` for that
- The task is pure architecture exploration with no implementation yet
- The best next step is root-cause debugging rather than coding
- The change is so trivial that Lead Producer decides no TDD overlay is needed

## Default Route
Lead Producer should combine:
- `superpowers:test-driven-development` for the execution method
- the relevant local owner for domain expertise
- any needed context modules for Frontier, Sui, economy, or game-specific context

Common pairings:
- `superpowers:test-driven-development` + `team-dev-team`
- `superpowers:test-driven-development` + `role-qa-engineer`
- `superpowers:test-driven-development` + `role-principal-software-engineer`
- `superpowers:test-driven-development` + `team-move-team`
- `superpowers:test-driven-development` + `team-frontend-team`

## Load Rules
If Superpowers is installed, treat `superpowers:test-driven-development` as authoritative. Use the local reference files in `references/` only when:
- Superpowers is unavailable
- You need supplemental local heuristics for interface depth, mocking boundaries, or refactoring discussion
- Lead Producer wants local context on how TDD interacts with an existing team or artifact shape

## Local Value
- Preserves local domain ownership while Superpowers supplies the strict coding discipline
- Keeps context modules in scope during implementation
- Makes TDD discoverable from the local index and teams without duplicating the upstream doctrine
- Gives Lead Producer a clean adapter when the task is "use TDD here" rather than "teach TDD from scratch"

## Anti-Patterns
- Treating this local workflow as a replacement for `superpowers:test-driven-development`
- Re-explaining rigid TDD doctrine here instead of deferring to the upstream overlay
- Using this workflow to justify skipping local domain expertise on Sui, Frontier, UI, or architecture-heavy work

## Pairing Guidance
- Pair with `team-dev-team` for implementation review or behavior-sensitive fixes.
- Pair with `role-qa-engineer` when acceptance criteria, coverage shape, or regression risk need extra rigor.
- Pair with `role-principal-software-engineer` when interface quality and maintainability are part of the goal.
- Pair with domain teams such as `team-move-team` when strict TDD is needed inside a specialized technical area.

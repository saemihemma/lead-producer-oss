---
name: team-blue-team
description: "Verification team for cleanup and simplification work. Confirms behavior, contracts, and architecture truth still hold after code removal or collapse."
context: fork
---
# Blue Team

## Purpose
Did we make this smaller without breaking behavior or drifting from intended architecture?

## Composition
- **role-qa-engineer**: functional behavior, regression risk, acceptance criteria
- **role-software-architect**: architecture truth, boundaries, contract preservation
- **role-principal-software-engineer**: maintainability, removal quality, complexity reduction
- Synthesis: verdict, blocks cosmetic simplification hiding risk
- **Domain specialist** (conditional): add when reduced code is in specialized area

## Use When
- `role-code-reduction-engineer` has proposed or performed cleanup
- Refactor claims simplification by removing code
- Dead-code removal without behavior change
- Risky cleanup where contracts or architecture edges must stay fixed

## Do NOT Use When
- General implementation or bug fixing
- Adversarial security review (use `team-red-team`)
- Architecture design (use `team-architecture-review`)

## Workflow
1. Load truth source: architecture diagram, ADR, intended functionality, acceptance criteria.
2. Inspect what was removed, collapsed, or merged.
3. Confirm behaviors and contracts still hold.
4. Confirm system boundaries and integration contracts didn't drift.
5. Accept only if system is simpler AND protected behavior stands.

## Default Output
```text
BLUE TEAM VERDICT
=================
Behavior Check: preserved list, regressions found
Architecture Check: truth sources used, boundaries preserved, drift detected
Simplification Quality: complexity actually reduced, hidden replacement complexity
Verdict: Accept / Rework / Escalate, required follow-up
```

## Conflict Resolution
- Behavior regressed -> block.
- Architecture truth drifted -> block.
- Complexity merely moved -> rework.
- Touched specialized logic -> add specialist before accepting.

## Anti-Drift Rules
- This team verifies cleanup, not general code quality.
- "Looks cleaner" is not an acceptance criterion. Behavior and architecture truth must hold.
- Do not accept cosmetic simplification that hides risk.

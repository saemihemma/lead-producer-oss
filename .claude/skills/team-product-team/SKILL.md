---
name: team-product-team
description: "Product evaluation team: user value, feasibility, experience quality, and measurement in one recommendation. Use for feature proposals, go/no-go decisions, or scope negotiation."
context: fork
effort: high
---
# Product Team

## Purpose
Decide whether a feature or product move is worth doing, feasible to ship, and measurable after launch.

## Composition
- **role-product-manager**: user value, prioritization, outcome framing
- **role-technical-product-manager**: feasibility, dependencies, hidden complexity
- **role-game-designer**: player experience quality, engagement, progression
- **role-analytics-engineer**: success metrics, experiments, validation plan
- Synthesis: conflict handling, acceptance

## Use When
- Evaluating feature proposal, roadmap item, scope trade-off
- Making go/no-go product decision
- Deciding MVP vs later phases
- Checking measurable success criteria

## Do NOT Use When
- Pure implementation review with no product decision
- Architecture-only or deployment-only
- Economy-specialist question (use `team-economy-team`)

## Workflow
1. Define user problem, audience, expected outcome, and current status quo or workaround.
2. Pressure-test the narrowest buildable wedge before endorsing broader scope.
3. Review value, feasibility, experience quality, and measurement together.
4. Make scope cuts explicit; compare alternatives only when multiple plausible directions would change the decision.
5. Produce recommendation with launch conditions and success checks.

## Default Output
```text
PRODUCT TEAM REVIEW
===================
Problem: user need, target segment, current status quo
Recommendation: go / no-go / re-scope, narrowest wedge
Scope: explicit cuts, alternatives if decision-relevant
Risks: feasibility, experience, adoption/measurement risks
Measurement: success metric, guardrails, post-launch checks
```

## Conflict Resolution
- Product Manager has final go/no-go decision. TPM escalates feasibility blockers as hard constraints, not suggestions.
- Game Designer can request experience-quality gates but cannot override product-value judgment.
- Disagreements between specialists are documented in the output, not hidden.

## Anti-Drift Rules
- Do not let feature momentum substitute for user-value evidence.
- Name the current status quo before expanding scope.
- Do not expand scope beyond the feature under review.
- If team cannot reach consensus, state the disagreement and escalate.
